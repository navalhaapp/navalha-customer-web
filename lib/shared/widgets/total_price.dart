import 'package:flutter/material.dart';
import 'package:intl/intl.dart';

class TotalPrice extends StatelessWidget {
  final double price;
  final String service;
  final bool disabled;

  const TotalPrice({
    Key? key,
    required this.price,
    required this.service,
    required this.disabled,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final heightSize = MediaQuery.of(context).size.height;
    return Padding(
      padding: const EdgeInsets.only(top: 10),
      child: Column(
        children: [
          Text(
            service,
            style: TextStyle(
              color: disabled
                  ? Colors.white
                  : const Color.fromARGB(255, 62, 62, 62),
              fontSize: 16,
            ),
          ),
          Row(
            mainAxisAlignment: MainAxisAlignment.center,
            crossAxisAlignment: CrossAxisAlignment.end,
            children: [
              Padding(
                padding: const EdgeInsets.only(bottom: 2),
                child: Text(
                  'R\$',
                  style: TextStyle(
                    color: disabled
                        ? Colors.white
                        : const Color.fromARGB(255, 62, 62, 62),
                    fontSize: heightSize * 0.012,
                  ),
                ),
              ),
              Text(
                NumberFormat.simpleCurrency(decimalDigits: 2, name: "")
                    .format(price),
                style: TextStyle(
                  color: disabled
                      ? Colors.white
                      : const Color.fromARGB(255, 62, 62, 62),
                  fontSize: heightSize * 0.02,
                ),
              ),
            ],
          ),
        ],
      ),
    );
  }
}
