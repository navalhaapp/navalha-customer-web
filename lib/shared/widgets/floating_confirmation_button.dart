// Developer            Data              Decription
// Vitor               22/08/2022        Floating confirmation button creation

import 'package:flutter/material.dart';

class FloatingConfirmationButton extends StatelessWidget {
  final Function onPressed;
  const FloatingConfirmationButton({
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
        side: BorderSide(color: Color.fromARGB(255, 255, 228, 92), width: 4),
      ),
      elevation: 1.5,
      child: const Icon(Icons.check, color: Colors.white, size: 30),
    );
  }
}
