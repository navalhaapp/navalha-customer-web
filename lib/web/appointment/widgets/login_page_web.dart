import 'package:flutter/material.dart';
import 'package:navalha/core/assets.dart';
import 'package:navalha/web/appointment/widgets/body_login_page_web.dart';

class LoginPageWeb extends StatefulWidget {
  static const route = '/login-page-web';
  const LoginPageWeb({
    Key? key,
  }) : super(key: key);

  @override
  State<LoginPageWeb> createState() => _LoginPageWebState();
}

class _LoginPageWebState extends State<LoginPageWeb> {
  bool loading = false;
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color.fromARGB(255, 20, 20, 20),
      body: const BodyLoginWeb(isloginDialog: false),
      appBar: AppBar(
        elevation: 0,
        backgroundColor: const Color.fromARGB(255, 20, 20, 20),
        leading: const SizedBox(),
        title: SizedBox(
          height: 50,
          child: Image.asset(
            logoBrancaCustomer,
            fit: BoxFit.contain,
          ),
        ),
      ),
    );
  }
}
