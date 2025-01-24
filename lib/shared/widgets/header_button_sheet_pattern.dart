import 'package:flutter/material.dart';

class HeaderBottonSheetPattern extends StatelessWidget {
  final Widget? widget;
  final Function? onClose;
  final double? width;
  const HeaderBottonSheetPattern({
    Key? key,
    this.widget,
    this.onClose,
    this.width,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final size = MediaQuery.of(context).size;

    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: [
        IconButton(
          padding: EdgeInsets.zero,
          onPressed: onClose == null ? () {} : onClose!(),
          icon: const Icon(
            Icons.close,
            color: Colors.transparent,
          ),
        ),
        widget ??
            Container(
              margin: const EdgeInsets.only(bottom: 10),
              width: width ?? size.width * 0.10,
              height: 5,
              decoration: BoxDecoration(
                color: Colors.white,
                borderRadius: BorderRadius.circular(25),
              ),
            ),
        IconButton(
          padding: const EdgeInsets.only(right: 10),
          onPressed: () => Navigator.pop(context),
          splashColor: Colors.transparent,
          highlightColor: Colors.transparent,
          icon: const Icon(
            Icons.close,
            color: Colors.white,
          ),
        )
      ],
    );
  }
}
