import 'dart:ui' as ui;
import 'dart:async';
import 'dart:math' as math; // <-- Usamos math para dibujar el arco
import 'package:custom_info_window/custom_info_window.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:google_maps_cluster_manager/google_maps_cluster_manager.dart'
        as cluster_manager_lib show Cluster, ClusterManager;
import 'package:google_maps_flutter/google_maps_flutter.dart' as gmaps;

import 'package:prosecat/generated/l10n.dart';
import 'package:prosecat/helpers/helpers.dart';
import 'package:prosecat/helpers/widget_to_marker.dart';
import 'package:prosecat/services/device_provider.dart';
import 'package:prosecat/system/global.dart';

import '../models/models.dart';

class MapController extends ChangeNotifier {
  final String apiUrl = GlobalVariables().apiUrl;
  final String urlGetUserMapIcons = GlobalVariables().urlGetUserMapIcons;

  StreamController<List<DeviceResponse>>? streamController;
  Stream<List<DeviceResponse>>? get getDevice => streamController?.stream;

  StreamSubscription<List<DeviceResponse>>? overviewSuscription;
  StreamSubscription<List<DeviceResponse>>? polylineSuscription;
  CustomInfoWindowController? customInfoWindowController;
  CustomInfoWindowController? customLabelWindowController;
  final List<gmaps.Polyline> _polylines = [];
  Set<gmaps.Polyline> get polylines => _polylines.toSet();

  DeviceProvider deviceProvider = DeviceProvider();
  String deviceAddress = '';

  //Sirve para guardar el id de los dispositivos que se eliminan del mapa
  List<String> tempDevice = [];

  Item? itemdeviceOverview;
  bool openDeviceOverview = false;
  int deviceIndex = 0;
  late cluster_manager_lib.ClusterManager _manager;

  final Map<gmaps.PolygonId, gmaps.Polygon> _polygons = {};
  Set<gmaps.Polygon> get polygons => _polygons.values.toSet();
  final _markers = {};

  final Completer<gmaps.GoogleMapController> _controller =
      Completer<gmaps.GoogleMapController>();

  Completer<gmaps.GoogleMapController> get controller => _controller;

  gmaps.GoogleMapController? mapController;

  MapController() {
    initState();
  }

  Set<gmaps.Marker> markers = {};
  Set<gmaps.Marker> nonClusteringMarkers =
      {}; // Lista para los marcadores no clusterizados
  Set<gmaps.Marker> nonClusteringLabels = {};
  List<Place> items = [];
  List<Place> get getItems => items;

  //Editar items
  set setItems(Place item) {
    items.add(item);
    tempDevice.removeWhere((element) => element == item.id);
    _manager.setItems(items);
  }

  close() {
    markers.clear();
    nonClusteringMarkers.clear();
    nonClusteringLabels.clear();
    _polygons.clear();
    _polylines.clear();

    //Cerrar ventana
    setIsDeviceOverviewOpen = false;

    //Reiniciar variables
    setShowPolylines(show: false);
    setShowImgDirection(show: false);
    setIsGeofencesBuilding(false);
    setIsGeofence(show: false);

    //Cerrar stream
    streamController?.close();
    streamController = null;

    getItems.clear();
    overviewSuscription?.cancel();
    polylineSuscription?.cancel();
  }

  void addEvent(List<DeviceResponse> event) {
    streamController?.add(event);
  }

  //Mostrar imagen amarilla, roja o verde sobre el marcador para señalar su dirección
  bool showImgDirection = false;
  bool get getShowImgDirection => showImgDirection;
  gmaps.LatLng? latLngFromMarkerSelected;

  setShowImgDirection({bool? show}) {
    show != null
        ? showImgDirection = show
        : showImgDirection = !showImgDirection;

    _manager.updateMap();
    notifyListeners();
  }

  //Mostrar polilíneas
  bool showPolylines = false;
  bool get getShowPolylines => showPolylines;
  setShowPolylines({bool? show}) {
    show != null ? showPolylines = show : showPolylines = !showPolylines;
    showPolyline();
    notifyListeners();
  }

  //Mostrar recorrido
  bool showTour = false;
  bool get getShowTour => showTour;
  setShowTour() {
    showTour = !showTour;
    showTours();
    notifyListeners();
  }

  //Mostrar barra de progreso mientras las geocercas cargan
  bool isGeofencesBuilding = false;
  bool get getIsGeofencesBuilding => isGeofencesBuilding;
  setIsGeofencesBuilding(bool geofenceIsBuild) {
    isGeofencesBuilding = geofenceIsBuild;
    notifyListeners();
  }

  //Para manejar el estado del botón que carga las geocercas
  bool isGeofence = false;
  bool get getIsGeofence => isGeofence;
  setIsGeofence({bool? show}) {
    show != null ? isGeofence = show : isGeofence = !isGeofence;
    notifyListeners();
  }

  //Extraer informacion para crear los polígonos
  getLatLng(Map items) {
    items.forEach((key, value) {
      addGeofences(value['cordinates'], key, value['color'], value['name']);
    });
    setIsGeofencesBuilding(false);
  }

  //Agregar polígono
  addGeofences(List<gmaps.LatLng> points, int poligonId, String code,
      String name) async {
    gmaps.PolygonId polylinId = gmaps.PolygonId(poligonId.toString());
    final Color color = hexToColor(code);
    gmaps.Polygon polygon = gmaps.Polygon(
      polygonId: polylinId,
      // ignore: deprecated_member_use
      fillColor: color.withOpacity(0.5),
      strokeColor: color,
      strokeWidth: 3,
      points: points,
    );

    _polygons[polylinId] = polygon;
    gmaps.LatLng labelPosition =
        points.isNotEmpty ? points[0] : const gmaps.LatLng(0, 0);

    final imageBytes = await getTextOnlyMarker(
      name,
      fontSize: 35,
      // ignore: deprecated_member_use
      backgroundColor: color.withOpacity(0.5),
      shadowColor: Colors.black,
      imageHeight: 75.0, // Alto personalizado de la imagen
    );

    final ui.Image image = await decodeImageFromList(imageBytes);

    final ByteData? byteData =
        await image.toByteData(format: ui.ImageByteFormat.png);

    final marker = addNonClusteringLabel(
      labelPosition,
      polylinId.toString(),
      byteData!.buffer.asUint8List(),
      '',
    );
    _markers[polylinId] = marker;
  }

  StreamSubscription<List<DeviceResponse>>? streamSubscription;

  //Mostrar puntos de interés
  void showTours() async {
    if (!getShowTour) {
      nonClusteringMarkers.clear();
      return;
    }

    final tourList = await deviceProvider.getTours();

    if (tourList.status == 1) {
      try {
        tourList.items?.mapIcons?.forEach((item) async {
          Uint8List iBytes = await imageToBytes(
            path: item.mapIcon!.url!,
            width: 20,
          );

          ui.Image i = await decodeImageFromList(iBytes);

          final imageBytes = await getInfoWindowMarker(
            item.name!,
            i,
            imageWidth: 80,
            imageHeight: 80,
          );
          final ui.Image image = await decodeImageFromList(imageBytes);

          final ByteData? byteData =
              await image.toByteData(format: ui.ImageByteFormat.png);
          if (byteData == null) {
            throw Exception("No se pudieron obtener los bytes de la imagen.");
          }

          addNonClusteringMarkers(
            gmaps.LatLng(item.coordinates!['lat'], item.coordinates!['lng']),
            item.id.toString() +
                item.mapIconId.toString() +
                item.userId.toString(),
            byteData.buffer.asUint8List(),
            '${S.current.descripcion}: ${item.description!}',
          );
        });
      } catch (e) {
        //
      }
    } else {
      setShowTour();
    }
  }

  //Agregar polilíneas
  void showPolyline() {
    if (!getShowPolylines) {
      polylineSuscription?.cancel();
      _polylines.clear(); // Limpiar polilíneas
      return;
    }

    polylineSuscription?.cancel();
    _polylines.clear();

    if (getDevice != null) {
      polylineSuscription = getDevice!.listen((event) {
        List<gmaps.Polyline> polylinesToAdd = [];

        for (var element in event) {
          for (var item in element.items) {
            List<gmaps.LatLng> positions = [];
            if (item.time.toLowerCase() != 'expirado') {
              if (item.tail.isNotEmpty) {
                item.tail.last.lat = item.lat.toString();
                item.tail.last.lng = item.lng.toString();
              }
              positions.addAll(item.tail.map((position) => gmaps.LatLng(
                  double.parse(position.lat), double.parse(position.lng))));

              polylinesToAdd.add(gmaps.Polyline(
                width: 4,
                polylineId: gmaps.PolylineId(item.name + item.id.toString()),
                points: positions,
                color: hexToColor(item.deviceData.tailColor),
              ));
            }
          }
        }

        addPolylines(polylinesToAdd);
      });
    }
  }

  void addPolylines(List<gmaps.Polyline> polylinesToAdd) {
    _polylines.addAll(polylinesToAdd);
  }

  deleteGeofences() {
    _polygons.clear();
    _markers.clear();
    nonClusteringLabels.clear();

    setIsGeofence();
    notifyListeners(); // Notifica a la UI que hubo cambios
  }

  //Abrir un menu de informacion para cada dispositivo(DeviceOverview)
  bool get getIsDeviceOverviewOpen => openDeviceOverview;
  set setIsDeviceOverviewOpen(bool value) {
    openDeviceOverview = value;
    notifyListeners();
  }

  gmaps.LatLng? get getLatLngFromMarkerSelected => latLngFromMarkerSelected;
  set setLatLngFromMarkerSelected(gmaps.LatLng? position) {
    latLngFromMarkerSelected = position;
    notifyListeners();
  }

  int get getIdFromDeviceSelected => deviceIndex;
  set setIdFromDeviceSelected(int index) {
    deviceIndex = index;
    notifyListeners();
  }

  cluster_manager_lib.ClusterManager get getManager => _manager;

  Item? get getDeviceOverviewItem => itemdeviceOverview;
  set setDeviceOverviewItem(int index) {
    if (getDevice != null && mapController != null) {
      overviewSuscription = getDevice!.listen((event) async {
        for (var list in event) {
          for (var element in list.items) {
            if (element.id == getIdFromDeviceSelected) {
              await deviceProvider
                  .getGeocoder(element.lat, element.lng)
                  .then((val) => deviceAddress = val);
            }
          }
        }
      });
      return;
    }
    return;
  }

  //Lenar lista con items
  fillItems() async {
    streamController = StreamController<List<DeviceResponse>>.broadcast();
    if (getDevice != null) {
      getDevice?.listen((event) {
        for (var element in event) {
          for (var item in element.items) {
            bool imgArrow = item.icon.type == 'arrow';

            Place place = Place(
              item.name,
              item.speed,
              item.distanceUnitHour,
              item.course.toDouble(),
              item.iconColor,
              item.time,
              id: item.id.toString(),
              path: imgArrow ? null : item.icon.path,
              asset: imgArrow ? 'assets/icon/arrow_yellow.png' : null,
              location: gmaps.LatLng(item.lat, item.lng),
              rotation:
                  (item.icon.type == 'rotating' || item.icon.type == 'arrow')
                      ? item.course.toDouble()
                      : 0,
            );

            // Buscamos si el elemento ya existe en la lista
            int index = getItems.indexWhere((p) => p.id == item.id.toString());

            // Si ya existe, lo actualizamos
            if (index != -1) {
              //Si deviceOverview está abierto, mueve la cámara
              if (getIsDeviceOverviewOpen &&
                  getIdFromDeviceSelected == item.id) {
                final bool locationExists = items.any(
                    (val) => val.location == gmaps.LatLng(item.lat, item.lng));
                if (!locationExists) {
                  final cameraUpdate = gmaps.CameraUpdate.newLatLng(
                      gmaps.LatLng(item.lat, item.lng));
                  mapController!.animateCamera(cameraUpdate);
                }
              }
              updateMarkerPosition(
                  item.id.toString(), gmaps.LatLng(item.lat, item.lng));
              items[index] = place;
            }
            // Si el elemento está en tempDevice, no lo agregamos
            else if (tempDevice.contains(item.id.toString())) {
              return;
            }
            // Si es nuevo, lo agregamos
            else {
              setItems = place;
            }
          }
        }
      });
    }
  }

  void initState() {
    _manager = _initClusterManager();
  }

  cluster_manager_lib.ClusterManager<Place> _initClusterManager() {
    return cluster_manager_lib.ClusterManager<Place>(
      getItems,
      _updateMarkers,
      markerBuilder: _markerBuilder as Future<gmaps.Marker> Function(dynamic),
      stopClusteringZoom: 7.84, // Detener agrupamiento a partir de zoom ~8
    );
  }

  _updateMarkers(Set<gmaps.Marker> markers) {
    this.markers = markers;
  }

  onMapCreated(gmaps.GoogleMapController controller) async {
    mapController = controller;
    _manager.setMapId(mapController!.mapId);
    await fillItems();

    if (!_controller.isCompleted) {
      _controller.complete(controller);
    }
  }

  //Crear marcadores sin cluster
  addNonClusteringMarkers(gmaps.LatLng position, String markerId,
      Uint8List byteData, String infoWindowText) {
    final marker = gmaps.Marker(
      anchor: const Offset(0.5, 0.7),
      markerId: gmaps.MarkerId(markerId),
      position: position,
      onTap: () {
        moveCamera(position);
        addCustomInfoWindow(infoWindowText, position);
      },
      // ignore: deprecated_member_use
      icon: gmaps.BitmapDescriptor.fromBytes(byteData),
    );
    nonClusteringMarkers.add(marker);
  }

  //Crear labels en áreas (no cluster)
  addNonClusteringLabel(gmaps.LatLng position, String markerId,
      Uint8List byteData, String infoWindowText) {
    final marker = gmaps.Marker(
      anchor: const Offset(0, 0),
      markerId: gmaps.MarkerId(markerId),
      position: position,
      onTap: () {
        moveCamera(position);
        addCustomInfoWindow(infoWindowText, position);
      },
      // ignore: deprecated_member_use
      icon: gmaps.BitmapDescriptor.fromBytes(byteData),
    );
    nonClusteringLabels.add(marker);
  }

  // --- INICIO CAMBIOS ---
  /// Función para generar un ícono de clúster: círculo azul, arco verde y número en blanco

  Future<gmaps.BitmapDescriptor> getClusterBitmap(int size,
      {String? text}) async {
    final ui.PictureRecorder pictureRecorder = ui.PictureRecorder();
    final ui.Canvas canvas = ui.Canvas(pictureRecorder);

    final Offset center = Offset(size * 0.5, size * 0.5);

    // 1) CÍRCULO AZUL PRINCIPAL (más pequeño)
    final double circleRadius = size * 0.32; // 25% del lienzo
    final paintCenter = Paint()
      ..color = Colors.blue
      ..style = PaintingStyle.fill;
    canvas.drawCircle(center, circleRadius, paintCenter);

    // 2) ARCO AZUL (algo más grande que el círculo)
    final double arcBlueRadius = circleRadius + 8; // +10 para que quede fuera
    final Rect rectBlue =
        Rect.fromCircle(center: center, radius: arcBlueRadius);
    final paintBlueArc = Paint()
      ..color = Colors.blue
      ..style = PaintingStyle.stroke
      ..strokeWidth = 6; // Ajusta grosor

    // Ángulos: por ejemplo, un arco de 270° centrado (desde -135° hasta 135°)
    final double startAngleBlue = 45 * math.pi / 180; // -90°
    final double sweepAngleBlue = -270 * math.pi / 180; // 270°
    canvas.drawArc(
        rectBlue, startAngleBlue, sweepAngleBlue, false, paintBlueArc);

    // 3) ARCO VERDE (más grande que el azul anterior)
    final double arcGreenRadius = circleRadius + 18; // +20 mayor todavía
    final Rect rectGreen =
        Rect.fromCircle(center: center, radius: arcGreenRadius);
    final paintGreenArc = Paint()
      ..color = Colors.green
      ..style = PaintingStyle.stroke
      ..strokeWidth = 6; // Ajusta grosor

    // Mismo ángulo, para que se vea “rodeando” al azul
    final double startAngleGreen = 45 * math.pi / 180;
    final double sweepAngleGreen = -270 * math.pi / 180;
    canvas.drawArc(
        rectGreen, startAngleGreen, sweepAngleGreen, false, paintGreenArc);

    // 4) TEXTO en el centro (número de clúster)
    if (text != null) {
      final textPainter = TextPainter(textDirection: TextDirection.ltr);
      textPainter.text = TextSpan(
        text: text,
        style: const TextStyle(
          fontSize: 25,
          color: Colors.white,
          fontWeight: FontWeight.bold,
        ),
      );
      textPainter.layout();
      textPainter.paint(
        canvas,
        Offset(
          center.dx - textPainter.width / 2,
          center.dy - textPainter.height / 2,
        ),
      );
    }

    // 5) CONVERTIR A PNG
    final ui.Image image =
        await pictureRecorder.endRecording().toImage(size, size);
    final ByteData? byteData =
        await image.toByteData(format: ui.ImageByteFormat.png);
    // ignore: deprecated_member_use
    return gmaps.BitmapDescriptor.fromBytes(byteData!.buffer.asUint8List());
  }

  // --- FIN CAMBIOS ---

  //Crear marcadores con cluster manager
  Future<gmaps.Marker> Function(cluster_manager_lib.Cluster<Place>) get _markerBuilder =>
      (final cluster) async {
        String? path;
        String? asset;
        String id = '';
        double rotation = 0.0;
        double imageRotate = 0.0;
        String name = '';
        int speed = 0;
        String distanceUnitHour = '';
        String iconColor = '';

        for (var element in cluster.items) {
          path = element.path;
          asset = element.asset;
          id = element.id;
          rotation = element.rotation;
          imageRotate = element.imageRotate;
          name = element.name;
          speed = element.speed;
          distanceUnitHour = element.distanceUnitHour;
          iconColor = element.iconColor;
        }

        gmaps.BitmapDescriptor markerIcon;

        if (cluster.isMultiple) {
          // --- INICIO CAMBIOS ---
          // Si es un clúster con varios ítems, usamos getClusterBitmap
          markerIcon = await getClusterBitmap(
            120,
            text: cluster.count.toString(),
          );
          // --- FIN CAMBIOS ---
        } else {
          // Si es un solo ítem, usamos tu método existente (flecha/rotación/etc.)
          markerIcon = await getMarkerBitmap(false, 200,
              '$name ($speed $distanceUnitHour)', getShowImgDirection,
              path: path,
              asset: asset,
              rotation: rotation,
              text: null,
              imageRotate: getShowImgDirection
                  ? 'assets/icon/flechas/flecha_$iconColor.png'
                  : null,
              rotateAngle: imageRotate,
              subtitle: null,
              contain: null,
              color: iconColor);
        }

        return gmaps.Marker(
          anchor: const Offset(0.5, 0.7),
          markerId: gmaps.MarkerId(id),
          position: cluster.location,
          onTap: (cluster.isMultiple)
              ? () async {
                  // Hacemos zoom para ver todos los ítems del clúster
                  List<gmaps.LatLng> markerPositions = [];
                  for (var element in cluster.items) {
                    markerPositions.add(element.location);
                  }
                  gmaps.LatLngBounds bounds =
                      calculateLatLngBounds(markerPositions);
                  final cameraUpdate =
                      gmaps.CameraUpdate.newLatLngBounds(bounds, 110);

                  await mapController!.animateCamera(cameraUpdate);
                  _manager.updateMap();
                  notifyListeners();
                }
              : () async {
                  setLatLngFromMarkerSelected = cluster.location;
                  moveCamera(cluster.location);
                  setDeviceOverviewItem = int.parse(id);
                  setIdFromDeviceSelected = int.parse(id);
                  setIsDeviceOverviewOpen = true;
                },
          icon: markerIcon,
        );
      };

  //Calcular límite (bounds) de las polilíneas
  gmaps.LatLngBounds calculateLatLngBounds(
      List<gmaps.LatLng> polylineCoordinates) {
    double minLat = double.infinity;
    double minLng = double.infinity;
    double maxLat = -double.infinity;
    double maxLng = -double.infinity;

    for (gmaps.LatLng coordinate in polylineCoordinates) {
      if (coordinate.latitude < minLat) minLat = coordinate.latitude;
      if (coordinate.longitude < minLng) minLng = coordinate.longitude;
      if (coordinate.latitude > maxLat) maxLat = coordinate.latitude;
      if (coordinate.longitude > maxLng) maxLng = coordinate.longitude;
    }

    return gmaps.LatLngBounds(
      southwest: gmaps.LatLng(minLat, minLng),
      northeast: gmaps.LatLng(maxLat, maxLng),
    );
  }

  //Actualizar la posicion de un marcador
  void updateMarkerPosition(String id, gmaps.LatLng newPosition) {
    final int indexToUpdate = items.indexWhere((element) => element.id == id);
    if (indexToUpdate == -1) return;

    if (items[indexToUpdate].location == newPosition) return;

    items[indexToUpdate].location = newPosition;
    _manager.setItems(items);
  }

  //Obtener la posición actual de un vehículo
  gmaps.LatLng getCurrentPosition(String id) {
    final int indexToUpdate = items.indexWhere((element) => element.id == id);
    return items[indexToUpdate].location;
  }

  //Mover la camara
  moveCamera(gmaps.LatLng position) {
    if (position == const gmaps.LatLng(0.0, 0.0)) return;
    if (mapController != null) {
      final cameraUpdate = gmaps.CameraUpdate.newCameraPosition(
        gmaps.CameraPosition(target: position, zoom: 19),
      );
      mapController!.animateCamera(cameraUpdate);
    }
  }

  //Eliminar marcador
  void removeItem(String idMarkCar) {
    items.removeWhere((element) => element.id == idMarkCar);
    tempDevice.add(idMarkCar);
    _manager.setItems(items);
  }

  //Cambiar zoom del mapa
  changeZoom(double zoom) {
    if (mapController != null) {
      final cameraUpdate = gmaps.CameraUpdate.zoomTo(zoom);
      mapController!.animateCamera(cameraUpdate);
    }
  }

  //Mover la camara para mostrar todos los marcadores
  moveCameraPositionByBounds(List<gmaps.LatLng> positions) async {
    try {
      gmaps.LatLngBounds bounds = calculateLatLngBounds(positions);
      final cameraUpdate = gmaps.CameraUpdate.newLatLngBounds(bounds, 40);
      mapController!.animateCamera(cameraUpdate);
    } catch (e) {
      //
    }
  }

  //Agregar ventana de información sobre el marcador
  addCustomInfoWindow(String description, gmaps.LatLng position) {
    if (customInfoWindowController != null) {
      customInfoWindowController!.addInfoWindow!(
        Container(
          padding: const EdgeInsets.all(10),
          decoration: BoxDecoration(
            color: Colors.white,
            borderRadius: const BorderRadius.all(Radius.circular(10.0)),
            boxShadow: [
              BoxShadow(
                // ignore: deprecated_member_use
                color: Colors.black.withOpacity(0.2),
                spreadRadius: 2,
                blurRadius: 5,
                offset: const Offset(0, 3),
              ),
            ],
          ),
          child: Text(description),
        ),
        position,
      );
    }
  }

  //Posicion inicial
  gmaps.CameraPosition get getStartPosition => const gmaps.CameraPosition(
      target: gmaps.LatLng(23.140536396634165, -101.82000571949492), zoom: 1);
}
