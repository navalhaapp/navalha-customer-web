// ignore_for_file: use_build_context_synchronously

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_rating_bar/flutter_rating_bar.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:navalha/mobile-DEPRECIATED/calendar/model/model_create_review.dart';
import 'package:navalha/mobile-DEPRECIATED/calendar/provider/provider_create_review.dart';
import 'package:navalha/shared/utils.dart';
import 'package:navalha/shared/widgets/header_button_sheet_pattern.dart';
import 'package:navalha/web/db/db_customer_shared.dart';
import '../../../core/assets.dart';
import '../../../core/colors.dart';
import '../../../shared/shows_dialogs/evaluate__barber/widgets/comment_barber_bottom_sheet.dart';
import '../../../shared/widgets/button_pattern_botton_sheet.dart';

class EvaluateBottonSheetWeb extends StatefulWidget {
  const EvaluateBottonSheetWeb({
    Key? key,
    required this.imgProfessional,
    required this.day,
    required this.serviceName,
    required this.barberShopName,
    required this.serviceId,
    required this.customerId,
  }) : super(key: key);

  final String imgProfessional;
  final String day;
  final String serviceName;
  final String barberShopName;
  final String serviceId;
  final String customerId;

  @override
  State<EvaluateBottonSheetWeb> createState() =>
      _SelectServiceBottonSheetState();
}

class _SelectServiceBottonSheetState extends State<EvaluateBottonSheetWeb> {
  String? description;
  double ratingSelected = 5;

  @override
  Widget build(BuildContext context) {
    final size = MediaQuery.of(context).size;

    return SafeArea(
      minimum: EdgeInsets.only(top: size.height * 0.04),
      child: Scaffold(
        bottomSheet: GestureDetector(
          onTap: () {},
          child: Consumer(
            builder: (context, ref, child) {
              final retrievedCustomer = LocalStorageManager.getCustomer();
              final createReview =
                  ref.watch(CreateReviewStateController.provider.notifier);
              return Container(
                decoration: BoxDecoration(
                  color: colorBackground181818,
                  borderRadius: const BorderRadius.only(
                    topLeft: Radius.circular(15),
                    topRight: Radius.circular(15),
                  ),
                ),
                child: Column(
                  mainAxisSize: MainAxisSize.min,
                  children: [
                    const HeaderBottonSheetPattern(),
                    Container(
                      decoration: BoxDecoration(
                        boxShadow: shadow,
                        shape: BoxShape.circle,
                      ),
                      padding: EdgeInsets.zero,
                      width: MediaQuery.of(context).size.height * 0.15,
                      height: MediaQuery.of(context).size.height * 0.15,
                      child: ClipRRect(
                        borderRadius: BorderRadius.circular(1000),
                        child: FadeInImage.assetNetwork(
                          placeholder: imgLoading3,
                          image: widget.imgProfessional,
                          fit: BoxFit.cover,
                          fadeInDuration: const Duration(milliseconds: 500),
                          fadeInCurve: Curves.easeIn,
                        ),
                      ),
                    ),
                    SizedBox(height: MediaQuery.of(context).size.width * 0.04),
                    const Text(
                      textAlign: TextAlign.center,
                      'Avalie o atendimento',
                      style: TextStyle(color: Colors.white, fontSize: 20),
                    ),
                    SizedBox(height: MediaQuery.of(context).size.width * 0.04),
                    Text(
                      textAlign: TextAlign.center,
                      'Dia ${widget.day}, ${widget.serviceName} em ${widget.barberShopName}',
                      style: TextStyle(
                          color: colorFontUnable116116116, fontSize: 15),
                    ),
                    SizedBox(height: MediaQuery.of(context).size.width * 0.02),
                    RatingBar.builder(
                      initialRating: 5,
                      minRating: 1,
                      direction: Axis.horizontal,
                      allowHalfRating: true,
                      itemCount: 5,
                      itemSize: 50,
                      itemPadding: const EdgeInsets.symmetric(horizontal: 5),
                      unratedColor: const Color.fromARGB(80, 255, 255, 255),
                      itemBuilder: (context, _) => const Icon(
                        CupertinoIcons.star_fill,
                        color: Colors.white,
                      ),
                      onRatingUpdate: (rating) {
                        ratingSelected = rating;
                      },
                    ),
                    ElevatedButton(
                      style: ButtonStyle(
                        overlayColor: MaterialStateProperty.all<Color>(
                          colorContainers353535,
                        ),
                        backgroundColor: MaterialStateProperty.all<Color>(
                            Colors.transparent),
                        elevation: MaterialStateProperty.all(0),
                        shape:
                            MaterialStateProperty.all<RoundedRectangleBorder>(
                          RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(18),
                          ),
                        ),
                      ),
                      child: const Padding(
                        padding: EdgeInsets.symmetric(horizontal: 10),
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: [
                            Icon(
                              CupertinoIcons.pencil_ellipsis_rectangle,
                              color: Colors.white,
                            ),
                            SizedBox(width: 10),
                            Text(
                              'Fazer um elogio',
                              style:
                                  TextStyle(color: Colors.white, fontSize: 15),
                            ),
                          ],
                        ),
                      ),
                      onPressed: () {
                        showModalBottomSheet<void>(
                          backgroundColor: Colors.black,
                          isScrollControlled: true,
                          shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(18),
                          ),
                          context: context,
                          builder: (BuildContext context) {
                            return CommentBarberBottomSheet(
                              description: (desc) {
                                setState(() {
                                  description = desc;
                                });
                              },
                            );
                          },
                        );
                      },
                    ),
                    SizedBox(height: MediaQuery.of(context).size.width * 0.06),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceAround,
                      children: [
                        ButtonPattern(
                          child: Text(
                            'Cancelar',
                            style: TextStyle(
                              fontSize: 15,
                              color: colorRed1765959,
                            ),
                          ),
                          onPressed: () {
                            Navigator.pop(context);
                          },
                        ),
                        ButtonPattern(
                          child: const Text(
                            'Enviar',
                            style: TextStyle(
                              fontSize: 15,
                              color: Colors.white,
                            ),
                          ),
                          onPressed: () async {
                            ResponseCreateReview response =
                                await createReview.createReview(
                              retrievedCustomer!.token,
                              description,
                              ratingSelected,
                              widget.serviceId,
                              widget.customerId,
                            );
                            if (response.status == 'success') {
                              Navigator.pop(context);
                              showSnackBar(context, 'Obrigado pela avaliação');
                              Navigator.of(context).pushNamed('/calendar');
                            } else {
                              Navigator.pop(context);
                              showSnackBar(context, 'Ops, algo aconteceu');
                            }
                          },
                        ),
                      ],
                    ),
                  ],
                ),
              );
            },
          ),
        ),
      ),
    );
  }
}
