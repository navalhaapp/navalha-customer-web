import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';

import 'package:navalha/core/colors.dart';
import 'package:navalha/shared/utils.dart';

class TextEditPattern extends HookConsumerWidget {
  final String label;
  final bool? obscure;
  final TextEditingController controller;
  final String? hint;
  final TextInputFormatter? mask;
  final TextInputType? keyboardType;
  final Widget? suffixIcon;
  final Color? color;
  final int? maxLength;
  final EdgeInsets? margin;
  final Function? onChange;
  final double? width;
  final int? maxLines;
  final EdgeInsetsGeometry? padding;
  final double? height;
  final double? sizeLabel;
  final double? sizeHint;

  const TextEditPattern({
    this.padding,
    required this.label,
    this.obscure,
    required this.controller,
    this.hint,
    this.mask,
    this.keyboardType,
    this.suffixIcon,
    this.color,
    this.maxLength,
    this.margin,
    this.onChange,
    this.width,
    this.maxLines,
    this.height,
    this.sizeLabel,
    this.sizeHint,
  });

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    return Container(
      margin: margin ??
          EdgeInsets.symmetric(
            horizontal: MediaQuery.of(context).size.width * 0.03,
            vertical: MediaQuery.of(context).size.height * 0.02,
          ),
      width: width ?? MediaQuery.of(context).size.width * 0.9,
      decoration: BoxDecoration(
        color: color ?? colorContainers242424,
        borderRadius: const BorderRadius.all(
          Radius.circular(15),
        ),
      ),
      child: Padding(
        padding: padding ??
            EdgeInsets.only(
              top: MediaQuery.of(context).size.height * 0.02,
              left: MediaQuery.of(context).size.width * 0.05,
              bottom: MediaQuery.of(context).size.height * 0.004,
            ),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          mainAxisSize: MainAxisSize.min,
          children: [
            Text(
              label,
              style: TextStyle(
                color: Colors.white,
                fontSize: sizeLabel ?? 17,
              ),
            ),
            InkWell(
              hoverColor: Colors.transparent,
              splashColor: Colors.transparent,
              highlightColor: Colors.transparent,
              splashFactory: NoSplash.splashFactory,
              child: SizedBox(
                height: height ?? 50,
                // width: MediaQuery.of(context).size.width * 0.8,
                child: TextFormField(
                  onChanged: (value) => {
                    if (onChange != null) {onChange!()}
                  },
                  maxLength: maxLength ?? 500,
                  buildCounter: (BuildContext context,
                          {int? currentLength,
                          int? maxLength,
                          bool? isFocused}) =>
                      null,
                  keyboardType: keyboardType,
                  cursorColor: Colors.white,
                  onTap: () {},
                  inputFormatters: UtilValidator.numberFormater(mask)
                      ? [FilteringTextInputFormatter.digitsOnly, mask!]
                      : null,
                  obscureText: obscure ?? false,
                  controller: controller,
                  maxLines: obscure == false ? maxLines : 1,
                  style: TextStyle(
                    fontSize: sizeHint ?? 12,
                    color: const Color.fromARGB(255, 255, 255, 255),
                    fontStyle: FontStyle.normal,
                  ),
                  decoration: InputDecoration(
                    suffixIcon: suffixIcon,
                    hintText: hint,
                    hintStyle: const TextStyle(
                      color: Color.fromARGB(255, 119, 119, 119),
                    ),
                    border: InputBorder.none,
                    focusedBorder: InputBorder.none,
                    enabledBorder: InputBorder.none,
                  ),
                ),
              ),
            )
          ],
        ),
      ),
    );
  }
}
