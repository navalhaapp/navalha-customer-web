import 'package:flutter/material.dart';

class NameUser extends StatelessWidget {
  const NameUser({
    Key? key,
    required this.name,
  }) : super(key: key);

  final String name;

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      width: MediaQuery.of(context).size.width * 0.8,
      child: Text(
        overflow: TextOverflow.ellipsis,
        name.contains(' ') ? name.substring(0, name.indexOf(' ')) : name,
        textAlign: TextAlign.center,
        style: const TextStyle(
          color: Colors.white,
          fontSize: 20,
        ),
      ),
    );
  }
}
