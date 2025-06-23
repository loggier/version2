import 'package:flutter/material.dart';

//Texto que se mostrara sobre los custom infoWindow
Text labelOnInfoWindow(String title, String value, {bool color = true}) {
    return Text.rich(
      TextSpan(
        text: '$title: ',
        style: TextStyle(
          fontWeight: FontWeight.bold,
          color: color ? Colors.black : null
        ),
        children: [
          TextSpan(
            text: value,          
            style: const TextStyle(
              fontWeight: FontWeight.normal,
            ),
          ),
        ],
      ),
      maxLines: 4,
    );
  } 