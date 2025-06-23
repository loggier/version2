import 'package:flutter/material.dart';
import 'package:prosecat/controllers/controllers.dart';
import 'package:prosecat/generated/l10n.dart';
import 'package:prosecat/helpers/helpers.dart';
import 'package:prosecat/models/alerts_response.dart';
import 'package:provider/provider.dart';
import 'package:expandable_text/expandable_text.dart';

class AlertsList extends StatelessWidget {
  const AlertsList({
    super.key,
    required this.alerts,
    this.isFromSearch,
    this.scrollController,
  });
  final List<Datum> alerts;
  final bool? isFromSearch;
  final ScrollController? scrollController;

  @override
  Widget build(BuildContext context) {
    final mapAlertsProvider = Provider.of<MapAlertsController>(context);

    return Scrollbar(
      interactive: true,
      controller: scrollController,
      child: ListView.builder(
          controller: scrollController,
          physics: const BouncingScrollPhysics(),
          primary: false,
          shrinkWrap: true,
          itemCount: alerts.length,
          itemBuilder: (contextt, int index) {
            Color? conteinerColor = index % 2 == 0
                ? Theme.of(context).brightness == Brightness.light
                    ? Colors.white
                    : Colors.black87
                : Theme.of(context).brightness == Brightness.light
                    ? Colors.grey.shade300
                    : Colors.grey.shade900;

            mapAlertsProvider.getElementSelected == alerts[index].id.toString()
                ? conteinerColor = Colors.amber
                : conteinerColor;

            return GestureDetector(
              onTap: () {
                //Guardar id del elemento seleccionado para poner un color indicativo a la alerta seleccionada
                mapAlertsProvider
                    .setElementSelected(alerts[index].id.toString());

                //Si en caso la alerta halla sido cliqueada desde el buscador, entonces navegar asía atras para mostrar el mapa
                if (isFromSearch != null && isFromSearch == true) {
                  Navigator.pop(context);
                }

                //Agregar marcador
                mapAlertsProvider.addMarker(
                    alerts[index].deviceId,
                    alerts[index].latitude,
                    alerts[index].longitude,
                    'assets/icon/flag.png',
                    alerts[index].deviceName,
                    alerts[index].time,
                    alerts[index].speed.toString(),
                    alerts[index].message,
                    address: alerts[index].address);
              },
              child: Container(
                color: conteinerColor,
                child: Row(
                  children: [
                    AlertasTitle(
                      titulo: alerts[index].time.toString(),
                    ),
                    AlertasTitle(
                      titulo: alerts[index].deviceName.toString(),
                    ),
                    AlertasTitle(
                      titulo: alerts[index].message.toString(),
                    ),
                    AlertasTitle(
                      titulo: alerts[index].address ?? '',
                      maxTwoLines: true,
                    ),
                  ],
                ),
              ),
            );
          }),
    );
  }
}

class AlertasTitle extends StatelessWidget {
  const AlertasTitle({
    super.key,
    required this.titulo,
    this.isTitle,
    this.maxTwoLines,
  });

  final String titulo;
  final bool? isTitle;
  final bool? maxTwoLines;

  @override
  Widget build(BuildContext context) {
    double screenWidth = MediaQuery.of(context).size.width;
    return Container(
      // color: Colors.red.shade100,
      width: (screenWidth * 25) / 100,
      padding: const EdgeInsets.all(5),
      child: Center(
        child: Stack(
          children: [
            AnimatedSize(
              duration: const Duration(milliseconds: 300),
              child: ExpandableText(
                titulo,
                expandText: S.of(context).labelMostrarMas,
                collapseText: S.of(context).labelmostrarMenos,
                linkColor: Theme.of(context).colorScheme.primary,
                maxLines: 3,
                style: Theme.of(context).textTheme.bodyLarge!.copyWith(
                    color: Theme.of(context).brightness == Brightness.light
                        ? Colors.grey[800]
                        : Colors.white,
                    fontSize: 12,
                    fontWeight: FontWeight.bold,
                    overflow: TextOverflow.ellipsis),
                textAlign:
                    (isTitle == true) ? TextAlign.center : TextAlign.left,
                textScaleFactor: ScaleSize.textScaleFactor(context),
              ),
            ),
            // Text(
            //   titulo,
            //   style: Theme.of(context).textTheme.bodyLarge!.copyWith(
            //     color: Theme.of(context).brightness == Brightness.light ? Colors.grey[800] : Colors.white,
            //     fontSize: 12,
            //     fontWeight: FontWeight.bold,
            //     overflow: TextOverflow.ellipsis
            //   ),
            //   textAlign: (isTitle == true) ? TextAlign.center : TextAlign.left,
            //   textScaleFactor: ScaleSize.textScaleFactor(context),
            //   maxLines: 2,

            // ),
            // Positioned(
            //   right: 0,
            //   child: GestureDetector(
            //     onTap: (){
            //       print('Abrir');
            //     },
            //     child: const Icon(Icons.remove_red_eye, size: 15,))
            // )
          ],
        ),
      ),
    );
  }
}
