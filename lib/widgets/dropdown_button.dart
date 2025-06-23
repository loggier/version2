import 'package:flutter/material.dart';
import 'package:flutter_speed_dial/flutter_speed_dial.dart';

class DropdownButtonD extends StatelessWidget {
  final List<SpeedDialChild> children;
  const DropdownButtonD({
    super.key, 
    required this.children,
  });

  @override
  Widget build(BuildContext context) {
    final width = MediaQuery.of(context).size.width;
    Size iconSize = Size((width * 12) / 100, (width * 12) / 100);
    return SpeedDial(
      gradientBoxShape: BoxShape.circle,
      closeManually: false,
      buttonSize: iconSize,
      childrenButtonSize: iconSize,
      direction: SpeedDialDirection.down,
      // backgroundColor: Theme.of(context).primaryColorLight,
      backgroundColor: Theme.of(context).brightness == Brightness.light ? Colors.white : Colors.grey.shade900,
      foregroundColor: Theme.of(context).brightness == Brightness.light ? Colors.black87 : Colors.white,
      animatedIcon: AnimatedIcons.menu_close,
      spacing: 1,
      spaceBetweenChildren: 2,
      renderOverlay: false,
      children: children
    );
  }
}