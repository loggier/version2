import 'package:flutter/material.dart';

class DateTimeDecorationUi {
  static InputDecoration dateTimeDecorationAll({
    String? labelText,
    Icon? suffixIcon,
  }){
    return InputDecoration(
      hintStyle: const TextStyle(color: Colors.black45),
      labelStyle: TextStyle(color: Colors.grey.shade700),
      errorStyle: const TextStyle(color: Colors.redAccent),
      border: InputBorder.none,
      suffixIcon: (suffixIcon != null) ? suffixIcon : const Icon(Icons.calendar_month),
      labelText: (labelText != null) ? labelText : null,
    );
  }
}