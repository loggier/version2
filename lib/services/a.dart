import 'dart:ui' as ui;
import 'dart:math' as math;

import 'package:flutter/services.dart';
import 'package:flutter_cache_manager/flutter_cache_manager.dart';

 Future<Uint8List> imageToBytes({
  int width = 100,
  double? rotation,
  String asset = '',
  String path = '',
  bool rotateImage = false,  
   String? angleImageAsset,   
   double rotateAngle = 0.0, 
}) async {
  Uint8List bytes;
  ui.Image image;
  ui.Image angleImage;
  final pictureRecorder = ui.PictureRecorder();
  final canvas = ui.Canvas(pictureRecorder);

  //Imagen local
  if (asset.isNotEmpty) {
    final data = await rootBundle.load(asset);
    bytes = data.buffer.asUint8List();
    image = await getImage(bytes, width);
  } else {
    //Imagen de internet
    final file = await DefaultCacheManager().getSingleFile(path);
    bytes = await file.readAsBytes();
    image = await getImage(bytes, width);
  }
    
  if (angleImageAsset != null) {
    // Cargar la imagen a superponer (angleImage)
    final angleImageData = await rootBundle.load(angleImageAsset);
    final angleImageBytes = angleImageData.buffer.asUint8List();
    angleImage = await getImage(angleImageBytes, width);
      
    image = await getRotateImageBytes(image, rotation ?? 0);
    angleImage = await getRotateImageBytes(angleImage, rotateAngle);

    // Obtén las dimensiones originales de las imágenes
    final imageWidth = image.width.toDouble();
    final imageHeight = image.height.toDouble();
    final angleImageWidth = angleImage.width.toDouble();
    final angleImageHeight = angleImage.height.toDouble();

    // Calcula las dimensiones máximas entre las dos imágenes
    final maxWidth = imageWidth > angleImageWidth ? imageWidth : angleImageWidth;
    final maxHeight = imageHeight > angleImageHeight ? imageHeight : angleImageHeight;

    // Calcula el factor de escala solo para angleImage
    final scale = maxWidth / angleImageWidth;

    // Calcula las nuevas dimensiones de angleImage
    final newAngleImageWidth = angleImageWidth * scale;
    final newAngleImageHeight = angleImageHeight * scale;

    // Calcula las coordenadas (dx, dy) para centrar ambas imágenes en el contenedor
    final dxImage = (maxWidth - imageWidth) / 2;
    final dyImage = (maxHeight - imageHeight) / 2;
    final dxAngleImage = (maxWidth - newAngleImageWidth) / 2;
    final dyAngleImage = (maxHeight - newAngleImageHeight) / 2;

    canvas.drawImageRect(
      image,
      Rect.fromLTWH(0, 0, imageWidth, imageHeight),
      Rect.fromLTWH(dxImage, dyImage, imageWidth, imageHeight), // Usa las dimensiones originales
      ui.Paint(),
    );

    canvas.drawImageRect(
      angleImage,
      Rect.fromLTWH(0, 0, angleImageWidth, angleImageHeight),
      Rect.fromLTWH(dxAngleImage, dyAngleImage, newAngleImageWidth, newAngleImageHeight),
      ui.Paint(),
    );

    final newPicture = pictureRecorder.endRecording();
    final finalImage = await newPicture.toImage(maxWidth.toInt(), maxHeight.toInt());
    final pngBytes = await finalImage.toByteData(format: ui.ImageByteFormat.png);
    return pngBytes!.buffer.asUint8List();
  }

  if (rotation != null) {      
    final imageB = await getRotateImageBytes(image, rotation);
    final  pngBytes = await imageB.toByteData(format: ui.ImageByteFormat.png);
    return pngBytes!.buffer.asUint8List();
  }
  return bytes;
}

getImage(Uint8List bytes, int width) async {
  final codec = await ui.instantiateImageCodec(bytes, targetWidth: width);
  final frame = await codec.getNextFrame();
  return frame.image;
}

Future<ui.Image> getRotateImageBytes(ui.Image image, double rotation, {
  double? width, 
  double? height
  })async{

  final angle = rotation * math.pi / 180;
  final imageSize = Size(image.width.toDouble(), image.height.toDouble());
  final newHeight = imageSize.width * math.sin(angle).abs() + imageSize.height * math.cos(angle).abs();
  final newWidth = imageSize.height * math.sin(angle).abs() + imageSize.width * math.cos(angle).abs();
  final newSize = Size(newWidth, newHeight);

  final recorder = ui.PictureRecorder();
  final canvas = ui.Canvas(recorder);

  // Translate and rotate the image
  canvas.translate(newWidth / 2, newHeight / 2);
  canvas.rotate(angle);
  canvas.translate(-imageSize.width / 2, -imageSize.height / 2);

  canvas.drawImageRect(
    image,
    Rect.fromLTWH(0, 0, imageSize.width, imageSize.height),
    Rect.fromLTWH(0, 0, imageSize.width, imageSize.height),
    ui.Paint(),
  );

  final rotatedPicture = recorder.endRecording();
  final rotatedImage = await rotatedPicture.toImage(newSize.width.toInt(), newSize.height.toInt());
  
  return rotatedImage;
}

// import 'dart:ui' as ui;
// import 'dart:math' as math;

// import 'package:flutter/services.dart';
// import 'package:flutter_cache_manager/flutter_cache_manager.dart';

//  Future<Uint8List> imageToBytes({
//   int width = 100,
//   double rotation = 0,
//   String asset = '',
//   String path = '',
//   bool rotateImage = false,  
// }) async {
//   Uint8List bytes;
//   ui.Image image;

//   //Imagen local
//   if (asset.isNotEmpty) {
//     final data = await rootBundle.load(asset);
//     bytes = data.buffer.asUint8List();
//     final codec = await ui.instantiateImageCodec(bytes, targetWidth: width);
//     final frame = await codec.getNextFrame();
//     image = frame.image;
//   } else {
//     //Imagen de internet
//     final file = await DefaultCacheManager().getSingleFile(path);
//     bytes = await file.readAsBytes();
//     final codec = await ui.instantiateImageCodec(bytes, targetWidth: width);
//     final frame = await codec.getNextFrame();
//     image = frame.image;
//   }

//   if (rotateImage) {
//     // No rotar la imagen
//     return bytes;
//   }

//   final angle = rotation * math.pi / 180;
//   final imageSize = Size(image.width.toDouble(), image.height.toDouble());
//   final newHeight = imageSize.width * math.sin(angle).abs() + imageSize.height * math.cos(angle).abs();
//   final newWidth = imageSize.height * math.sin(angle).abs() + imageSize.width * math.cos(angle).abs();
//   final newSize = Size(newWidth, newHeight);

//   final pictureRecorder = ui.PictureRecorder();
//   final canvas = ui.Canvas(pictureRecorder);

//   canvas.translate(newWidth / 2, newHeight / 2);
//   canvas.rotate(angle);
//   canvas.translate(-imageSize.width / 2, -imageSize.height / 2);

//   canvas.drawImageRect(
//     image,
//     Rect.fromLTWH(0, 0, imageSize.width, imageSize.height),
//     Rect.fromLTWH(0, 0, imageSize.width, imageSize.height),
//     ui.Paint(),
//   );

//   final newPicture = pictureRecorder.endRecording();
//   final finalImage = await newPicture.toImage(newSize.width.toInt(), newSize.height.toInt());
//   final pngBytes = await finalImage.toByteData(format: ui.ImageByteFormat.png);

//   return pngBytes!.buffer.asUint8List();
// }