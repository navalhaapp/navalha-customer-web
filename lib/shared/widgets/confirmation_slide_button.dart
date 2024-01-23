// Developer            Data              Decription
// Rovigo               22/08/2022        Confirmation slide butto creation

import 'package:action_slider/action_slider.dart';
import 'package:flutter/material.dart';
import 'package:navalha/mobile/home/home_page.dart';

class ConfirmationSlideButton extends StatelessWidget {
  final String? text;

  const ConfirmationSlideButton({Key? key, this.text}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final heightSize = MediaQuery.of(context).size.height;
    return Center(
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: <Widget>[
          ActionSlider.standard(
            sliderBehavior: SliderBehavior.stretch,
            width: MediaQuery.of(context).size.width * 0.9,
            backgroundColor: const Color.fromARGB(255, 255, 228, 92),
            toggleColor: const Color.fromARGB(255, 0, 0, 0),
            loadingIcon: const CircularProgressIndicator(
              valueColor: AlwaysStoppedAnimation<Color>(
                Colors.white,
              ),
            ),
            icon: Icon(
              Icons.navigate_next_outlined,
              color: Colors.white,
              size: MediaQuery.of(context).size.width * 0.1,
            ),
            successIcon: Icon(
              Icons.check,
              color: Colors.white,
              size: MediaQuery.of(context).size.width * 0.06,
            ),
            action: (controller) async {
              controller.loading(); //starts loading animation
              await Future.delayed(
                const Duration(seconds: 2),
              );
              controller.success(); //starts success animation
              await Future.delayed(
                const Duration(seconds: 1),
                () {
                  Navigator.pushNamed(context, HomePage.route);
                },
              );
              controller.reset(); //resets the slider
            },
            child: Text(
              text == null ? 'Deslize para confirmar' : text.toString(),
              style: TextStyle(
                color: Colors.white,
                fontSize: MediaQuery.of(context).size.width * 0.05,
              ),
            ),
          ),
          SizedBox(height: heightSize * 0.05),
        ],
      ),
    );
  }
}
