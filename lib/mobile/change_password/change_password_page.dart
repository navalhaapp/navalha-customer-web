// ignore_for_file: use_build_context_synchronously

import 'package:flutter/material.dart';
import 'package:flutter_pw_validator/Resource/Strings.dart';
import 'package:flutter_pw_validator/flutter_pw_validator.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:navalha/mobile/change_password/provider/provider_change_password.dart';
import 'package:navalha/core/colors.dart';
import 'package:navalha/mobile/register/registration_password.dart';
import 'package:shared_preferences/shared_preferences.dart';
import '../login/controller/login_controller.dart';
import '../../shared/utils.dart';
import '../../shared/widgets/text_edit.dart';

class ChangePasswordPage extends StatefulWidget {
  ChangePasswordPage({super.key});
  static const route = '/change-password-page';
  static bool btnConverIsPressed = false;
  bool passedTest = false;
  @override
  State<ChangePasswordPage> createState() => _ChangePasswordPageState();
}

class _ChangePasswordPageState extends State<ChangePasswordPage> {
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
    return WillPopScope(
      onWillPop: () async {
        return true;
      },
      child: SafeArea(
        top: false,
        child: Scaffold(
          backgroundColor: colorBackground181818,
          appBar: AppBar(
            leading: IconButton(
              icon: const Icon(Icons.arrow_back_ios_new, size: 17),
              onPressed: () {
                Navigator.pop(context);
              },
            ),
            automaticallyImplyLeading: false,
            title: Text('Trocar senha', style: TextStyle(shadows: shadow)),
            elevation: 0,
            centerTitle: true,
            backgroundColor: Colors.transparent,
          ),
          body: SizedBox(
            height: MediaQuery.of(context).size.height,
            child: ListView(
              children: [
                TextEditPattern(
                  controller: currentPasswordController,
                  obscure: !_passwordVisible,
                  label: 'Senha Atual',
                  maxLength: 30,
                  hint: 'Informe sua senha atual',
                  keyboardType: TextInputType.visiblePassword,
                  color: colorContainers242424,
                  suffixIcon: IconButton(
                    padding: EdgeInsets.only(
                        left: MediaQuery.of(context).size.width * 0.1),
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
                TextEditPattern(
                  controller: newPasswordController,
                  obscure: !_passwordVisible,
                  maxLength: 30,
                  label: 'Nova senha',
                  hint: 'Informe a nova senha',
                  keyboardType: TextInputType.visiblePassword,
                  color: colorContainers242424,
                ),
                TextEditPattern(
                  controller: confirmPasswordController,
                  obscure: !_passwordVisible,
                  maxLength: 30,
                  label: 'Confirme sua senha',
                  hint: 'Confirme a nova senha',
                  keyboardType: TextInputType.visiblePassword,
                  color: colorContainers242424,
                ),
                Padding(
                  padding: EdgeInsets.symmetric(
                    horizontal: MediaQuery.of(context).size.width * 0.08,
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
                      width: MediaQuery.of(context).size.width * 0.8,
                      height: MediaQuery.of(context).size.height * 0.17,
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
          floatingActionButton: Consumer(
            builder: (context, ref, child) {
              final loginController =
                  ref.read(LoginStateController.provider.notifier);
              final changePasswordController =
                  ref.read(ChangePasswordStateController.provider.notifier);
              final String token = loginController.user!.token!;
              final String userId = loginController.user!.customer!.customerId!;
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
                    await changePasswordController.changePassword(
                        userId,
                        currentPasswordController.text,
                        newPasswordController.text,
                        token);
                    if (changePasswordController.userChangePassword!.status !=
                        'success') {
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
                        Navigator.pop(context);
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

class FlutterPwValidatorNavalha implements FlutterPwValidatorStrings {
  @override
  final String atLeast = 'Ao menos - caracteres';
  @override
  final String normalLetters = '- Letter';
  @override
  final String uppercaseLetters = '- Letra maiúscula';
  @override
  final String numericCharacters = '- Caractere numérico';
  @override
  final String specialCharacters = '- Caractere especial';

  @override
  String lowercaseLetters = 'Uppercase letter';
}
