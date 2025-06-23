import 'dart:io';

import 'package:custom_info_window/custom_info_window.dart';
import 'package:flutter/material.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:prosecat/controllers/map_controller.dart';
import 'package:prosecat/helpers/launch_url.dart';
import 'package:prosecat/models/device_response.dart';
import 'package:prosecat/providers/map_screen_provider.dart';
import 'package:prosecat/services/device_provider.dart';
import 'package:prosecat/widgets/widgets.dart';
import 'package:provider/provider.dart';
import 'package:animate_do/animate_do.dart';

class HomeMap extends StatelessWidget {
  const HomeMap({super.key});

  @override
  Widget build(BuildContext context) {
    CustomInfoWindowController customController = CustomInfoWindowController();

    final mapType = Provider.of<MapScreenProvider>(context);
    final mapController = Provider.of<MapController>(context);

    return Consumer<DeviceProvider>(builder: (context, device, child) {
      // device.getAllDevice();

      // mapController.streamController.add(device.devicesResponse);

      mapController.addEvent(device.devicesResponse);

      if (device.devicesResponse.isNotEmpty) {
        return Scaffold(
          body: Stack(
            children: [
              GoogleMap(
                // indoorViewEnabled: true,
                // fortyFiveDegreeImageryEnabled: true,
                myLocationButtonEnabled: false,
                mapToolbarEnabled: true,
                polylines: mapController.polylines,
                // trafficEnabled: true,
                polygons: mapController.polygons,
                mapType: mapType.getMapType,
                initialCameraPosition: mapController.getStartPosition,
                markers: {
                  ...mapController.markers,
                  ...mapController.nonClusteringMarkers,
                  ...mapController.nonClusteringLabels
                },
                onMapCreated: (GoogleMapController controller) async {
                  await mapController.onMapCreated(controller);

                  List<LatLng> positions = [];

                  getPositionsList(List<DeviceResponse> devices) {
                    positions.clear();
                    for (var element in devices) {
                      for (var element in element.items) {
                        positions.add(LatLng(element.lat, element.lng));
                      }
                    }
                    return positions;
                  }

                  Future.delayed(const Duration(seconds: 1), () {
                    mapController.moveCameraPositionByBounds(
                        getPositionsList(device.devicesResponse));
                  });

                  //CustomInfoWindow
                  mapController.customInfoWindowController ??= customController;

                  mapController.customInfoWindowController!
                      .googleMapController = controller;
                },
                onCameraMove: (position) {
                  mapController.getManager.onCameraMove(position);

                  if (mapController.customInfoWindowController != null &&
                      mapController.customInfoWindowController!.onCameraMove !=
                          null) {
                    mapController.customInfoWindowController!.onCameraMove!();
                  }
                },
                onTap: (position) async {
                  // mapController.setLatLngFromMarkerSelected = null;
                  if (mapController.customInfoWindowController != null) {
                    mapController.customInfoWindowController?.hideInfoWindow!();
                  }
                },

                //Para quitar el futureDelayed se puede aqui pero toma en cuenta que esto se volvera a dibujar, ese es el error
                onCameraIdle: () {
                  mapController.getManager.updateMap();
                },
              ),
              (mapController.customInfoWindowController != null)
                  ? CustomInfoWindow(
                      controller: mapController.customInfoWindowController!,
                      height: 60,
                      width: 180,
                      offset: 35,
                    )
                  : Container(),
              if (mapController.getLatLngFromMarkerSelected != null &&
                  Platform.isIOS)
                Positioned(
                  bottom: 30,
                  left: 10,
                  child: Row(
                    children: [
                      IconBox(
                        assetImage: 'assets/images/google_map_route.png',
                        onTap: () {
                          final String url =
                              'https://www.google.com/maps/dir/?api=1&destination=${mapController.getLatLngFromMarkerSelected!.latitude},${mapController.getLatLngFromMarkerSelected!.longitude}';
                          launchUrlToExternalApp(url);
                        },
                      ),
                      IconBox(
                        assetImage: 'assets/images/google_map.png',
                        onTap: () {
                          final String url =
                              'https://maps.google.com/?q=${mapController.getLatLngFromMarkerSelected!.latitude},${mapController.getLatLngFromMarkerSelected!.longitude}';
                          launchUrlToExternalApp(url);
                        },
                      )
                    ],
                  ),
                ),
            ],
          ),
        );
      }
      return const LoadingScreen();
    });
  }
}

class IconBox extends StatelessWidget {
  const IconBox({
    super.key,
    required this.assetImage,
    required this.onTap,
  });

  final String assetImage;
  final VoidCallback onTap;

  @override
  Widget build(BuildContext context) {
    return FadeInLeft(
      child: InkWell(
        onTap: onTap,
        child: Container(
          decoration: BoxDecoration(
              color: Colors.white70, borderRadius: BorderRadius.circular(2)),
          width: 35,
          height: 35,
          alignment: Alignment.center,
          child: Image.asset(
            assetImage,
            width: 22,
          ),
        ),
      ),
    );
  }
}
