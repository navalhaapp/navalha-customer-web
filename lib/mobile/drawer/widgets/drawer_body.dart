// ignore_for_file: use_build_context_synchronously

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:google_sign_in/google_sign_in.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:navalha/mobile/calendar/calendar_page.dart';
import 'package:navalha/mobile/change_password/change_password_page.dart';
import 'package:navalha/core/assets.dart';
import 'package:navalha/core/colors.dart';
import 'package:navalha/mobile/edit_profile/edit_profile_page.dart';
import 'package:navalha/mobile/faq/faq_page.dart';
import 'package:navalha/mobile/home/home_page.dart';
import 'package:navalha/mobile/login/login_page.dart';
import 'package:navalha/mobile/login/model/auth_model.dart';
import 'package:navalha/shared/animation/page_trasition.dart';
import 'package:navalha/shared/onboarding/onboarding_page.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:url_launcher/url_launcher.dart';
import '../../../core/images_s3.dart';
import '../../delete_account/delete_account_page.dart';
import '../../login/controller/login_controller.dart';
import '../../my_packages/my_packages_page.dart';
import '../../payment/provider/provider_refresh.dart';
import '../../../shared/shimmer/shimmer_top_container.dart';
import '../../../shared/utils.dart';

class DrawerBody extends StatelessWidget {
  const DrawerBody({
    Key? key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final GoogleSignIn googleSignIn = GoogleSignIn();
    signOutWithGoogle() async {
      await googleSignIn.signOut();
    }

    Size size = MediaQuery.of(context).size;
    return Container(
      height: size.height,
      padding: EdgeInsets.only(top: size.height * 0.05),
      decoration: BoxDecoration(
        color: colorBackground181818,
        borderRadius: const BorderRadius.only(
          bottomLeft: Radius.circular(25),
          topLeft: Radius.circular(25),
        ),
      ),
      width: size.width * 0.8,
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
                  label: 'Editar perfil',
                  onPressed: () => navigationWithFadeAnimation(
                      const EditProfilePage(), context),
                  icon: CupertinoIcons.person_alt_circle,
                ),
                _ButtonItem(
                  label: 'Minha agenda',
                  onPressed: () async {
                    if (loginController.user == null) {
                      navigationWithFadeAnimation(
                          const CalendarPage(), context);
                    } else {
                      navigationWithFadeAnimation(
                          const ShimmerTopContainer(), context);
                      AuthCustomer response = await refresh.refresh(
                        loginController.user!.customer!.customerId!,
                        loginController.user!.token!,
                      );
                      if (response.status == 'success') {
                        loginController.user!.customer = response.customer!;
                        Navigator.pop(context);
                        navigationWithFadeAnimation(
                            const CalendarPage(), context);
                      } else {
                        Navigator.pop(context);
                        showSnackBar(context, 'Ops, algo aconteceu');
                      }
                    }
                  },
                  icon: CupertinoIcons.calendar,
                ),
                _ButtonItem(
                  label: 'Meus pacotes',
                  onPressed: () async {
                    if (loginController.user == null) {
                      navigationWithFadeAnimation(
                          const MyPackagesPage(), context);
                    } else {
                      navigationWithFadeAnimation(
                          const ShimmerTopContainer(), context);
                      AuthCustomer response = await refresh.refresh(
                        loginController.user!.customer!.customerId!,
                        loginController.user!.token!,
                      );
                      if (response.status == 'success') {
                        loginController.user!.customer = response.customer!;
                        Navigator.pop(context);
                        navigationWithFadeAnimation(
                            const MyPackagesPage(), context);
                      } else {
                        Navigator.pop(context);
                        showSnackBar(context, 'Ops, algo aconteceu');
                      }
                    }
                  },
                  icon: CupertinoIcons.collections_solid,
                ),
                _ButtonItem(
                  label: 'Página navalha',
                  onPressed: () => _launchUrl(),
                  icon: Icons.phone_iphone_rounded,
                ),
                _ButtonItem(
                  label: 'Dúvidas frequentes',
                  onPressed: () =>
                      navigationWithFadeAnimation(const FaqPage(), context),
                  icon: CupertinoIcons.headphones,
                ),
                _ButtonItem(
                  label: 'Onboarding',
                  onPressed: () => navigationWithFadeAnimation(
                    OnBoarding(
                      onBoardManagerImages: onboardingList(context),
                      homePage: const HomePage(),
                    ),
                    context,
                  ),
                  icon: CupertinoIcons.collections_solid,
                ),
                Container(
                  margin: const EdgeInsets.only(bottom: 20, top: 10),
                  decoration: const BoxDecoration(
                    border: Border(
                      bottom: BorderSide(
                        color: Colors.white,
                        width: 2,
                      ),
                    ),
                  ),
                ),
                loginController.user?.customer == null
                    ? const SizedBox()
                    : Visibility(
                        visible:
                            !loginController.user!.customer!.externalAccount!,
                        child: _ButtonItem(
                          label: 'Trocar senha',
                          onPressed: () => navigationWithFadeAnimation(
                              ChangePasswordPage(), context),
                          icon: CupertinoIcons.lock_shield,
                        ),
                      ),
                Visibility(
                  visible: loginController.user?.customer == null,
                  replacement: _ButtonItem(
                    label: 'Excluir conta',
                    onPressed: () => navigationWithFadeAnimation(
                        const DeleteAccountPage(), context),
                    icon: CupertinoIcons.delete,
                  ),
                  child: const SizedBox(),
                ),
                _ButtonItem(
                  label: 'Sair',
                  onPressed: () async {
                    signOutWithGoogle();
                    SharedPreferences prefs =
                        await SharedPreferences.getInstance();
                    await prefs.setString('email', '');
                    await prefs.setString('password', '');
                    loginController.user = null;
                    navigationWithFadeAnimation(const LoginPage(), context);
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
            size: size.width * 0.06,
          ),
          const SizedBox(width: 30),
          Text(
            label,
            style: TextStyle(
              color: Colors.white,
              fontSize: size.width * 0.04,
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
            width: MediaQuery.of(context).size.width * 0.2,
            height: MediaQuery.of(context).size.width * 0.2,
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
        SizedBox(height: MediaQuery.of(context).size.width * 0.02),
        Padding(
          padding: const EdgeInsets.only(left: 20, right: 10),
          child: Text(
            nameUser.contains(' ')
                ? nameUser.substring(0, nameUser.indexOf(' '))
                : nameUser,
            style: const TextStyle(
              color: Colors.white,
              fontSize: 25,
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
