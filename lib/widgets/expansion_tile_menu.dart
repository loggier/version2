// ignore_for_file: avoid_print

import 'package:collection/collection.dart';
import 'package:flutter/material.dart';
import 'package:prosecat/models/device_response.dart';
import 'package:prosecat/widgets/widgets.dart';
import 'package:flutter/widgets.dart' as flutter_icon;

class ExpansionTileMenu extends StatelessWidget {
  const ExpansionTileMenu({
    super.key,
    required this.device,
  });
  final DeviceResponse device;

  @override
  Widget build(BuildContext context) {
    return ExpansionTile(
      shape: const RoundedRectangleBorder(
        borderRadius: BorderRadius.zero,
      ),
      title: Text('${device.title} - (${device.items.length.toString()})'),
      leading: const flutter_icon.Icon(
        Icons.arrow_drop_down_circle,
        size: 28,
      ),
      // leading: const SvgIcon(asset: 'assets/icon/dont_disturb.svg', width: 28,),
      // textColor: Colors.black,
      backgroundColor: Theme.of(context).brightness == Brightness.light
          ? const Color.fromARGB(255, 237, 236, 236)
          : null,
      iconColor: Colors.black,
      children: [
        ConstrainedBox(
          constraints: const BoxConstraints(minHeight: 10, maxHeight: 240),
          child: ListView.builder(
              itemCount: device.items.length,
              shrinkWrap: true,
              itemBuilder: (_, index) {
                ItemSensor? acc;
                bool engineState = false;

                acc = device.items[index].sensors!.isNotEmpty
                    ? device.items[index].sensors!
                        .firstWhereOrNull((element) => element.type == 'acc')
                    : null;

                if (acc != null) {
                  // Verifica si acc.val es una cadena antes de convertirla a booleano
                  if (acc.val is String) {
                    engineState = acc.val.toLowerCase() == 'true';
                  } else if (acc.val is bool) {
                    // Si acc.val ya es un booleano, simplemente asigna su valor
                    engineState = acc.val;
                  } else {
                    // Si acc.val no es un String ni un bool, puedes manejar el error aquí
                    print('Valor inesperado para acc.val: ${acc.val}');
                  }
                }

                return Column(
                  children: [
                    ExpansionItemTile(
                      iconEngine: (engineState)
                          ? 'assets/images/engine_on.svg'
                          : 'assets/images/engine_off.svg',
                      item: device.items[index],
                    ),
                  ],
                );
              }),
        ),
      ],
    );
  }
}
