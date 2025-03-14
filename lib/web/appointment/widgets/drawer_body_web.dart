// ignore_for_file: use_build_context_synchronously

import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:google_sign_in/google_sign_in.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:navalha/web/db/db_customer_shared.dart';
import 'package:navalha/web/db/db_resume_last_page.dart';
import 'package:url_launcher/url_launcher.dart';
import 'package:navalha/core/assets.dart';
import 'package:navalha/core/colors.dart';
import '../../../core/images_s3.dart';
import '../../../shared/utils.dart';

class DrawerBodyWeb extends StatelessWidget {
  const DrawerBodyWeb({
    Key? key,
    required this.barberShopId,
  }) : super(key: key);

  final String barberShopId;

  @override
  Widget build(BuildContext context) {
    Size size = MediaQuery.of(context).size;
    return Container(
      height: size.height,
      padding: EdgeInsets.only(top: size.height * 0.05),
      decoration: BoxDecoration(
        color: colorContainers242424,
        borderRadius: const BorderRadius.only(
          bottomRight: Radius.circular(20),
          topRight: Radius.circular(20),
        ),
      ),
      width: 250,
      child: Consumer(
        builder: (context, ref, child) {
          CustomerDB? retrievedCustomer = LocalStorageManager.getCustomer();
          return Column(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Column(
                mainAxisAlignment: MainAxisAlignment.start,
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Visibility(
                    visible: retrievedCustomer != null,
                    child: _ImageProfile(
                      imgProfile:
                          retrievedCustomer?.image ?? imgProfileDefaultS3,
                      nameUser:
                          getFirstName(retrievedCustomer?.name ?? ''),
                      adressEmail: retrievedCustomer == null
                          ? ''
                          : retrievedCustomer.email.contains('appleid.com')
                              ? ''
                              : retrievedCustomer.email,
                    ),
                  ),
                  _ButtonItem(
                    label: 'Reservar',
                    onPressed: () {
                      Navigator.of(context).pushNamed('/');
                    },
                    icon: CupertinoIcons.calendar_badge_plus,
                  ),
                  _ButtonItem(
                    label: 'Meus agendamentos',
                    onPressed: () async {
                      Navigator.of(context).pushNamed('/calendar');
                    },
                    icon: CupertinoIcons.calendar,
                  ),
                  _ButtonItem(
                    label: 'Página navalha',
                    onPressed: () => _launchUrl(),
                    icon: Icons.phone_iphone_rounded,
                  ),
                  _ButtonItem(
                    label: retrievedCustomer == null
                        ? 'Entrar na sua conta'
                        : 'Sair',
                    onPressed: () async {
                      // final GoogleSignIn _googleSignIn = GoogleSignIn(
                      //     // clientId:
                      //     //     '503923325128-ms8brondqnsrld6bu5vcptsireonda6t.apps.googleusercontent.com',
                      //     );
                      // await _googleSignIn.disconnect();
                      // await _googleSignIn.signOut();
                      LocalStorageManagerLastPage.saveResumeLastPage(
                          ResumeLastPage(false));
                      LocalStorageManager.clearCustomer();
                      Navigator.of(context).pushNamed('/login');
                    },
                    icon: Icons.exit_to_app_rounded,
                  ),
                ],
              ),
              SizedBox(
                height: 50,
                child: Image.asset(
                  logoBrancaCustomer,
                  fit: BoxFit.contain,
                ),
              ),
            ],
          );
        },
      ),
    );
  }
}

class _ButtonItem extends StatelessWidget {
  final String label;
  final Function onPressed;
  final IconData icon;

  const _ButtonItem({
    Key? key,
    required this.label,
    required this.onPressed,
    required this.icon,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    Size size = MediaQuery.of(context).size;
    return MaterialButton(
      padding: const EdgeInsets.symmetric(vertical: 15, horizontal: 20),
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(10),
      ),
      elevation: 5,
      minWidth: size.width * 0.6,
      height: size.height * 0.05,
      onPressed: () => onPressed(),
      child: Row(
        children: [
          Icon(
            icon,
            color: Colors.white,
            size: 20,
          ),
          const SizedBox(width: 10),
          Text(
            label,
            style: const TextStyle(
              color: Colors.white,
            ),
          ),
        ],
      ),
    );
  }
}

class _ImageProfile extends StatelessWidget {
  final String nameUser;
  final String adressEmail;
  final String imgProfile;

  const _ImageProfile({
    Key? key,
    required this.nameUser,
    required this.adressEmail,
    required this.imgProfile,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Padding(
          padding: const EdgeInsets.only(left: 20),
          child: Container(
            padding: EdgeInsets.zero,
            width: 80,
            height: 80,
            child: ClipRRect(
              borderRadius: BorderRadius.circular(1000),
              child: FadeInImage.assetNetwork(
                placeholder: imgLoading3,
                image: imgProfile,
                fit: BoxFit.cover,
                fadeInDuration: const Duration(milliseconds: 500),
                fadeInCurve: Curves.easeIn,
              ),
            ),
          ),
        ),
        const SizedBox(height: 20),
        Padding(
          padding: const EdgeInsets.only(left: 20, right: 10),
          child: Text(
            nameUser.contains(' ')
                ? nameUser.substring(0, nameUser.indexOf(' '))
                : nameUser,
            style: const TextStyle(
              color: Colors.white,
            ),
          ),
        ),
        adressEmail == ""
            ? const SizedBox()
            : Padding(
                padding: const EdgeInsets.only(left: 20, right: 10),
                child: Text(
                  adressEmail,
                  style: const TextStyle(
                    color: Color.fromARGB(255, 163, 163, 163),
                    fontSize: 15,
                  ),
                ),
              ),
        Container(
          margin: const EdgeInsets.only(top: 20),
          decoration: const BoxDecoration(
            border: Border(
              bottom: BorderSide(
                color: Colors.white,
                width: 0.2,
              ),
            ),
          ),
        ),
      ],
    );
  }
}

final Uri _url = Uri.parse('https://navalha.app.br');

Future<void> _launchUrl() async {
  if (!await launchUrl(_url)) {
    throw Exception('Could not launch $_url');
  }
}
