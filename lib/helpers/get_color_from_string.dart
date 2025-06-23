import 'package:flutter/material.dart';

//Devolver un color a partir de una cadena de texto
Color getColorFromString(String colorString) {
  switch (colorString) {
    case 'yellow':
      return const Color.fromRGBO(255, 226, 98, 1);
    case 'red':
      return Colors.red.shade500; 
    case 'green':
      return Colors.green.shade500;
    default:
      return Colors.red.shade500; 
  }
}