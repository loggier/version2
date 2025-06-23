// ignore_for_file: deprecated_member_use

import 'dart:async';
import 'dart:ui' as ui;

import 'package:custom_info_window/custom_info_window.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:prosecat/generated/l10n.dart';
import 'package:prosecat/helpers/helpers.dart';
import 'package:prosecat/helpers/widget_to_marker.dart';
import 'package:prosecat/models/device_details.dart';
import 'package:prosecat/services/device_provider.dart';
import 'package:collection/collection.dart';

class MapRecordController extends ChangeNotifier {
  DeviceDetails? deviceDetail;
  List<LatLng> positions = [];

  List rawTime = [];
  List<double> speed = [];
  List<double> rotations = [];
  String? speedSufix = '';
  final Map<PolylineId, Polyline> _polylines = {};
  Set<Polyline> get polylines => _polylines.values.toSet();
  Set<Marker> markers = {};
  bool _isPlay = false;
  GoogleMapController? mapController;
  CustomInfoWindowController? customInfoWindowController;
  String elementSelected = '';
  String alertSelected = '';
  bool get isPlay => _isPlay;
  String pinMarkerId = 'pinMarker001';
  DeviceProvider deviceProvider = DeviceProvider();
  LatLng? firstLocation;
  List<ItemItem> positionItem = [];
  void setIsPlay(bool value) {
    _isPlay = value;
    notifyListeners();
  }

  Timer? timer;
  int _currentPolylineIndex = 0;
  LatLng? _currentMarkerPosition;
  bool showSpeedLines = false;
  bool isLoading = false;

  //Guardar el id del markador seleccionado
  String get getElementSelected => elementSelected;
  setElementSelected(String value) {
    elementSelected = value;
    notifyListeners();
  }

  //Guardar el id de la alerta seleccionada
  String get getAlertSelected => alertSelected;
  setAlertSelected(String value) {
    alertSelected = value;
    notifyListeners();
  }

  //Agregar lineas de colores
  bool get getShowSpeedLines => showSpeedLines;
  setShowSpeedLines(bool value) {
    showSpeedLines = value;
    notifyListeners();
  }

  bool get getIsLoading => isLoading;
  set setIsLoading(bool value) {
    isLoading = value;
    notifyListeners();
  }

  void close() {
    // Liberar los recursos y cancelar el Timer
    markers.clear();
    _isPlay = false;
    _currentMarkerPosition = null;
    _currentPolylineIndex = 0;
    mapController = null;
    mapController?.dispose();
    firstLocation = null;
    timer?.cancel();
    deviceDetail = null;
    positionItem.clear();
    // super.dispose();
  }

  handleItems(DeviceDetails deviceDetails) async {
    deviceDetail = deviceDetails;
    await setItems(deviceDetail!);
  }

  //Extraer informacion
  setItems(DeviceDetails deviceDetails) async {
    deviceDetail = deviceDetails;
    _currentMarkerPosition = null;
    _currentPolylineIndex = 0;
    positions.clear();
    rawTime.clear();
    _polylines.clear();
    speed.clear();
    rotations.clear();
    markers.clear();
    firstLocation = null;
    setShowSpeedLines(false);
    positionItem.clear();

    Sensor? sensorSpeed;

    if (deviceDetail != null) {
      sensorSpeed = deviceDetail!.sensor!
          .firstWhereOrNull((element) => element.name == 'KILOMETRAJE');
    }
    if (sensorSpeed != null) {
      speedSufix = sensorSpeed.sufix;
    } else {
      speedSufix = 'kph';
    }

    for (var item in deviceDetail!.items!) {
      for (int i = 0; i < item.items.length; i++) {
        final position = LatLng(item.items[i].lat, item.items[i].lng);

        // if (!(item.items[i].lat == 42.0 || item.items[i].lng == 2.0) || item.items[i].id != null || !(item.items[i].lat == 41.0 || item.items[i].lng == 1.0)) {
        // item.items.sort((a, b) => DateTime.parse(a.rawTime).compareTo(DateTime.parse(b.rawTime)));

        if (item.status == 1) {
          rawTime.add(item.items[i].rawTime);
          speed.add(item.items[i].speed.toDouble());
          rotations.add(item.items[i].course != null
              ? item.items[i].course!.toDouble()
              : 0.0);
        }

        //Averiguar si hay un id repetido en la lista de marcadores
        final markerId = markers.any((marker) =>
            marker.markerId == MarkerId(item.items[i].id.toString()));
        final existPosition =
            markers.any((marker) => marker.position == position);
        if (!existPosition) {
          if (item.status == 1) {
            positionItem.add(item.items[i]);
          }
        }

        //Inicio de ruta
        if (item.status == 3) {
          await addMarker(
              item.items[i].id.toString(),
              position,
              item.items[i].rawTime.toString(),
              item.items[i].speed.toString(),
              'assets/icon/status/route_start.png',
              false,
              80,
              altitude: item.items[i].altitude ?? 0.0,
              driver: item.driver);
        }

        //Paradas en ruta
        if (item.status == 2 && !markerId) {
          await addMarker(
            item.items[0].id.toString(),
            position,
            item.items[0].rawTime,
            item.items[0].speed.toString(),
            'assets/icon/status/route_stop.png',
            false,
            80,
            altitude: item.items[0].altitude ?? 0,
            showTime: item.show,
            leftTime: item.left.toString(),
            time: item.time.toString(),
            driver: item.driver,
          );
        }

        //Ruta finalizada
        if (item.status == 4) {
          await addMarker(
              item.items[i].id.toString(),
              position,
              item.items[i].rawTime.toString(),
              item.items[i].speed.toString(),
              'assets/icon/status/route_end.png',
              false,
              80,
              altitude: item.items[i].altitude ?? 0,
              driver: item.driver,
              showTime: item.show);
        }

        //Eventos
        if (item.status == 5) {
          await addMarker(
              item.items[i].id.toString(),
              position,
              item.items[i].rawTime.toString(),
              item.items[i].speed.toString(),
              'assets/icon/status/route_event.png',
              false,
              80,
              altitude: item.items[i].altitude ?? 0,
              driver: item.driver,
              showTime: item.show,
              leftTime: item.left.toString(),
              time: item.time.toString());
        }
        // }
      }
    }

    for (int i = 0; i < positionItem.length; i++) {
      // Comprueba si el elemento actual está ordenado
      bool isOrder = false;
      if (i == 0 ||
          positionItem[i].rawTime.compareTo(positionItem[i - 1].rawTime) >= 0) {
        isOrder = true;
      }

      // Conserva solo los elementos ordenados
      if (isOrder) {
        positions.add(LatLng(positionItem[i].lat, positionItem[i].lng));
      }
    }

    //Obtener el primer vehículo
    final DeviceDetailsItem firstDevice = deviceDetail!.items!.first;

    //Obtener primera localización
    firstLocation = LatLng(firstDevice.items[0].lat, firstDevice.items[0].lng);

    addPolylines(positions, 'markerId', Colors.green);

    //Ajustar posición de la camara
    centerCamera(positions);

    //Marcador con movimiento
    await addMarker(pinMarkerId, firstLocation!, rawTime[0].toString(),
        speed[0].toString(), 'assets/icon/arrow-offline.png', false, 100,
        rotation: rotations[0]);
    notifyListeners();
  }

  centerCamera(List<LatLng> positionsList) async {
    //Ajustar posición de la camara
    LatLngBounds bounds = calculateLatLngBounds(positionsList);

    final cameraUpdate = CameraUpdate.newLatLngBounds(bounds, 0);
    await mapController!.animateCamera(cameraUpdate);
  }

  //Agregar polilineas
  addPolylines(List<LatLng> positions, String id, Color color) {
    PolylineId polylineId = PolylineId(id);
    final polyline = Polyline(
      polylineId: polylineId,
      color: color,
      width: 4,
      points: positions,
    );
    _polylines[polylineId] = polyline;
  }

  //Cambiar tipo de polilineas
  handleTypesPolylines() async {
    _polylines.clear();
    List<LatLng> otrosPositions = [];
    Color color;
    if (getShowSpeedLines) {
      for (var i = 0; i < positions.length - 1; i++) {
        if (speed[i] <= 30) {
          color = Colors.green;
        } else if (speed[i] > 30 && speed[i] <= 80) {
          color = Colors.yellow;
        } else {
          color = Colors.red;
        }

        await addPolylines([
          positions[i],
          positions[i + 1],
        ], 'polyline_$i', color);
        otrosPositions.add(positions[i]);
      }
      setIsLoading = false;
      return;
    }

    setIsLoading = false;
    addPolylines(positions, 'markerId', Colors.green);
  }

  //Agregar marcador
  addMarker(String markerId, LatLng position, String data, String speed,
      String path, bool isFromNetwork, int width,
      {double? altitude,
      String? driver,
      String? showTime,
      String? leftTime,
      String? time,
      double rotation = 0}) async {
    final Uint8List imageB;
    imageB =
        await getImage(isFromNetwork, width, path, rotation, markerId, data);

    Marker marker = Marker(
        // rotation: rotation,
        anchor: const Offset(0.5, 0.7),
        markerId: MarkerId(markerId),
        // infoWindow: InfoWindow(title: data, snippet: speed),
        position: position,
        icon: BitmapDescriptor.fromBytes(imageB),
        // ? BitmapDescriptor.fromBytes(
        //     await imageToBytes(width: width , path: path,),
        //   )
        // : BitmapDescriptor.fromBytes(
        //   await imageToBytes(width: width,  asset: path,)
        // ),
        onTap: () {
          if (markerId != pinMarkerId) {
            //Agregar nuevo markador seleccionado
            setElementSelected(markerId);
            setAlertSelected(markerId);

            //Agregar customInfoWindow
            addCustomInfoWindow(position,
                speed: speed,
                altitude: altitude,
                driver: driver,
                showTime: showTime,
                leftTime: leftTime,
                time: time);

            return;
          }

          Marker existingMarker = markers
              .firstWhere((marker) => marker.markerId.value == pinMarkerId);

          addCustomInfoWindow(
            existingMarker.position,
            showTime: rawTime[_currentPolylineIndex].toString(),
          );
        });
    markers.add(marker);
  }

  getImage(bool isFromNetwork, int width, String path, double rotation,
      String markerId, String data,
      {String? subtitle}) async {
    final Uint8List iBytes;
    ui.Image i;
    Uint8List imageB;

    isFromNetwork
        ? iBytes =
            await imageToBytes(width: width, path: path, rotation: rotation)
        : iBytes =
            await imageToBytes(width: width, asset: path, rotation: rotation);

    if (markerId == pinMarkerId) {
      i = await decodeImageFromList(iBytes);

      final imageBytes = await getInfoWindowMarker(data, i, subtitle: subtitle);
      final ui.Image image = await decodeImageFromList(imageBytes);

      final ByteData? byteData =
          await image.toByteData(format: ui.ImageByteFormat.png);
      if (byteData == null) {
        throw Exception("No se pudieron obtener los bytes de la imagen.");
      }

      // Convierte los bytes a Uint8List
      imageB = byteData.buffer.asUint8List();
    } else {
      imageB = iBytes;
    }
    return imageB;
  }

  //Agregar ventana de información sobre el marcador
  addCustomInfoWindow(LatLng position,
      {String? speed,
      double? altitude,
      String? driver,
      String? showTime,
      String? leftTime,
      String? time}) async {
    final address =
        await deviceProvider.getGeocoder(position.latitude, position.longitude);
    if (customInfoWindowController != null) {
      customInfoWindowController!.addInfoWindow!(
        Container(
          padding: const EdgeInsets.all(10),
          decoration: BoxDecoration(
            color: Colors.white,
            borderRadius: const BorderRadius.all(Radius.circular(10.0)),
            boxShadow: [
              BoxShadow(
                color: Colors.black.withOpacity(0.2),
                spreadRadius: 2,
                blurRadius: 5,
                offset: const Offset(
                    0, 3), // ajusta la posición de la sombra (eje X, eje Y)
              ),
            ],
          ),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              labelOnInfoWindow(S.current.labelDireccion, address),
              (driver != null)
                  ? labelOnInfoWindow(S.current.labelConductor, driver)
                  : const SizedBox(),
              labelOnInfoWindow(
                  S.current.labelLatitud, position.latitude.toString()),
              labelOnInfoWindow(
                  S.current.labelLongitud, position.longitude.toString()),
              (altitude != null)
                  ? labelOnInfoWindow(S.current.labelAltitud, '$altitude m')
                  : const SizedBox(),
              (speed != null)
                  ? labelOnInfoWindow(S.current.labelVelocidad, '$speed kph')
                  : const SizedBox(),
              (showTime != null)
                  ? labelOnInfoWindow(S.current.labelArribo, showTime)
                  : const SizedBox(),
              (leftTime != null)
                  ? labelOnInfoWindow(S.current.labelPartio, leftTime)
                  : const SizedBox(),
              (time != null)
                  ? labelOnInfoWindow(S.current.labelDuracion, time)
                  : const SizedBox(),
            ],
          ),
        ),
        position,
      );
    }
  }

  //Mover marcador
  void startMarkerMovement() async {
    if (timer != null && timer!.isActive) {
      timer!.cancel();
    }

    Marker updateMarker;

    Marker existingMarker =
        markers.firstWhere((marker) => marker.markerId.value == pinMarkerId);

    _currentMarkerPosition = positions[_currentPolylineIndex];

    timer = Timer.periodic(const Duration(milliseconds: 300), (_) async {
      if (isPlay) {
        if (_currentPolylineIndex < positions.length - 1) {
          final Uint8List imageB;

          imageB = await getImage(
              false,
              80,
              'assets/icon/arrow-offline.png',
              rotations[_currentPolylineIndex],
              pinMarkerId,
              rawTime[_currentPolylineIndex].toString(),
              subtitle: '${speed[_currentPolylineIndex]} $speedSufix/h');

          updateMarker = existingMarker.copyWith(
            iconParam: BitmapDescriptor.fromBytes(imageB),
            positionParam: _currentMarkerPosition,
            // onTapParam: ()async{
            //   await addCustomInfoWindow(
            //     _currentMarkerPosition!,
            //     showTime: rawTime[_currentPolylineIndex].toString(),
            //   );
            // }
          );

          // mapController!.showMarkerInfoWindow(MarkerId(pinMarkerId));

          //Mover la camara a la nueva posicion visible
          if (mapController != null) {
            final LatLngBounds visibleBounds =
                await mapController!.getVisibleRegion();

            if (!visibleBounds.contains(updateMarker.position)) {
              // El marcador está fuera del rango de pantalla visible
              mapController!
                  .moveCamera(CameraUpdate.newLatLng(_currentMarkerPosition!));
              // mapController!.animateCamera();
            }
          }

          updateMarkerPosition(updateMarker);
          _currentMarkerPosition = positions[_currentPolylineIndex];
          _currentPolylineIndex++;
        } else {
          setIsPlay(false);
          timer!.cancel();
        }
      }
    });
  }

  //Parar movimiento del marcador y regresarlo a su posicion inicial
  void stopMarkerMovement() async {
    if (timer != null) {
      timer!.cancel();

      final Uint8List byteData;

      byteData = await getImage(false, 100, 'assets/icon/arrow-offline.png', 0,
          pinMarkerId, rawTime[0].toString(),
          subtitle: '${speed[0]} $speedSufix/h');

      Marker updateMarker;

      Marker existingMarker =
          markers.firstWhere((marker) => marker.markerId.value == pinMarkerId);

      //Reiniciar indice
      _currentPolylineIndex = 0;

      //Mover el marcador a la primera posicion
      updateMarker = existingMarker.copyWith(
          iconParam: BitmapDescriptor.fromBytes(byteData),
          // onTapParam: (){
          //   //Agregar nuevo markador seleccionado
          //   setElementSelected(pinMarkerId);
          //   //Agregar customInfoWindow
          //   addCustomInfoWindow(
          //     positions[0],
          //     showTime: rawTime[0].toString(),
          //   );
          // },
          // infoWindowParam: InfoWindow(
          //   title: rawTime[_currentPolylineIndex].toString(),
          //   snippet: speed[_currentPolylineIndex].toString() + speedSufix
          // ),
          positionParam: positions[0]);

      firstLocation != null ? moveCameraPosition(firstLocation!) : null;

      updateMarkerPosition(updateMarker);

      setIsPlay(false);

      // mapController!.showMarkerInfoWindow(updateMarker.markerId);
    }
  }

  //Iniciar al movimiento del marcador
  void playMarkerMovement() {
    setIsPlay(!isPlay);
    if (isPlay) {
      startMarkerMovement();
      return;
    }
    timer!.cancel();
  }

  //Cambiar la posicion del marcador
  void updateMarkerPosition(Marker updateMarker) {
    markers = markers.map((marker) {
      if (marker.markerId == updateMarker.markerId) {
        // Actualizar la posición del marcador
        return updateMarker.copyWith(positionParam: updateMarker.position);
      } else {
        return marker;
      }
    }).toSet();
    notifyListeners();
  }

  //Calcular limete(bounds) de las polilíneas
  LatLngBounds calculateLatLngBounds(List<LatLng> polylineCoordinates) {
    double minLat = double.infinity;
    double minLng = double.infinity;
    double maxLat = -double.infinity;
    double maxLng = -double.infinity;

    for (LatLng coordinate in polylineCoordinates) {
      if (coordinate.latitude < minLat) minLat = coordinate.latitude;
      if (coordinate.longitude < minLng) minLng = coordinate.longitude;
      if (coordinate.latitude > maxLat) maxLat = coordinate.latitude;
      if (coordinate.longitude > maxLng) maxLng = coordinate.longitude;
    }

    return LatLngBounds(
      southwest: LatLng(minLat, minLng),
      northeast: LatLng(maxLat, maxLng),
    );
  }

  //Posicion inicial de la camara
  initialCameraPosition(LatLng initialCamera) => CameraPosition(
        target: initialCamera,
        zoom: 4,
      );

  //Mover camara
  moveCameraPosition(LatLng newPosition) {
    if (mapController != null) {
      final cameraUpdate = CameraUpdate.newLatLng(newPosition);

      mapController!.animateCamera(cameraUpdate);
    }
  }
}
