import 'package:flutter/material.dart';
import 'package:navalha/shared/widgets/header_button_sheet_pattern.dart';

import '../../payment/widgets/add_card_container.dart';

class ImagePickerBottonSheet extends StatelessWidget {
  const ImagePickerBottonSheet({
    Key? key,
    required this.onTapTakeGallery,
    required this.onTapTakePhoto,
  }) : super(key: key);

  final Function onTapTakeGallery;
  final Function onTapTakePhoto;

  @override
  Widget build(BuildContext context) {
    final size = MediaQuery.of(context).size;

    return SafeArea(
      top: false,
      child: Container(
        decoration: const BoxDecoration(
          color: Color.fromARGB(255, 36, 36, 36),
          borderRadius: BorderRadius.only(
            topLeft: Radius.circular(15),
            topRight: Radius.circular(15),
          ),
        ),
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            const HeaderBottonSheetPattern(),
            Padding(
              padding: EdgeInsets.symmetric(
                horizontal: size.width * 0.06,
              ),
              child: Column(
                mainAxisAlignment: MainAxisAlignment.start,
                children: [
                  Column(
                    mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                    children: [
                      InkWell(
                        child: AddCardContainer(
                          title: 'Tirar foto',
                          icon: Icons.add_a_photo,
                          ontap: () => onTapTakePhoto(),
                        ),
                      ),
                      SizedBox(height: size.height * 0.025),
                      InkWell(
                        child: AddCardContainer(
                          title: 'Escolher foto',
                          icon: Icons.add_photo_alternate_rounded,
                          ontap: () => onTapTakeGallery(),
                        ),
                      ),
                      SizedBox(height: size.height * 0.025),
                    ],
                  )
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}
