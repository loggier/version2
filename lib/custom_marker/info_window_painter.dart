import 'dart:ui' as ui;
import 'package:flutter/material.dart';

class InfoWindowPainter extends CustomPainter {
  final String title;
  final String? subTitle;
  final String? color;
  final String? contain;
  final bool? center;
  final double width;
  final double fontSize;
  final FontWeight fontWeight;
  final ui.Image image;
  final double adjustedImageWidth;
  final double adjustedImageHeight;

  InfoWindowPainter(this.title, this.width, this.fontSize, this.fontWeight,
      this.image, this.adjustedImageWidth, this.adjustedImageHeight,
      {this.subTitle, this.contain, this.center, this.color});

  get getAdjustedImageHeight => adjustedImageHeight;
  // Función auxiliar para mapear nombres de color a Color
  Color parseNamedColor(String c) {
    switch (c.toLowerCase()) {
      case 'red':
        return Colors.red;
      case 'green':
        return Colors.green;
      case 'blue':
        return Colors.blue;
      case 'yellow':
        return Colors.yellow;
      case 'orange':
        return Colors.orange;
      default:
        return Colors.black;
    }
  }

  @override
  void paint(Canvas canvas, Size size) async {
    double textStartX = 5;
    double subtitleStartX = 5;
    double containStartX = 5;

    Paint paint = Paint()
      ..color = Colors.white
      ..style = PaintingStyle.fill;

    //Dividir el ancho que tengo en final size = Size(width, 60);  en 2 partes 1.- alto de la caja blanca 2.- alto de la flecha

    // double height = subTitle != null ? 80 : 45;
    double height = 45;

    if (subTitle != null) {
      height = 80;
    }
    if (contain != null) {
      height = 120;
    }

    //1
    final whiteBox = Rect.fromLTWH(0, 0, width + 30, height);
    final whiteAndRadius =
        RRect.fromRectAndRadius(whiteBox, const Radius.circular(10));

    //Dibujar caja blanca
    canvas.drawRRect(whiteAndRadius, paint);

    // Si se pasa color, dibujamos el cuadro de color al inicio del título
    if (color != null && color!.isNotEmpty) {
      // Dimensiones y padding para el cuadro
      const double boxWidth = 20.0;
      const double boxHeight = 45.0;
      const double padding = 0;
      final double boxY = (height - boxHeight) / 2;
      final Paint colorPaint = Paint()..color = parseNamedColor(color!);
      final Rect colorRect = Rect.fromLTWH(padding, boxY, boxWidth, boxHeight);
      canvas.drawRect(colorRect, colorPaint);
      // Ajustamos la posición inicial del título para que no se superponga al cuadro
      textStartX = 25;
    }

    //Dibujar texto
    TextSpan textSpan = TextSpan(
        style: TextStyle(
            color: const Color.fromARGB(255, 114, 114, 114),
            fontSize: fontSize,
            fontWeight: fontWeight),
        text: title);

    final textPainter = TextPainter(
        text: textSpan,
        textDirection: TextDirection.ltr,
        textAlign: TextAlign.left)
      ..layout(maxWidth: width + 30, minWidth: 100);

    textPainter.paint(canvas, Offset(textStartX, 5));

    if (subTitle != null) {
      //Dibujar texto
      TextSpan textSubtitle = TextSpan(
          style: TextStyle(
              color: Colors.grey, fontSize: fontSize, fontWeight: fontWeight),
          text: subTitle);

      final textPainterSubtitle = TextPainter(
          text: textSubtitle,
          textDirection: TextDirection.ltr,
          textAlign: TextAlign.center)
        ..layout(maxWidth: width + 10, minWidth: 70);

      textPainterSubtitle.paint(canvas, Offset(subtitleStartX, 40));
    }

    if (contain != null) {
      //Dibujar texto
      TextSpan textContain = TextSpan(
          style: TextStyle(
              color: Colors.grey, fontSize: fontSize, fontWeight: fontWeight),
          text: contain);

      final textPainterContain = TextPainter(
          text: textContain,
          textDirection: TextDirection.ltr,
          textAlign: TextAlign.center)
        ..layout(maxWidth: width + 10, minWidth: 70);

      if (center != null) {
        if (center!) {
          containStartX = (width - textPainterContain.width) / 2;
        }
      }

      textPainterContain.paint(canvas, Offset(containStartX, 75));
    }

    //Dibujar flecha (triángulo) debajo de la caja blanca
    const double arrowWidth = 20; // Ancho de la flecha
    const double arrowHeight = 10; // Altura de la flecha //2

    final double arrowTop = whiteBox.bottom; // Parte superior de la flecha
    final double arrowLeft = whiteBox.left +
        (whiteBox.width - arrowWidth) / 2; // Izquierda de la flecha

    final path = Path()
      ..moveTo(arrowLeft, arrowTop)
      ..lineTo(arrowLeft + arrowWidth / 2, arrowTop + arrowHeight)
      ..lineTo(arrowLeft + arrowWidth, arrowTop)
      ..close();

    canvas.drawPath(path, paint);

    //Pintar imagen
    // Obtener el ancho del canvas
    final double canvasWidth = size.width;

    // Calcular la posición horizontal (izquierda) para centrar la imagen
    final double imageLeft = (canvasWidth - adjustedImageWidth) / 2;

    // Calcular la posición vertical (arriba) para colocar la imagen debajo de la flecha
    final double imageTop = arrowTop + arrowHeight + 5;

    // Dibujar la imagen centrada y ajustada en el canvas
    final src =
        Rect.fromLTWH(0, 0, image.width.toDouble(), image.height.toDouble());
    final dst = Rect.fromLTWH(
        imageLeft, imageTop, adjustedImageWidth, adjustedImageHeight);
    canvas.drawImageRect(image, src, dst, paint);
  }

  @override
  bool shouldRepaint(InfoWindowPainter oldDelegate) => true;

  @override
  bool shouldRebuildSemantics(InfoWindowPainter oldDelegate) => false;
}
