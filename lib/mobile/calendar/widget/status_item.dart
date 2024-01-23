import 'package:flutter/material.dart';

class StatusItem extends StatelessWidget {
  const StatusItem({
    Key? key,
    required this.status,
    required this.color,
    required this.textColor,
  }) : super(key: key);

  final String status;
  final Color color;
  final Color textColor;

  @override
  Widget build(BuildContext context) {
    Size size = MediaQuery.of(context).size;
    return Container(
      decoration: BoxDecoration(
        borderRadius: const BorderRadius.all(
          Radius.circular(10),
        ),
        color: color,
      ),
      margin: EdgeInsets.only(bottom: size.height * 0.01, right: 10),
      child: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 6, vertical: 3),
        child: Text(
          textAlign: TextAlign.center,
          status,
          style: TextStyle(color: textColor),
        ),
      ),
    );
  }
}
