import 'package:flutter/material.dart';

class SearchDecoration {
  static InputDecoration searchDecorationAll({
    required String hintText,
  }){
    return InputDecoration(
      // border: InputBorder.none,
      prefixIcon: const Icon(Icons.search),
      hintText: hintText,
      filled: true,
      fillColor: Colors.white,
      border: OutlineInputBorder(
        borderRadius: BorderRadius.circular(10.0),
        borderSide: BorderSide.none,
      ),
      focusedBorder: const OutlineInputBorder(
        borderSide: BorderSide(
          color: Colors.white,
          width: 1,
        )
      ),
      prefixIconColor: Colors.grey
    );
  }
}