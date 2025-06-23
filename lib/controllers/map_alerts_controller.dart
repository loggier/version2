import 'dart:async';
import 'package:flutter/material.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:prosecat/generated/l10n.dart';
import 'package:prosecat/helpers/helpers.dart';
import 'package:custom_info_window/custom_info_window.dart';
import '../models/models.dart';

class MapAlertsController extends ChangeNotifier {
  final Completer<GoogleMapController> _controller = Completer();
  Set<Marker> markers = {};
  CustomInfoWindowController? customInfoWindowController;

  Item? item;

  GoogleMapController? mapController;
  String elementSelected = '';

  //Guardar el id del markador seleccionado
  String get getElementSelected => elementSelected;
  setElementSelected(String value) {
    elementSelected = value;
    notifyListeners();
  }

  close() {
    markers.clear();
    elementSelected = '';
    item = null;
  }

  //Agregar un custom marker
  addMarker(int id, double lat, double lng, String asset, String message,
      String date, String speed, String event,
      {String? address}) async {
    const markerId = MarkerId('mapAlerts');
    final position = LatLng(lat, lng);

    moveCamera(position);

    Marker marker = Marker(
        markerId: markerId,
        position: position,
        onTap: () {
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
                      offset: const Offset(0,
                          3), // ajusta la posición de la sombra (eje X, eje Y)
                    ),
                  ],
                ),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    labelOnInfoWindow(event, ''),
                    labelOnInfoWindow(S.current.labelNombre, message),
                    address != null
                        ? labelOnInfoWindow(S.current.labelDireccion, address)
                        : Container(),
                    labelOnInfoWindow(S.current.labelFecha, date),
                    labelOnInfoWindow(S.current.labelPosicion, '$lat, $lng'),
                    labelOnInfoWindow(S.current.labelVelocidad, '$speed kph'),
                  ],
                ),
              ),
              LatLng(lat, lng),
            );
          }
        },
        // ignore: deprecated_member_use
        icon: BitmapDescriptor.fromBytes(
          await imageToBytes(asset: asset),
        ));

    markers = {marker};

    notifyListeners();
  }

  onMapCreated(GoogleMapController controller) async {
    mapController = controller;
    // await marker();
    if (!_controller.isCompleted) {
      _controller.complete(mapController);
    }
  }

  //Mover posición de la camara
  moveCamera(LatLng newPosition) {
    if (mapController != null) {
      final cameraUpdate = CameraUpdate.newCameraPosition(
          CameraPosition(target: newPosition, zoom: 15));
      mapController!.animateCamera(cameraUpdate);
    }
  }

  //Posicion inicial del mapa
  CameraPosition getStartPosition() {
    return const CameraPosition(
      target: LatLng(24.713568, -103.050108),
      zoom: 1,
    );
  }
}
