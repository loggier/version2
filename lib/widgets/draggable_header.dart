
// ignore_for_file: avoid_print

import 'package:flutter/material.dart';
import 'package:prosecat/controllers/map_controller.dart';
import 'package:prosecat/generated/l10n.dart';
import 'package:prosecat/services/device_provider.dart';
import 'package:prosecat/system/global.dart';
import 'package:prosecat/widgets/svg_icon.dart';
import 'package:provider/provider.dart';
import 'package:prosecat/widgets/vehicle_camera/show_camera.dart';

class DraggableHeader extends StatelessWidget {
  const DraggableHeader({
    super.key,
    required this.backColor,
    required this.text,
    required this.asset,
    required this.deviceData,
    required this.id,
    this.comandFunction,
  });

  final Color backColor;
  final String text, asset, id;
  final VoidCallback? comandFunction;
  final List<dynamic> deviceData;

  @override
  Widget build(BuildContext context) {
    final mapController = Provider.of<MapController>(context, listen: false);
    final double width = MediaQuery.of(context).size.width;
    final String apiUrl = GlobalVariables().apiUrl;
    final deviceProvider = Provider.of<DeviceProvider>(context, listen: false);

    String state = '';

    if (backColor == const Color.fromRGBO(255, 226, 98, 1)) {
      state = S.of(context).labelDetenido;
    } else if (backColor == Colors.green.shade500) {
      state = S.of(context).labelEnLinea;
    } else {
      state = S.of(context).labelDesconectado;
    }

    return Container(
      width: double.infinity,
      decoration: const BoxDecoration(
        borderRadius: BorderRadius.only(
            topLeft: Radius.circular(15), topRight: Radius.circular(15)),
      ),
      child: Stack(
        alignment: AlignmentDirectional.center,
        children: [
          Column(
            children: [
              //Linea blanca
              Container(
                width: 50,
                height: 7,
                margin: const EdgeInsets.only(top: 10),
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(5),
                  color: Colors.grey.shade400,
                ),
              ),
              //Nombre del vehiculo
              Container(
                padding: const EdgeInsets.only(right: 8),
                width: (width * 80) / 100,
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    //Nombre, estado y imagen
                    Row(
                      crossAxisAlignment: CrossAxisAlignment.center,
                      children: [
                        //Imagen
                        ConstrainedBox(
                            constraints:
                                BoxConstraints.loose(const Size(55, 50)),
                            child: Image.network(
                              'https://$apiUrl/$asset',
                              fit: BoxFit.contain,
                            )),
                        const SizedBox(
                          width: 15,
                        ),
                        //Nombre y estado
                        Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Row(
                              children: [
                                SvgIcon(
                                    asset: 'assets/icon/key.svg',
                                    width: 15,
                                    color: Theme.of(context).brightness ==
                                            Brightness.light
                                        ? null
                                        : Colors.white),
                                const SizedBox(
                                  width: 5,
                                ),
                                FittedBox(
                                  child: Text(text,
                                      style: const TextStyle(
                                          // fontSize: 18,
                                          fontWeight: FontWeight.bold)),
                                ),
                              ],
                            ),
                            Container(
                                decoration: BoxDecoration(
                                    color: backColor,
                                    borderRadius: BorderRadius.circular(3)),
                                padding: const EdgeInsets.symmetric(
                                    horizontal: 7, vertical: 1),
                                child: Text(
                                  state,
                                  style: const TextStyle(
                                      fontWeight: FontWeight.w600),
                                )),
                          ],
                        ),
                      ],
                    ),
                    //Comando
                    GestureDetector(
                      onTap: comandFunction,
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: <Widget>[
                          Column(
                            mainAxisAlignment: MainAxisAlignment.center,
                            children: <Widget>[
                              const SvgIcon(
                                asset:
                                    'assets/icon/sensors/info/telegram-svgrepo-com.svg',
                              ),
                              Text(
                                S.of(context).labelComando,
                                style: TextStyle(
                                  color: Theme.of(context).brightness ==
                                          Brightness.light
                                      ? Colors.grey.shade900
                                      : Colors.white,
                                ),
                              ),
                            ],
                          ),
                          const SizedBox(width: 5), // Espacio entre los botones
                        ],
                      ),
                    ),
                    GestureDetector(
                      onTap: () {
                        // Llama a la función showCamera con los parámetros requeridos
                        print(' el ID: ');
                        print(id);

                        deviceProvider.checkCameraAvailability(id);

                        showCamera(context, 'idMdvr_value', deviceData, text);
                      },
                      child: deviceData.isNotEmpty
                          ? Row(
                              mainAxisAlignment: MainAxisAlignment.center,
                              children: <Widget>[
                                const SizedBox(
                                    width: 5), // Espacio entre los botones
                                Column(
                                  mainAxisAlignment: MainAxisAlignment.center,
                                  children: <Widget>[
                                    const SvgIcon(
                                      asset:
                                          'assets/icon/sensors/info/video.svg', // Cambia a tu segundo icono
                                    ),
                                    Text(
                                      'Camara', // Cambia a tu texto deseado
                                      style: TextStyle(
                                        color: Theme.of(context).brightness ==
                                                Brightness.light
                                            ? Colors.grey.shade900
                                            : Colors.white,
                                      ),
                                    ),
                                  ],
                                ),
                              ],
                            )
                          : Container(),
                    ),
                  ],
                ),
              ),
            ],
          ),
          Positioned(
            right: 0,
            child: IconButton(
                onPressed: () {
                  //Cerrar ventana
                  mapController.setIsDeviceOverviewOpen = false;

                  //Cancelar stream
                  mapController.overviewSuscription?.cancel();
                },
                icon: const Icon(Icons.close)),
          )
        ],
      ),
    );
  }
}
