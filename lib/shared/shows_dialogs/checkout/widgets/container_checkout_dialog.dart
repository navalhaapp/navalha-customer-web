import 'package:auto_size_text/auto_size_text.dart';
import 'package:flutter/material.dart';

import '../../../../core/colors.dart';

class ContainerCheckoutDialog extends StatelessWidget {
  final String price;
  final String service;
  final String imgservice;
  final bool lastOne;

  const ContainerCheckoutDialog({
    Key? key,
    required this.price,
    required this.service,
    required this.imgservice,
    required this.lastOne,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final size = MediaQuery.of(context).size;
    return Padding(
      padding: const EdgeInsets.all(8.0),
      child: Container(
        decoration: BoxDecoration(
          border: Border(
            bottom: BorderSide(
              color: !lastOne ? colorFontUnable116116116 : Colors.transparent,
              width: 0.5,
            ),
          ),
        ),
        child: Padding(
          padding: const EdgeInsets.all(8.0),
          child: Row(
            children: [
              CircleAvatar(
                radius: size.height * 0.045,
                backgroundColor: const Color.fromARGB(255, 34, 34, 34),
                child: SizedBox(
                  height: size.height * 0.2,
                  width: size.width * 0.2,
                  child: Image.asset(imgservice),
                ),
              ),
              SizedBox(width: size.width * 0.1),
              Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                mainAxisAlignment: MainAxisAlignment.spaceAround,
                children: [
                  AutoSizeText(
                    service,
                    style: const TextStyle(color: Colors.white, fontSize: 17),
                  ),
                  SizedBox(height: size.height * 0.015),
                  Text(
                    price,
                    style: const TextStyle(
                      color: Color.fromARGB(255, 153, 153, 153),
                      fontSize: 17,
                    ),
                  ),
                ],
              ),
            ],
          ),
        ),
      ),
    );
  }
}
