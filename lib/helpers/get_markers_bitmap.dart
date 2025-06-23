import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:prosecat/helpers/image_to_byte.dart';
import 'package:prosecat/helpers/widget_to_marker.dart';
import 'dart:ui' as ui;
import 'package:prosecat/system/global.dart';

final String apiUrl = GlobalVariables().apiUrl;

//Dibuja los clusters
Future<BitmapDescriptor> getMarkerBitmap(
    bool isMultiple, int size, String title, bool rotateImage,
    {String? path,
    String? text,
    String? asset,
    String? subtitle,
    String? contain,
    double rotation = 0,
    String? imageRotate,
    String? color,
    double rotateAngle = 0.0}) async {
  if (kIsWeb) size = (size / 2).floor();

  final ui.PictureRecorder pictureRecorder = ui.PictureRecorder();
  final Canvas canvas = Canvas(pictureRecorder);
  final Paint paint1 = Paint()..color = Colors.orange;
  final Paint paint2 = Paint()..color = Colors.white;
  int imageWith = 0;
  int imageHeigh = 0;

  if (text != null) {
    canvas.drawCircle(Offset(size / 2, size / 2), size / 2.2,
        paint2); //Linea blanca del primer circulo
    canvas.drawCircle(Offset(size / 2, size / 2), size / 2.8,
        paint1); //Circulo naranja del primer circulo

    TextPainter painter = TextPainter(textDirection: TextDirection.ltr);
    painter.text = TextSpan(
      text: text,
      style: TextStyle(
          fontSize: size / 4,
          color: Colors.white,
          fontWeight: FontWeight.normal),
    );
    painter.layout();
    painter.paint(
      canvas,
      Offset(size / 2 - painter.width / 2, size / 2 - painter.height / 2),
    );
  } else {
    // final imageBytes = await paintInformationWindow(title, 'https://$apiUrl/$path', rotateImage, rotation: rotation.toDouble(), imageRotate: imageRotate);
    // final imageBytes = await imageToBytes('https://$apiUrl/$path', rotation: rotation.toDouble());
    ui.Image i;
    final iBytes = await imageToBytes(
        path: path != null ? 'https://$apiUrl/$path' : '',
        asset: asset ?? '',
        width: 180,
        rotation: rotation.toDouble(),
        rotateImage: rotateImage,
        angleImageAsset: imageRotate,
        rotateAngle: rotateAngle);
    // final iBytes = await imageToBytes(path: 'https://$apiUrl/$path', width: 50, rotation: rotation.toDouble(), rotateImage: rotateImage);
    i = await decodeImageFromList(iBytes);

    final imageBytes = await getInfoWindowMarker(title, i,
        subtitle: subtitle, center: false, contain: contain, color: color);
    final ui.Image image = await decodeImageFromList(imageBytes);

    const offsetX = 0.0; // No hay desplazamiento horizontal
    const offsetY = 0.0;

    imageWith = image.width.toInt();
    imageHeigh = image.height.toInt();

    // Dibujar la imagen sobre el canvas
    final src =
        Rect.fromLTWH(0, 0, image.width.toDouble(), image.height.toDouble());
    final dst = Rect.fromLTWH(offsetX, offsetY, image.width.toDouble(),
        image.height.toDouble()); //Agrandar imagen pero la estira
    canvas.drawImageRect(image, src, dst, paint2);
  }
  final dynamic img;

  if (isMultiple) {
    img = await pictureRecorder.endRecording().toImage(size, size);
  } else {
    img = await pictureRecorder.endRecording().toImage(imageWith, imageHeigh);
    // print('imageWith: $imageWith');
  }
  final data = await img.toByteData(format: ui.ImageByteFormat.png) as ByteData;

  // ignore: deprecated_member_use
  return BitmapDescriptor.fromBytes(data.buffer.asUint8List());
}
