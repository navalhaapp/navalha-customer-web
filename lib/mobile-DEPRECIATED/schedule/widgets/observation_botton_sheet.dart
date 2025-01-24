import 'dart:async';

import 'package:flutter/material.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:navalha/web/utils/utils.dart';
import '../../../core/colors.dart';
import '../../../shared/providers.dart';
import '../../../shared/widgets/header_button_sheet_pattern.dart';
import '../model/model_reserved_time.dart';

class ObservationBottomSheet extends StatefulWidget {
  const ObservationBottomSheet({
    Key? key,
    required this.onChanged,
    required this.initialObservation,
  }) : super(key: key);

  final ValueChanged<String> onChanged;
  final String initialObservation;

  @override
  State<ObservationBottomSheet> createState() => _ObservationBottomSheetState();
}

class _ObservationBottomSheetState extends State<ObservationBottomSheet> {
  Timer? _debounce;
  late StateController<ReservedTime> reservedTime;
  TextEditingController observationController = TextEditingController();
  bool loading = false;

  @override
  void initState() {
    super.initState();
    observationController.text = widget.initialObservation;

    WidgetsBinding.instance.addPostFrameCallback((_) {
      Future.microtask(() {
        if (mounted) {
          FocusScope.of(context).requestFocus(_focusNode);
        }
      });
    });
  }

  @override
  void dispose() {
    _focusNode.dispose();
    super.dispose();
  }

  final FocusNode _focusNode = FocusNode();

  @override
  Widget build(BuildContext context) {
    final size = MediaQuery.of(context).size;

    return Consumer(
      builder: (context, ref, child) {
        final resumePayment = ref.watch(resumePaymentProvider.state);
        reservedTime = ref.watch(reservedTimeProvider.state);
        return Padding(
          padding: NavalhaUtils().calculateDialogPadding(context),
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
                const HeaderBottonSheetPattern(width: 40),
                Padding(
                  padding: const EdgeInsets.only(
                    left: 10,
                    right: 10,
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
                        padding: EdgeInsets.zero,
                        height: size.height * 0.2,
                        width: MediaQuery.of(context).size.width,
                        decoration: const BoxDecoration(
                          borderRadius: BorderRadius.all(Radius.circular(17)),
                          color: Color.fromARGB(255, 25, 25, 25),
                        ),
                        child: Padding(
                          padding: const EdgeInsets.symmetric(
                              horizontal: 20, vertical: 8),
                          child: TextField(
                            autofocus: false,
                            focusNode: _focusNode,
                            onChanged: (value) {
                              if (_debounce?.isActive ?? false) {
                                _debounce!.cancel();
                              }
                              _debounce =
                                  Timer(const Duration(milliseconds: 1000), () {
                                widget.onChanged(value);
                              });
                            },
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
                                  'Adicione instruções ou preferências para o seu atendimento',
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
                Padding(
                  padding: const EdgeInsets.only(bottom: 10),
                  child: Row(
                    children: [
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
                          margin: const EdgeInsets.only(left: 5, right: 10),
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
                        ),
                      ),
                    ],
                  ),
                ),
              ],
            ),
          ),
        );
      },
    );
  }
}
