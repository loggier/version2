import 'package:flutter/material.dart';
import 'package:flutter_speed_dial/flutter_speed_dial.dart';
import 'package:prosecat/ui/ui.dart';

SpeedDialChild getChildButton(
    double width, 
    IconData icon,
    String label,
    VoidCallback onTap,
    BuildContext context,
    {
      Color backgroundColor = Colors.white,
      Color foregroundColor = Colors.black
    }
  ) {
    return SpeedDialChild(
      backgroundColor: backgroundColor,
      foregroundColor: foregroundColor,
      shape: const CircleBorder(),
      labelWidget: getLabelButton(label, context),
      child: Icon(icon, size: (width * 6) / 100,),
      onTap: onTap
    );
  }