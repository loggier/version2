import 'package:flutter/material.dart';
import 'package:prosecat/generated/l10n.dart';
import 'package:prosecat/models/alerts_response.dart';
import 'package:prosecat/services/services.dart';
import 'package:prosecat/ui/ui.dart';
import 'package:prosecat/widgets/widgets.dart';
import 'package:provider/provider.dart';

class AlertSearchDelegate extends SearchDelegate {
  //Cambiar dependiendo idioma
  @override
  String get searchFieldLabel => S.current.labelBuscar;

  List<Datum> items = [];

  //Funcion de busqueda
  List<Datum> searchItems(String query, List<Datum> devices) {
    Set<Datum> uniqueItems = {};

    String queryLower = query.toLowerCase();

    for (var device in devices) {
      //Busca por nombre de dispositivo y por nombre de alerta
      if (device.deviceName.toLowerCase().contains(queryLower) || device.name.toLowerCase().contains(queryLower)) {
        uniqueItems.add(device);
      }
    }

    return uniqueItems.toList();
  }

  @override
  List<Widget>? buildActions(BuildContext context) {
    return [
      IconButton(
          icon: const Icon(Icons.clear),
          onPressed: () {
            items.clear();
            query = '';
          })
    ];
  }

  @override
  Widget? buildLeading(BuildContext context) {
    return IconButton(
        icon: const Icon(Icons.arrow_back),
        onPressed: () {
          close(context, null);
        });
  }

  @override
  Widget buildResults(BuildContext context) {
    return AlertsList(alerts: items, isFromSearch: true,);
  }

  Widget _emptyContainer(BuildContext context){
    return Center(
      child: Icon(
        Icons.notifications,
        color: Theme.of(context).brightness == Brightness.light ? Colors.black38 : Colors.white,
        size: 130,
      ),
    );
  }

  @override
  Widget buildSuggestions(BuildContext context) {
    if (query.isEmpty) {
      return _emptyContainer(context);
    }

    final deviceProvider = Provider.of<DeviceProvider>(context);
    
    return FutureBuilder(
      future: deviceProvider.getAlerts(),
      builder: (_, snapshot) {
        
        if (snapshot.connectionState == ConnectionState.waiting) {
            return Center(
              child: SizedBox(width: 150, height: 150, child: loadingMapAnimation())
            );
          } else if (snapshot.hasError) {
            return Text('Error ${snapshot.error}');
          } else {
            final response = snapshot.data!;
            final alerts = response.items.data;

            items = searchItems(query, alerts);

            //Si no encuentra datos regresa un icono que indique que no encontro
            if (items.isEmpty) return _emptyContainer(context);

            return AlertsList(alerts: items, isFromSearch: true,);
          }
      },
    );

  }
}
