// Developer            Data              Decription
// Vitor               22/08/2022        Schedule confirmation button creation

import 'package:flutter/material.dart';

class SlideTransitionAnimation extends PageRouteBuilder {
  final Widget page;
  Curve? curveType;
  SlideTransitionAnimation({
    required this.page,
    this.curveType,
  }) : super(
            pageBuilder: (context, animation, anotherAnimation) => page,
            transitionDuration: const Duration(
              milliseconds: 2000,
            ),
            transitionsBuilder: (context, animation, anotherAnimation, child) {
              animation = CurvedAnimation(
                curve: curveType ?? Curves.easeOutExpo,
                parent: animation,
              );
              return SlideTransition(
                position: Tween(
                        begin: const Offset(1.0, 0.0),
                        end: const Offset(0.0, 0.0))
                    .animate(animation),
                textDirection: TextDirection.rtl,
                child: page,
              );
            });
}
