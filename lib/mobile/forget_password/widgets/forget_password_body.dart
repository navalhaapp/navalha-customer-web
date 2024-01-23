// ignore_for_file: use_build_context_synchronously

import 'package:flutter/material.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';

import '../../../core/colors.dart';
import '../../login/login_page.dart';
import '../../../shared/animation/page_trasition.dart';
import '../../../shared/shows_dialogs/dialog.dart';
import 'form_field_email.dart';

class ForgetPasswordBody extends StatefulWidget {
  const ForgetPasswordBody({Key? key}) : super(key: key);

  @override
  State<ForgetPasswordBody> createState() => _ForgetPasswordBodyState();
}

class _ForgetPasswordBodyState extends State<ForgetPasswordBody> {
  final TextEditingController emailController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    final size = MediaQuery.of(context).size;
    return Column(
      children: [
        Icon(
          Icons.lock,
          size: size.width * 0.3,
          color: Colors.white,
        ),
        const Padding(
          padding: EdgeInsets.symmetric(horizontal: 20),
          child: Text(
            textAlign: TextAlign.center,
            'Informe seu e-mail para que possamos enviar informações de como recuperar a sua senha',
            style: TextStyle(
              color: Colors.white,
              fontSize: 17,
            ),
          ),
        ),
        FormFieldEmail(hint: 'E-mail do cadastro', controller: emailController),
        // SizedBox(height: size.height * 0.3),
        Consumer(
          builder: (context, ref, child) {
            return _FloatingForget(
              onPressed: () {
                showCustomDialog(
                  context,
                  _ForgetDialog(
                    addresEmail: emailController.text,
                  ),
                );
              },
            );
          },
        ),
      ],
    );
  }
}

class _FloatingForget extends StatelessWidget {
  const _FloatingForget({
    Key? key,
    required this.onPressed,
  }) : super(key: key);

  final Function onPressed;

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
          elevation: MaterialStateProperty.all(15),
          backgroundColor:
              MaterialStateProperty.all<Color>(colorContainers242424),
          shape: MaterialStateProperty.all<RoundedRectangleBorder>(
            RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(15),
            ),
          ),
        ),
        child: Padding(
          padding: EdgeInsets.symmetric(horizontal: size.width * 0.1),
          child: const Text(
            'Enviar',
            style: TextStyle(color: Colors.white),
          ),
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
      backgroundColor: const Color.fromARGB(150, 0, 0, 0),
      title: SizedBox(
        width: size.width * 0.6,
        child: Column(
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
                fontSize: 15,
              ),
            ),
          ],
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
                backgroundColor: MaterialStateProperty.all<Color>(
                    const Color.fromARGB(255, 24, 24, 24)),
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
                navigationWithFadeAnimation(const LoginPage(), context);
              },
            )
          ],
        ),
      ],
    );
  }
}
