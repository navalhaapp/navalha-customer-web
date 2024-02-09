// ignore_for_file: use_build_context_synchronously

import 'dart:html';

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:url_launcher/url_launcher.dart';

import 'package:navalha/core/assets.dart';
import 'package:navalha/core/colors.dart';
import 'package:navalha/mobile/login/controller/login_controller.dart';
import 'package:navalha/mobile/payment/provider/provider_refresh.dart';
import 'package:navalha/shared/animation/page_trasition.dart';
import 'package:navalha/web/appointment/widgets/calendar_page_web.dart';
import 'package:navalha/web/appointment/widgets/login_page_web.dart';
import 'package:navalha/web/appointment/widgets/services_page_web.dart';
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
        color: colorBackground181818,
        borderRadius: const BorderRadius.only(
          bottomRight: Radius.circular(25),
          topRight: Radius.circular(25),
        ),
      ),
      width: 250,
      child: Consumer(
        builder: (context, ref, child) {
          final loginController =
              ref.read(LoginStateController.provider.notifier);
          final refresh = ref.watch(RefreshStateController.provider.notifier);
          return SingleChildScrollView(
            child: Column(
              mainAxisAlignment: MainAxisAlignment.start,
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                _ImageProfile(
                  imgProfile: loginController.user?.customer?.imgProfile ??
                      imgProfileDefaultS3,
                  nameUser: getFirstName(
                      loginController.user?.customer?.name ?? 'Usuário'),
                  adressEmail: loginController.user?.customer == null
                      ? ''
                      : loginController.user!.customer!.email!
                              .contains('appleid.com')
                          ? ''
                          : loginController.user!.customer!.email!,
                ),
                _ButtonItem(
                  label: 'Reservar',
                  onPressed: () {
                    Navigator.of(context).pushNamed('/');
                  },
                  icon: CupertinoIcons.calendar_badge_plus,
                ),
                _ButtonItem(
                  label: 'Minha agenda',
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
                  label: 'Sair',
                  onPressed: () async {
                    loginController.user = null;
                    navigationWithFadeAnimation(const LoginPageWeb(), context);
                  },
                  icon: Icons.exit_to_app_rounded,
                ),
              ],
            ),
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
          ),
          const SizedBox(width: 30),
          Text(
            label,
            style: TextStyle(
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
            width: 120,
            height: 120,
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
                padding: const EdgeInsets.only(left: 20),
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
