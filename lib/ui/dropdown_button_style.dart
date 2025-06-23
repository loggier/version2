import 'package:flutter/material.dart';
import 'package:prosecat/helpers/scale_size.dart';


Container getLabelButton(String text, BuildContext context) {
    // Theme.of(context).brightness == Brightness.light ? Colors.black87 : Colors.white,
    return Container(
      alignment: Alignment.center,
      margin: const EdgeInsets.only(right: 5),
      padding: const EdgeInsets.symmetric(horizontal: 5),
      height: 24,
      decoration: BoxDecoration(
        color: Theme.of(context).brightness == Brightness.light ? Colors.white : Colors.grey.shade900,
        borderRadius: BorderRadius.circular(5)
      ),
      child: Text(
        text,
        style: Theme.of(context).textTheme.bodyLarge!.copyWith(
          color: Theme.of(context).brightness == Brightness.light ? Colors.black87 : Colors.white,
        ),
        textScaler: TextScaler.linear(ScaleSize.textScaleFactor(context)),
        
      ),
    );
  }