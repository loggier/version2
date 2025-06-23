import 'package:prosecat/screens/streaming/streaming_test.dart';
import 'package:flutter/material.dart';

showCamera(BuildContext context, String idMdvr, List<dynamic> urls,
    String vehicleName) {
  return showModalBottomSheet<void>(
    context: context,
    isScrollControlled: true, // Permite que la modal se expanda correctamente
    builder: (BuildContext context) {
      return VehicleCamera(
        idMdvr: idMdvr,
        urls: urls,
        vehicleName: vehicleName,
      );
    },
  );
}

class VehicleCamera extends StatelessWidget {
  const VehicleCamera(
      {super.key,
      required this.idMdvr,
      required this.vehicleName,
      required this.urls});
  final String idMdvr, vehicleName;
  final List<dynamic> urls;

  @override
  Widget build(BuildContext context) {
    // ignore: unused_local_variable
    final size = MediaQuery.of(context).size;

    return Container(
      color: Colors.white,
      child: SizedBox(
        width: double.infinity,
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          mainAxisSize: MainAxisSize.min,
          children: [
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Padding(
                  padding: const EdgeInsets.only(left: 10),
                  child: Text('Cámara ($vehicleName)',
                      style: Theme.of(context).textTheme.bodyLarge?.copyWith(
                          color: Colors.black, fontWeight: FontWeight.bold)),
                ),
                IconButton(
                    onPressed: () => Navigator.pop(context),
                    icon: const Icon(Icons.close))
              ],
            ),
            // Reducimos el espacio a solo 5px
            const SizedBox(height: 5),
            Padding(
              padding: const EdgeInsets.symmetric(
                  horizontal: 5), // Ajuste de padding para reducir espacio
              child: Column(
                children: [
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      StreamingScreen(videoUrls: [
                        urls[0],
                        urls[1],
                      ]),
                    ],
                  ),
                  // Eliminamos espacios entre filas
                  const SizedBox(
                      height: 50), // Reducimos aún más el espacio entre filas
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}
