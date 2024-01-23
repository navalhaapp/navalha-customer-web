import 'package:flutter/material.dart';

enum PageTransitionType { regular, fade }

class PageTransition {
  Widget child;
  PageTransitionType type;
  Duration transitionDuration;

  PageTransition(
      {required this.child,
      this.type = PageTransitionType.regular,
      required this.transitionDuration});

  build() {
    switch (type) {
      case PageTransitionType.regular:
        return MaterialPageRoute(builder: (_) => child);

      case PageTransitionType.fade:
        return PageRouteBuilder(
            pageBuilder: (_, __, ___) => child,
            transitionsBuilder: (_, a, __, c) =>
                FadeTransition(opacity: a, child: c),
            transitionDuration: transitionDuration);

      default:
        return MaterialPageRoute(builder: (_) => child);
    }
  }
}

void navigationFadePush(Widget page, BuildContext context) {
  Navigator.of(context).push(PageTransition(
    child: page,
    type: PageTransitionType.fade,
    transitionDuration: const Duration(milliseconds: 300),
  ).build());
}

void navigationFadePushReplacement(Widget page, BuildContext context) {
  Navigator.of(context).pushReplacement(PageTransition(
    child: page,
    type: PageTransitionType.fade,
    transitionDuration: const Duration(milliseconds: 300),
  ).build());
}
