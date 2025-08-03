import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_rating_bar/flutter_rating_bar.dart';
import 'package:navalha/core/cors_helper.dart';

import 'package:navalha/shared/model/service_model.dart';

import '../../../../../../core/assets.dart';
import '../../../../../../core/colors.dart';

class ProfessionalItem extends StatelessWidget {
  final String name;
  final String img;
  final String? imgService;
  final double rating;
  final double? servicePrice;
  final int? serviceTime;
  final bool hidePriceAndTime;
  final List<Service>? listImgServices;
  final bool? havePrice;

  const ProfessionalItem({
    Key? key,
    required this.name,
    required this.img,
    this.imgService,
    required this.rating,
    this.servicePrice,
    this.serviceTime,
    required this.hidePriceAndTime,
    this.listImgServices,
    this.havePrice,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    Size size = MediaQuery.of(context).size;
    return Container(
      margin: EdgeInsets.only(
        bottom: size.height * .015,
        left: size.width * .03,
        right: size.width * .03,
      ),
      decoration: BoxDecoration(
        borderRadius: const BorderRadius.all(Radius.circular(18)),
        color: colorContainers242424,
      ),
      child: Padding(
        padding: const EdgeInsets.all(8.0),
        child: Row(
          children: [
            Container(
              margin: const EdgeInsets.symmetric(horizontal: 10),
              width: MediaQuery.of(context).size.width * 0.15,
              height: MediaQuery.of(context).size.width * 0.15,
              child: ClipOval(
                child: FadeInImage.assetNetwork(
                  placeholder: imgLoading3,
                  image: img,
                  fit: BoxFit.cover,
                ),
              ),
            ),
            Column(
              mainAxisAlignment: MainAxisAlignment.center,
              crossAxisAlignment: hidePriceAndTime
                  ? CrossAxisAlignment.start
                  : CrossAxisAlignment.end,
              children: [
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  crossAxisAlignment: CrossAxisAlignment.center,
                  children: [
                    SizedBox(
                      width: size.width * 0.5,
                      child: Text(
                        textAlign: TextAlign.start,
                        name,
                        overflow: TextOverflow.ellipsis,
                        maxLines: 1,
                        style: TextStyle(
                          color: Colors.white,
                          fontSize: size.height * .025,
                        ),
                      ),
                    ),
                    RatingBar.builder(
                      initialRating: rating,
                      minRating: 1,
                      direction: Axis.horizontal,
                      allowHalfRating: true,
                      itemCount: 5,
                      itemSize: size.width * 0.032,
                      ignoreGestures: true,
                      unratedColor: const Color.fromARGB(80, 255, 255, 255),
                      itemBuilder: (context, _) => const Icon(
                        CupertinoIcons.star_fill,
                        color: Colors.white,
                      ),
                      onRatingUpdate: (rating) {},
                    ),
                  ],
                ),
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    hidePriceAndTime
                        ? Row(
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            children: [
                              Row(
                                children: [
                                  const Icon(
                                    CupertinoIcons.clock_fill,
                                    color: Colors.white,
                                    size: 14,
                                  ),
                                  Text(
                                    ' ${serviceTime}min',
                                    style: const TextStyle(
                                      color: Colors.white,
                                      fontSize: 16,
                                    ),
                                  ),
                                  const SizedBox(width: 10),
                                  havePrice == null
                                      ? Text(
                                          'R\$ ${servicePrice?.toStringAsFixed(2).replaceAll('.', ',')}',
                                          style: const TextStyle(
                                            color: Colors.white,
                                            fontSize: 16,
                                          ),
                                        )
                                      : const SizedBox()
                                ],
                              ),
                            ],
                          )
                        : const SizedBox(),
                    SizedBox(width: havePrice == null ? 0 : size.width * 0.2),
                    hidePriceAndTime
                        ? Container(
                            margin: EdgeInsets.only(
                                left:
                                    !hidePriceAndTime ? 0 : size.width * 0.22),
                            width: MediaQuery.of(context).size.width * 0.07,
                            height: MediaQuery.of(context).size.width * 0.07,
                            child: ClipOval(
                              child: FadeInImage.assetNetwork(
                                placeholder: imgLoading3,
                                image:
                                    imgService!,
                                fit: BoxFit.fill,
                              ),
                            ),
                          )
                        : Row(
                            children: [
                              for (int i = 0; i < listImgServices!.length; i++)
                                Container(
                                  margin: const EdgeInsets.only(
                                      left: 4, top: 5, bottom: 5),
                                  width:
                                      MediaQuery.of(context).size.width * 0.07,
                                  height:
                                      MediaQuery.of(context).size.width * 0.07,
                                  child: ClipOval(
                                    child: FadeInImage.assetNetwork(
                                      placeholder: imgLoading3,
                                      image: listImgServices![i].imgProfile!,
                                      fit: BoxFit.fill,
                                    ),
                                  ),
                                ),
                            ],
                          )
                  ],
                )
              ],
            ),
          ],
        ),
      ),
    );
  }
}
