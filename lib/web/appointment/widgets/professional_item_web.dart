import 'package:auto_size_text/auto_size_text.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_rating_bar/flutter_rating_bar.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:navalha/shared/model/barber_shop_model.dart';
import 'package:navalha/shared/model/professional_model.dart';
import 'package:navalha/shared/model/service_model.dart';
import '../../../../../../core/assets.dart';
import '../../../mobile/home/model/response_get_barber_shop_by_id.dart';

class ProfessionalItemWeb extends StatelessWidget {
  final String name;
  final String img;
  final String? imgService;
  final double rating;
  final double? servicePrice;
  final int? serviceTime;
  final bool hidePriceAndTime;
  final List<Service>? listImgServices;
  final bool? havePrice;
  final Function onConfirm;
  final List<Professional> listProfessionals;
  final String serviceName;
  final String serviceImg;
  final String professionalId;
  final BarberShop barberShop;
  final CustomerPackages? packageList;
  final List<Service>? listProfessionalServices;
  final int i;

  const ProfessionalItemWeb({
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
    required this.onConfirm,
    required this.listProfessionals,
    required this.serviceName,
    required this.serviceImg,
    required this.professionalId,
    required this.barberShop,
    this.packageList,
    this.listProfessionalServices,
    required this.i,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Consumer(
      builder: (context, ref, child) {
        return Container(
          margin: const EdgeInsets.only(
            bottom: 15,
            left: 30,
            right: 30,
          ),
          decoration: const BoxDecoration(
            borderRadius: BorderRadius.all(Radius.circular(18)),
            color: Color.fromARGB(255, 28, 28, 28),
          ),
          child: Padding(
            padding: const EdgeInsets.all(8.0),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Row(
                  children: [
                    Container(
                      margin:
                          const EdgeInsets.only(left: 10, right: 10, top: 10),
                      width: 50,
                      height: 50,
                      child: ClipOval(
                        child: FadeInImage.assetNetwork(
                          placeholder: imgLoading3,
                          image: img,
                          fit: BoxFit.cover,
                        ),
                      ),
                    ),
                    Column(
                      mainAxisAlignment: MainAxisAlignment.start,
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        SizedBox(
                          width: MediaQuery.sizeOf(context).height > 700
                              ? 140
                              : 50,
                          child: AutoSizeText(
                            textAlign: TextAlign.start,
                            name,
                            overflow: TextOverflow.ellipsis,
                            maxLines: 1,
                            style: const TextStyle(
                              color: Colors.white,
                            ),
                          ),
                        ),
                        const SizedBox(height: 5),
                        hidePriceAndTime
                            ? Row(
                                mainAxisAlignment:
                                    MainAxisAlignment.spaceBetween,
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
                                        ),
                                      ),
                                      const SizedBox(width: 10),
                                      havePrice == null
                                          ? Text(
                                              'R\$ ${servicePrice?.toStringAsFixed(2).replaceAll('.', ',')}',
                                              style: const TextStyle(
                                                color: Colors.white,
                                              ),
                                            )
                                          : const SizedBox()
                                    ],
                                  ),
                                ],
                              )
                            : const SizedBox(),
                      ],
                    ),
                  ],
                ),
                Column(
                  crossAxisAlignment: CrossAxisAlignment.end,
                  children: [
                    Padding(
                      padding: const EdgeInsets.only(
                        right: 5,
                        top: 5,
                        bottom: 5,
                      ),
                      child: RatingBar.builder(
                        initialRating: rating,
                        minRating: 1,
                        direction: Axis.horizontal,
                        allowHalfRating: true,
                        itemCount: 5,
                        itemSize: 15,
                        ignoreGestures: true,
                        unratedColor: const Color.fromARGB(80, 255, 255, 255),
                        itemBuilder: (context, _) => const Icon(
                          CupertinoIcons.star_fill,
                          color: Colors.white,
                        ),
                        onRatingUpdate: (rating) {},
                      ),
                    ),
                    const SizedBox(height: 5),
                    Visibility(
                      visible: MediaQuery.sizeOf(context).width > 474 &&
                          listImgServices!.length > 5,
                      child: Row(
                        children: [
                          for (int i = 0; i < listImgServices!.length; i++)
                            Container(
                              margin: const EdgeInsets.only(
                                right: 5,
                                top: 5,
                                bottom: 5,
                              ),
                              width: 20,
                              height: 20,
                              child: ClipOval(
                                child: FadeInImage.assetNetwork(
                                  placeholder: imgLoading3,
                                  image: listImgServices![i].imgProfile!,
                                  fit: BoxFit.fill,
                                ),
                              ),
                            ),
                        ],
                      ),
                    )
                  ],
                ),
              ],
            ),
          ),
        );
      },
    );
  }
}
