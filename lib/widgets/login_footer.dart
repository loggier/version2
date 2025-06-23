import 'package:prosecat/generated/l10n.dart';
import 'package:flutter/material.dart';
import 'package:prosecat/system/global.dart';

class LoginFooter extends StatelessWidget {
  final double screenWidth;

  const LoginFooter({Key? key, required this.screenWidth}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    // return Text('PROSECAT | Sistema de Rastreo Satelital');
    return Container(
      // color: Colors.white,
      width: (screenWidth * 80) / 100,
      height: 60,
      decoration: BoxDecoration(
          border: Border(
              top: BorderSide(
                  color: Theme.of(context).brightness == Brightness.light
                      ? Colors.black
                      : Colors.white,
                  width: 1.0))),
      child: Center(
          child: Text(
        '${GlobalVariables().fotterName.toUpperCase()} ',
        style: const TextStyle(fontWeight: FontWeight.bold),
        textAlign: TextAlign.center,
      )),
    );
  }
}
