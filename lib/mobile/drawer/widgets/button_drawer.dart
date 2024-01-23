import 'package:flutter/material.dart';

import 'package:navalha/core/colors.dart';

class ButtonsDrawer extends StatelessWidget {
  final String label;
  final Function onPressed;
  final Color color;

  const ButtonsDrawer({
    Key? key,
    required this.label,
    required this.onPressed,
    required this.color,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final size = MediaQuery.of(context).size;

    return Padding(
      padding: EdgeInsets.only(bottom: size.height * 0.01),
      child: MaterialButton(
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(25),
        ),
        elevation: 5,
        minWidth: size.width * 0.6,
        height: size.height * 0.05,
        color: colorContainers242424,
        onPressed: () => onPressed(),
        child: Text(
          label,
          style: TextStyle(
            shadows: shadow,
            color: color,
            fontSize: size.height * 0.02,
          ),
        ),
      ),
    );
  }
}
