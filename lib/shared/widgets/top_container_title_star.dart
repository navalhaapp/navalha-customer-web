// Developer            Data              Decription
// Rovigo               22/08/2022        Top container pattern creation

import 'dart:core';

import 'package:auto_size_text/auto_size_text.dart';
import 'package:flutter/material.dart';
import 'package:navalha/core/assets.dart';
import 'package:navalha/core/colors.dart';

class TopContainerTitleStar extends StatelessWidget {
  final String imgProfile;
  final String imgBackGround;
  final String name;

  const TopContainerTitleStar({
    Key? key,
    required this.imgProfile,
    required this.imgBackGround,
    required this.name,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Stack(
      children: [
        Column(
          mainAxisAlignment: MainAxisAlignment.start,
          children: [
            Container(
              width: double.maxFinite,
              height: MediaQuery.of(context).size.height * 0.3,
              decoration: BoxDecoration(
                borderRadius: const BorderRadius.only(
                  bottomLeft: Radius.circular(50),
                ),
                image: DecorationImage(
                  opacity: 0.6,
                  image: AssetImage(imgBackgroundBarberShopSmall),
                  fit: BoxFit.cover,
                ),
              ),
            ),
            Container(
              margin: EdgeInsets.only(
                  left: MediaQuery.of(context).size.height * 0.1),
              width: double.maxFinite,
              height: MediaQuery.of(context).size.height * 0.07,
              decoration: const BoxDecoration(
                color: Color.fromARGB(255, 26, 26, 26),
                borderRadius: BorderRadius.only(
                  bottomRight: Radius.circular(35),
                ),
              ),
              child: Padding(
                padding: EdgeInsets.only(
                    left: MediaQuery.of(context).size.width * 0.08),
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Center(
                      child: AutoSizeText(
                        name,
                        maxLines: 2,
                        style: TextStyle(
                          fontSize: MediaQuery.of(context).size.width * 0.06,
                          fontWeight: FontWeight.bold,
                          color: Colors.white,
                          shadows: const [
                            Shadow(
                              blurRadius: 10,
                              offset: Offset(1, 1),
                              color: Color.fromARGB(255, 0, 0, 0),
                            )
                          ],
                        ),
                      ),
                    ),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        Icon(
                          Icons.star,
                          color: Colors.white,
                          size: 15,
                          shadows: shadow,
                        ),
                        const Icon(Icons.star, color: Colors.white, size: 15),
                        const Icon(Icons.star, color: Colors.white, size: 15),
                        const Icon(Icons.star, color: Colors.white, size: 15),
                        const Icon(Icons.star_border, color: Colors.white, size: 15),
                      ],
                    ),
                  ],
                ),
              ),
            ),
          ],
        ),
        Positioned(
          top: MediaQuery.of(context).size.height * 0.185,
          child: Container(
            width: MediaQuery.of(context).size.height * 0.185,
            height: MediaQuery.of(context).size.height * 0.185,
            decoration: BoxDecoration(
              shape: BoxShape.circle,
              image: DecorationImage(
                fit: BoxFit.fill,
                image: AssetImage(imgProfile),
              ),
            ),
          ),
        ),
      ],
    );
  }
}
