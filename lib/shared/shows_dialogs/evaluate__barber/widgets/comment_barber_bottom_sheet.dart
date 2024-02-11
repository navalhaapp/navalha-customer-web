import 'package:flutter/material.dart';

import 'package:navalha/core/colors.dart';
import 'package:navalha/shared/widgets/header_button_sheet_pattern.dart';

import '../../../widgets/button_pattern_botton_sheet.dart';

class CommentBarberBottomSheet extends StatefulWidget {
  const CommentBarberBottomSheet({
    Key? key,
    required this.description,
  }) : super(key: key);
  final Function(String) description;

  @override
  State<CommentBarberBottomSheet> createState() =>
      _CommentBarberBottomSheetState();
}

class _CommentBarberBottomSheetState extends State<CommentBarberBottomSheet> {
  TextEditingController descriptionEditController = TextEditingController();
  bool loading = false;
  @override
  Widget build(BuildContext context) {
    final size = MediaQuery.of(context).size;

    return SafeArea(
      top: false,
      child: Padding(
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
                      'Nos diga o que achou do serviço!',
                      style: TextStyle(
                          color: Color.fromARGB(255, 255, 255, 255),
                          fontSize: 18),
                    ),
                    SizedBox(height: size.height * 0.025),
                    Container(
                      height: size.height * 0.2,
                      decoration: const BoxDecoration(
                        borderRadius: BorderRadius.all(Radius.circular(17)),
                        color: Colors.white70,
                      ),
                      child: Padding(
                        padding: const EdgeInsets.symmetric(
                            horizontal: 15, vertical: 8),
                        child: TextFormField(
                          maxLines: 5,
                          maxLength: 250,
                          cursorColor: Colors.black,
                          controller: descriptionEditController,
                          obscureText: false,
                          style: const TextStyle(
                            fontSize: 22,
                            color: Color.fromARGB(255, 0, 0, 0),
                            fontStyle: FontStyle.normal,
                          ),
                          decoration: const InputDecoration(
                            hintText: 'Escreva um comentário...',
                            hintStyle: TextStyle(
                              fontSize: 17,
                              color: Color.fromARGB(255, 0, 0, 0),
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
                    child: const Text(
                      'Confirmar',
                      style: TextStyle(
                        color: Colors.white,
                        fontSize: 15,
                      ),
                    ),
                    onPressed: () {
                      widget.description(descriptionEditController.text);
                      Navigator.pop(context);
                    },
                  ),
                ],
              ),
            ],
          ),
        ),
      ),
    );
  }
}
