import 'package:flutter/material.dart';

class CircleForIcon extends StatelessWidget {
  const CircleForIcon({
    super.key, required this.icon, this.color, this.iconColor,
  });

  final IconData icon;
  final Color? color;
  final Color? iconColor;

  @override
  Widget build(BuildContext context) {
    return CircleAvatar(
      radius: 45,
      backgroundColor: (color == null) ? Colors.white : color,
      child: Icon(icon, size: 40, color: (iconColor == null) ? Colors.black : iconColor,),
    );
  }
}