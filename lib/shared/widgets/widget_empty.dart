import 'package:flutter/material.dart';

import 'package:navalha/core/assets.dart';

import '../../core/colors.dart';

class WidgetEmpty extends StatelessWidget {
  final String title;
  final String subTitle;
  final String text;
  final Function onPressed;
  final double? topSpace;
  final double? spaceBetween;
  final double? titleSize;
  final bool? havebutton;
  final bool? haveIcon;
  final Color? color;

  const WidgetEmpty({
    Key? key,
    required this.title,
    required this.subTitle,
    required this.text,
    required this.onPressed,
    this.topSpace,
    this.spaceBetween,
    this.titleSize,
    this.havebutton,
    this.haveIcon,
    this.color,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    Size size = MediaQuery.of(context).size;
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 10),
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          SizedBox(height: topSpace ?? size.height * 0.1),
          haveIcon == null
              ? Image(
                  image: AssetImage(iconEmpyYellow),
                  height: size.height * .15,
                )
              : const SizedBox(),
          SizedBox(height: spaceBetween ?? size.height * 0.0),
          Text(
            textAlign: TextAlign.center,
            title,
            style: TextStyle(
              color: Colors.white,
              fontWeight: FontWeight.bold,
              fontSize: titleSize ?? 25,
            ),
          ),
          Text(
            textAlign: TextAlign.center,
            subTitle,
            style: const TextStyle(
              color: Color.fromARGB(255, 209, 209, 209),
              fontWeight: FontWeight.w500,
              fontSize: 15,
            ),
          ),
          havebutton == null
              ? Padding(
                  padding: EdgeInsets.symmetric(vertical: size.height * .03),
                  child: MaterialButton(
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(25),
                    ),
                    elevation: 0,
                    minWidth: size.width * 0.8,
                    height: size.height * 0.05,
                    color: color ?? colorContainers242424,
                    onPressed: () => onPressed(),
                    child: Text(
                      text,
                      style: TextStyle(
                        color: colorWhite255255255,
                        fontSize: 16,
                      ),
                    ),
                  ),
                )
              : const SizedBox()
        ],
      ),
    );
  }
}
