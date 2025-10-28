import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_rating_bar/flutter_rating_bar.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:navalha/core/cors_helper.dart';
import 'package:navalha/shared/model/barber_shop_model.dart';
import 'package:navalha/shared/model/professional_model.dart';
import 'package:navalha/shared/model/service_model.dart';
import '../../../../../../core/assets.dart';
import '../../../mobile-DEPRECIATED/home/model/response_get_barber_shop_by_id.dart';

class ProfessionalItemWeb extends StatefulWidget {
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
  State<ProfessionalItemWeb> createState() => _ProfessionalItemWebState();
}

class _ProfessionalItemWebState extends State<ProfessionalItemWeb> {
  Color _containerColor = const Color.fromARGB(255, 28, 28, 28);
  @override
  Widget build(BuildContext context) {
    return Consumer(
      builder: (context, ref, child) {
        var listImgServicess = widget.listImgServices!.take(5);
        return MouseRegion(
          onEnter: (_) {
            setState(
                () => _containerColor = const Color.fromARGB(255, 40, 40, 40));
          },
          onExit: (_) {
            setState(
                () => _containerColor = const Color.fromARGB(255, 28, 28, 28));
          },
          child: Container(
            margin: const EdgeInsets.only(
              bottom: 15,
              left: 30,
              right: 30,
            ),
            decoration: BoxDecoration(
              borderRadius: const BorderRadius.all(Radius.circular(18)),
              color: _containerColor,
              border:
                  Border.all(color: Colors.white.withOpacity(0.06), width: 1),
              boxShadow: [
                BoxShadow(
                  color: Colors.black.withOpacity(0.20),
                  blurRadius: 10,
                  offset: const Offset(0, 6),
                ),
              ],
            ),
            child: Padding(
              padding: const EdgeInsets.all(8),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.start,
                children: [
                  Container(
                    margin: const EdgeInsets.only(left: 10, right: 5, top: 10),
                    width: 50,
                    height: 50,
                    child: ClipOval(
                      child: FadeInImage.assetNetwork(
                        placeholder: imgLoading3,
                        image: widget.img,
                        // image: CORSHelper.getProxiedImageUrl(widget.img),
                        fit: BoxFit.cover,
                      ),
                    ),
                  ),
                  Expanded(
                    child: Column(
                      children: [
                        Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            Expanded(
                              child: Text(
                                widget.name,
                                overflow: TextOverflow.ellipsis,
                                maxLines: 1,
                                style: const TextStyle(
                                  color: Colors.white,
                                ),
                              ),
                            ),
                            Padding(
                              padding: const EdgeInsets.only(
                                right: 5,
                                top: 5,
                                bottom: 5,
                              ),
                              child: RatingBar.builder(
                                initialRating: widget.rating,
                                minRating: 1,
                                direction: Axis.horizontal,
                                allowHalfRating: true,
                                itemCount: 5,
                                itemSize: 15,
                                ignoreGestures: true,
                                unratedColor:
                                    const Color.fromARGB(80, 255, 255, 255),
                                itemBuilder: (context, _) => const Icon(
                                  CupertinoIcons.star_fill,
                                  color: Colors.white,
                                ),
                                onRatingUpdate: (rating) {},
                              ),
                            ),
                          ],
                        ),
                        Row(
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
                                  ' ${widget.serviceTime}min',
                                  style: const TextStyle(
                                    color: Colors.white,
                                  ),
                                ),
                              ],
                            ),
                            Row(
                              children: [
                                for (int i = 0;
                                    i < listImgServicess.length;
                                    i++)
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
                                        image: 
                                            widget.listImgServices![i]
                                                .imgProfile!,
                                        // image: CORSHelper.getProxiedImageUrl(
                                        //     widget.listImgServices![i]
                                        //         .imgProfile!),
                                        fit: BoxFit.fill,
                                      ),
                                    ),
                                  ),
                              ],
                            )
                          ],
                        ),
                      ],
                    ),
                  ),
                ],
              ),
            ),
          ),
        );
      },
    );
  }
}

//  Row(
//                 mainAxisAlignment: MainAxisAlignment.start,
//                 children: [
//                   Text('data'),
//                   Expanded(
//                     child: Column(
//                       children: [
//                         Row(
//                           mainAxisAlignment: MainAxisAlignment.spaceBetween,
//                           children: [
//                             Text('data'),
//                             Text('data'),
//                           ],
//                         ),
//                         Row(
//                           mainAxisAlignment: MainAxisAlignment.spaceBetween,
//                           children: [
//                             Text('data'),
//                             Text('data'),
//                           ],
//                         )
//                       ],
//                     ),
//                   )
//                 ],
//               )
