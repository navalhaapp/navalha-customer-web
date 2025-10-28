import 'package:flutter/material.dart';

import '../../core/colors.dart';

class ButtonPattern extends StatelessWidget {
  final Widget child;
  final Function onPressed;
  final Color? color;
  final double? width;
  final bool? elevation;
  final EdgeInsetsGeometry? margin;
  const ButtonPattern({
    Key? key,
    required this.child,
    required this.onPressed,
    this.color,
    this.width,
    this.elevation,
    this.margin,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final size = MediaQuery.of(context).size;
    return Container(
      margin: margin ?? const EdgeInsets.symmetric(vertical: 10),
      width: width ?? size.width * 0.45,
      height: 35,
      decoration: BoxDecoration(
        color: colorContainers242424,
        borderRadius: const BorderRadius.all(
          Radius.circular(14),
        ),
        border: Border.all(color: Colors.white.withOpacity(0.06), width: 1),
        boxShadow: [
          BoxShadow(
            color: Colors.black.withOpacity(0.20),
            blurRadius: 10,
            offset: const Offset(0, 6),
          ),
        ],
      ),
      child: ElevatedButton(
        style: ButtonStyle(
          overlayColor: MaterialStateProperty.all<Color>(
            colorContainers353535,
          ),
          elevation: MaterialStateProperty.all(elevation == null ? 5 : 0),
          backgroundColor: MaterialStateProperty.all<Color>(
            color ?? colorContainers242424,
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
