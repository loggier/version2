import 'dart:ui' as ui;

import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:prosecat/custom_marker/info_window_painter.dart';

Future<Uint8List> getInfoWindowMarker(String name, ui.Image image,
    {String? subtitle,
    String? contain,
    String? color,
    double imageWidth = 140,
    double imageHeight = 140,
    bool? center}) async {
  final recorder = ui.PictureRecorder();
  final canvas = Canvas(recorder);
  const fontSize = 35.0;
  const fontWeight = FontWeight.bold;

  // Definir una lista de textos
  List<String> texts = [name];

  if (subtitle != null) {
    texts.add(subtitle);
  }

  if (contain != null) {
    texts.add(contain);
  }

  // Encontrar el texto más largo usando reduce
  String longestText = texts.reduce((currentLongest, text) {
    return text.length > currentLongest.length ? text : currentLongest;
  });

  final width = _getTextWidth(longestText, fontSize, fontWeight) + 10;

  // Dibujar la imagen centrada en el canvas y agrandarla sin estirarla
  double desiredImageWidth =
      imageWidth; // Tamaño deseado de ancho para la imagen
  double desiredImageHeight =
      imageHeight; // Tamaño deseado de alto para la imagen

  // if (isRotateImage) {
  //   desiredImageHeight = 190;
  //   desiredImageWidth = 190;
  // }

  final double aspectRatio = image.width.toDouble() / image.height.toDouble();
  double adjustedImageWidth = desiredImageWidth + 40;
  double adjustedImageHeight = desiredImageWidth / aspectRatio;

  // Asegurarse de que la imagen ajustada no exceda la altura deseada
  if (adjustedImageHeight > desiredImageHeight) {
    adjustedImageHeight = desiredImageHeight;
    adjustedImageWidth = desiredImageHeight * aspectRatio;
  }

  // int extraHeight = subtitle != null ? 80 : 45;
  int extraHeight = 45;

  if (subtitle != null) {
    extraHeight = 80;
  }

  if (contain != null) {
    extraHeight = 120;
  }

  final size = Size(width + 25, adjustedImageHeight + extraHeight + 10);

  final infoWindow = InfoWindowPainter(name, width, fontSize, fontWeight, image,
      adjustedImageWidth, adjustedImageHeight,
      subTitle: subtitle, contain: contain, center: center, color: color);

  infoWindow.paint(canvas, size);

  final picture = recorder.endRecording();
  final newImage =
      await picture.toImage(size.width.toInt(), size.height.toInt());
  final byteData = await newImage.toByteData(format: ui.ImageByteFormat.png);

  // return BitmapDescriptor.fromBytes(byteData!.buffer.asUint8List());
  return byteData!.buffer.asUint8List();
}

Future<Uint8List> getTextOnlyMarker(
  String text, {
  double fontSize = 30.0,
  FontWeight fontWeight = FontWeight.bold,
  Color textColor = Colors.white, // Color del texto en blanco por defecto
  double padding = 3.0,
  double? imageWidth, // Ancho personalizado de la imagen
  double? imageHeight, // Alto personalizado de la imagen
  Color backgroundColor = Colors.black, // Color de fondo en negro por defecto
  double backgroundPadding = 2.0, // Padding adicional para el fondo
  Color shadowColor = Colors.grey, // Color de la sombra del texto
  double shadowBlurRadius = 4.0, // Desenfoque de la sombra
  Offset shadowOffset = const Offset(2.0, 2.0), // Desplazamiento de la sombra
}) async {
  final recorder = ui.PictureRecorder();
  final canvas = Canvas(recorder);

  // Calcula el ancho del texto con la función _getTextWidth existente
  final textWidth = _getTextWidth(text, fontSize, fontWeight) + padding * 2;

  // Define el alto de la caja que contendrá el texto
  final textHeight = fontSize + padding * 2;

  // Usa el tamaño personalizado si se proporciona, de lo contrario, usa el tamaño calculado
  final canvasWidth = imageWidth ?? textWidth;
  final canvasHeight = imageHeight ?? textHeight;

  // Define el tamaño del canvas basado en el ancho y alto especificado o calculado
  final size = Size(canvasWidth, canvasHeight);

  // Dibuja el fondo con padding adicional
  final backgroundRect = Rect.fromLTWH(
    backgroundPadding,
    backgroundPadding,
    canvasWidth - backgroundPadding * 2,
    canvasHeight - backgroundPadding * 2,
  );

  final backgroundPaint = Paint()..color = backgroundColor;
  canvas.drawRect(backgroundRect, backgroundPaint);

  // Dibuja el texto con sombra centrado en el canvas
  final textPainter = TextPainter(
    textDirection: TextDirection.ltr,
    textAlign: TextAlign.center,
    text: TextSpan(
      text: text,
      style: TextStyle(
        fontSize: fontSize,
        fontWeight: fontWeight,
        color: textColor,
        shadows: [
          Shadow(
            color: shadowColor,
            offset: shadowOffset,
            blurRadius: shadowBlurRadius,
          ),
        ],
      ),
    ),
  );

  textPainter.layout(
    minWidth: 0,
    maxWidth: canvasWidth,
  );

  // Ajusta la posición del texto para centrarlo en la imagen
  final offset = Offset(
    (canvasWidth - textPainter.width) / 2,
    (canvasHeight - textPainter.height) / 2,
  );

  textPainter.paint(canvas, offset);

  final picture = recorder.endRecording();
  final newImage =
      await picture.toImage(size.width.toInt(), size.height.toInt());
  final byteData = await newImage.toByteData(format: ui.ImageByteFormat.png);

  return byteData!.buffer.asUint8List();
}

//Obtener el ancho del texto
double _getTextWidth(String text, double fontSize, FontWeight fontWeight) {
  final TextPainter painter = TextPainter(
    textDirection: TextDirection.ltr,
    text: TextSpan(
      text: text,
      style: TextStyle(
        fontSize: fontSize,
        fontWeight: fontWeight,
      ),
    ),
  )..layout();

  return painter.width;
}
