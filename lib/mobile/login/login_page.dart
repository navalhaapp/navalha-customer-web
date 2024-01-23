// Developer            Data              Decription
// Rovigo               22/08/2022        Login page creation

import 'package:flutter/material.dart';
import 'package:navalha/core/colors.dart';
import 'package:navalha/mobile/login/widgets/terms_and_conditios.dart';
import 'widgets/body_login.dart';

class LoginPage extends StatelessWidget {
  const LoginPage({Key? key}) : super(key: key);

  static const route = '/login-page';

  @override
  Widget build(BuildContext context) {
    return WillPopScope(
      onWillPop: () async {
        return false;
      },
      child: SafeArea(
        top: false,
        child: Scaffold(
          backgroundColor: colorBackground181818,
          body: const BodyLogin(),
          bottomNavigationBar: const ContinueWithoutRegister(),
        ),
      ),
    );
  }
}
