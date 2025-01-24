import 'package:flutter/material.dart';

class NavalhaUtils {
  EdgeInsets calculateDialogPadding(BuildContext context) {
    double screenWidth = MediaQuery.of(context).size.width;
    double dialogWidth = 600;

    // Calcula o padding necessário para centralizar o diálogo
    double horizontalPadding = (screenWidth > dialogWidth)
        ? (screenWidth - dialogWidth) / 2
        : 20.0; // Define um padding mínimo para telas menores

    return EdgeInsets.symmetric(horizontal: horizontalPadding);
  }
}
