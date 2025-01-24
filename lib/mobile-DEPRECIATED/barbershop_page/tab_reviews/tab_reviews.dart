import 'package:flutter/material.dart';
import 'package:navalha/mobile-DEPRECIATED/barbershop_page/barbershop_page.dart';
import 'package:navalha/mobile-DEPRECIATED/barbershop_page/tab_reviews/widgets/review_item.dart';
import 'package:navalha/shared/model/barber_shop_model.dart';
import 'package:navalha/shared/model/review_model.dart';
import 'package:navalha/shared/widgets/page_transition.dart';
import 'package:navalha/shared/widgets/widget_empty.dart';
import '../../../../../core/images_s3.dart';

class TabReviews extends StatelessWidget {
  final BarberShop barberShop;
  const TabReviews({Key? key, required this.barberShop}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    Size size = MediaQuery.of(context).size;
    List<Review>? listReviews =
        getReviewsWithDescription(barberShop.barberShopReviews);

    return listReviews == null || listReviews.isEmpty
        ? WidgetEmpty(
            havebutton: false,
            title: 'Sem avaliações',
            subTitle: 'A barbearia não recebeu nenhuma avaliação.',
            text: 'Atualizar',
            topSpace: size.height * 0.01,
            onPressed: () {
              navigationFadePush(const BarbershopPage(), context);
            },
          )
        : Column(
            children: [
              for (int i = 0; i < listReviews.length; i++)
                ComentsItem(
                  reviewId: listReviews[i].reviewId!,
                  moreComments: listReviews[i].answer == null ? false : true,
                  answerBarberShop: listReviews[i].answer,
                  dateReview: listReviews[i].date!,
                  description: listReviews[i].description!,
                  imgBarberShop: barberShop.imgProfile!,
                  imgCustomer: listReviews[i].customer!.imgProfile ??
                      '$baseUrlS3bucket$imgDefaultProfessionalF',
                  nameBarberShop: barberShop.name!,
                  nameCustomer: listReviews[i].customer!.name!,
                  rating: listReviews[i].rating!,
                )
            ],
          );
  }
}

List<Review>? getReviewsWithDescription(List<Review>? reviews) {
  List<Review>? filteredReviews;

  if (reviews != null) {
    filteredReviews = [];

    for (Review review in reviews) {
      if (review.description != null && review.description!.isNotEmpty) {
        filteredReviews.add(review);
      }
    }
  }

  return filteredReviews;
}
