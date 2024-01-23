// Developer            Data              Decription
// Vitor Daniel         22/08/2022        Barber list item creation

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_rating_bar/flutter_rating_bar.dart';
import 'package:navalha/core/assets.dart';
import 'package:navalha/core/colors.dart';
import 'package:navalha/shared/widgets/service_price.dart';

class BarberListItem extends StatefulWidget {
  const BarberListItem({
    Key? key,
    required this.berbercutPrice,
    required this.haircutPrice,
    required this.scissorPrice,
    required this.barberShopName,
    this.topColor = const Color.fromARGB(255, 18, 18, 18),
    this.bottomCollor = const Color.fromARGB(255, 25, 25, 25),
    required this.rating,
    required this.distance,
    required this.imgBarberShop,
    required this.berbercutVisible,
    required this.scissorVisible,
    required this.haircutVisible,
  }) : super(key: key);

  final double berbercutPrice;
  final double haircutPrice;
  final double scissorPrice;
  final String barberShopName;
  final Color topColor;
  final Color bottomCollor;
  final double rating;
  final String distance;
  final String imgBarberShop;
  final bool berbercutVisible;
  final bool scissorVisible;
  final bool haircutVisible;
  @override
  State<BarberListItem> createState() => _BarberListItemState();
}

class _BarberListItemState extends State<BarberListItem> {
  @override
  Widget build(BuildContext context) {
    Size size = MediaQuery.of(context).size;

    return Padding(
      padding: EdgeInsets.only(
        left: size.width * 0.02,
        right: size.width * 0.02,
        bottom: size.height * 0.02,
      ),
      child: Column(
        children: [
          Container(
            padding: const EdgeInsets.only(top: 15, right: 10, left: 15),
            width: double.maxFinite,
            decoration: BoxDecoration(
              borderRadius:
                  const BorderRadius.vertical(top: Radius.circular(18)),
              color: colorContainers242424,
            ),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Row(
                  children: [
                    Container(
                      margin: const EdgeInsets.only(right: 5),
                      padding: EdgeInsets.zero,
                      width: size.height * 0.03,
                      height: size.height * 0.03,
                      decoration: const BoxDecoration(
                        shape: BoxShape.circle,
                      ),
                      child: ClipOval(
                        child: FadeInImage.assetNetwork(
                          placeholder: imgLoading3,
                          image: widget.imgBarberShop,
                          fit: BoxFit.cover,
                        ),
                      ),
                    ),
                    SizedBox(
                      width: size.width * 0.8,
                      child: Text(
                        widget.barberShopName,
                        overflow: TextOverflow.ellipsis,
                        style: TextStyle(
                          color: Colors.white,
                          fontSize: size.width * 0.048,
                          fontWeight: FontWeight.w500,
                        ),
                      ),
                    ),
                  ],
                ),
                SizedBox(height: size.height * 0.01),
                Row(
                  children: [
                    Visibility(
                      visible: widget.berbercutVisible &&
                          widget.scissorVisible &&
                          widget.haircutVisible,
                      child: SizedBox(
                        height: size.height * 0.07,
                        width: size.width * 0.05,
                      ),
                    ),
                    Visibility(
                      visible: !widget.berbercutVisible,
                      child: ServicePrice(
                        price: widget.berbercutPrice
                            .toStringAsFixed(2)
                            .replaceAll('.', ','),
                        service: 'Barba',
                        disabled: true,
                      ),
                    ),
                    Visibility(
                      visible: !widget.scissorVisible,
                      child: ServicePrice(
                        price: widget.scissorPrice
                            .toStringAsFixed(2)
                            .replaceAll('.', ','),
                        service: 'Tesoura',
                        disabled: true,
                      ),
                    ),
                    Visibility(
                      visible: !widget.haircutVisible,
                      child: ServicePrice(
                        price: widget.haircutPrice
                            .toStringAsFixed(2)
                            .replaceAll('.', ','),
                        service: 'Máquina',
                        disabled: true,
                      ),
                    ),
                  ],
                ),
              ],
            ),
          ),
          Container(
            height: size.height * 0.045,
            decoration: BoxDecoration(
              boxShadow: const [],
              borderRadius:
                  const BorderRadius.vertical(bottom: Radius.circular(18)),
              color: colorContainers353535,
            ),
            child: Padding(
              padding: const EdgeInsets.symmetric(horizontal: 10),
              child: Row(
                crossAxisAlignment: CrossAxisAlignment.center,
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Row(
                    children: [
                      Icon(
                        CupertinoIcons.location_solid,
                        color: Colors.white,
                        size: size.width * 0.05,
                      ),
                      const SizedBox(
                        width: 5,
                      ),
                      Text(
                        '${widget.distance} km',
                        style: TextStyle(
                            fontSize: size.width * 0.042, color: Colors.white),
                      ),
                    ],
                  ),
                  RatingBar.builder(
                    initialRating: widget.rating,
                    minRating: 1,
                    direction: Axis.horizontal,
                    allowHalfRating: true,
                    itemCount: 5,
                    itemSize: size.width * 0.04,
                    ignoreGestures: true,
                    unratedColor: const Color.fromARGB(80, 255, 255, 255),
                    itemBuilder: (context, _) => const Icon(
                      CupertinoIcons.star_fill,
                      color: Colors.white,
                    ),
                    onRatingUpdate: (rating) {},
                  )
                ],
              ),
            ),
          )
        ],
      ),
    );
  }
}
