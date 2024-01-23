import 'package:flutter/material.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';

import '../../../core/colors.dart';
import '../../../shared/providers.dart';
import '../../../shared/widgets/button_pattern_botton_sheet.dart';
import '../../../shared/widgets/header_button_sheet_pattern.dart';
import '../model/model_reserved_time.dart';

class ObservationBottomSheet extends StatefulWidget {
  const ObservationBottomSheet({
    Key? key,
  }) : super(key: key);

  @override
  State<ObservationBottomSheet> createState() => _ObservationBottomSheetState();
}

class _ObservationBottomSheetState extends State<ObservationBottomSheet> {
  late StateController<ReservedTime> reservedTime;
  TextEditingController observationController = TextEditingController();
  bool loading = false;
  @override
  Widget build(BuildContext context) {
    final size = MediaQuery.of(context).size;

    return SafeArea(
      top: false,
      child: Consumer(
        builder: (context, ref, child) {
          final resumePayment = ref.watch(resumePaymentProvider.state);
          reservedTime = ref.watch(reservedTimeProvider.state);
          return Padding(
            padding: EdgeInsets.only(
              bottom: MediaQuery.of(context).viewInsets.bottom,
            ),
            child: Container(
              decoration: BoxDecoration(
                color: colorBackground181818,
                borderRadius: const BorderRadius.only(
                  topLeft: Radius.circular(17),
                  topRight: Radius.circular(17),
                ),
              ),
              child: Column(
                mainAxisSize: MainAxisSize.min,
                children: [
                  const HeaderBottonSheetPattern(),
                  Padding(
                    padding: EdgeInsets.only(
                      left: size.width * 0.06,
                      right: size.width * 0.06,
                    ),
                    child: Column(
                      mainAxisSize: MainAxisSize.min,
                      mainAxisAlignment: MainAxisAlignment.start,
                      children: [
                        const Text(
                          'Adicione uma observação',
                          style: TextStyle(
                            color: Color.fromARGB(255, 255, 255, 255),
                            fontSize: 17,
                          ),
                        ),
                        SizedBox(height: size.height * 0.025),
                        Container(
                          height: size.height * 0.2,
                          decoration: const BoxDecoration(
                            borderRadius: BorderRadius.all(Radius.circular(17)),
                            color: Color.fromARGB(255, 25, 25, 25),
                          ),
                          child: Padding(
                            padding: const EdgeInsets.symmetric(
                                horizontal: 15, vertical: 8),
                            child: TextFormField(
                              controller: observationController,
                              maxLines: 5,
                              maxLength: 250,
                              cursorColor: Colors.white,
                              obscureText: false,
                              style: const TextStyle(
                                color: Color.fromARGB(255, 255, 255, 255),
                                fontStyle: FontStyle.normal,
                              ),
                              decoration: InputDecoration(
                                hintText:
                                    'Escreva uma observação para o profissional...',
                                hintStyle: TextStyle(
                                  fontSize: 17,
                                  color: colorFontUnable116116116,
                                ),
                                border: InputBorder.none,
                                focusedBorder: InputBorder.none,
                              ),
                            ),
                          ),
                        ),
                        SizedBox(height: size.height * 0.01),
                      ],
                    ),
                  ),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                    children: [
                      ButtonPattern(
                        width: size.width * 0.41,
                        color: colorContainers242424,
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
                        width: size.width * 0.41,
                        color: colorContainers242424,
                        child: !loading
                            ? const Text(
                                'Confirmar',
                                style: TextStyle(
                                  color: Colors.white,
                                  fontSize: 15,
                                ),
                              )
                            : const SizedBox(
                                width: 20,
                                height: 20,
                                child: CircularProgressIndicator(
                                  color: Colors.white,
                                  strokeWidth: 2,
                                ),
                              ),
                        onPressed: () async {
                          reservedTime.state.observation =
                              observationController.text;
                          resumePayment.state.observation =
                              observationController.text;
                          setState(() {
                            loading = true;
                          });
                          Navigator.pop(context);
                          setState(() {
                            loading = false;
                          });
                        },
                      ),
                    ],
                  ),
                ],
              ),
            ),
          );
        },
      ),
    );
  }
}
