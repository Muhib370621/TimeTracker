import 'package:flutter/material.dart';

class Utilities {
  static showSnack(BuildContext context, String text,
      {bool persistent = false}) {
    ScaffoldMessenger.of(context).hideCurrentSnackBar();
    Duration duration =
        (persistent) ? const Duration(days: 1) : const Duration(milliseconds: 4000);
    DismissDirection dismissDirection =
        (persistent) ? DismissDirection.none : DismissDirection.down;
    ScaffoldMessenger.of(context).showSnackBar(SnackBar(
      content: Text(
        text,
        style: const TextStyle(
            fontWeight: FontWeight.w700, fontSize: 14, color: Colors.white),
      ),
      duration: duration,
      dismissDirection: dismissDirection,
      behavior: SnackBarBehavior.floating,
    ));
  }
}