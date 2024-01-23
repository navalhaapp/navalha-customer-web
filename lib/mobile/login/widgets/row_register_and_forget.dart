// Developer            Data              Decription
// Rovigo               22/08/2022        Extracting register and forget row

import 'package:flutter/material.dart';
import 'package:navalha/mobile/forget_password/forget_password_page.dart';
import 'package:navalha/mobile/register/registration_page_client.dart';
import 'package:navalha/shared/animation/page_trasition.dart';

class RowRegisterAndForget extends StatelessWidget {
  const RowRegisterAndForget({
    Key? key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      width: MediaQuery.of(context).size.width * 0.92,
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          TextButton(
            onPressed: () {
              navigationWithFadeAnimation(const ForgetPasswordPage(), context);
            },
            style: ButtonStyle(
              overlayColor: MaterialStateProperty.all(Colors.transparent),
            ),
            child: const Text(
              'Esqueci a senha',
              style: TextStyle(
                color: Colors.white,
              ),
            ),
          ),
          TextButton(
            onPressed: () {
              navigationWithFadeAnimation(
                  const RegistrationPageClient(), context);
            },
            style: ButtonStyle(
              overlayColor: MaterialStateProperty.all(Colors.transparent),
            ),
            child: const Text(
              'Cadastrar-se',
              style: TextStyle(
                color: Colors.white,
              ),
            ),
          ),
        ],
      ),
    );
  }
}
