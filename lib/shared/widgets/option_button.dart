// Developer            Data              Descrição
// Vitor Daniel         22/08/2022        filter button creation.

import 'package:auto_size_text/auto_size_text.dart';
import 'package:flutter/material.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:navalha/core/colors.dart';

class OptionButton extends HookConsumerWidget {
  final String image;
  final String filterName;
  final Function ontap;
  final bool focusedOption;
  const OptionButton({
    required this.focusedOption,
    required this.ontap,
    Key? key,
    required this.image,
    required this.filterName,
  }) : super(key: key);
  @override
  Widget build(BuildContext context, WidgetRef ref) {
    Size size = MediaQuery.of(context).size;
    return Column(
      children: [
        GestureDetector(
          onTap: () {
            ontap();
          },
          child: Container(
            height: size.height * .04,
            margin: const EdgeInsets.only(bottom: 5),
            decoration: BoxDecoration(
                boxShadow: shadow,
                color: colorContainers242424,
                borderRadius: BorderRadius.circular(18)),
            width: size.width * .20,
            child: Center(
              child: AnimatedContainer(
                curve: Curves.linear,
                duration: const Duration(milliseconds: 130),
                height: focusedOption ? 80 : 80,
                child: Image.asset(
                  image,
                  color: focusedOption
                      ? const Color.fromARGB(255, 255, 255, 255)
                      : const Color.fromARGB(255, 125, 125, 125),
                  width:
                      focusedOption ? size.height * 0.06 : size.height * 0.05,
                  height:
                      focusedOption ? size.height * 0.06 : size.height * 0.05,
                ),
              ),
            ),
          ),
        ),
        Padding(
          padding: const EdgeInsets.only(bottom: 10),
          child: AutoSizeText(
            filterName,
            style: TextStyle(
              color: focusedOption ? Colors.white : colorFontUnable116116116,
              fontSize: focusedOption ? 14 : 12,
            ),
          ),
        ),
      ],
    );
  }
}
