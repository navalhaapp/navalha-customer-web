import 'package:flutter/material.dart';

void navigationWithFadeAnimation(Widget page, BuildContext context) {
  Navigator.push(
      context,
      PageRouteBuilder(
          pageBuilder: (_, __, ___) => page,
          transitionDuration: const Duration(milliseconds: 150),
          transitionsBuilder: (_, a, __, c) =>
              FadeTransition(opacity: a, child: c)));
}
