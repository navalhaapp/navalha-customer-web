import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:navalha/core/assets.dart';
import 'package:navalha/mobile-DEPRECIATED/login/login_page.dart';
import 'package:navalha/mobile-DEPRECIATED/login/widgets/back_ground_login_top.dart';
import 'package:navalha/mobile-DEPRECIATED/login/widgets/row_social_networks_google.dart';
import 'package:navalha/mobile-DEPRECIATED/register/registration_page_client.dart';
import 'package:navalha/shared/animation/page_trasition.dart';

class RegistrationTypesBody extends StatelessWidget {
  const RegistrationTypesBody({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    Size size = MediaQuery.of(context).size;
    return SingleChildScrollView(
      child: Center(
        child: Stack(
          alignment: Alignment.center,
          children: [
            Column(
              mainAxisAlignment: MainAxisAlignment.start,
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                const BackgroundLoginTop(),
                SizedBox(height: size.height * .05),
                Padding(
                  padding: EdgeInsets.only(
                    bottom: size.width * .04,
                  ),
                  child: const Text(
                    'Ou',
                    style: TextStyle(color: Colors.white),
                  ),
                ),
                const RowSocialNetworks(),
                Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    const Text(
                      'Já possui conta?',
                      style: TextStyle(
                        color: Colors.white,
                      ),
                    ),
                    TextButton(
                      onPressed: () {
                        navigationWithFadeAnimation(const LoginPage(), context);
                      },
                      style: ButtonStyle(
                        overlayColor:
                            MaterialStateProperty.all(Colors.transparent),
                      ),
                      child: const Text(
                        'Fazer login',
                        style: TextStyle(
                          color: Colors.white,
                        ),
                      ),
                    ),
                  ],
                ),
              ],
            ),
            Positioned(
              top: size.height < 700 ? size.height * .02 : size.height * .05,
              child: SizedBox(
                width: size.width * 0.9,
                child: Image.asset(
                  logoBrancaCustomer,
                  fit: BoxFit.fitHeight,
                ),
              ),
            ),
            Positioned(
              top: size.height * 0.3,
              width: size.width,
              child: Padding(
                padding: EdgeInsets.symmetric(
                  horizontal: MediaQuery.of(context).size.width * .05,
                ),
                child: GestureDetector(
                  onTap: () => navigationWithFadeAnimation(
                      const RegistrationPageClient(), context),
                  child: Container(
                    margin: EdgeInsets.only(
                      bottom: size.height * .015,
                    ),
                    decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(15),
                      color: Colors.white,
                    ),
                    height: size.height * .06,
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.start,
                      children: [
                        SizedBox(width: size.width * 0.18),
                        const Icon(
                          CupertinoIcons.mail_solid,
                          color: Colors.white,
                        ),
                        SizedBox(
                          width: size.width * .05,
                        ),
                        Text(
                          'Continuar com Email',
                          style: TextStyle(
                            color: Colors.black,
                            fontWeight: FontWeight.bold,
                            fontSize: size.height * .02,
                          ),
                        ),
                      ],
                    ),
                  ),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
