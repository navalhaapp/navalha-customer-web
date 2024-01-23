import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:navalha/core/colors.dart';
import 'package:navalha/shared/types.dart';
import 'package:navalha/shared/utils.dart';

class ContainerFormField extends HookConsumerWidget {
  final bool? obscure;
  final TextEditingController controller;
  final String? hint;
  final TextInputFormatter? mask;
  final TextInputType? keyboardType;
  final EditType type;

  final Function? onSubmit;

  const ContainerFormField({
    super.key,
    required this.type,
    this.obscure,
    required this.controller,
    this.onSubmit,
    this.hint,
    this.mask,
    this.keyboardType,
  });
  @override
  Widget build(BuildContext context, WidgetRef ref) {
    return GestureDetector(
      onTap: () {},
      child: Container(
        margin: EdgeInsets.symmetric(
          horizontal: MediaQuery.of(context).size.width * 0.07,
          vertical: MediaQuery.of(context).size.height * 0.01,
        ),
        decoration: BoxDecoration(
          boxShadow: shadow,
          color: colorContainers242424,
          borderRadius: const BorderRadius.all(
            Radius.circular(10),
          ),
        ),
        child: Padding(
          padding: EdgeInsets.only(
            left: MediaQuery.of(context).size.width * 0.05,
          ),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            mainAxisSize: MainAxisSize.min,
            children: [
              InkWell(
                hoverColor: Colors.transparent,
                splashColor: Colors.transparent,
                highlightColor: Colors.transparent,
                splashFactory: NoSplash.splashFactory,
                child: SizedBox(
                  height: MediaQuery.of(context).size.height * 0.06,
                  width: MediaQuery.of(context).size.width * 0.8,
                  child: TextFormField(
                    keyboardType: keyboardType,
                    onTap: () {},
                    inputFormatters: UtilValidator.numberFormater(mask)
                        ? [FilteringTextInputFormatter.digitsOnly, mask!]
                        : null,
                    obscureText: obscure ?? false,
                    controller: controller,
                    style: TextStyle(
                      fontSize: MediaQuery.of(context).size.width * 0.045,
                      color: const Color.fromARGB(255, 255, 255, 255),
                    ),
                    decoration: InputDecoration(
                      hintText: hint,
                      hintStyle: const TextStyle(
                        color: Color.fromARGB(255, 119, 119, 119),
                      ),
                      border: InputBorder.none,
                    ),
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
