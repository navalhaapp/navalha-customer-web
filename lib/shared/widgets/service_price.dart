// Developer            Data              Decription
// Vitor               12/10/2022        Fork a top_container_title and add startlist

import 'package:flutter/material.dart';

class ServicePrice extends StatelessWidget {
  final String price;
  final String service;
  final bool disabled;

  const ServicePrice({
    Key? key,
    required this.price,
    required this.service,
    required this.disabled,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final size = MediaQuery.of(context).size;
    return Padding(
      padding: EdgeInsets.only(
        right: size.width * 0.05,
        top: size.height * 0.01,
        bottom: size.height * 0.02,
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            service,
            style: const TextStyle(
              color: Colors.white,
              fontSize: 16,
            ),
          ),
          Row(
            mainAxisAlignment: MainAxisAlignment.center,
            crossAxisAlignment: CrossAxisAlignment.end,
            children: [
              Padding(
                padding: EdgeInsets.only(bottom: size.height * 0.003),
                child: Text(
                  'R\$',
                  style: TextStyle(
                    color: Colors.white,
                    fontSize: size.height * 0.012,
                  ),
                ),
              ),
              Text(
                price,
                style: TextStyle(
                  color: Colors.white,
                  fontSize: size.height * 0.02,
                ),
              ),
            ],
          ),
        ],
      ),
    );
  }
}
