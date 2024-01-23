// Developer            Data              Decription
// Vitor               22/08/2022        Schedule confirmation button creation

import 'package:flutter/material.dart';
import 'package:progress_state_button/iconed_button.dart';
import 'package:progress_state_button/progress_button.dart';

import 'slide_animation.dart';

class SaveInformationButton extends StatefulWidget {
  final Widget page;
  final String labelName;
  const SaveInformationButton({
    Key? key,
    required this.page,
    required this.labelName,
  }) : super(key: key);

  @override
  SaveInformationButtonState createState() => SaveInformationButtonState();
}

class SaveInformationButtonState extends State<SaveInformationButton> {
  ButtonState stateOnlyText = ButtonState.idle;
  ButtonState stateTextWithIcon = ButtonState.idle;

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: const EdgeInsets.all(18.0),
      decoration: BoxDecoration(
        border: Border.all(
            color: const Color.fromARGB(255, 255, 228, 92), width: 2),
        borderRadius: BorderRadius.circular(40),
        color: Colors.transparent,
      ),
      child: ProgressButton.icon(
        iconedButtons: {
          ButtonState.idle: IconedButton(
            text: widget.labelName,
            icon: const Icon(Icons.check, color: Colors.white),
            color: Colors.transparent,
          ),
          ButtonState.loading: const IconedButton(
            text: 'Loading',
            color: Colors.transparent,
          ),
          ButtonState.fail: const IconedButton(
            text: 'Failed',
            icon: Icon(Icons.cancel, color: Colors.white),
            color: Colors.transparent,
          ),
          ButtonState.success: const IconedButton(
            icon: Icon(
              Icons.check_circle,
              color: Colors.white,
            ),
            color: Colors.transparent,
          )
        },
        onPressed: onPressedIconWithText,
        state: stateTextWithIcon,
      ),
    );
  }

  void onPressedIconWithText() {
    switch (stateTextWithIcon) {
      case ButtonState.idle:
        stateTextWithIcon = ButtonState.loading;
        Future.delayed(
          const Duration(milliseconds: 1500),
          () {
            setState(
              () {
                stateTextWithIcon = ButtonState.success;
                Navigator.of(context).pushReplacement(
                    SlideTransitionAnimation(page: widget.page));
              },
            );
          },
        );

        break;
      case ButtonState.loading:
        break;
      case ButtonState.success:
        stateTextWithIcon = ButtonState.idle;
        break;
      case ButtonState.fail:
        stateTextWithIcon = ButtonState.idle;
        break;
    }
    setState(
      () {
        stateTextWithIcon = stateTextWithIcon;
      },
    );
  }
}
