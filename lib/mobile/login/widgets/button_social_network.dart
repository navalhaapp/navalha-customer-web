import 'package:flutter/material.dart';

class ButtonSocialNetwork extends StatelessWidget {
  const ButtonSocialNetwork({
    Key? key,
    required this.label,
    required this.img,
    required this.color,
    required this.textColor,
    required this.onTap,
  }) : super(key: key);

  final Widget label;
  final String img;
  final Color color;
  final Color textColor;
  final Function onTap;

  @override
  Widget build(BuildContext context) {
    Size size = MediaQuery.of(context).size;
    return GestureDetector(
      onTap: () => onTap(),
      child: Container(
        width: size.width * 0.92,
        margin: EdgeInsets.only(
          bottom: size.height * .015,
        ),
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(15),
          color: color,
        ),
        height: size.height * .06,
        child: Row(
          mainAxisAlignment: MainAxisAlignment.start,
          children: [
            SizedBox(width: size.width * 0.18),
            SizedBox(
              height: size.height * .022,
              child: Image.asset(img),
            ),
            SizedBox(
              width: size.width * .05,
            ),
            label
          ],
        ),
      ),
    );
  }
}
