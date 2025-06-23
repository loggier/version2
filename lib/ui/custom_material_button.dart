import 'package:flutter/material.dart';

class CustomMaterialButton extends StatelessWidget{
  final String label;
  final VoidCallback? onPressed;
  final Color backgroundColor;
  
  const CustomMaterialButton({super.key, 
    required this.label, this.onPressed, required this.backgroundColor,
  });
  @override
  Widget build(BuildContext context) {
    return MaterialButton(
      minWidth: double.infinity,
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(30),
      ),
      disabledColor: Colors.grey,
      elevation: 0,
      color: backgroundColor,
      onPressed: onPressed,
      child: Container(
        padding: const EdgeInsets.symmetric(horizontal: 80, vertical: 15),
        child: Text(
          label,
          style: const TextStyle(color: Colors.white),
        ),
      ),
    );  
  }
}