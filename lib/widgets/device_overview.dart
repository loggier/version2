import 'package:flutter/material.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:prosecat/controllers/map_controller.dart';
import 'package:prosecat/generated/l10n.dart';
import 'package:prosecat/helpers/helpers.dart';
import 'package:prosecat/models/models.dart';
import 'package:prosecat/services/services.dart';
import 'package:prosecat/widgets/circular_color_button.dart';
import 'package:prosecat/widgets/widgets.dart';
import 'package:provider/provider.dart';
import 'package:fluttertoast/fluttertoast.dart';

class DeviceOverview extends StatelessWidget {
  const DeviceOverview({
    super.key,
    required this.controller,
  });
  final ScrollController controller;
  @override
  Widget build(BuildContext context) {
    final double width = MediaQuery.of(context).size.width;
    final mapController = Provider.of<MapController>(context, listen: false);
    final LatLng? latlngDeviceSelected = context.select<MapController, LatLng?>(
        (provider) => provider.getLatLngFromMarkerSelected);

    final deviceId = mapController.getIdFromDeviceSelected;

    final Color color = Theme.of(context).brightness == Brightness.light
        ? Colors.grey.shade900
        : Colors.white;
    final size = MediaQuery.of(context).size;

    return SingleChildScrollView(
      controller: controller,
      child: Consumer<DeviceProvider>(builder: (context, device, child) {
        Item? item;

        for (var list in device.devicesResponse) {
          for (var element in list.items) {
            if (element.id == deviceId) {
              item = element;
            }
          }
        }

        if (item == null) {
          return Container();
        }

        final deviceInfo = DeviceInfo(
            item.time,
            item.totalDistance.toString(),
            'km',
            item.stopDuration,
            item.deviceData.imei,
            item.course.toString(),
            driver: item.driver != '-' ? item.driver : null);

        final deviceInfoMap = deviceInfo.toMap();
        return Column(
          children: [
            Padding(
                padding:
                    const EdgeInsets.symmetric(horizontal: 10, vertical: 5),
                child: (latlngDeviceSelected != null)
                    ? Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          Row(
                            children: [
                              IconBox(
                                assetImage:
                                    'assets/images/google_map_route.png',
                                onTap: () {
                                  final String url =
                                      'https://www.google.com/maps/dir/?api=1&destination=${latlngDeviceSelected.latitude},${latlngDeviceSelected.longitude}';
                                  launchUrlToExternalApp(url);
                                },
                              ),
                              IconBox(
                                assetImage: 'assets/images/google_map.png',
                                onTap: () {
                                  final String url =
                                      'https://maps.google.com/?q=${latlngDeviceSelected.latitude},${latlngDeviceSelected.longitude}';
                                  launchUrlToExternalApp(url);
                                },
                              )
                            ],
                          ),
                          Row(
                            children: [
                              Column(
                                children: [
                                  CircularColorButton(
                                    size: (size.width * 10) / 100,
                                    color:
                                        const Color.fromRGBO(102, 188, 99, 1),
                                    image: 'assets/icon/engine_black.png',
                                    border: Border.all(
                                        color: const Color.fromARGB(
                                            255, 54, 182, 50),
                                        width: 2),
                                    onTap: () {
                                      showConfirmationDialog(context, [
                                        TextSpan(
                                            text:
                                                '${S.of(context).labelDeseaEnviarElComando} ',
                                            style:
                                                const TextStyle(fontSize: 17)),
                                        TextSpan(
                                          text: S.of(context).desbloquearMotor,
                                          style: const TextStyle(
                                              fontWeight: FontWeight.bold,
                                              fontSize: 17),
                                        ),
                                        TextSpan(
                                            text:
                                                ' ${S.of(context).labelAlaUnidad} ',
                                            style:
                                                const TextStyle(fontSize: 17)),
                                        TextSpan(
                                          text: item!.name,
                                          style: const TextStyle(
                                              fontWeight: FontWeight.bold,
                                              fontSize: 17),
                                        ),
                                      ], onAcceptPressed: () {
                                        Navigator.pop(
                                            navigatorKey.currentContext!, 'OK');

                                        device.postCommandDevices(
                                            'GPRS',
                                            item!.id.toString(),
                                            'engineResume',
                                            '-');

                                        Fluttertoast.showToast(
                                            msg: "Se ha enviado el comando");
                                      });
                                    },
                                  ),
                                ],
                              ),
                              const SizedBox(width: 8),
                              Column(
                                children: [
                                  CircularColorButton(
                                    size: (size.width * 10) / 100,
                                    color: const Color.fromRGBO(163, 75, 71, 1),
                                    image: 'assets/icon/engine_black.png',
                                    border: Border.all(
                                        color: const Color.fromARGB(
                                            255, 155, 40, 34),
                                        width: 2),
                                    onTap: () {
                                      showConfirmationDialog(context, [
                                        TextSpan(
                                            text:
                                                '${S.of(context).labelDeseaEnviarElComando} ',
                                            style:
                                                const TextStyle(fontSize: 17)),
                                        TextSpan(
                                          text: S.of(context).lockEngine,
                                          style: const TextStyle(
                                              fontWeight: FontWeight.bold,
                                              fontSize: 17),
                                        ),
                                        TextSpan(
                                            text:
                                                ' ${S.of(context).labelAlaUnidad} ',
                                            style:
                                                const TextStyle(fontSize: 17)),
                                        TextSpan(
                                          text: item!.name,
                                          style: const TextStyle(
                                              fontWeight: FontWeight.bold,
                                              fontSize: 17),
                                        ),
                                      ], onAcceptPressed: () {
                                        Navigator.pop(
                                            navigatorKey.currentContext!, 'OK');

                                        device.postCommandDevices(
                                            'GPRS',
                                            item!.id.toString(),
                                            'engineStop',
                                            '-');

                                        Fluttertoast.showToast(
                                            msg: S
                                                .of(context)
                                                .seHaEnviadoElComando);
                                      });
                                    },
                                  ),
                                ],
                              )
                            ],
                          ),
                        ],
                      )
                    : const SizedBox()),
            Container(
                padding: const EdgeInsets.only(bottom: 23),
                decoration: BoxDecoration(
                  color: Theme.of(context).brightness == Brightness.light
                      ? Colors.white
                      : Colors.grey.shade900,
                  borderRadius: const BorderRadius.only(
                    topLeft: Radius.circular(30),
                    topRight: Radius.circular(30),
                  ),
                ),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    // header con nombre del dispositivo
                    (mapController.getIsDeviceOverviewOpen)
                        ? DraggableHeader(
                            text: item.name,
                            backColor: getColorFromString(item.iconColor),
                            asset: item.icon.path,
                            deviceData: item.deviceData.idMdvr,
                            id: item.id.toString(),
                            comandFunction: () {
                              final deviceProvider =
                                  Provider.of<DeviceProvider>(context,
                                      listen: false);
                              deviceProvider.getCommandDevices(item!.id).then(
                                  (value) => showModalBottom(context, value,
                                      item!.name, item.id.toString()));
                            },
                          )
                        : Container(),

                    const Divider(),

                    // Tarjetas con informacion del vehiculo
                    (mapController.getIsDeviceOverviewOpen)
                        ? Column(
                            children: [
                              TargetInformation(
                                text: mapController.deviceAddress,
                                asset: 'assets/icon/sensors/info/location.svg',
                              ),
                              for (var key in deviceInfoMap.keys)
                                TargetInformation(
                                  title: key,
                                  text: deviceInfoMap[key],
                                  asset: assetFromName(key),
                                ),
                              GestureDetector(
                                  onTap: () {
                                    final String url =
                                        'https://www.google.com/maps/dir/?api=1&destination=${item!.lat},${item.lng}';
                                    launchUrlToExternalApp(url);
                                  },
                                  child: TargetInformation(
                                    text: S.of(context).labelIrA('Google Maps'),
                                    asset:
                                        'assets/icon/sensors/info/terrestrial.svg',
                                  )),
                              GestureDetector(
                                  onTap: () => onBasicAlertPressed(
                                      context, item!.name, item.id),
                                  child: TargetInformation(
                                    text: S.of(context).tituloCompartir,
                                    asset: 'assets/images/share.svg',
                                  ))
                            ],
                          )
                        : Container(),

                    // Tarjetas con informacion del vehiculo
                    (mapController.getIsDeviceOverviewOpen &&
                            item.sensors!.isNotEmpty)
                        ? Container(
                            alignment: AlignmentDirectional.center,
                            margin: const EdgeInsets.symmetric(horizontal: 10),
                            decoration: BoxDecoration(
                              color: Theme.of(context).brightness ==
                                      Brightness.light
                                  ? Colors.white
                                  : Colors.grey.shade900,
                              borderRadius: BorderRadius.circular(10),
                              boxShadow: [
                                BoxShadow(
                                  color: Colors.grey
                                      .withOpacity(0.3), // color de la sombra
                                  spreadRadius: 3, // ancho de la sombra
                                  blurRadius: 9, // intensidad de la sombra
                                  offset: const Offset(0,
                                      3), // posición de la sombra (eje x, eje y)
                                ),
                              ],
                            ),
                            child: Column(
                              // crossAxisAlignment: (item.sensors!.length == 1) ? CrossAxisAlignment.start : CrossAxisAlignment.center,
                              children: [
                                Container(
                                    alignment: AlignmentDirectional.center,
                                    width: (width * 86) / 100,
                                    margin: const EdgeInsets.all(10),
                                    child: Text(
                                      S.of(context).labelSensores,
                                      style:
                                          TextStyle(fontSize: 20, color: color),
                                    )),
                                Wrap(
                                  alignment: WrapAlignment.start,
                                  children: [
                                    //text: device.devicesResponse[0].items[0].stopDuration,);
                                    for (var item in item.sensors!)
                                      Row(
                                        mainAxisAlignment:
                                            MainAxisAlignment.center,
                                        children: [
                                          Container(
                                              // color: Colors.red,
                                              width: (width * 48) / 100,
                                              padding: const EdgeInsets.only(
                                                  bottom: 10),
                                              child: Row(
                                                children: [
                                                  Image.asset(
                                                    assetFromTypeSensor(
                                                        item.name,
                                                        value: item.val
                                                            .toString()),
                                                    width: 20,
                                                  ),
                                                  const SizedBox(width: 10),
                                                  Expanded(
                                                    child: Text(
                                                      item.name,
                                                      style: TextStyle(
                                                          color: color),
                                                    ),
                                                  ),
                                                ],
                                              )),
                                          Container(
                                              padding: const EdgeInsets.only(
                                                  bottom: 10),
                                              // color: Colors.blue,
                                              width: (width * 35) / 100,
                                              child: Text(
                                                item.value,
                                                style: TextStyle(color: color),
                                              ))
                                        ],
                                      )
                                    // SizedBox(
                                    //   width: (width * 48) / 100,
                                    //   child: TargetInformation(title: item.name, text: item.value, asset: assetFromTypeSensor(item.name, value: item.val.toString()),)
                                    // )
                                  ],
                                ),
                              ],
                            ))
                        : Container()
                  ],
                )),
          ],
        );
      }),
    );
  }
}

Future<dynamic> showModalBottom(
    BuildContext context,
    List<CommandsResponse> commandsResponse,
    String deviceName,
    String deviceId) {
  // final itemCount = commandsResponse.length;
  // final screenHeight = MediaQuery.of(context).size.height;
  // final itemHeight = screenHeight / itemCount;

  // double initialChildSize = 0.5;
  // if (itemHeight < initialChildSize) {
  //   initialChildSize = itemCount * itemHeight / screenHeight;
  // }

  return showModalBottomSheet(
    // isScrollControlled: true,
    useSafeArea: true,
    // useRootNavigator: true,
    // isDismissible: false,
    shape: const RoundedRectangleBorder(borderRadius: BorderRadius.zero),
    context: context,
    builder: (context) {
      return DraggableScrollableSheet(
          initialChildSize: 0.30,
          // minChildSize: 0.4,
          maxChildSize: 1,
          expand: false,
          // snap: true,
          builder: (context, scrollController) {
            return BottomSheetItemsColumn(
              scrollController,
              commandsResponse: commandsResponse,
              deviceName: deviceName,
              deviceId: deviceId,
            );
          });
    },
  );
}

//Diseño del DraggableScrollableSheet
class BottomSheetItemsColumn extends StatelessWidget {
  final ScrollController scrollController;
  final String? deviceName;
  final String deviceId;
  final List<CommandsResponse> commandsResponse;
  const BottomSheetItemsColumn(this.scrollController,
      {super.key,
      required this.commandsResponse,
      this.deviceName,
      required this.deviceId});

  @override
  Widget build(BuildContext context) {
    return SingleChildScrollView(
      controller: scrollController,
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Padding(
            padding:
                const EdgeInsets.only(top: 20, left: 20, right: 20, bottom: 25),
            child: Text(
              '${S.of(context).labelComando.toUpperCase()} GPRS',
              style: const TextStyle(fontSize: 18, color: Colors.grey),
            ),
          ),
          (commandsResponse.isNotEmpty)
              ? Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    for (var element in commandsResponse)
                      LabelCommand(
                          title: element.title!,
                          deviceName: deviceName,
                          deviceId: deviceId,
                          commandType: element.type!,
                          defaultData: element.defaultData ?? ""),
                  ],
                )
              : LabelCommand(
                  title: S.of(context).labelSinComandos.toUpperCase()),
        ],
      ),
    );
  }
}

//Alerta
class LabelCommand extends StatelessWidget {
  const LabelCommand(
      {super.key,
      required this.title,
      this.deviceName,
      this.deviceId,
      this.commandType,
      this.defaultData});

  final String title;
  final String? deviceName, deviceId, commandType, defaultData;

  @override
  Widget build(BuildContext context) {
    final deviceProvider = Provider.of<DeviceProvider>(context, listen: false);

    return GestureDetector(
      onTap: (deviceName == null)
          ? null
          : () {
              Navigator.pop(context);
              showConfirmationDialog(context, [
                TextSpan(
                    text: '${S.of(context).labelDeseaEnviarElComando} ',
                    style: const TextStyle(fontSize: 17)),
                TextSpan(
                  text: title,
                  style: const TextStyle(
                      fontWeight: FontWeight.bold, fontSize: 17),
                ),
                TextSpan(
                    text: ' ${S.of(context).labelAlaUnidad} ',
                    style: const TextStyle(fontSize: 17)),
                TextSpan(
                  text: deviceName,
                  style: const TextStyle(
                      fontWeight: FontWeight.bold, fontSize: 17),
                ),
              ], onAcceptPressed: () {
                Navigator.pop(navigatorKey.currentContext!, 'OK');

                deviceProvider.postCommandDevices(
                    'GPRS', deviceId!, commandType!, defaultData!);

                Fluttertoast.showToast(msg: "Se ha enviado el comando");
              });
            },
      child: Container(
        width: double.infinity,
        padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 15),
        child: Text(
          title,
          style: const TextStyle(fontSize: 18),
        ),
      ),
    );
  }
}

void showConfirmationDialog(BuildContext context, List<InlineSpan> text,
    {VoidCallback? onAcceptPressed}) {
  showDialog<String>(
    context: context,
    builder: (BuildContext context) => AlertDialog(
      title: Text(S.of(context).mensaje),
      content: RichText(
        text:
            TextSpan(style: DefaultTextStyle.of(context).style, children: text),
      ),
      actions: <Widget>[
        TextButton(
          onPressed: () => Navigator.pop(context, 'Cancel'),
          child: Text(
            S.of(context).labelCancelar,
            style: TextStyle(color: Theme.of(context).colorScheme.primary),
          ),
        ),
        TextButton(
          onPressed: onAcceptPressed,
          child: Text(
            'OK',
            style: TextStyle(color: Theme.of(context).colorScheme.primary),
          ),
        ),
      ],
    ),
  );
}
