import 'package:flutter/material.dart';
import 'package:prosecat/generated/l10n.dart';
import 'package:prosecat/models/models.dart';
import 'package:prosecat/services/services.dart';
import 'package:prosecat/widgets/widgets.dart';
import 'package:flutter/widgets.dart'  as flutter_icon;

class DeviceSearchDelegate extends SearchDelegate {
  //Cambiar dependiendo idioma

  final DeviceProvider? device;
  final bool? isFromPageView;

  @override
  String get searchFieldLabel => S.current.labelBuscar;
  List<Item> items = [];

  DeviceSearchDelegate({this.device, this.isFromPageView});

  //Funcion de busqueda
  List<Item> searchItems(String query, List<dynamic> devices) {
    Set<Item> uniqueItems = {};
    String queryLower = query.toLowerCase();

    for (var device in devices) {
      for (var item in device.items) {
        if (item.name.toLowerCase().contains(queryLower)) {
          uniqueItems.add(item);
        }
      }
    }

    return uniqueItems.toList();
  }

  @override
  List<Widget>? buildActions(BuildContext context) {
    return [
      IconButton(
          icon: const flutter_icon.Icon(Icons.clear),
          onPressed: () {
            items.clear();
            query = '';
          })
    ];
  }

  @override
  Widget? buildLeading(BuildContext context) {
    return IconButton(
        icon: const flutter_icon.Icon(Icons.arrow_back),
        onPressed: () {
          close(context, null);
        });
  }

  @override
  Widget buildResults(BuildContext context) {
    if (items.isEmpty) {
      return const Text('Sin resultados');
    }
    return Container(
          margin: const EdgeInsets.only(top: 20),
          child: GroupItem(grupo: items, isFromSearch: false, isFromPageView: isFromPageView ?? false,));
  }

  @override
  Widget buildSuggestions(BuildContext context) {
    if (query.isEmpty) {
      return Center(
        child: flutter_icon.Icon(
          Icons.directions_car,
          color: Theme.of(context).brightness == Brightness.light ? Colors.black38 : Colors.white,
          size: 130,
        ),
      );
    }

    items = searchItems(query, device!.devicesResponse);

    if (items.isNotEmpty) {
      return Container(
          margin: const EdgeInsets.only(top: 20),
          child: GroupItem(grupo: items, isFromSearch: true, isFromPageView: isFromPageView ?? false,));
    } else {
      return Center(
          child: flutter_icon.Icon(
        Icons.search,
        color: Theme.of(context).brightness == Brightness.light ? Colors.black38 : Colors.white,
        size: 130,
      ));
    }
  }
}
