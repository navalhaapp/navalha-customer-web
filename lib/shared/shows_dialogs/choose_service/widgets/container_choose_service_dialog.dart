import 'package:auto_size_text/auto_size_text.dart';
import 'package:flutter/material.dart';

class ContainerChooseServiceDialog extends StatelessWidget {
  final String price;
  final String service;
  final String imgservice;
  final String time;
  final Function onTap;

  const ContainerChooseServiceDialog({
    Key? key,
    required this.price,
    required this.service,
    required this.imgservice,
    required this.time,
    required this.onTap,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final size = MediaQuery.of(context).size;
    return Column(
      children: [
        GestureDetector(
          onTap: () => onTap(),
          child: Container(
            alignment: Alignment.center,
            height: size.height * 0.08,
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
                        decoration: TextDecoration.none,
                        fontSize: 10,
                        color: Colors.white,
                      ),
                    ),
                    SizedBox(height: size.height * 0.005),
                    Row(
                      children: [
                        Row(
                          children: [
                            const Icon(
                              Icons.access_time_rounded,
                              color: Colors.white,
                              size: 15,
                            ),
                            Text(
                              '${time}min',
                              style: const TextStyle(
                                decoration: TextDecoration.none,
                                color: Colors.white,
                                fontSize: 14,
                              ),
                            ),
                          ],
                        ),
                        SizedBox(width: size.width * 0.05),
                        Row(
                          children: [
                            const Text(
                              'R\$ ',
                              style: TextStyle(
                                decoration: TextDecoration.none,
                                color: Colors.white,
                                fontSize: 14,
                              ),
                            ),
                            Text(
                              price,
                              style: const TextStyle(
                                decoration: TextDecoration.none,
                                color: Colors.white,
                                fontSize: 14,
                              ),
                            ),
                          ],
                        ),
                      ],
                    ),
                  ],
                ),
              ],
            ),
          ),
        ),
        SizedBox(
          height: size.height * 0.01,
        ),
      ],
    );
  }
}
