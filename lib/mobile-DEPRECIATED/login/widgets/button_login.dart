import 'package:flutter/material.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:navalha/core/colors.dart';

class ButtonLogin extends StatefulHookConsumerWidget {
  const ButtonLogin({
    super.key,
    required this.onPressed,
    required this.child,
  });

  final Function onPressed;
  final Widget child;

  @override
  ConsumerState<ButtonLogin> createState() => _ButtonLoginState();
}

class _ButtonLoginState extends ConsumerState<ButtonLogin> {
  @override
  Widget build(BuildContext context) {
    return MaterialButton(
      elevation: 0,
      onPressed: () => widget.onPressed(),
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(15),
      ),
      minWidth: MediaQuery.of(context).size.width * .9,
      color: colorContainers242424,
      height: 50,
      child: widget.child,
    );
  }
}
