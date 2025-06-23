import 'package:flutter/material.dart';
import 'package:prosecat/controllers/controllers.dart';
import 'package:prosecat/helpers/helpers.dart';
import 'package:prosecat/providers/pages_provider.dart';
import 'package:prosecat/services/services.dart';
import 'package:prosecat/widgets/widgets.dart';
import 'package:provider/provider.dart';

// ListTile buildMenuItem(BuildContext context ,String asset, String text, String? route){
//   final authService = Provider.of<AuthService>(context, listen: false);
//   final deviceProvider = Provider.of<DeviceProvider>(context, listen: false);
//   final mapController = Provider.of<MapController>(context, listen: false);

//   return ListTile(
//     // horizontalTitleGap: 25,
//       leading: SvgIcon(
//         asset: asset, 
//         width: 28, 
//         color: Theme.of(context).brightness == Brightness.light ? null : Colors.white,
//       ),      
//       trailing:  (route != null) 
//         ? const Icon(Icons.arrow_forward_ios_outlined)
//         : null,
//       title: Text(
//         text, 
//         style: Theme.of(context).textTheme.bodyLarge,
//         textScaleFactor: ScaleSize.textScaleFactor(context),),
//       onTap: (route != null)
//       ? () {
//         if(route == '') {
//           Navigator.pop(context);
//           return;
//         }

//         if(route == 'login') {
//             authService.logout();
//             deviceProvider.alertsReponse = null;
//             Navigator.pushNamedAndRemoveUntil(context, 'login', (route) => false);
//             mapController.close();
//             deviceProvider.close();
//           return;
//         }

//         //Pausar stream del mapa principal
//         Provider.of<DeviceProvider>(context, listen: false).pause();

//         //Navegar a la ruta
//         Navigator.pushNamed(context, route);
        
//       }
//       : null
//     );
// }

class ListButtons extends StatelessWidget {
  const ListButtons({super.key, required this.asset, required this.text, this.route});

  final String asset, text;
  final String? route;


  @override
  Widget build(BuildContext context) {
    final authService = Provider.of<AuthService>(context, listen: false);
    final deviceProvider = Provider.of<DeviceProvider>(context, listen: false);
    final mapController = Provider.of<MapController>(context, listen: false);
    final pagesProvider = Provider.of<PagesProvider>(context, listen: false);
    final mapAlertsController = Provider.of<MapAlertsController>(context, listen: false);

  return ListTile(
    // horizontalTitleGap: 25,
      leading: SvgIcon(
        asset: asset, 
        width: 28, 
        color: Theme.of(context).brightness == Brightness.light ? null : Colors.white,
      ),      
      trailing:  (route != null) 
        ? const Icon(Icons.arrow_forward_ios_outlined)
        : null,
      title: Text(
        text, 
        style: Theme.of(context).textTheme.bodyLarge,
        textScaler: TextScaler.linear(ScaleSize.textScaleFactor(context)),
      ),
      onTap: (route != null)
      ? () {
        if(route == '') {
          Navigator.pop(context);
          return;
        }
        //Pausar stream del mapa principal
        Provider.of<DeviceProvider>(context, listen: false).pause();

        if(route == 'login') {
            authService.logout();
            pagesProvider.animateToPage(0);
            deviceProvider.alertsReponse = null;
            mapAlertsController.close();
            mapController.close();
            deviceProvider.close();
            Navigator.pushNamedAndRemoveUntil(context, 'login', (route) => false);
          return;
        }


        //Navegar a la ruta
        Navigator.pushNamed(context, route!);
        
      }
      : null
    );
  }
}