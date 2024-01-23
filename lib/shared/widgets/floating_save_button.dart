import 'package:flutter/material.dart';

class FloatingSaveButton extends StatelessWidget {
  final Function onPressed;
  const FloatingSaveButton({
    Key? key,
    required this.onPressed,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return FloatingActionButton(
      mini: false,
      backgroundColor: Colors.transparent,
      splashColor: Colors.black,
      onPressed: () => onPressed(),
      hoverElevation: 1.5,
      shape: const StadiumBorder(
        side: BorderSide(color: Color.fromARGB(255, 255, 228, 92), width: 2),
      ),
      elevation: 1.5,
      child: const Icon(Icons.save, color: Colors.white, size: 25),
    );
  }
}
