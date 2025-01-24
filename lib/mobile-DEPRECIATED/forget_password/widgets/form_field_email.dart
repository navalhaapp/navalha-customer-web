import 'package:flutter/material.dart';

import 'package:navalha/core/colors.dart';

class FormFieldEmail extends StatelessWidget {
  const FormFieldEmail({
    Key? key,
    required this.hint,
    required this.controller,
    this.maxLength,
  }) : super(key: key);

  final String hint;
  final TextEditingController controller;
  final int? maxLength;
  @override
  Widget build(BuildContext context) {
    return Container(
      margin: const EdgeInsets.symmetric(horizontal: 20),
      padding: const EdgeInsets.symmetric(horizontal: 20),
      decoration: BoxDecoration(
        color: colorContainers353535,
        borderRadius: const BorderRadius.all(
          Radius.circular(15),
        ),
      ),
      child: TextFormField(
        maxLength: maxLength,
        buildCounter: (BuildContext context,
                {int? currentLength, int? maxLength, bool? isFocused}) =>
            null,
        keyboardType: TextInputType.emailAddress,
        controller: controller,
        style: const TextStyle(
          color: Color.fromARGB(255, 255, 255, 255),
        ),
        decoration: InputDecoration(
          hintText: hint,
          hintStyle: const TextStyle(
            color: Color.fromARGB(255, 255, 255, 255),
          ),
          border: InputBorder.none,
        ),
      ),
    );
  }
}
