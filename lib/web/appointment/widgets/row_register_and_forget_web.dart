// Developer            Data              Decription
// Rovigo               22/08/2022        Extracting register and forget row

import 'package:flutter/material.dart';
import 'package:navalha/shared/animation/page_trasition.dart';
import 'package:navalha/web/appointment/widgets/forget_password_page_web.dart';
import 'package:navalha/web/appointment/widgets/register_web/registration_page_client_web.dart';

class RowRegisterAndForgetWeb extends StatelessWidget {
  const RowRegisterAndForgetWeb({
    Key? key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 20),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          TextButton(
            onPressed: () {
              navigationWithFadeAnimation(
                  const ForgetPasswordPageWeb(), context);
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
                  const RegistrationPageClientWeb(), context);
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
