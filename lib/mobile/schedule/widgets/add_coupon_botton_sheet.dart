// ignore_for_file: use_build_context_synchronously

import 'package:flutter/material.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';

import 'package:navalha/mobile/schedule/model/response_get_promotional_code.dart';
import 'package:navalha/mobile/schedule/provider/provider_get_promotional_code.dart';
import 'package:navalha/mobile/schedule/schedule_page.dart';
import 'package:navalha/shared/utils.dart';
import 'package:navalha/shared/widgets/page_transition.dart';

import '../../../core/colors.dart';
import '../../login/controller/login_controller.dart';
import '../../../shared/model/barber_shop_model.dart';
import '../../../shared/providers.dart';
import '../../../shared/widgets/button_pattern_botton_sheet.dart';
import '../../../shared/widgets/header_button_sheet_pattern.dart';

class AddCouponHourBottonSheet extends StatefulWidget {
  const AddCouponHourBottonSheet({
    Key? key,
    required this.onConfirm,
    required this.barberShop,
  }) : super(key: key);
  final Function onConfirm;
  final BarberShop barberShop;

  @override
  State<AddCouponHourBottonSheet> createState() =>
      _AddCouponHourBottonSheetState();
}

class _AddCouponHourBottonSheetState extends State<AddCouponHourBottonSheet> {
  TextEditingController codeController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    final size = MediaQuery.of(context).size;

    return SafeArea(
      minimum: EdgeInsets.only(top: size.height * 0.04),
      child: Scaffold(
        bottomSheet: GestureDetector(
          onTap: (() {}),
          child: Consumer(
            builder: (context, ref, child) {
              final authLoginController =
                  ref.watch(LoginStateController.provider.notifier);
              final promotionalCodeController = ref
                  .watch(GetPromotionalCodeStateController.provider.notifier);
              var totalPriceProvider =
                  ref.watch(totalPriceServiceProvider.state);
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
                    Padding(
                      padding: EdgeInsets.symmetric(
                        horizontal: size.width * 0.03,
                        vertical: size.height * 0.02,
                      ),
                      child: TextFormField(
                        maxLength: 50,
                        buildCounter: (BuildContext context,
                                {int? currentLength,
                                int? maxLength,
                                bool? isFocused}) =>
                            null,
                        style: const TextStyle(color: Colors.white),
                        cursorColor: Colors.white,
                        controller: codeController,
                        decoration: const InputDecoration(
                          focusedBorder: OutlineInputBorder(
                            borderSide: BorderSide(
                              color: Color.fromARGB(255, 238, 238, 238),
                              width: 2.0,
                            ),
                          ),
                          enabledBorder: OutlineInputBorder(
                            borderSide:
                                BorderSide(color: Colors.grey, width: 1.0),
                          ),
                          labelText: 'Informe o cupom aqui',
                          labelStyle:
                              TextStyle(fontSize: 15, color: Colors.white),
                          border: OutlineInputBorder(),
                          hintStyle: TextStyle(color: Colors.white),
                        ),
                        onChanged: (value) {
                          codeController.value = TextEditingValue(
                            text: value.toUpperCase(),
                            selection: TextSelection.fromPosition(
                              TextPosition(offset: value.length),
                            ),
                          );
                        },
                      ),
                    ),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceAround,
                      children: [
                        ButtonPattern(
                          child: Text(
                            'Cancelar',
                            style: TextStyle(
                              color: colorRed1765959,
                              fontSize: 15,
                            ),
                          ),
                          onPressed: () {
                            Navigator.pop(context);
                          },
                        ),
                        ButtonPattern(
                          child: const Text(
                            'Confirmar',
                            style: TextStyle(
                              fontSize: 15,
                              color: Colors.white,
                            ),
                          ),
                          onPressed: () async {
                            ResponseGetPromotionalCode response =
                                await promotionalCodeController
                                    .getPromotionalCode(
                                        authLoginController.user!.token!,
                                        codeController.text,
                                        widget.barberShop.barbershopId!);
                            if (response.status == 'success') {
                              totalPriceProvider.state.discount =
                                  response.result.discount;
                              showSnackBar(context, 'Desconto aplicado');
                              widget.onConfirm();
                              navigationFadePushReplacement(
                                  const SchedulePage(), context);
                            } else if (response.result ==
                                'promotional_code_not_found') {
                              showSnackBar(
                                  context, 'Cupom de desconto não encontrado');
                            } else {
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