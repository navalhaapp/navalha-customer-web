import 'package:auto_size_text/auto_size_text.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_rating_bar/flutter_rating_bar.dart';

import '../../../../core/assets.dart';
import '../../../../core/colors.dart';

class ComentsItem extends StatelessWidget {
  const ComentsItem({
    Key? key,
    required this.moreComments,
    required this.imgCustomer,
    required this.imgBarberShop,
    required this.rating,
    required this.nameCustomer,
    required this.nameBarberShop,
    required this.dateReview,
    required this.description,
    required this.answerBarberShop,
    required this.reviewId,
  }) : super(key: key);

  final bool moreComments;
  final String imgCustomer;
  final String imgBarberShop;
  final double rating;
  final String nameCustomer;
  final String nameBarberShop;
  final String dateReview;
  final String description;
  final String? answerBarberShop;
  final String reviewId;

  @override
  Widget build(BuildContext context) {
    Size size = MediaQuery.of(context).size;
    return Container(
      margin: EdgeInsets.only(
        bottom: size.height * .015,
        left: size.width * .03,
        right: size.width * .03,
      ),
      padding: EdgeInsets.all(size.height * .02),
      decoration: BoxDecoration(
        color: colorContainers242424,
        borderRadius: BorderRadius.circular(18),
      ),
      child: Column(
        mainAxisAlignment: MainAxisAlignment.start,
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          _RowImageHeader(
            rating: rating,
            moreComments: false,
            img: imgCustomer,
            name: nameCustomer,
          ),
          Row(
            crossAxisAlignment: CrossAxisAlignment.start,
            mainAxisAlignment: MainAxisAlignment.start,
            children: [
              Padding(
                padding: EdgeInsets.only(
                  left: answerBarberShop != null ? size.width * 0.18 : 0,
                  top: answerBarberShop == null ? size.height * 0.01 : 0,
                  bottom: answerBarberShop == null ? size.height * 0.01 : 0,
                ),
                child: SizedBox(
                  width: moreComments ? size.width * 0.64 : size.width * 0.84,
                  child: Text(
                    style: TextStyle(
                      color: Colors.grey,
                      fontSize: size.height * .020,
                    ),
                    maxLines: 6,
                    description,
                  ),
                ),
              ),
            ],
          ),
          SizedBox(height: answerBarberShop != null ? 10 : 0),
          Visibility(
            visible: answerBarberShop != null,
            child: _RowImageHeader(
              rating: rating,
              moreComments: true,
              img: imgBarberShop,
              name: nameBarberShop,
            ),
          ),
          Visibility(
            visible: answerBarberShop != null,
            child: Padding(
              padding: EdgeInsets.only(
                top: size.height * 0.015,
              ),
              child: AutoSizeText(
                style:
                    TextStyle(color: Colors.grey, fontSize: size.height * .020),
                maxLines: 6,
                answerBarberShop ?? '',
              ),
            ),
          ),
        ],
      ),
    );
  }
}

class _RowImageHeader extends StatelessWidget {
  const _RowImageHeader({
    Key? key,
    required this.moreComments,
    required this.img,
    required this.name,
    required this.rating,
  }) : super(key: key);

  final bool moreComments;
  final String img;
  final String name;
  final double rating;

  @override
  Widget build(BuildContext context) {
    Size size = MediaQuery.of(context).size;
    return Row(
      children: [
        Container(
          margin: EdgeInsets.only(right: size.width * .035),
          padding: EdgeInsets.zero,
          width: MediaQuery.of(context).size.width * 0.15,
          height: MediaQuery.of(context).size.width * 0.15,
          child: ClipRRect(
            borderRadius: BorderRadius.circular(1000),
            child: FadeInImage.assetNetwork(
              placeholder: imgLoading3,
              image: img,
              fit: BoxFit.cover,
              fadeInDuration: const Duration(milliseconds: 500),
              fadeInCurve: Curves.easeIn,
            ),
          ),
        ),
        Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            SizedBox(
              width: size.width * 0.6,
              child: Text(
                name,
                overflow: TextOverflow.ellipsis,
                style: TextStyle(
                  color: Colors.white,
                  fontSize: size.height * .026,
                ),
              ),
            ),
            !moreComments
                ? RatingBar.builder(
                    initialRating: rating,
                    minRating: 1,
                    direction: Axis.horizontal,
                    allowHalfRating: true,
                    itemCount: 5,
                    itemSize: 14,
                    ignoreGestures: true,
                    unratedColor: const Color.fromARGB(80, 255, 255, 255),
                    itemBuilder: (context, _) => const Icon(
                      CupertinoIcons.star_fill,
                      color: Colors.white,
                    ),
                    onRatingUpdate: (rating) {},
                  )
                : const Text(
                    'Resposta da barbearia',
                    style: TextStyle(color: Colors.white, fontSize: 12),
                  ),
          ],
        )
      ],
    );
  }
}
