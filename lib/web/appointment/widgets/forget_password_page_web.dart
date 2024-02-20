// ignore_for_file: use_build_context_synchronously

import 'package:flutter/material.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:navalha/core/colors.dart';
import 'package:navalha/mobile/forget_password/model/reset_password_model.dart';
import 'package:navalha/mobile/forget_password/provider/provider_reset_password.dart';
import 'package:navalha/mobile/forget_password/widgets/form_field_email.dart';
import 'package:navalha/shared/animation/page_trasition.dart';
import 'package:navalha/shared/utils.dart';
import 'package:navalha/shared/widgets/header_button_sheet_pattern.dart';
import 'package:navalha/web/appointment/reset_page/reset_page.dart';
import 'package:pin_code_fields/pin_code_fields.dart';

class ForgetPasswordPageWeb extends StatefulWidget {
  static const route = '/forget-password-page';

  const ForgetPasswordPageWeb({Key? key}) : super(key: key);

  @override
  State<ForgetPasswordPageWeb> createState() => _ForgetPasswordPageWebState();
}

class _ForgetPasswordPageWebState extends State<ForgetPasswordPageWeb> {
  final TextEditingController emailController = TextEditingController();
  final TextEditingController codeController = TextEditingController();
  int _state = 0;

  @override
  Widget build(BuildContext context) {
    final size = MediaQuery.of(context).size;
    return SafeArea(
      top: false,
      child: Scaffold(
        appBar: AppBar(
          elevation: 0,
          leading: IconButton(
              icon: const Icon(Icons.arrow_back_ios_new, size: 17),
              onPressed: () {
                Navigator.pop(context);
              }),
          backgroundColor: Colors.transparent,
          title: const Text('Recuperar senha'),
          centerTitle: true,
        ),
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
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Column(
                  children: [
                    SizedBox(height: size.height * 0.02),
                    const Icon(
                      Icons.lock,
                      size: 80,
                      color: Colors.white,
                    ),
                    SizedBox(height: size.height * 0.02),
                    const Padding(
                      padding: EdgeInsets.symmetric(horizontal: 20),
                      child: Text(
                        textAlign: TextAlign.center,
                        'Informe seu email para que possamos enviar informações de como recuperar a sua senha',
                        style: TextStyle(
                          color: Colors.white,
                          fontSize: 17,
                        ),
                      ),
                    ),
                    SizedBox(height: size.height * 0.02),
                    FormFieldEmail(
                      maxLength: 300,
                      hint: 'Email do cadastro',
                      controller: emailController,
                    ),
                  ],
                ),
                Consumer(
                  builder: (context, ref, child) {
                    final resetPasswordController = ref
                        .read(ResetPasswordStateController.provider.notifier);
                    return _FloatingForget(
                      child: setUpButtonChild(),
                      onPressed: () async {
                        setState(() {
                          _state = 1;
                        });
                        if (emailController.text.length > 3) {
                          ResetPasswordModel adressEmail =
                              await resetPasswordController
                                  .resetPassword(emailController.text.trim());
                          setState(() {
                            _state = 0;
                          });
                          if (adressEmail.result == 'not_found') {
                            showSnackBar(context, 'E-mail não encontrado');

                            setState(() {
                              _state = 0;
                            });
                          } else if (adressEmail.status == 'success') {
                            print(adressEmail.result!.verificationCode);
                            showModalBottomSheet(
                              context: context,
                              builder: (BuildContext context) {
                                return _ConfirmEmailBottonSheet(
                                  customerId: adressEmail.result!.customerId!,
                                  resultCode:
                                      adressEmail.result!.verificationCode!,
                                  email: emailController.text.trim(),
                                  codeController: codeController,
                                );
                              },
                            );

                            setState(() {
                              _state = 2;
                            });
                          } else {
                            if (adressEmail.result ==
                                'external_account_cant_reset_password') {
                              showSnackBar(
                                context,
                                'Este e-mail foi criado usando o Google, portanto, não é possível alterá-lo por aqui.',
                              );
                            }
                          }
                        } else {
                          showSnackBar(context, 'Digite um email válido');
                          setState(() {
                            _state = 0;
                          });
                        }
                      },
                    );
                  },
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
      return const Text('Enviar', style: TextStyle(color: Colors.white));
    } else if (_state == 1) {
      return const CircularProgressIndicator(
        valueColor: AlwaysStoppedAnimation<Color>(Colors.white),
        strokeWidth: 2,
      );
    } else {
      return const Icon(Icons.check, color: Colors.white, size: 43);
    }
  }
}

class _FloatingForget extends StatelessWidget {
  const _FloatingForget({
    Key? key,
    required this.onPressed,
    required this.child,
  }) : super(key: key);

  final Function onPressed;
  final Widget child;

  @override
  Widget build(BuildContext context) {
    final size = MediaQuery.of(context).size;
    return Container(
      margin: EdgeInsets.only(bottom: size.height * .02, left: 20, right: 20),
      width: size.width * 0.9,
      height: 50,
      child: ElevatedButton(
        style: ButtonStyle(
          overlayColor: MaterialStateProperty.all<Color>(
            colorContainers353535,
          ),
          elevation: MaterialStateProperty.all(0),
          backgroundColor:
              MaterialStateProperty.all<Color>(colorContainers353535),
          shape: MaterialStateProperty.all<RoundedRectangleBorder>(
            RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(15),
            ),
          ),
        ),
        child: Padding(
          padding: EdgeInsets.symmetric(horizontal: size.width * 0.1),
          child: child,
        ),
        onPressed: () => onPressed(),
      ),
    );
  }
}

class _ConfirmEmailBottonSheet extends StatelessWidget {
  const _ConfirmEmailBottonSheet({
    Key? key,
    required this.codeController,
    required this.email,
    required this.resultCode,
    required this.customerId,
  }) : super(key: key);

  final TextEditingController codeController;
  final String email;
  final String resultCode;
  final String customerId;

  @override
  Widget build(BuildContext context) {
    final size = MediaQuery.of(context).size;
    return SafeArea(
      child: Container(
        decoration: BoxDecoration(
          color: colorBackground181818,
          borderRadius: const BorderRadius.only(
            topLeft: Radius.circular(15),
            topRight: Radius.circular(15),
          ),
        ),
        child: Padding(
          padding: const EdgeInsets.all(22),
          child: Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              const HeaderBottonSheetPattern(),
              const Padding(
                padding: EdgeInsets.all(8.0),
                child: Text(
                  'Por favor, digite o codigo que enviamos para:',
                  textAlign: TextAlign.center,
                  style: TextStyle(
                    color: Color.fromARGB(255, 204, 204, 204),
                    fontSize: 17,
                  ),
                ),
              ),
              Padding(
                padding: const EdgeInsets.only(top: 0),
                child: Text(
                  email,
                  textAlign: TextAlign.center,
                  style: const TextStyle(
                    color: Colors.white,
                    fontSize: 17,
                    fontWeight: FontWeight.w600,
                  ),
                ),
              ),
              GestureDetector(
                onTap: () {},
                child: SizedBox(
                  width: 250,
                  child: Padding(
                    padding: const EdgeInsets.symmetric(vertical: 30),
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
                          Navigator.pushNamed(context, '/reset-password',
                              arguments: {
                                'customer_id': customerId,
                              });
                          showSnackBar(context, 'Email confirmado!');
                          codeController.dispose();
                        } else {
                          Navigator.pop(context);
                          showSnackBar(context, 'Código incorreto');
                        }
                      },
                      onChanged: (value) {
                        debugPrint(value);
                      },
                    ),
                  ),
                ),
              ),
              Padding(
                padding: const EdgeInsets.only(left: 20, right: 20),
                child: Text(
                  'Não encontrou? Confira a aba de Promoções ou Spam do seu e-mail',
                  textAlign: TextAlign.center,
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
  }
}
