// Developer            Data              Decription
// Rovigo               22/08/2022        Extracting terms and conditions

import 'package:flutter/material.dart';
import 'package:navalha/mobile-DEPRECIATED/home/home_page.dart';
import 'package:navalha/shared/animation/page_trasition.dart';

class ContinueWithoutRegister extends StatelessWidget {
  const ContinueWithoutRegister({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      height: MediaQuery.of(context).size.height * .05,
      child: Center(
        child: TextButton(
          child: const Text(
            'Continuar sem cadastro',
            style: TextStyle(
              color: Colors.white,
              fontWeight: FontWeight.bold,
            ),
          ),
          onPressed: () =>
              navigationWithFadeAnimation(const HomePage(), context),
        ),
      ),
    );
  }
}
