import 'package:flutter/material.dart';

class FloatingButtonOnMap extends StatelessWidget {
  const FloatingButtonOnMap({
    super.key,
    required this.screenHeight, required this.buttonOnMap,
  });

  final double screenHeight;
  final Widget buttonOnMap;

  @override
  Widget build(BuildContext context) {
    return Container(
      // margin: EdgeInsets.only(top: (screenHeight * 10) / 100),
      child: buttonOnMap,
    );
  }
}

