import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:navalha/shared/utils.dart';

class TextEditPatternWeb extends HookConsumerWidget {
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
  final List<TextInputFormatter>? inputFormatters;

  const TextEditPatternWeb({
    super.key,
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
    this.inputFormatters,
  });

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    return Container(
      margin: margin ??
          const EdgeInsets.symmetric(
            horizontal: 20,
          ),
      decoration: BoxDecoration(
        color: color ?? const Color.fromARGB(255, 30, 30, 30),
        borderRadius: const BorderRadius.all(
          Radius.circular(15),
        ),
      ),
      child: Padding(
        padding: const EdgeInsets.only(top: 20, left: 20, right: 20),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          mainAxisSize: MainAxisSize.min,
          children: [
            Text(
              label,
              style: const TextStyle(
                color: Colors.white,
              ),
            ),
            InkWell(
              hoverColor: Colors.transparent,
              splashColor: Colors.transparent,
              highlightColor: Colors.transparent,
              splashFactory: NoSplash.splashFactory,
              child: SizedBox(
                height: MediaQuery.of(context).size.height * 0.06,
                width: MediaQuery.of(context).size.width * 0.8,
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
                  inputFormatters: inputFormatters == null
                      ? UtilValidator.numberFormater(mask)
                          ? [FilteringTextInputFormatter.digitsOnly, mask!]
                          : null
                      : inputFormatters,
                  obscureText: obscure ?? false,
                  controller: controller,
                  style: const TextStyle(
                    color: Color.fromARGB(255, 255, 255, 255),
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
