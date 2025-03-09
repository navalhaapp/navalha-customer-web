// Developer            Data              Description
// Rovigo              22/08/2022         register page 1 creation  (client).
// Vitor               05/01/2023         creating create customer controller

// ignore_for_file: use_build_context_synchronously

import 'package:email_validator/email_validator.dart';
import 'package:flutter/material.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:navalha/core/colors.dart';
import 'package:navalha/mobile-DEPRECIATED/register/provider/provider_auth_email.dart';
import 'package:navalha/shared/animation/page_trasition.dart';
import '../../shared/shows_dialogs/dialog.dart';
import '../../shared/utils.dart';
import '../../shared/widgets/text_edit.dart';
import 'provider/register_customer_provider.dart';
import 'registration_page_client_second.dart';
import 'package:pin_code_fields/pin_code_fields.dart';

class RegistrationPageClient extends StatefulHookConsumerWidget {
  const RegistrationPageClient({super.key});

  @override
  ConsumerState<RegistrationPageClient> createState() =>
      _RegistrationPageClientState();
  static const route = '/register-page';
}

class _RegistrationPageClientState
    extends ConsumerState<RegistrationPageClient> {
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
        appBar: AppBar(
          backgroundColor: Colors.transparent,
          elevation: 0,
        ),
        body: Column(
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            TextEditPattern(
              margin: EdgeInsets.symmetric(
                horizontal: MediaQuery.of(context).size.width * 0.03,
              ),
              width: MediaQuery.of(context).size.width,
              maxLength: 50,
              controller: nameEditController,
              label: 'Nome completo',
              hint: 'Digite o nome',
              obscure: false,
              keyboardType: TextInputType.name,
            ),
            TextEditPattern(
              width: MediaQuery.of(context).size.width,
              maxLength: 300,
              controller: emailEditController,
              label: 'Email',
              hint: 'Digite o Email',
              obscure: false,
              keyboardType: TextInputType.emailAddress,
            ),
          ],
        ),
        floatingActionButton: Consumer(
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
                } else if (RegExp(r"[0-9]").hasMatch(nameEditController.text)) {
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
                } else if (!EmailValidator.validate(emailEditController.text)) {
                  showSnackBar(context, 'Digite um email válido');
                } else if (emailEditController.text
                    .toLowerCase()
                    .contains('icloud')) {
                  showSnackBar(
                    context,
                    'Não é possível usar e-mails do iCloud para confirmação no momento. Por favor, utilize outro provedor como Gmail ou Outlook.',
                  );
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
                    showSnackBar(context, 'Esse email já foi cadastrado!');
                  } else {
                    showSnackBar(context, 'Ops, algo aconteceu!');
                  }
                }
              },
            );
          },
        ),
      ),
    );
  }

  Widget setUpButtonChild() {
    if (_state == 0) {
      return const Icon(Icons.navigate_next, color: Colors.white, size: 45);
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
        return AlertDialog(
          alignment: Alignment.center,
          shape: const RoundedRectangleBorder(
            borderRadius: BorderRadius.all(
              Radius.circular(32.0),
            ),
          ),
          scrollable: true,
          backgroundColor: colorContainers242424,
          content: Column(
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

    return AlertDialog(
      alignment: Alignment.center,
      shape: const RoundedRectangleBorder(
        borderRadius: BorderRadius.all(
          Radius.circular(32.0),
        ),
      ),
      scrollable: true,
      backgroundColor: colorContainers242424,
      title: SizedBox(
        width: size.width * 0.6,
        child: const Text(
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
                  const RegistrationPageClientSecond(), context),
            )
          ],
        ),
      ],
    );
  }
}
