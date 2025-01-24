// ignore_for_file: use_build_context_synchronously

import 'package:flutter/material.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:navalha/mobile-DEPRECIATED/schedule/model/response_get_promotional_code.dart';
import 'package:navalha/mobile-DEPRECIATED/schedule/provider/provider_get_promotional_code.dart';
import 'package:navalha/shared/utils.dart';
import 'package:navalha/web/db/db_customer_shared.dart';
import 'package:navalha/web/utils/utils.dart';
import '../../../core/colors.dart';
import '../../../shared/model/barber_shop_model.dart';
import '../../../shared/providers.dart';
import '../../../shared/widgets/header_button_sheet_pattern.dart';

class AddCouponHourBottonSheet extends StatefulWidget {
  const AddCouponHourBottonSheet({
    Key? key,
    required this.onChanged,
    required this.barberShop,
  }) : super(key: key);
  final ValueChanged<String> onChanged;
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

    return Consumer(
      builder: (context, ref, child) {
        CustomerDB? retrievedCustomer = LocalStorageManager.getCustomer();
        final promotionalCodeController =
            ref.watch(GetPromotionalCodeStateController.provider.notifier);
        var totalPriceProvider = ref.watch(totalPriceServiceProvider.state);
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
                const HeaderBottonSheetPattern(width: 24),
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
                        borderSide: BorderSide(color: Colors.grey, width: 1.0),
                      ),
                      labelText: 'Informe o cupom aqui',
                      labelStyle: TextStyle(fontSize: 15, color: Colors.white),
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
                    Expanded(
                      child: Container(
                        margin: const EdgeInsets.only(
                            left: 10, right: 10, bottom: 10),
                        height: 35,
                        decoration: BoxDecoration(
                          color: colorContainers242424,
                          borderRadius: const BorderRadius.all(
                            Radius.circular(14),
                          ),
                        ),
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
                      ),
                    ),
                    Expanded(
                      child: Container(
                        margin: const EdgeInsets.only(left: 10, right: 5),
                        height: 35,
                        decoration: BoxDecoration(
                          color: colorContainers242424,
                          borderRadius: const BorderRadius.all(
                            Radius.circular(14),
                          ),
                        ),
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
                            'Confirmar',
                            style: TextStyle(
                              fontSize: 15,
                              color: Colors.white,
                            ),
                          ),
                          onPressed: () async {
                            ResponseGetPromotionalCode response =
                                await promotionalCodeController
                                    .getPromotionalCode(codeController.text,
                                        widget.barberShop.barbershopId!);
                            if (response.status == 'success') {
                              widget.onChanged(codeController.text);

                              totalPriceProvider.state.discount =
                                  response.result.discount;
                              showSnackBar(context, 'Desconto aplicado');
                              Navigator.of(context).pop();
                            } else if (response.result ==
                                'promotional_code_not_found') {
                              showSnackBar(
                                  context, 'Cupom de desconto não encontrado');
                              Navigator.of(context).pop();
                            } else {
                              showSnackBar(context, 'Ops, algo aconteceu');
                              Navigator.of(context).pop();
                            }
                          },
                        ),
                      ),
                    ),
                  ],
                ),
              ],
            ),
          ),
        );
      },
    );
  }
}
