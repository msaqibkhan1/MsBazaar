import 'package:another_flushbar/flushbar.dart';
import 'package:flutter/material.dart';

class AnotherFlushbar {
  static anotherFlushbar(context, String message) {
    return Flushbar(
      margin: const EdgeInsets.only(left: 25, right: 25),
      borderRadius: BorderRadius.circular(8),
      message: message,
      // backgroundColor: Colors.blue,
      borderColor: Colors.black,
      shouldIconPulse: false,
      backgroundGradient: const LinearGradient(colors: [
        Colors.blue,
        Colors.red,
      ]),
      forwardAnimationCurve: Curves.elasticInOut,
      flushbarPosition: FlushbarPosition.TOP,
      isDismissible: false,
      duration: const Duration(seconds: 4),
      icon: const Icon(
        Icons.error,
        color: Colors.white,
      ),
    ).show(context);
  }
}
