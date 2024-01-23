import 'package:flutter/material.dart';

import 'package:navalha/mobile/login/login_page.dart';
import 'package:navalha/mobile/register/registration_page_client.dart';
import 'package:navalha/shared/animation/page_trasition.dart';

import '../../../core/assets.dart';
import '../../../core/colors.dart';
import '../../login/widgets/back_ground_login_top.dart';

class CustomerRegistrationBody extends StatelessWidget {
  const CustomerRegistrationBody({
    Key? key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    Size size = MediaQuery.of(context).size;
    return SingleChildScrollView(
      child: Center(
        child: Stack(
          alignment: Alignment.center,
          children: [
            Column(
              children: [
                const BackgroundLoginTop(),
                Padding(
                  padding: EdgeInsets.only(
                    top: size.height * 0.05,
                    bottom: size.height * 0.02,
                  ),
                  child: const Text(
                    'Ou',
                    style: TextStyle(color: Colors.white),
                  ),
                ),
                ButtonRegisterSocial(
                  color: Colors.white,
                  image: Image.asset(imgLogoGoogle),
                  label: 'Registrar-se com o Google',
                  textColor: const Color.fromARGB(255, 0, 0, 0),
                  onPressed: () {},
                ),
                ButtonRegisterSocial(
                  color: const Color.fromARGB(255, 27, 119, 242),
                  image: Image.asset(imgLogoFacebook),
                  label: 'Registrar-se com o Facebook',
                  textColor: const Color.fromARGB(255, 0, 0, 0),
                  onPressed: () {},
                ),
                Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    const Text(
                      'Já possui conta?',
                      style: TextStyle(color: Colors.white, fontSize: 14),
                    ),
                    TextButton(
                      style: ButtonStyle(
                        overlayColor: MaterialStateColor.resolveWith(
                          (states) => Colors.transparent,
                        ),
                      ),
                      onPressed: () => navigationWithFadeAnimation(
                          const LoginPage(), context),
                      child: const Text('Fazer login'),
                    )
                  ],
                )
              ],
            ),
            Positioned(
              left: size.width * .3,
              top: size.height * .05,
              child: SizedBox(
                height: size.height * .22,
                child: Image.asset(
                  logoBrancaCustomer,
                  fit: BoxFit.fitHeight,
                ),
              ),
            ),
            Positioned(
              top: size.height * 0.3,
              child: ButtonRegister(
                onPressed: () => navigationWithFadeAnimation(
                    const RegistrationPageClient(), context),
                color: const Color.fromARGB(255, 255, 255, 255),
                icon: const Icon(Icons.mail_outlined),
                label: 'Registrar-se com um e-mail',
                textColor: const Color.fromARGB(255, 0, 0, 0),
              ),
            ),
          ],
        ),
      ),
    );
  }
}

class ButtonRegister extends StatelessWidget {
  const ButtonRegister({
    Key? key,
    required this.label,
    required this.icon,
    required this.color,
    required this.textColor,
    required this.onPressed,
  }) : super(key: key);

  final String label;
  final Icon icon;
  final Color color;
  final Color textColor;
  final Function onPressed;

  @override
  Widget build(BuildContext context) {
    Size size = MediaQuery.of(context).size;
    return GestureDetector(
      onTap: () => onPressed(),
      child: Container(
        margin: EdgeInsets.only(
          bottom: size.height * .015,
        ),
        decoration: BoxDecoration(
          boxShadow: shadow,
          borderRadius: BorderRadius.circular(15),
          color: color,
        ),
        height: size.height * .06,
        width: size.width * 0.9,
        child: Row(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            SizedBox(
              height: size.height * .022,
              child: icon,
            ),
            SizedBox(
              width: size.width * .05,
            ),
            Text(
              label,
              style: TextStyle(
                color: textColor,
                fontWeight: FontWeight.bold,
                fontSize: size.height * .02,
              ),
            ),
          ],
        ),
      ),
    );
  }
}

class ButtonRegisterSocial extends StatelessWidget {
  const ButtonRegisterSocial({
    Key? key,
    required this.label,
    required this.image,
    required this.color,
    required this.textColor,
    required this.onPressed,
  }) : super(key: key);

  final String label;
  final Image image;
  final Color color;
  final Color textColor;
  final Function onPressed;

  @override
  Widget build(BuildContext context) {
    Size size = MediaQuery.of(context).size;
    return GestureDetector(
      onTap: () => onPressed(),
      child: Container(
        margin: EdgeInsets.only(
          bottom: size.height * .015,
        ),
        decoration: BoxDecoration(
          boxShadow: shadow,
          borderRadius: BorderRadius.circular(15),
          color: color,
        ),
        height: size.height * .06,
        width: size.width * 0.9,
        child: Row(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            SizedBox(
              height: size.height * .022,
              child: image,
            ),
            SizedBox(
              width: size.width * .05,
            ),
            Text(
              label,
              style: TextStyle(
                color: textColor,
                fontWeight: FontWeight.bold,
                fontSize: size.height * .02,
              ),
            ),
          ],
        ),
      ),
    );
  }
}
