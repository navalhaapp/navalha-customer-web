// Developer            Data              Decription
// Rovigo               12/10/2022        Fork a top_container_title and add startlist

import 'dart:core';

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_rating_bar/flutter_rating_bar.dart';

import 'package:navalha/core/assets.dart';
import 'package:navalha/core/colors.dart';

class TopContainerPatternStar extends StatefulWidget {
  final String imgProfile;
  final String? imgBackGround;
  final double rating;
  final double? height;
  final double? heightImage;

  const TopContainerPatternStar({
    Key? key,
    required this.imgProfile,
    this.imgBackGround,
    required this.rating,
    this.height,
    this.heightImage,
  }) : super(key: key);

  @override
  State<TopContainerPatternStar> createState() =>
      _TopContainerPatternStarState();
}

class _TopContainerPatternStarState extends State<TopContainerPatternStar> {
  @override
  Widget build(BuildContext context) {
    return Stack(
      children: [
        Column(
          mainAxisAlignment: MainAxisAlignment.start,
          children: [
            Container(
              width: double.maxFinite,
              height: widget.height ?? MediaQuery.of(context).size.height * 0.3,
              decoration: BoxDecoration(
                borderRadius: const BorderRadius.only(
                  bottomLeft: Radius.circular(50),
                ),
                image: widget.imgBackGround == null
                    ? DecorationImage(
                        opacity: 0.6,
                        image: AssetImage(imgBackgroundBarberShop3curt2),
                        fit: BoxFit.cover,
                      )
                    : null,
              ),
              child: widget.imgBackGround != null
                  ? FadeInImage.assetNetwork(
                      placeholder: imgBackgroundBarberShop,
                      image: widget.imgBackGround!,
                      fit: BoxFit.cover,
                      fadeInDuration: const Duration(milliseconds: 500),
                      fadeInCurve: Curves.easeIn,
                    )
                  : null,
            ),
            Container(
              alignment: Alignment.centerRight,
              margin: EdgeInsets.only(
                left: MediaQuery.of(context).size.height * 0.1,
                bottom: MediaQuery.of(context).size.height * 0.015,
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
                padding: const EdgeInsets.only(right: 20),
                child: RatingBar.builder(
                  initialRating: widget.rating,
                  minRating: 1,
                  direction: Axis.horizontal,
                  allowHalfRating: true,
                  itemCount: 5,
                  itemSize: MediaQuery.of(context).size.width * 0.05,
                  ignoreGestures: true,
                  unratedColor: const Color.fromARGB(80, 255, 255, 255),
                  itemBuilder: (context, _) => const Icon(
                    CupertinoIcons.star_fill,
                    color: Color.fromARGB(255, 255, 255, 255),
                  ),
                  onRatingUpdate: (rating) {},
                ),
              ),
            ),
          ],
        ),
        Positioned(
          top: widget.heightImage ?? MediaQuery.of(context).size.height * 0.185,
          child: Container(
            decoration: BoxDecoration(
              boxShadow: shadow,
              shape: BoxShape.circle,
            ),
            padding: EdgeInsets.zero,
            width: MediaQuery.of(context).size.height * 0.185,
            height: MediaQuery.of(context).size.height * 0.185,
            child: ClipRRect(
              borderRadius: BorderRadius.circular(1000),
              child: FadeInImage.assetNetwork(
                placeholder: imgLoading3,
                image: widget.imgProfile,
                fit: BoxFit.cover,
                fadeInDuration: const Duration(milliseconds: 500),
                fadeInCurve: Curves.easeIn,
              ),
            ),
          ),
        ),
      ],
    );
  }
}
