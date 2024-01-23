import 'package:flutter/material.dart';

import '../../core/colors.dart';

class ButtonPatternDialog extends StatelessWidget {
  final Widget child;
  final Function onPressed;
  final Color? color;
  final double? width;
  const ButtonPatternDialog({
    Key? key,
    required this.child,
    required this.onPressed,
    this.color,
    this.width,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final size = MediaQuery.of(context).size;
    return Container(
      margin: const EdgeInsets.symmetric(vertical: 10),
      width: width ?? size.width * 0.3,
      height: 35,
      decoration: BoxDecoration(
        color: colorContainers242424,
        borderRadius: const BorderRadius.all(
          Radius.circular(14),
        ),
      ),
      child: ElevatedButton(
        style: ButtonStyle(
          elevation: MaterialStateProperty.all(5),
          backgroundColor: MaterialStateProperty.all<Color>(
            color ?? colorContainers242424,
          ),
          overlayColor: MaterialStateProperty.all<Color>(
            colorContainers353535,
          ),
          shape: MaterialStateProperty.all<RoundedRectangleBorder>(
            RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(14),
            ),
          ),
        ),
        child: child,
        onPressed: () => onPressed(),
      ),
    );
  }
}
