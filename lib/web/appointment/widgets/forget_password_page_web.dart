// ignore_for_file: use_build_context_synchronously

import 'package:flutter/material.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:navalha/core/colors.dart';
import 'package:navalha/mobile/forget_password/provider/provider_reset_password.dart';
import 'package:navalha/mobile/forget_password/widgets/form_field_email.dart';
import 'package:navalha/mobile/login/login_page.dart';
import 'package:navalha/shared/animation/page_trasition.dart';
import 'package:navalha/shared/shows_dialogs/dialog.dart';
import 'package:navalha/shared/utils.dart';
import 'package:navalha/web/appointment/widgets/login_page_web.dart';

class ForgetPasswordPageWeb extends StatefulWidget {
  static const route = '/forget-password-page';

  const ForgetPasswordPageWeb({Key? key}) : super(key: key);

  @override
  State<ForgetPasswordPageWeb> createState() => _ForgetPasswordPageWebState();
}

class _ForgetPasswordPageWebState extends State<ForgetPasswordPageWeb> {
  final TextEditingController emailController = TextEditingController();

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
                          final adressEmail = await resetPasswordController
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
                            showCustomDialog(
                              context,
                              _ForgetDialog(
                                addresEmail: emailController.text,
                              ),
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
      margin: EdgeInsets.only(bottom: size.height * .02),
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

class _ForgetDialog extends StatelessWidget {
  const _ForgetDialog({
    Key? key,
    required this.addresEmail,
  }) : super(key: key);

  final String addresEmail;
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
      backgroundColor: colorBackground181818,
      title: const Text(
        textAlign: TextAlign.center,
        'Sucesso!',
        style: TextStyle(
          color: Color.fromARGB(255, 255, 255, 255),
        ),
      ),
      content: Column(
        children: [
          const Text(
            textAlign: TextAlign.center,
            'Instruções enviadas para o e-mail: ',
            style: TextStyle(
              color: Color.fromARGB(255, 192, 192, 192),
              fontSize: 15,
            ),
          ),
          const SizedBox(height: 10),
          Text(
            textAlign: TextAlign.center,
            addresEmail,
            style: const TextStyle(
              color: Colors.white,
              fontWeight: FontWeight.w600,
              fontSize: 15,
            ),
          ),
          const SizedBox(height: 10),
          const Icon(
            Icons.check_circle_rounded,
            color: Colors.white,
            size: 80,
          ),
        ],
      ),
      actions: <Widget>[
        Row(
          mainAxisAlignment: MainAxisAlignment.spaceEvenly,
          children: [
            SizedBox(
              width: size.width * 0.3,
              child: ElevatedButton(
                style: ButtonStyle(
                  overlayColor: MaterialStateProperty.all<Color>(
                    colorContainers353535,
                  ),
                  backgroundColor:
                      MaterialStateProperty.all<Color>(colorContainers242424),
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
                onPressed: () {
                  navigationWithFadeAnimation(const LoginPageWeb(), context);
                },
              ),
            )
          ],
        ),
      ],
    );
  }
}
