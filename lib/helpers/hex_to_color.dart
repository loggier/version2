import 'package:flutter/material.dart';

//Convertir color hexadecimal a un color de material color
Color hexToColor(String code) {
    if (code.startsWith('#')) {
      code = code.substring(1); // Elimina el símbolo # si está presente
    }
    return Color(int.parse(code, radix: 16) + 0xFF000000);
  }