import 'package:flutter/material.dart';

import 'package:navalha/core/colors.dart';

import '../../../core/assets.dart';
import '../../../core/images_s3.dart';

class ContainerServicesTimeAndPrice extends StatelessWidget {
  final String service;
  final String price;
  final String time;
  final bool select;

  const ContainerServicesTimeAndPrice({
    Key? key,
    required this.service,
    required this.price,
    required this.time,
    required this.select,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    Size size = MediaQuery.of(context).size;
    return Container(
      margin: EdgeInsets.symmetric(
        horizontal: size.width * 0.01,
        vertical: size.height * 0.015,
      ),
      width: size.width * 0.21,
      // height: size.height * 0.133,
      decoration: BoxDecoration(
        boxShadow: shadow,
        color: !select
            ? const Color.fromARGB(255, 30, 30, 30)
            : colorContainers242424,
        borderRadius: BorderRadiusDirectional.circular(15),
      ),
      child: Column(
        children: [
          SizedBox(
            height: size.height * 0.055,
            child: Padding(
              padding: EdgeInsets.symmetric(
                horizontal: size.width * 0.025,
                vertical: size.height < 700
                    ? size.height * 0.001
                    : size.height * 0.008,
              ),
              child: Text(
                textAlign: TextAlign.center,
                service,
                style: TextStyle(
                  color: !select
                      ? colorFontUnable116116116
                      : const Color.fromARGB(255, 255, 255, 255),
                ),
              ),
            ),
          ),
          Container(
            width: size.width * 0.23,
            height: size.height * 0.002,
            color: !select
                ? colorFontUnable116116116
                : const Color.fromARGB(255, 255, 255, 255),
          ),
          Container(
            margin: EdgeInsets.symmetric(
              // horizontal: size.width * 0.01,
              vertical: size.height * 0.01,
            ),
            padding: EdgeInsets.zero,
            width: size.height * 0.08,
            height: size.height * 0.08,
            child: Stack(
              alignment: Alignment.center,
              children: [
                ClipRRect(
                  borderRadius: BorderRadius.circular(100),
                  child: FadeInImage.assetNetwork(
                    placeholder: imgLoading3,
                    image: '$baseUrlS3bucket$iconServiceBeard',
                    fadeInDuration: const Duration(milliseconds: 500),
                    fadeInCurve: Curves.easeIn,
                  ),
                ),
                Visibility(
                  visible: !select,
                  child: CircleAvatar(
                    radius: size.height * 0.04,
                    backgroundColor: const Color.fromARGB(150, 0, 0, 0),
                  ),
                )
              ],
            ),
          ),
        ],
      ),
    );
  }
}
