import 'package:flutter/material.dart';
import 'package:prosecat/controllers/map_controller.dart';
import 'package:prosecat/generated/l10n.dart';
import 'package:prosecat/helpers/get_color_from_string.dart';
import 'package:prosecat/helpers/navigator_key.dart';
import 'package:prosecat/models/device_response.dart';
import 'package:prosecat/providers/providers.dart';
import 'package:prosecat/services/services.dart';
import 'package:prosecat/ui/show_dialog.dart';
import 'package:provider/provider.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart' show LatLng;
import '../widgets/widgets.dart';
import 'package:flutter/widgets.dart' as flutter_icon;

class MapScreen extends StatefulWidget {
  const MapScreen({super.key});

  @override
  State<MapScreen> createState() => _MapScreenState();
}

class _MapScreenState extends State<MapScreen>
    with AutomaticKeepAliveClientMixin {
  @override
  Widget build(BuildContext context) {
    super.build(context);

    double screenHeight = MediaQuery.of(context).size.height;
    double screenWidth = MediaQuery.of(context).size.width;
    final mapController = Provider.of<MapController>(context);
    final mapType = Provider.of<MapScreenProvider>(context, listen: false);
    return Scaffold(
      body: SafeArea(
        child: Stack(
          children: [
            const HomeMap(),
            (mapController.getIsGeofencesBuilding)
                ? buildLoadingSpin()
                : const SizedBox(),
            DropdownButton(
              screenWidth: screenWidth,
              mapType: mapType,
              mapController: mapController,
            ),

            //Botones de dispositivos flotantes
            Container(
              // color: Colors.red,
              margin: const EdgeInsets.all(10),
              height: 35,
              width: screenWidth,
              child: FloatingRectangleButtons(mapController: mapController),
            ),
            ShowDeviceOverview(screenHeight),
          ],
        ),
      ),
    );
  }

  @override
  bool get wantKeepAlive => true;
}

class FloatingRectangleButtons extends StatelessWidget {
  const FloatingRectangleButtons({
    super.key,
    required this.mapController,
  });

  final MapController mapController;

  @override
  Widget build(BuildContext context) {
    return Consumer<DeviceProvider>(builder: (context, device, child) {
      List<Item> allDevice = [];
      for (var deviceResponse in device.devicesResponse) {
        for (var element in deviceResponse.items) {
          allDevice.add(element);
        }
      }

      return allDevice.isNotEmpty
          ? ListView.builder(
              scrollDirection: Axis.horizontal,
              itemCount: allDevice.length,
              itemBuilder: (_, int index) {
                return Container(
                  margin: const EdgeInsets.only(right: 5),
                  child: ElevatedButton.icon(
                    onPressed: () {
                      //Mover la camara a la nueva posicion
                      mapController.moveCamera(
                          LatLng(allDevice[index].lat, allDevice[index].lng));

                      //Cambiar posición de vehículo seleccionado
                      mapController.setLatLngFromMarkerSelected =
                          LatLng(allDevice[index].lat, allDevice[index].lng);

                      //Asignar un id del dispositivo cliqueado
                      mapController.setDeviceOverviewItem = allDevice[index].id;

                      mapController.setIdFromDeviceSelected =
                          allDevice[index].id;

                      //Abrir ventana
                      mapController.setIsDeviceOverviewOpen = true;
                    },
                    icon: flutter_icon.Icon(
                      Icons.radio_button_checked,
                      color: getColorFromString(allDevice[index].iconColor),
                    ),
                    // CircleAvatar(
                    //   radius: 10,
                    // backgroundColor: getColorFromString(allDevice[index].iconColor),
                    //   child:
                    // ),
                    label: Text(
                      allDevice[index].name,
                      style: TextStyle(
                          color:
                              Theme.of(context).brightness == Brightness.light
                                  ? Colors.black87
                                  : Colors.white),
                    ),
                  ),
                );
              })
          : Container();
    });
  }
}

class DropdownButton extends StatelessWidget {
  const DropdownButton({
    super.key,
    required this.screenWidth,
    required this.mapType,
    required this.mapController,
  });

  final double screenWidth;
  final MapScreenProvider mapType;
  final MapController mapController;

  @override
  Widget build(BuildContext context) {
    return Positioned(
        right: 0,
        top: 55,
        child: Container(
            alignment: Alignment.center,
            width: (screenWidth * 20) / 100,
            child: DropdownButtonD(
              children: [
                getChildButton(screenWidth, Icons.layers, S.current.labelMapas,
                    () => mapType.setMapType(), context),
                getChildButton(
                    screenWidth,
                    Icons.fullscreen_exit_rounded,
                    S.current.labelExpandir,
                    () => mapController.changeZoom(1),
                    context),
                getChildButton(
                  screenWidth,
                  Icons.pentagon_outlined,
                  S.current.labelRutas,
                  () async {
                    if (mapController.getIsGeofence) {
                      mapController.deleteGeofences();
                      return;
                    }
                    mapController.setIsGeofence();
                    mapController.setIsGeofencesBuilding(true);
                    final response = await Provider.of<DeviceProvider>(context,
                            listen: false)
                        .getGeofences();
                    if (response.isNotEmpty) {
                      mapController.getLatLng(response);
                      return;
                    }
                    mapController.setIsGeofencesBuilding(false);
                    mapController.setIsGeofence();

                    return await showMyDialog(
                        navigatorKey.currentContext!,
                        S.current.mensaje,
                        S.current.errorSinDatos,
                        S.current.aceptarMensaje);
                  },
                  context,
                  // backgroundColor: Theme.of(context).brightness == Brightness.light ? backgroundColor : Colors.black87,
                  // foregroundColor: Theme.of(context).brightness == Brightness.light ? foregroundColor : Colors.white,

                  backgroundColor: (mapController.getIsGeofence)
                      ? Colors.black
                      : Colors.white,
                  foregroundColor: (mapController.getIsGeofence)
                      ? Colors.white
                      : Colors.black,
                ),
                getChildButton(
                  screenWidth,
                  Icons.my_location_outlined,
                  S.current.labelMiUbicacion,
                  () => mapController.setShowImgDirection(),
                  context,
                  backgroundColor: (mapController.getShowImgDirection)
                      ? Colors.black
                      : Colors.white,
                  foregroundColor: (mapController.getShowImgDirection)
                      ? Colors.white
                      : Colors.black,
                ),
                getChildButton(
                  screenWidth,
                  Icons.polyline,
                  S.current.labelMostrarRecorrido,
                  () => mapController.setShowPolylines(),
                  context,
                  backgroundColor: (mapController.getShowPolylines)
                      ? Colors.black
                      : Colors.white,
                  foregroundColor: (mapController.getShowPolylines)
                      ? Colors.white
                      : Colors.black,
                ),
                getChildButton(
                  screenWidth,
                  Icons.location_pin,
                  S.current.puntosDeInteres,
                  () => mapController.setShowTour(),
                  context,
                  backgroundColor:
                      (mapController.getShowTour) ? Colors.black : Colors.white,
                  foregroundColor:
                      (mapController.getShowTour) ? Colors.white : Colors.black,
                ),
              ],
            )));
  }
}

class ShowDeviceOverview extends StatelessWidget {
  final double screenHeight;

  const ShowDeviceOverview(this.screenHeight, {super.key});

  @override
  Widget build(BuildContext context) {
    final mapController = Provider.of<MapController>(context);
    return AnimatedPositioned(
        duration: const Duration(milliseconds: 300),
        // bottom: _isOpen ? 0 : -MediaQuery.of(context).size.height * 0.9,
        bottom: mapController.getIsDeviceOverviewOpen
            ? 0
            : -MediaQuery.of(context).size.height * 0.9,
        left: 0,
        right: 0,
        height: MediaQuery.of(context).size.height * 0.9,
        child: DraggableScrollableSheet(builder: (context, scrollcontroller) {
          return Container(
              padding: const EdgeInsets.only(bottom: 23),
              decoration: BoxDecoration(
                borderRadius: const BorderRadius.only(
                  topLeft: Radius.circular(30),
                  topRight: Radius.circular(30),
                ),
                gradient: LinearGradient(
                  begin: Alignment.center,
                  end: Alignment.bottomCenter,
                  colors: [
                    Colors.transparent, // Color arriba (transparente)
                    Theme.of(context).brightness == Brightness.light
                        ? Colors.white // Color abajo para tema claro
                        : Colors.grey.shade900, // Color abajo para tema oscuro
                    Theme.of(context).brightness == Brightness.light
                        ? Colors.white // Color abajo para tema claro
                        : Colors.grey.shade900, // Color abajo para tema oscuro
                  ],
                  stops: const [
                    0.0,
                    0.5,
                    1.0
                  ], // Ajusta las ubicaciones de los colores
                ),
              ),
              child: DeviceOverview(
                controller: scrollcontroller,
              ));
        }));
  }
}
