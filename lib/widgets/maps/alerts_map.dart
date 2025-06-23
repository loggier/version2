import 'package:custom_info_window/custom_info_window.dart';
import 'package:flutter/material.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:prosecat/controllers/controllers.dart';
import 'package:prosecat/providers/providers.dart';
import 'package:prosecat/widgets/widgets.dart';
import 'package:provider/provider.dart';

class AlertsMap extends StatefulWidget {
  const AlertsMap({
    super.key,
  });

  @override
  State<AlertsMap> createState() => _AlertsMapState();
}

class _AlertsMapState extends State<AlertsMap>{
  @override
  void dispose() {
    super.dispose();
    final alertsController = MapAlertsController();
    if (alertsController.customInfoWindowController != null) {      
      alertsController.customInfoWindowController!.dispose();
    }
    
  }
  @override
  Widget build(BuildContext context) {
    final mapAlertsController = Provider.of<MapAlertsController>(context);
    final mapScreenProvider = Provider.of<MapScreenProvider>(context);
    CustomInfoWindowController customController = CustomInfoWindowController();
    GoogleMapController controller;

    return Stack(
      children: [
        GoogleMap(          
          mapType: mapScreenProvider.getMapTypeOverview[mapScreenProvider.count],
          initialCameraPosition: mapAlertsController.getStartPosition(),
          onMapCreated: (GoogleMapController mapController){
            controller = mapController;    
            
            mapAlertsController.onMapCreated(controller);
          
            mapAlertsController.customInfoWindowController ??= customController;

            mapAlertsController.customInfoWindowController!.googleMapController = controller;
            
          },
          markers: mapAlertsController.markers,
          onCameraMove: (position) {
            if (mapAlertsController.customInfoWindowController != null &&
                mapAlertsController.customInfoWindowController!.onCameraMove != null) {
              mapAlertsController.customInfoWindowController!.onCameraMove!();
            }
          },
          onTap: (position){
            if (mapAlertsController.customInfoWindowController != null) {
              
              mapAlertsController.customInfoWindowController?.hideInfoWindow!();
            }
          },
        ),
        (mapAlertsController.customInfoWindowController != null)

          ? CustomInfoWindow(
              controller: mapAlertsController.customInfoWindowController!,
              height: 200,
              width: 300,
              offset: 35,
            )
          : Container(),
        const ButtonHandlerStyleMap(),
      ],
    );
  }
}