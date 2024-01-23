import 'package:auto_size_text/auto_size_text.dart';
import 'package:flutter/material.dart';

class ContainerEvaluateDialog extends StatelessWidget {
  final String price;
  final String service;
  final String imgservice;

  const ContainerEvaluateDialog({
    Key? key,
    required this.price,
    required this.service,
    required this.imgservice,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final size = MediaQuery.of(context).size;
    return Column(
      children: [
        Container(
          alignment: Alignment.center,
          height: size.height * 0.075,
          width: double.maxFinite,
          decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(15),
            color: const Color.fromARGB(255, 24, 24, 24),
          ),
          child: Row(
            children: [
              SizedBox(width: size.width * 0.01),
              CircleAvatar(
                radius: size.height * 0.035,
                backgroundColor: const Color.fromARGB(255, 34, 34, 34),
                child: SizedBox(
                  height: size.height * 0.2,
                  width: size.width * 0.2,
                  child: Image.asset(imgservice),
                ),
              ),
              SizedBox(width: size.width * 0.02),
              Column(
                mainAxisSize: MainAxisSize.min,
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  AutoSizeText(
                    service,
                    style: const TextStyle(
                      color: Colors.white,
                    ),
                  ),
                  Text(
                    price,
                    style: const TextStyle(
                      color: Colors.white,
                      fontSize: 14,
                    ),
                  ),
                ],
              ),
            ],
          ),
        ),
        SizedBox(
          height: size.height * 0.01,
        ),
      ],
    );
  }
}
