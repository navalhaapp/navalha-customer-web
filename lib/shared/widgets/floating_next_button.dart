// Developer            Data              Decription
// Vitor               22/08/2022        Floating next button creation

// ignore_for_file: public_member_api_docs, sort_constructors_first
import 'package:flutter/material.dart';

class FloatingNextButton extends StatelessWidget {
  final Function onPressed;
  const FloatingNextButton({
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
          side: BorderSide(color: Color.fromARGB(255, 255, 228, 92), width: 4)),
      elevation: 1.5,
      child: const Icon(Icons.navigate_next, color: Colors.white, size: 45),
    );
  }
}
