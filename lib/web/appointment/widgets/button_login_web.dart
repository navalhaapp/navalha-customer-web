// Developer            Data              Decription
// Rovigo              22/08/2022        Extracting button login

import 'package:flutter/material.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';

import '../../../core/colors.dart';

class ButtonLoginWeb extends StatefulHookConsumerWidget {
  const ButtonLoginWeb({
    super.key,
    required this.onPressed,
    required this.child,
  });

  final Function onPressed;
  final Widget child;

  @override
  ConsumerState<ButtonLoginWeb> createState() => _ButtonLoginWebState();
}

class _ButtonLoginWebState extends ConsumerState<ButtonLoginWeb> {
  @override
  Widget build(BuildContext context) {
    return MaterialButton(
      onPressed: () => widget.onPressed(),
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(15),
      ),
      minWidth: 500,
      color: const Color.fromARGB(255, 30, 30, 30),
      height: 50,
      child: widget.child,
    );
  }
}
