import 'package:custom_info_window/custom_info_window.dart';
import 'package:flutter/material.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:prosecat/controllers/controllers.dart';
import 'package:prosecat/generated/l10n.dart';
import 'package:prosecat/models/models.dart';
import 'package:prosecat/providers/map_screen_provider.dart';
import 'package:prosecat/services/services.dart';
import 'package:prosecat/widgets/widgets.dart';
import 'package:provider/provider.dart';

class HistoryMap extends StatefulWidget {
  const HistoryMap({
    super.key, 
    required this.deviceDetails, 
    required this.screenWidth,
  });
  final DeviceDetails? deviceDetails;
  final double screenWidth;

  @override
  State<HistoryMap> createState() => _HistoryMapState();
}

class _HistoryMapState extends State<HistoryMap> {
  MapRecordController? mapRecordController;
  DeviceProvider? deviceProvider;
  
  @override
  void didChangeDependencies() {
    mapRecordController = Provider.of<MapRecordController>(context, listen: false);   
    deviceProvider = Provider.of<DeviceProvider>(context, listen: false);   
    super.didChangeDependencies();
  }

  @override
  void dispose() {
    super.dispose();
    //Reiniciar fechar
    deviceProvider!.dateTo = DateTime.now();
    deviceProvider!.dateFrom = DateTime.now();
    
    // widget.deviceDetails = null;
    mapRecordController!.close();
  }
  @override
  Widget build(BuildContext context) {
    final mapScreenProvider = Provider.of<MapScreenProvider>(context);
    CustomInfoWindowController customController = CustomInfoWindowController();
    
    return Consumer<MapRecordController>(
      builder: (context, mapRecordController, child) {
        return Stack(
          children: [
            GoogleMap(
              markers: mapRecordController.markers,
              // polylines: mapRecordController.polylines,
              polylines: mapRecordController.polylines,
              mapType: mapScreenProvider.getMapTypeOverview[mapScreenProvider.count],
              onMapCreated: (GoogleMapController controller){            
                mapRecordController.mapController = null;
                if (mapRecordController.mapController == null) { 
                  mapRecordController.mapController = controller;

                  //Lo que pasa es que al salir deviceDetails queda con un estado con datos por lo que al volver a entrar se llena mas
                  mapRecordController.setItems(widget.deviceDetails!);
                  final timer = mapRecordController.timer;
                  if (timer != null) {
                    timer.cancel();
                    mapRecordController.setIsPlay(false);
                  }        

                  //CustomInfoWindow
                  mapRecordController.customInfoWindowController ??= customController;

                  mapRecordController.customInfoWindowController!.googleMapController = controller;

                }
              },
              onCameraMove: (position){
                if (mapRecordController.customInfoWindowController != null &&
                    mapRecordController.customInfoWindowController!.onCameraMove != null) {
                    mapRecordController.customInfoWindowController!.onCameraMove!();
                }
              },
              onTap: (position){
                if (mapRecordController.customInfoWindowController != null) {
                  mapRecordController.customInfoWindowController?.hideInfoWindow!();
                  
                  //Agregar nuevo markador seleccionado
                  mapRecordController.setElementSelected('');
                }
              },
              initialCameraPosition: mapRecordController.initialCameraPosition(LatLng(widget.deviceDetails!.items![0].items[0].lat, widget.deviceDetails!.items![0].items[0].lng)),
            ),
            (mapRecordController.customInfoWindowController != null)
              ? CustomInfoWindow(
                  controller: mapRecordController.customInfoWindowController!,
                  height: 260,
                  width: 300,
                  offset: 35,
                )
              : Container(),

              //Botones flotantes
              Positioned(
                right: 10,
                top: 10,
                child: DropdownButtonD(
                  children: [
                    getChildButton(
                      widget.screenWidth, 
                      Icons.map, 
                      S.of(context).labelMapas, 
                      () => mapScreenProvider.handlerMapTypeInOverview(),
                      context
                    ),
                    getChildButton(
                      widget.screenWidth, 
                      Icons.query_stats_rounded, 
                      S.of(context).labelLineasDeVelocidad, 
                      backgroundColor: (mapRecordController.getShowSpeedLines) ? Colors.black : Colors.white,
                      foregroundColor: (mapRecordController.getShowSpeedLines) ? Colors.white : Colors.black,
                      () {
                        mapRecordController.setIsLoading = true;
                        mapRecordController.setShowSpeedLines(!mapRecordController.getShowSpeedLines);
                        mapRecordController.handleTypesPolylines();
                      },
                      context
                    ),
                    getChildButton(
                      widget.screenWidth, 
                      Icons.zoom_in_map, 
                      S.of(context).center, 
                      () => mapRecordController.centerCamera(mapRecordController.positions),
                      context
                    ),
                  ]
                ),
              )
          ],
        );
      }
    );
  }
}