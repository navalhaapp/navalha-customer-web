import 'package:flutter/material.dart';

SnackBar snackBarPattern(String message,
    {EdgeInsetsGeometry? margin, Color? color, SnackBarBehavior? position}) {
  return SnackBar(
    elevation: 10,
    margin: margin,
    dismissDirection: DismissDirection.down,
    backgroundColor: color ?? const Color.fromARGB(255, 255, 255, 255),
    behavior: position ?? SnackBarBehavior.fixed,
    duration: const Duration(seconds: 2),
    shape: const RoundedRectangleBorder(
      borderRadius: BorderRadius.all(
        Radius.circular(8),
      ),
    ),
    content: Text(message, style: const TextStyle(color: Colors.black)),
  );
}
