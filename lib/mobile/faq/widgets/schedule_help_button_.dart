// Developer            Data              Decription
// Vitor               22/08/2022        Schedule confirmation button creation

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:navalha/core/colors.dart';
import 'package:progress_state_button/iconed_button.dart';
import 'package:progress_state_button/progress_button.dart';

class ScheduleHelpButton extends StatefulWidget {
  final String labelName;
  final Function onPressed;

  const ScheduleHelpButton({
    Key? key,
    required this.labelName,
    required this.onPressed,
  }) : super(key: key);

  @override
  ScheduleHelpButtonState createState() => ScheduleHelpButtonState();
}

class ScheduleHelpButtonState extends State<ScheduleHelpButton> {
  ButtonState stateOnlyText = ButtonState.idle;
  ButtonState stateTextWithIcon = ButtonState.idle;

  @override
  Widget build(BuildContext context) {
    Size size = MediaQuery.of(context).size;
    return Container(
      height: size.height * 0.05,
      width: size.width * 0.3,
      margin: const EdgeInsets.all(18.0),
      decoration: BoxDecoration(
          border: Border.all(color: colorYellow25020050, width: 2),
          borderRadius: BorderRadius.circular(40),
          color: Colors.transparent),
      child: ProgressButton.icon(
        iconedButtons: {
          ButtonState.idle: IconedButton(
              text: widget.labelName,
              icon: const Icon(CupertinoIcons.exclamationmark_octagon,
                  color: Color.fromARGB(255, 171, 171, 171)),
              color: Colors.transparent),
          ButtonState.loading:
              const IconedButton(text: 'Loading', color: Colors.transparent),
          ButtonState.fail: const IconedButton(
              text: 'Failed',
              icon: Icon(Icons.abc, color: Colors.white),
              color: Colors.transparent),
          ButtonState.success: const IconedButton(
              text: 'Success',
              icon: Icon(
                Icons.abc,
                color: Colors.white,
              ),
              color: Colors.transparent)
        },
        onPressed: () => widget.onPressed(),
        state: stateTextWithIcon,
      ),
    );
  }
}
