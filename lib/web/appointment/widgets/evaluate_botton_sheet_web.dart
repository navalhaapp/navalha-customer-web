// ignore_for_file: use_build_context_synchronously

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_rating_bar/flutter_rating_bar.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:navalha/mobile-DEPRECIATED/calendar/model/model_create_review.dart';
import 'package:navalha/mobile-DEPRECIATED/calendar/provider/provider_create_review.dart';
import 'package:navalha/shared/utils.dart';
import 'package:navalha/shared/widgets/header_button_sheet_pattern.dart';
import 'package:navalha/web/db/db_customer_shared.dart';
import 'package:navalha/web/utils/utils.dart';
import '../../../core/assets.dart';
import '../../../core/colors.dart';
import '../../../shared/shows_dialogs/evaluate__barber/widgets/comment_barber_bottom_sheet.dart';
import '../../../shared/widgets/button_pattern_botton_sheet.dart';
import '../../../shared/widgets/network_image_fallback.dart';

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
  double rating = 5;
  final TextEditingController _controller = TextEditingController();

  @override
  void initState() {
    _controller.text = '5';
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    final size = MediaQuery.of(context).size;

    return Consumer(
      builder: (context, ref, child) {
        final retrievedCustomer = LocalStorageManager.getCustomer();
        final createReview =
            ref.watch(CreateReviewStateController.provider.notifier);
        return Padding(
          padding: NavalhaUtils().calculateDialogPadding(context),
          child: Container(
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
                  width: 50,
                  height: 50,
                  child: ClipRRect(
                    borderRadius: BorderRadius.circular(1000),
                    child: NetworkImageFallback(
                      url: widget.imgProfessional,
                      placeholderAsset: imgLoading3,
                      errorAsset: iconLogoApp,
                      fit: BoxFit.cover,
                    ),
                  ),
                ),
                const SizedBox(height: 20),
                const Text(
                  textAlign: TextAlign.center,
                  'Avalie o atendimento',
                  style: TextStyle(color: Colors.white, fontSize: 20),
                ),
                const SizedBox(height: 5),
                Text(
                  textAlign: TextAlign.center,
                  'Dia ${widget.day}, ${widget.serviceName} em ${widget.barberShopName}',
                  style:
                      TextStyle(color: colorFontUnable116116116, fontSize: 15),
                ),
                const SizedBox(height: 20),
                StarRating(
                  rating: rating,
                  onRatingChanged: (newRating) {
                    setState(() {
                      rating = newRating;
                    });
                  },
                ),
                const SizedBox(height: 20),
                ElevatedButton(
                  style: ButtonStyle(
                    overlayColor: MaterialStateProperty.all<Color>(
                      colorContainers353535,
                    ),
                    backgroundColor:
                        MaterialStateProperty.all<Color>(Colors.transparent),
                    elevation: MaterialStateProperty.all(0),
                    shape: MaterialStateProperty.all<RoundedRectangleBorder>(
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
                          style: TextStyle(color: Colors.white, fontSize: 15),
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
                const SizedBox(height: 20),
                Padding(
                  padding:
                      const EdgeInsets.only(bottom: 10, left: 10, right: 10),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceAround,
                    children: [
                      Expanded(
                        child: ElevatedButton(
                          style: ButtonStyle(
                            overlayColor: MaterialStateProperty.all<Color>(
                              colorContainers353535,
                            ),
                            elevation: MaterialStateProperty.all(0),
                            backgroundColor: MaterialStateProperty.all<Color>(
                              colorContainers242424,
                            ),
                            shape: MaterialStateProperty.all<
                                RoundedRectangleBorder>(
                              RoundedRectangleBorder(
                                borderRadius: BorderRadius.circular(14),
                              ),
                            ),
                          ),
                          child: const Text(
                            'Enviar',
                            style: TextStyle(
                                fontSize: 15,
                                color: Colors.white,
                                fontWeight: FontWeight.bold),
                          ),
                          onPressed: () async {
                            ResponseCreateReview response =
                                await createReview.createReview(
                              retrievedCustomer!.token,
                              description,
                              double.parse(_controller.text),
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
                      ),
                    ],
                  ),
                ),
              ],
            ),
          ),
        );
      },
    );
  }
}


class StarRating extends StatefulWidget {
  final double rating;
  final void Function(double) onRatingChanged;
  final double iconSize;
  final Color activeColor;
  final Color inactiveColor;

  const StarRating({
    Key? key,
    required this.rating,
    required this.onRatingChanged,
    this.iconSize = 40,
    this.activeColor = Colors.white,
    this.inactiveColor = Colors.grey,
  }) : super(key: key);

  @override
  State<StarRating> createState() => _StarRatingState();
}

class _StarRatingState extends State<StarRating> {
  late double _currentRating;

  @override
  void initState() {
    _currentRating = widget.rating;
    super.initState();
  }

  void _updateRating(double newRating) {
    setState(() {
      _currentRating = newRating;
    });
    widget.onRatingChanged(_currentRating);
  }

  void _handleTap(double tappedPosition) {
    final newRating = (tappedPosition / widget.iconSize).clamp(0, 5);
    _updateRating(newRating.ceilToDouble());
  }

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onHorizontalDragUpdate: (details) {
        final box = context.findRenderObject() as RenderBox;
        final localPosition = box.globalToLocal(details.globalPosition);
        _handleTap(localPosition.dx);
      },
      onTapDown: (details) {
        final box = context.findRenderObject() as RenderBox;
        final localPosition = box.globalToLocal(details.globalPosition);
        _handleTap(localPosition.dx);
      },
      child: Row(
        mainAxisSize: MainAxisSize.min,
        children: List.generate(5, (index) {
          return Icon(
            index < _currentRating ? Icons.star : Icons.star_border,
            size: widget.iconSize,
            color: index < _currentRating
                ? widget.activeColor
                : widget.inactiveColor,
          );
        }),
      ),
    );
  }
}
