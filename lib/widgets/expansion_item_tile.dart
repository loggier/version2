import 'package:flutter/material.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:prosecat/generated/l10n.dart';
import 'package:prosecat/models/place.dart';
import 'package:prosecat/controllers/map_controller.dart';
import 'package:prosecat/models/device_response.dart';
import 'package:prosecat/providers/providers.dart';
import 'package:prosecat/widgets/widgets.dart';
import 'package:provider/provider.dart';
import 'package:flutter/material.dart' as flutter;

class ExpansionItemTile extends StatelessWidget {
  final String iconEngine;
  final Item item;
  const ExpansionItemTile({
    super.key,
    required this.iconEngine,
    required this.item,
  });

  @override
  Widget build(BuildContext context) {
    final mapController = Provider.of<MapController>(context, listen: false);

    final items = mapController.getItems
        .any((element) => element.id == item.id.toString());
    final pagesProvider = Provider.of<PagesProvider>(context, listen: false);

    return Container(
        decoration: const BoxDecoration(
          border: Border(
            bottom: BorderSide(
              color: Colors.grey,
              width: 0.4, // Ancho de la línea divisora
            ),
          ),
        ),
        child: ListTile(
            leading: GestureDetector(
              onTap: (pagesProvider.getCurrentPage == 0)
                  ? () {
                      if (items) {
                        mapController.removeItem(item.id.toString());
                        return;
                      }
                      mapController.setItems = Place(
                        item.name,
                        item.speed,
                        item.distanceUnitHour,
                        item.course.toDouble(),
                        item.iconColor,
                        item.time,
                        location: LatLng(item.lat, item.lng),
                        id: item.id.toString(),
                        path: item.icon.path,
                        rotation: (item.icon.type == 'rotating')
                            ? item.course.toDouble()
                            : 0.0,
                      );
                    }
                  : null,
              //CheckButton para quitar y agregar vehiculos al mapa
              child: Container(
                width: 26,
                height: 26,
                decoration: BoxDecoration(
                    shape: BoxShape.circle,
                    color: (items)
                        ? Theme.of(context).colorScheme.primary
                        : Colors.grey[300],
                    border: Border.all(color: Colors.grey, width: 1.0)),
                child: Center(
                    child: (items)
                        ? const flutter.Icon(
                            Icons.done,
                            color: Colors.white,
                          )
                        : null),
              ),
            ),
            title: Text(item.name, style: const TextStyle(fontSize: 13)),
            subtitle: (item.deviceData.expirationDate != null)
                ? Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(item.time),
                      FittedBox(
                          child: Text(
                        '${S.of(context).labelExpiracion} ${item.deviceData.expirationDate}',
                        style: Theme.of(context).textTheme.bodySmall!.copyWith(
                            fontWeight: FontWeight.bold,
                            fontSize: 12,
                            color: Colors.red.shade700),
                      )),
                    ],
                  )
                : Text(item.time, style: const TextStyle(fontSize: 11)),
            trailing: Row(
              mainAxisSize: MainAxisSize.min,
              mainAxisAlignment: MainAxisAlignment.end,
              children: [
                SvgIcon(
                  asset: iconEngine,
                  width: 35,
                ),
                const SizedBox(
                  width: 5,
                ),
                SvgIcon(
                  asset: 'assets/icon/flechas/circle_${item.iconColor}.svg',
                )
              ],
            ),
            onTap: () {
              //Detener el controlador principal
              // if (mapController.mapController != null && mapController.allDeviceSubscription != null) {
              //   print('SALIDAAAAAAAAAA');
              //   mapController.mapController!.dispose();
              //   mapController.allDeviceSubscription!.cancel();
              // }
              print('SALIDAAAAAAAAAA 2');

              Navigator.pop(context);
              Provider.of<PagesProvider>(context, listen: false)
                  .animateToPage(0);

              //Mover la camara a la nueva posicion
              mapController.moveCamera(LatLng(item.lat, item.lng));

              //Cambiar posición de vehículo seleccionado
              mapController.setLatLngFromMarkerSelected =
                  LatLng(item.lat, item.lng);

              //Asignar un id del dispositivo cliqueado
              mapController.setDeviceOverviewItem = item.id;

              mapController.setIdFromDeviceSelected = item.id;

              //Abrir ventana
              mapController.setIsDeviceOverviewOpen = true;
            }));
  }
}
