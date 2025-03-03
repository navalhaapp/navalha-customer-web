// ignore_for_file: use_build_context_synchronously

import 'package:email_validator/email_validator.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:navalha/web/appointment/text_edit_web.dart';
import 'package:pin_code_fields/pin_code_fields.dart';

import 'package:navalha/core/colors.dart';
import 'package:navalha/mobile-DEPRECIATED/register/provider/provider_auth_email.dart';
import 'package:navalha/mobile-DEPRECIATED/register/provider/register_customer_provider.dart';
import 'package:navalha/shared/animation/page_trasition.dart';
import 'package:navalha/shared/shows_dialogs/dialog.dart';
import 'package:navalha/shared/utils.dart';

import 'registration_page_client_second_web.dart';

class RegistrationPageClientWeb extends StatefulHookConsumerWidget {
  const RegistrationPageClientWeb({super.key});

  @override
  ConsumerState<RegistrationPageClientWeb> createState() =>
      _RegistrationPageClientWebState();
  static const route = '/register-web-page';
}

class _RegistrationPageClientWebState
    extends ConsumerState<RegistrationPageClientWeb> {
  final TextEditingController nameEditController = TextEditingController();
  final TextEditingController emailEditController = TextEditingController();
  final TextEditingController documentEditController = TextEditingController();
  final TextEditingController codeController = TextEditingController();
  int _state = 0;

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      top: false,
      child: Scaffold(
        backgroundColor: colorBackground181818,
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
              crossAxisAlignment: CrossAxisAlignment.end,
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        IconButton(
                          padding: const EdgeInsets.symmetric(
                              horizontal: 20, vertical: 15),
                          onPressed: () {
                            Navigator.pop(context);
                          },
                          icon: const Icon(
                            CupertinoIcons.back,
                            color: Colors.white,
                          ),
                        ),
                        Row(
                          children: [
                            const ContainerStepper(color: Colors.white),
                            ContainerStepper(color: Colors.grey.shade800),
                            ContainerStepper(color: Colors.grey.shade800),
                            ContainerStepper(color: Colors.grey.shade800),
                          ],
                        ),
                        IconButton(
                          padding: const EdgeInsets.symmetric(
                              horizontal: 20, vertical: 15),
                          onPressed: () {},
                          icon: const Icon(
                            CupertinoIcons.back,
                            color: Colors.transparent,
                          ),
                        ),
                      ],
                    ),
                    TextEditPatternWeb(
                      margin: const EdgeInsets.symmetric(
                        horizontal: 20,
                      ),
                      maxLength: 50,
                      controller: nameEditController,
                      label: 'Nome completo',
                      hint: 'Digite o nome',
                      obscure: false,
                      keyboardType: TextInputType.name,
                    ),
                    TextEditPatternWeb(
                      margin: const EdgeInsets.symmetric(
                        vertical: 10,
                        horizontal: 20,
                      ),
                      maxLength: 300,
                      controller: emailEditController,
                      label: 'Email',
                      hint: 'Digite o Email',
                      obscure: false,
                      keyboardType: TextInputType.emailAddress,
                    ),
                  ],
                ),
                Padding(
                  padding: const EdgeInsets.all(25),
                  child: Consumer(
                    builder: (context, ref, child) {
                      final authEmailController =
                          ref.read(AuthEmailStateController.provider.notifier);
                      return FloatingActionButton(
                        backgroundColor: Colors.transparent,
                        splashColor: Colors.black,
                        shape: const StadiumBorder(
                          side: BorderSide(
                            color: Color.fromARGB(255, 255, 228, 92),
                            width: 4,
                          ),
                        ),
                        child: setUpButtonChild(),
                        onPressed: () async {
                          if (nameEditController.text.trim().isEmpty) {
                            showSnackBar(
                              context,
                              'Digite seu nome',
                            );
                          } else if (nameEditController.text.length < 4) {
                            showSnackBar(
                              context,
                              'Nome muito curto',
                            );
                          } else if (RegExp(r"[0-9]")
                              .hasMatch(nameEditController.text)) {
                            showSnackBar(
                              context,
                              'O nome não pode conter números',
                            );
                          } else if (!RegExp(r"^[a-zA-Z\u00C0-\u017F\s]+$")
                              .hasMatch(nameEditController.text)) {
                            showSnackBar(
                              context,
                              'Digite um nome válido',
                            );
                          } else if (!nameEditController.text.contains(' ')) {
                            showSnackBar(
                              context,
                              'Digite o nome completo',
                            );
                          } else if (!EmailValidator.validate(
                              emailEditController.text)) {
                            showSnackBar(context, 'Digite um email válido');
                          } else {
                            setState(() {
                              _state = 1;
                            });
                            final adressEmail = await authEmailController
                                .authEmail(
                                    emailEditController.text.trim(), true);
                            if (adressEmail.result == 'already_exists') {
                              showSnackBar(context, 'Email já cadastrado');
                              setState(() {
                                _state = 0;
                              });
                            }
                            if (adressEmail.status == 'success') {
                              setState(() {
                                _state = 3;
                              });
                              showCustomDialog(
                                context,
                                _ConfirmEmail(
                                  resultCode: adressEmail.result!,
                                  name: nameEditController.text.trim(),
                                  email: emailEditController.text.trim(),
                                  codeController: codeController,
                                ),
                              );
                            } else if (adressEmail.result == 'already_exists') {
                              showSnackBar(
                                  context, 'Esse email já foi cadastrado!');
                            } else {
                              showSnackBar(context, 'Ops, algo aconteceu!');
                            }
                          }
                        },
                      );
                    },
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }

  Widget setUpButtonChild() {
    if (_state == 0) {
      return const Icon(Icons.navigate_next_rounded,
          color: Colors.white, size: 45);
    } else if (_state == 1) {
      return const CircularProgressIndicator(
        valueColor: AlwaysStoppedAnimation<Color>(Colors.white),
      );
    } else {
      return const Icon(Icons.check, color: Colors.white, size: 43);
    }
  }

  bool fullNameValidate(String fullName) {
    String patttern = r"^\s*([A-Za-z]{1,}([\.,] |[-']| ))+[A-Za-z]+\.?\s*$";
    RegExp regExp = RegExp(patttern);
    if (!regExp.hasMatch(fullName)) {
      return false;
    }
    return true;
  }
}

class ContainerStepper extends StatelessWidget {
  const ContainerStepper({
    Key? key,
    required this.color,
  }) : super(key: key);
  final Color color;

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: const EdgeInsets.only(right: 5),
      width: 30,
      height: 5,
      decoration: BoxDecoration(
        color: color,
        borderRadius: const BorderRadius.all(
          Radius.circular(1),
        ),
      ),
    );
  }
}

class _ConfirmEmail extends StatelessWidget {
  const _ConfirmEmail({
    Key? key,
    required this.codeController,
    required this.email,
    required this.name,
    required this.resultCode,
  }) : super(key: key);

  final TextEditingController codeController;
  final String email;
  final String name;
  final String resultCode;

  @override
  Widget build(BuildContext context) {
    return Consumer(
      builder: (context, ref, child) {
        final customerRegisterController =
            ref.watch(customerRegisterProvider.notifier);
        return SizedBox(
          width: 250,
          child: AlertDialog(
            alignment: Alignment.center,
            shape: const RoundedRectangleBorder(
              borderRadius: BorderRadius.all(
                Radius.circular(32.0),
              ),
            ),
            scrollable: true,
            backgroundColor: colorContainers242424,
            content: SizedBox(
              width: 250,
              child: Column(
                children: [
                  const Text(
                    textAlign: TextAlign.center,
                    'Por favor, digite o codigo que\n enviamos para:',
                    style: TextStyle(
                      color: Color.fromARGB(255, 204, 204, 204),
                      fontSize: 17,
                    ),
                  ),
                  Padding(
                    padding: const EdgeInsets.only(top: 20),
                    child: Text(
                      textAlign: TextAlign.center,
                      email,
                      style: const TextStyle(
                        color: Colors.white,
                        fontSize: 17,
                        fontWeight: FontWeight.w600,
                      ),
                    ),
                  ),
                  GestureDetector(
                    onTap: () {},
                    child: Padding(
                        padding: const EdgeInsets.symmetric(
                            vertical: 8.0, horizontal: 5),
                        child: PinCodeTextField(
                          appContext: context,
                          pastedTextStyle: const TextStyle(
                            color: Colors.white,
                            fontWeight: FontWeight.bold,
                          ),
                          length: 5,
                          obscureText: false,
                          obscuringCharacter: '*',
                          autoDismissKeyboard: true,
                          blinkWhenObscuring: false,
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          textStyle: const TextStyle(color: Colors.white),
                          animationType: AnimationType.fade,
                          autoDisposeControllers: false,
                          pinTheme: PinTheme(
                            shape: PinCodeFieldShape.box,
                            borderRadius: BorderRadius.circular(5),
                            fieldHeight: 50,
                            fieldWidth: 40,
                            activeFillColor: Colors.white,
                            activeColor: Colors.white,
                            disabledColor: Colors.white,
                            errorBorderColor: Colors.black,
                            inactiveColor: colorFontUnable116116116,
                            selectedColor: Colors.white,
                          ),
                          cursorColor: Colors.white,
                          animationDuration: const Duration(milliseconds: 300),
                          controller: codeController,
                          keyboardType: TextInputType.number,
                          onCompleted: (code) {
                            if (resultCode == codeController.text) {
                              Navigator.pop(context);
                              showCustomDialog(
                                  context, const _ConfirmEmailSuccess());
                              customerRegisterController.verifyValidProp([
                                'name',
                                'email',
                              ], [
                                name,
                                email
                              ]);
                            } else {
                              showSnackBar(context, 'Código incorreto');
                            }
                          },
                          onChanged: (value) {
                            debugPrint(value);
                          },
                        )),
                  ),
                  Padding(
                    padding: const EdgeInsets.only(top: 20),
                    child: Text(
                      textAlign: TextAlign.center,
                      'Não encontrou? Confira a aba de Promoções ou Spam do seu e-mail',
                      style: TextStyle(
                        color: colorFontUnable116116116,
                        fontSize: 15,
                      ),
                    ),
                  ),
                ],
              ),
            ),
          ),
        );
      },
    );
  }
}

class _ConfirmEmailSuccess extends StatelessWidget {
  const _ConfirmEmailSuccess({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final size = MediaQuery.of(context).size;

    return SizedBox(
      width: 250,
      child: AlertDialog(
        alignment: Alignment.center,
        shape: const RoundedRectangleBorder(
          borderRadius: BorderRadius.all(
            Radius.circular(32.0),
          ),
        ),
        scrollable: true,
        backgroundColor: colorContainers242424,
        title: const SizedBox(
          width: 250,
          child: Text(
            textAlign: TextAlign.center,
            'Email confirmado com sucesso!',
            style: TextStyle(color: Colors.white),
          ),
        ),
        content: const Icon(
          Icons.check_circle_rounded,
          color: Colors.white,
          size: 80,
        ),
        actions: <Widget>[
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceEvenly,
            children: [
              ElevatedButton(
                style: ButtonStyle(
                  overlayColor: MaterialStateProperty.all<Color>(
                    colorContainers353535,
                  ),
                  backgroundColor:
                      MaterialStateProperty.all<Color>(colorContainers353535),
                  shape: MaterialStateProperty.all<RoundedRectangleBorder>(
                    RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(15),
                    ),
                  ),
                ),
                child: const Padding(
                  padding: EdgeInsets.symmetric(horizontal: 25),
                  child: Text(
                    'Ok',
                    style: TextStyle(color: Colors.white),
                  ),
                ),
                onPressed: () => navigationWithFadeAnimation(
                    const RegistrationPageClientSecondWeb(), context),
              )
            ],
          ),
        ],
      ),
    );
  }
}
