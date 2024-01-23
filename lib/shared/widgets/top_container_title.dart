// Developer            Data              Decription
// Rovigo               22/08/2022        Top container pattern creation

import 'dart:core';
import 'package:flutter/material.dart';
import 'package:navalha/core/assets.dart';
import 'package:navalha/core/colors.dart';

class TopContainerTitle extends StatelessWidget {
  final String imgProfile;
  final String imgBackGround;
  final String name;

  const TopContainerTitle({
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
                left: MediaQuery.of(context).size.height * 0.1,
                bottom: MediaQuery.of(context).size.height * 0.02,
              ),
              width: double.maxFinite,
              height: MediaQuery.of(context).size.height * 0.07,
              decoration: BoxDecoration(
                color: colorContainers242424,
                borderRadius: const BorderRadius.only(
                  bottomRight: Radius.circular(35),
                ),
              ),
              child: Padding(
                padding: EdgeInsets.only(
                    left: MediaQuery.of(context).size.width * 0.08),
                child: Center(
                  child: SizedBox(
                    width: MediaQuery.of(context).size.width * 0.5,
                    child: Text(
                      textAlign: TextAlign.center,
                      overflow: TextOverflow.ellipsis,
                      name.contains(' ')
                          ? name.substring(0, name.indexOf(' '))
                          : name,
                      maxLines: 1,
                      style: const TextStyle(
                        fontSize: 20,
                        fontWeight: FontWeight.bold,
                        color: Colors.white,
                        shadows: [
                          Shadow(
                            blurRadius: 1,
                            offset: Offset(1, 1),
                            color: Color.fromARGB(255, 0, 0, 0),
                          ),
                        ],
                      ),
                    ),
                  ),
                ),
              ),
            ),
          ],
        ),
        Positioned(
          top: MediaQuery.of(context).size.height * 0.185,
          child: Container(
            decoration: BoxDecoration(
              boxShadow: const [
                BoxShadow(
                  blurRadius: 8,
                  color: Color.fromARGB(255, 4, 4, 4),
                  offset: Offset(1, 1),
                )
              ],
              shape: BoxShape.circle,
              image: DecorationImage(
                fit: BoxFit.cover,
                image: NetworkImage(imgProfile),
              ),
            ),
            width: MediaQuery.of(context).size.height * 0.185,
            height: MediaQuery.of(context).size.height * 0.185,
            child: ClipOval(
              child: FadeInImage.assetNetwork(
                placeholder: imgLoading3,
                image: imgProfile,
                fit: BoxFit.cover,
              ),
            ),
          ),
        ),
      ],
    );
  }
}
