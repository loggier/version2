import 'package:flutter/material.dart';
import 'package:flutter_spinkit/flutter_spinkit.dart';

AnimatedContainer buildLoadingSpin() {
    return AnimatedContainer(
      // color: Colors.transparent,
      width: double.infinity,
      duration: const Duration(milliseconds: 800),
      curve: Curves.fastLinearToSlowEaseIn,
      child: Dialog(
        insetPadding: const EdgeInsets.all(0),
        elevation: 1,
        shape: const RoundedRectangleBorder(
          borderRadius: BorderRadius.zero, // Establece los bordes a cero
        ),
        backgroundColor: Colors.transparent,
        child: Center(
                  child: Container(
                    width: 100,
                    height: 100,
                    alignment: Alignment.center,
                    decoration: BoxDecoration(
                      color: Colors.white,
                      shape: BoxShape.rectangle,
                      borderRadius: BorderRadius.circular(20),
                      boxShadow: const [
                        BoxShadow(
                          color: Colors.black26,
                          blurRadius: 10,
                          offset: Offset(0, 10)
                        )
                      ]
                    ),
                    child: const SpinKitPulse(
                      color: Colors.indigoAccent,
                      size: 100,
                    )
                  ),
                ),
      ),
    );
  }