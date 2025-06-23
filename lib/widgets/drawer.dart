import 'package:flutter/material.dart';
import 'package:prosecat/generated/l10n.dart';
import 'package:prosecat/services/services.dart';
import 'package:prosecat/widgets/widgets.dart';
import 'package:provider/provider.dart';

class AppDrawer extends StatelessWidget {
  const AppDrawer({super.key});

  @override
  Widget build(BuildContext context) {    
  return Drawer(      
      child: ListView(
        children: <Widget>[
          //Encabezado del Menú lateral          
          const DrawerHead(),

          Consumer<DeviceProvider>(
            builder: (context, device, child){
              return Column(
                children: [
                  for (var devicesResponse in device.devicesResponse)
                    ExpansionTileMenu(
                      device: devicesResponse,
                    )
                ],
              );
            }
          ),
          

          //Lista de botones
          ListButtons(asset: 'assets/icon/placeholder.svg', text: S.of(context).labelMapas, route:''),
          ListButtons(asset: 'assets/icon/cursor.svg', text: S.of(context).labelDispositivos, route:'devices'),
          ListButtons(asset: 'assets/icon/bell.svg', text: S.of(context).labelAlertas, route:'alerts'),
          ListButtons(asset: 'assets/icon/report.svg', text: S.of(context).informe, route:'reports_screen'),
          ListButtons(asset: 'assets/icon/user-1.svg', text: S.of(context).labelPerfil, route:'set_profile'),
          ListButtons(asset: 'assets/icon/padlock.svg', text: S.of(context).labelSalir, route:'login'),



          // buildMenuItem(context, 'assets/icon/cursor.svg', S.of(context).labelDispositivos, 'devices'),
          // buildMenuItem(context, 'assets/icon/bell.svg', S.of(context).labelAlertas, 'alerts'),
          // // buildMenuItem(context, 'assets/icon/bar-chart.svg', S.of(context).labelHistorial, 'history'),
          // buildMenuItem(context, 'assets/icon/user-1.svg', S.of(context).labelPerfil, 'set_profile'),
          // buildMenuItem(context, 'assets/icon/padlock.svg', S.of(context).labelSalir, 'login'),

        ],
      )
  );
  }
}