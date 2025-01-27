// ignore_for_file: use_build_context_synchronously

import 'package:flutter/material.dart';
import 'package:flutter_pw_validator/flutter_pw_validator.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:shared_preferences/shared_preferences.dart';

import 'package:navalha/core/colors.dart';
import 'package:navalha/mobile-DEPRECIATED/change_password/change_password_page.dart';
import 'package:navalha/mobile-DEPRECIATED/change_password/model/change_password_model.dart';
import 'package:navalha/mobile-DEPRECIATED/change_password/provider/provider_change_password.dart';
import 'package:navalha/shared/utils.dart';
import 'package:navalha/shared/widgets/text_edit.dart';
import 'package:navalha/web/appointment/widgets/register_web/registration_password_web.dart';

class ResetPasswordPage extends StatefulWidget {
  static const route = '/reset-password-page';

  ResetPasswordPage({
    Key? key,
    required this.arguments,
  }) : super(key: key);
  static bool btnConverIsPressed = false;
  final Map<String, dynamic> arguments;
  bool passedTest = false;
  @override
  State<ResetPasswordPage> createState() => _ResetPasswordPageState();
}

class _ResetPasswordPageState extends State<ResetPasswordPage> {
  TextEditingController currentPasswordController = TextEditingController();
  TextEditingController newPasswordController = TextEditingController();
  TextEditingController confirmPasswordController = TextEditingController();
  bool _passwordVisible = false;
  final GlobalKey<FlutterPwValidatorState> validatorKey =
      GlobalKey<FlutterPwValidatorState>();
  int _state = 0;
  @override
  void initState() {
    super.initState();

    _passwordVisible = false;
  }

  @override
  Widget build(BuildContext context) {

    final String customerId = widget.arguments['customer_id'] ?? '';
    final size = MediaQuery.of(context).size;
    return WillPopScope(
      onWillPop: () async {
        Navigator.pushNamed(context, '/forget');
        return true;
      },
      child: SafeArea(
        top: false,
        child: Scaffold(
          backgroundColor: colorBackground181818,
          appBar: AppBar(
            elevation: 0,
            leading: IconButton(
                icon: const Icon(Icons.arrow_back_ios_new, size: 17),
                onPressed: () => Navigator.pushNamed(context, '/forget')),
            backgroundColor: Colors.transparent,
            title: const Text('Trocar senha', style: TextStyle(fontSize: 18)),
            centerTitle: true,
          ),
          body: Center(
            child: Container(
              margin: const EdgeInsets.all(18),
              width: 500,
              height: 500,
              decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(15),
                color: colorContainers242424,
              ),
              child: Column(
                children: [
                  TextEditPattern(
                    padding: const EdgeInsets.symmetric(
                        horizontal: 20, vertical: 10),
                    sizeHint: 17,
                    sizeLabel: 18,
                    controller: newPasswordController,
                    obscure: !_passwordVisible,
                    maxLength: 30,
                    label: 'Nova senha',
                    hint: 'Informe a nova senha',
                    keyboardType: TextInputType.visiblePassword,
                    color: const Color.fromARGB(255, 28, 28, 28),
                    suffixIcon: Padding(
                      padding: const EdgeInsets.only(right: 20),
                      child: IconButton(
                        splashColor: Colors.transparent,
                        icon: Icon(
                          _passwordVisible
                              ? Icons.visibility
                              : Icons.visibility_off,
                          color: const Color.fromARGB(255, 255, 255, 255),
                        ),
                        onPressed: () {
                          setState(() {
                            _passwordVisible = !_passwordVisible;
                          });
                        },
                      ),
                    ),
                  ),
                  TextEditPattern(
                    padding: const EdgeInsets.symmetric(
                        horizontal: 20, vertical: 10),
                    sizeHint: 17,
                    sizeLabel: 18,
                    controller: confirmPasswordController,
                    obscure: !_passwordVisible,
                    maxLength: 30,
                    label: 'Confirme sua senha',
                    hint: 'Confirme a nova senha',
                    keyboardType: TextInputType.visiblePassword,
                    color: const Color.fromARGB(255, 28, 28, 28),
                  ),
                  Padding(
                    padding: EdgeInsets.symmetric(
                      horizontal: 20,
                    ),
                    child: SizedBox(
                      width: MediaQuery.of(context).size.width,
                      child: FlutterPwValidator(
                        key: validatorKey,
                        controller: newPasswordController,
                        strings: FlutterPwValidatorNavalha(),
                        minLength: 8,
                        uppercaseCharCount: 1,
                        numericCharCount: 1,
                        failureColor: const Color.fromARGB(255, 227, 90, 80),
                        width: 400,
                        height: 100,
                        onSuccess: () {
                          widget.passedTest = true;
                        },
                        onFail: () {},
                      ),
                    ),
                  ),
                ],
              ),
            ),
          ),
          floatingActionButton: Consumer(
            builder: (context, ref, child) {
              final changePasswordController =
                  ref.read(ChangePasswordStateController.provider.notifier);
              return FloatingActionButton(
                backgroundColor: Colors.transparent,
                splashColor: Colors.black,
                shape: const StadiumBorder(
                  side: BorderSide(
                      color: Color.fromARGB(255, 255, 228, 92), width: 4),
                ),
                child: setUpButtonChild(),
                onPressed: () async {
                  if (newPasswordController.text.isEmpty) {
                    showSnackBar(context, 'Digite uma senha');
                  } else if (newPasswordController.text.trim() !=
                      confirmPasswordController.text.trim()) {
                    showSnackBar(context, 'As senhas devem ser iguais');
                  } else if (!widget.passedTest) {
                    showSnackBar(context, 'Senha não segura');
                  } else if (!possuiLetraMaiuscula(
                      newPasswordController.text.trim())) {
                    showSnackBar(
                        context, 'A senha deve conter alguma letra maiúscula!');
                  } else {
                    setState(() {
                      _state = 1;
                    });
                    ChangePasswordResponse response =
                        await changePasswordController.changePassword(
                      customerId,
                      null,
                      newPasswordController.text,
                      null,
                    );
                    if (response.status != 'success') {
                      setState(() {
                        _state = 0;
                      });

                      showSnackBar(
                          context, 'Senha atual incorreta, tente novamente!');
                    } else {
                      setState(() {
                        _state = 2;
                      });
                      SharedPreferences prefs =
                          await SharedPreferences.getInstance();
                      prefs.setString('password', newPasswordController.text);
                      showSnackBar(context, 'Senha atualizada com sucesso!');
                      Future.delayed(const Duration(milliseconds: 1500))
                          .then((value) {
                        Navigator.of(context).pushNamed('/login');
                      });
                    }
                  }
                },
              );
            },
          ),
        ),
      ),
    );
  }

  Widget setUpButtonChild() {
    if (_state == 0) {
      return const Icon(Icons.check, color: Colors.white, size: 40);
    } else if (_state == 1) {
      return const CircularProgressIndicator(
        valueColor: AlwaysStoppedAnimation<Color>(Colors.white),
      );
    } else {
      return const Icon(Icons.check, color: Colors.white, size: 43);
    }
  }
}
