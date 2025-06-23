import 'package:flutter/material.dart';

Future<void> showMyDialog(BuildContext context, String title, String message, String labelButton) async {

  return showDialog<void>(  
    context: context,
    barrierDismissible: false, // user must tap button!
    builder: (BuildContext context) {
      return AlertDialog(
        title: Center(child: Text(title)),
        content: SingleChildScrollView(
          child: Center(
            child: Text(message)
          ),
        ),
        actions: <Widget>[
          Center(
            child: TextButton(
              child: Text(labelButton, style: TextStyle(color: Theme.of(context).colorScheme.primary),),
              onPressed: () {
                Navigator.of(context).pop();
              },
            ),
          ),
        ],
      );
    },
  );
}
