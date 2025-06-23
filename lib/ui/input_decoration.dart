import 'package:flutter/material.dart';

class DecorationInputs {
  static InputDecoration authDecorationInput(
    BuildContext context,
    {
    String? hintText,
    required String labelText,
    IconData? prefixIcon,
    InputBorder? enabledBorder,
    InputBorder? focusedBorder,    
  }){
    return InputDecoration(
      enabledBorder: enabledBorder ?? const UnderlineInputBorder(
        borderSide: BorderSide(color: Colors.grey)
      ),
      focusedBorder: focusedBorder ?? const UnderlineInputBorder(
        borderSide: BorderSide(
          color: Colors.grey,
          width: 2,
        )
      ),
      hintText: hintText,
      labelText: labelText,
      labelStyle: const TextStyle(
        color: Colors.grey
      ),
      prefixIcon: prefixIcon != null
        ? Icon(prefixIcon, color: Theme.of(context).colorScheme.primary)
        : null 
    );
  }
  
}