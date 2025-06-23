import 'package:flutter/material.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:prosecat/controllers/controllers.dart';
import 'package:prosecat/generated/l10n.dart';
import 'package:prosecat/helpers/helpers.dart';
import 'package:prosecat/models/models.dart';
import 'package:prosecat/providers/pages_provider.dart';
import 'package:prosecat/services/services.dart';
import 'package:prosecat/system/global.dart';
import 'package:prosecat/widgets/widgets.dart';
import 'package:provider/provider.dart';
import 'package:skeletons/skeletons.dart';
import 'package:flutter/widgets.dart' as flutter_icon;
import 'dart:math' as math;
import 'package:collection/collection.dart';

class GroupItem extends StatelessWidget {
  const GroupItem(
      {super.key,
      required this.grupo,
      required this.isFromSearch,
      required this.isFromPageView});

  final List<Item> grupo;
  final bool isFromSearch;
  final bool isFromPageView;

  @override
  Widget build(BuildContext context) {
    final device = Provider.of<DeviceProvider>(context, listen: false);
    final mapController = Provider.of<MapController>(context, listen: false);
    double screenWidth = MediaQuery.of(context).size.width;
    final String apiUrl = GlobalVariables().apiUrl;

    return ListView.separated(
      physics: const BouncingScrollPhysics(),
      shrinkWrap: true,
      itemCount: grupo.length,
      separatorBuilder: (_, __) => const Divider(),
      itemBuilder: (BuildContext context, int index) {
        //Determinar si esta encendido o apagado
        Color onlineColor = Colors.green;
        Color offlineColor = Colors.red;
        ItemSensor? acc;
        ItemSensor? batery;
        Color? color = offlineColor;

        if (grupo[index].sensors!.isNotEmpty) {
          acc = grupo[index]
              .sensors!
              .firstWhereOrNull((element) => element.type == 'acc');
          batery = grupo[index]
              .sensors!
              .firstWhereOrNull((element) => element.type == 'battery');
        }

        color =
            acc != null ? (acc.val ? onlineColor : offlineColor) : offlineColor;

        //Determinar bateria
        String? bateryState;
        bateryState = batery?.value.toString();

        //Determinar el estado de la conexion
        Color stateColor = getColorFromString(grupo[index].iconColor);
        String state = '';

        if (stateColor == const Color.fromRGBO(255, 226, 98, 1)) {
          state = S.of(context).labelDetenido;
        } else if (stateColor == Colors.green.shade500) {
          state = S.of(context).labelEnLinea;
        } else {
          state = S.of(context).labelDesconectado;
        }

        return GestureDetector(
          onTap: () {
            //Si viene desde el buscador, hacer la navegacion 2 veces
            if (isFromSearch) {
              Navigator.pop(context);
            }
            if (isFromPageView) {
              Provider.of<PagesProvider>(context, listen: false)
                  .animateToPage(0);
            } else {
              Navigator.pop(context);
            }

            Provider.of<DeviceProvider>(context, listen: false).resume();

            //Abrir ventana
            mapController.setIsDeviceOverviewOpen = true;

            //Asignar un id del dispositivo cliqueado
            mapController.setDeviceOverviewItem = grupo[index].id;

            //Cambiar posición de vehículo seleccionado
            mapController.setLatLngFromMarkerSelected =
                LatLng(grupo[index].lat, grupo[index].lng);

            mapController.setIdFromDeviceSelected = grupo[index].id;

            //Mover la camara a la nueva posicion
            Future.delayed(
                const Duration(seconds: 1),
                () => mapController
                    .moveCamera(LatLng(grupo[index].lat, grupo[index].lng)));
          },
          child: Container(
            margin: const EdgeInsets.only(
              right: 10,
              left: 10,
              bottom: 5,
            ),
            child: Column(
              children: [
                Container(
                    padding:
                        const EdgeInsets.only(bottom: 2, right: 8, left: 10),
                    decoration: BoxDecoration(
                      border: Border.all(width: 1, color: Colors.grey),
                      color: Theme.of(context).brightness == Brightness.light
                          ? const Color.fromRGBO(255, 251, 216, 1)
                          : Colors.grey.shade900,
                      borderRadius: BorderRadius.circular(
                          10), // Ajusta el valor para controlar la cantidad de redondeo
                      boxShadow: [
                        BoxShadow(
                          color: Colors.grey.withOpacity(
                              0.5), // Color de la sombra y su opacidad
                          spreadRadius: 2, // Radio de la expansión de la sombra
                          blurRadius: 5, // Desenfoque de la sombra
                          offset: const Offset(
                              0, 3), // Desplazamiento en el eje X y Y
                        ),
                      ],
                    ),
                    child: FutureBuilder(
                        future: device.getGeocoder(
                            grupo[index].lat, grupo[index].lng),
                        builder: (context, AsyncSnapshot snapshot) {
                          if (snapshot.connectionState ==
                                  ConnectionState.done &&
                              snapshot.hasData &&
                              snapshot.data != null) {
                            final address = snapshot.data!;

                            return Row(
                              crossAxisAlignment: CrossAxisAlignment.center,
                              mainAxisAlignment: MainAxisAlignment.spaceBetween,
                              children: [
                                Container(
                                  alignment: AlignmentDirectional.center,
                                  width: 50,
                                  // color: Colors.amber,
                                  child: ConstrainedBox(
                                      constraints: BoxConstraints.loose(
                                          const Size(50, 50)),
                                      child: Image.network(
                                        'https://$apiUrl/${grupo[index].icon.path}',
                                        width: 35,
                                        height: 35,
                                      )),
                                ),
                                Column(
                                  // mainAxisAlignment: MainAxisAlignment.center,
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  children: [
                                    DeviceItem(
                                      text: grupo[index].name,
                                      screenWidth: screenWidth,
                                      isName: true,
                                      fontBold: true,
                                    ),
                                    DeviceItem(
                                      asset: 'assets/icon/placeholder.svg',
                                      text: address,
                                      screenWidth: screenWidth,
                                      isName: false,
                                      hideText: true,
                                    ),
                                    DeviceItem(
                                      asset: 'assets/icon/time.svg',
                                      text: grupo[index].time,
                                      screenWidth: screenWidth,
                                      isName: false,
                                    ),
                                    (grupo[index].deviceData.expirationDate !=
                                            null)
                                        ? DeviceItem(
                                            asset:
                                                'assets/icon/date-expired.svg',
                                            text:
                                                '${S.of(context).labelFechaExpiracion} ${grupo[index].deviceData.expirationDate}',
                                            screenWidth: screenWidth,
                                            isName: false,
                                          )
                                        : Container()
                                  ],
                                ),
                                Column(
                                  children: [
                                    Text(
                                      grupo[index].speed.toString(),
                                      style: const TextStyle(
                                          fontWeight: FontWeight.bold,
                                          fontSize: 25),
                                    ),
                                    Text(grupo[index].distanceUnitHour)
                                  ],
                                ),
                              ],
                            );
                          }
                          return SkeletonParagraph();
                        })),
                Container(
                  alignment: AlignmentDirectional.center,
                  width: (screenWidth * 80) / 100,
                  padding: const EdgeInsets.all(2),
                  decoration: BoxDecoration(
                    color: Theme.of(context).brightness == Brightness.light
                        ? Colors.white
                        : Colors.grey.shade900,
                    borderRadius: BorderRadius.circular(
                        3), // Ajusta el valor para controlar la cantidad de redondeo
                    boxShadow: [
                      BoxShadow(
                        color: Colors.grey.withOpacity(
                            0.5), // Color de la sombra y su opacidad
                        spreadRadius: 2, // Radio de la expansión de la sombra
                        blurRadius: 5, // Desenfoque de la sombra
                        offset: const Offset(
                            0, 3), // Desplazamiento en el eje X y Y
                      ),
                    ],
                  ),
                  child: Container(
                    padding: const EdgeInsets.symmetric(horizontal: 10),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(
                          S.of(context).labelSensores,
                          style:
                              Theme.of(context).textTheme.bodyLarge!.copyWith(
                                    fontSize: 12,
                                  ),
                          textScaler: TextScaler.linear(
                              ScaleSize.textScaleFactor(context)),
                        ),
                        Row(
                          mainAxisAlignment: MainAxisAlignment.start,
                          children: [
                            Row(
                              crossAxisAlignment: CrossAxisAlignment.center,
                              children: [
                                flutter_icon.Icon(
                                  Icons.key,
                                  color: color,
                                ),
                                Text(
                                  color == onlineColor
                                      ? S.of(context).labelEncendido
                                      : S.of(context).labelApagado,
                                  style: Theme.of(context)
                                      .textTheme
                                      .bodyLarge!
                                      .copyWith(
                                        fontSize: 12,
                                      ),
                                  textScaler: TextScaler.linear(
                                      ScaleSize.textScaleFactor(context)),
                                ),
                              ],
                            ),
                            const SizedBox(
                              width: 10,
                            ),
                            bateryState != null
                                ? Row(
                                    crossAxisAlignment:
                                        CrossAxisAlignment.center,
                                    children: [
                                      Transform.rotate(
                                          angle: math.pi / 2.0,
                                          child: flutter_icon.Icon(
                                            Icons.battery_full,
                                            color: onlineColor,
                                          )),
                                      Text(
                                        '${S.of(context).labelBateriaInterna} - ($bateryState)',
                                        style: Theme.of(context)
                                            .textTheme
                                            .bodyLarge!
                                            .copyWith(
                                              fontSize: 12,
                                            ),
                                      )
                                    ],
                                  )
                                : Container()
                          ],
                        ),
                        Row(
                          mainAxisAlignment: MainAxisAlignment.start,
                          children: [
                            Row(
                              crossAxisAlignment: CrossAxisAlignment.center,
                              children: [
                                flutter_icon.Icon(Icons.radio_button_checked,
                                    color: stateColor),
                                Text(
                                  state,
                                  style: Theme.of(context)
                                      .textTheme
                                      .bodyLarge!
                                      .copyWith(
                                        fontSize: 12,
                                      ),
                                  textScaler: TextScaler.linear(
                                      ScaleSize.textScaleFactor(context)),
                                ),
                              ],
                            ),
                            const SizedBox(
                              width: 10,
                            ),
                            Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                Text(
                                  S.of(context).labelUltimaConexion,
                                  style: Theme.of(context)
                                      .textTheme
                                      .bodyLarge!
                                      .copyWith(
                                        fontSize: 12,
                                      ),
                                  textScaler: TextScaler.linear(
                                      ScaleSize.textScaleFactor(context)),
                                ),
                                Text(
                                  grupo[index].time,
                                  style: Theme.of(context)
                                      .textTheme
                                      .bodyLarge!
                                      .copyWith(
                                        fontSize: 12,
                                      ),
                                  textScaler: TextScaler.linear(
                                      ScaleSize.textScaleFactor(context)),
                                ),
                              ],
                            )
                          ],
                        )
                      ],
                    ),
                  ),
                )
              ],
            ),
          ),
        );
      },
    );
  }
}

class DeviceItem extends StatefulWidget {
  final String? asset;
  final String text;
  final double screenWidth;
  final bool? fontBold;
  final bool isName;
  final bool? hideText;
  const DeviceItem({
    super.key,
    this.asset,
    required this.text,
    required this.screenWidth,
    this.fontBold,
    required this.isName,
    this.hideText,
  });

  @override
  State<DeviceItem> createState() => _DeviceItemState();
}

class _DeviceItemState extends State<DeviceItem> {
  bool isReadMore = false;
  @override
  Widget build(BuildContext context) {
    return Container(
      margin: const EdgeInsets.only(top: 6),
      child: Row(
        children: [
          widget.asset != null
              ? Padding(
                  padding: const EdgeInsets.only(right: 10),
                  child: SvgIcon(
                    asset: widget.asset!,
                    width: 18,
                    color: (!widget.isName)
                        ? Theme.of(context).brightness == Brightness.light
                            ? null
                            : Colors.white
                        : null,
                  ),
                )
              : const SizedBox(),
          AnimatedSize(
            curve: Curves.fastEaseInToSlowEaseOut,
            duration: const Duration(milliseconds: 300),
            child: ConstrainedBox(
                constraints: BoxConstraints.loose(
                    Size((widget.screenWidth * 50) / 100, 170)),
                child: Row(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Expanded(
                        // constraints: BoxConstraints.loose(Size((widget.screenWidth * 45) / 100, 170)),
                        child: buildText(context)),
                    widget.hideText != null && widget.hideText!
                        ? GestureDetector(
                            onTap: () =>
                                setState(() => isReadMore = !isReadMore),
                            child: AnimatedSwitcher(
                              duration: const Duration(milliseconds: 300),
                              child: isReadMore
                                  ? const SvgIcon(
                                      asset: 'assets/icon/eye-slash.svg',
                                      width: 17,
                                    )
                                  : const SvgIcon(
                                      asset: 'assets/icon/eye.svg',
                                      width: 17,
                                    ),
                            ))
                        : const SizedBox()
                  ],
                )),
          ),
        ],
      ),
    );
  }

  Text buildText(BuildContext context) {
    final maxLines = isReadMore ? null : 2;
    final overFlow = isReadMore ? null : TextOverflow.ellipsis;
    return Text(
      widget.text,
      style: Theme.of(context).textTheme.bodyLarge!.copyWith(
            fontSize: (widget.fontBold ?? false) ? 14 : 12,
            fontWeight: (widget.fontBold ?? false)
                ? FontWeight.bold
                : FontWeight.normal,
          ),
      maxLines: maxLines,
      overflow: overFlow,
      textScaler: TextScaler.linear(ScaleSize.textScaleFactor(context)),
    );
  }
}
