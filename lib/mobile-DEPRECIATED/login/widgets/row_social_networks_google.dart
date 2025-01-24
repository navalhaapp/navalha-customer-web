// ignore_for_file: use_build_context_synchronously

import 'dart:io';

import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:geolocator/geolocator.dart';
import 'package:google_sign_in/google_sign_in.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:sign_in_with_apple/sign_in_with_apple.dart';
import 'package:navalha/core/assets.dart';
import 'package:navalha/mobile-DEPRECIATED/home/home_page.dart';
import 'package:navalha/mobile-DEPRECIATED/login/controller/login_controller.dart';
import 'package:navalha/mobile-DEPRECIATED/login/login_page.dart';
import 'package:navalha/mobile-DEPRECIATED/login/model/auth_model.dart';
import 'package:navalha/mobile-DEPRECIATED/permission_loc/permission_page.dart';
import 'package:navalha/mobile-DEPRECIATED/regiter_social_network/regiter_social_network_page.dart';
import 'package:navalha/shared/animation/page_trasition.dart';
import 'package:navalha/shared/onboarding/onboarding_page.dart';
import 'package:navalha/shared/providers.dart';
import 'package:navalha/shared/shimmer/shimmer_faq.dart';
import 'package:navalha/shared/utils.dart';
import 'package:navalha/shared/widgets/page_transition.dart';
import 'button_social_network.dart';

class RowSocialNetworks extends StatefulHookConsumerWidget {
  const RowSocialNetworks({Key? key}) : super(key: key);

  @override
  ConsumerState<RowSocialNetworks> createState() => _RowSocialNetworksState();
}

class _RowSocialNetworksState extends ConsumerState<RowSocialNetworks> {
  final FirebaseAuth _auth = FirebaseAuth.instance;
  final GoogleSignIn _googleSignIn = GoogleSignIn();
  bool? firtLogin = true;
  String? fullNameApple;
  late SharedPreferences prefs;

  @override
  Widget build(BuildContext context) {
    Size size = MediaQuery.of(context).size;
    return Consumer(
      builder: (context, ref, child) {
        final authLoginController =
            ref.watch(LoginStateController.provider.notifier);
        var fBTokenController = ref.watch(fBTokenProvider.state);

        return Column(
          children: [
            ButtonSocialNetwork(
              onTap: () async {
                prefs = await SharedPreferences.getInstance();
                firtLogin = prefs.getBool('firstLogin') ?? true;
                UserCredential? userCredential = await signInWithGoogle();
                userCredential == null
                    ? null
                    : await login(
                        context,
                        userCredential.user!.displayName,
                        authLoginController,
                        userCredential.user!.email!,
                        userCredential.user!.uid,
                        fBTokenController.state,
                        prefs,
                        firtLogin,
                        ref,
                      );
              },
              color: Colors.white,
              img: imgLogoGoogle,
              textColor: Colors.white,
              label: Text(
                'Continuar com Google',
                style: TextStyle(
                  color: Colors.black,
                  fontWeight: FontWeight.bold,
                  fontSize: size.height * .02,
                ),
              ),
            ),
            if (Platform.isIOS || kIsWeb)
              ButtonSocialNetwork(
                onTap: () async {
                  prefs = await SharedPreferences.getInstance();
                  firtLogin = prefs.getBool('firstLogin') ?? true;
                  UserCredential? userCredential = await signInWithApple();

                  fullNameApple = prefs.getString('fullNameApple');
                  userCredential == null
                      ? null
                      : await login(
                          context,
                          fullNameApple == ''
                              ? userCredential.user!.displayName
                              : fullNameApple,
                          authLoginController,
                          userCredential.user!.email!,
                          userCredential.user!.uid,
                          fBTokenController.state,
                          prefs,
                          firtLogin,
                          ref,
                        );
                },
                color: Colors.white,
                img: imgLogoApple,
                textColor: Colors.white,
                label: Text(
                  'Continuar com Apple',
                  style: TextStyle(
                    color: Colors.black,
                    fontWeight: FontWeight.bold,
                    fontSize: size.height * .02,
                  ),
                ),
              ),
          ],
        );
      },
    );
  }

  Future<UserCredential?> signInWithGoogle() async {
    try {
      final GoogleSignInAccount? googleUser = await _googleSignIn.signIn();

      final GoogleSignInAuthentication googleAuth =
          await googleUser!.authentication;
      navigationWithFadeAnimation(const ShimmerFaq(), context);

      final AuthCredential credential = GoogleAuthProvider.credential(
        accessToken: googleAuth.accessToken,
        idToken: googleAuth.idToken,
      );
      final UserCredential userCredential =
          await _auth.signInWithCredential(credential);

      return userCredential;
    } catch (error) {
      return null;
    }
  }

  Future<UserCredential?> signInWithApple() async {
    prefs = await SharedPreferences.getInstance();

    fullNameApple = prefs.getString('fullNameApple');
    try {
      final AuthorizationCredentialAppleID credential =
          await SignInWithApple.getAppleIDCredential(
        scopes: [
          AppleIDAuthorizationScopes.email,
          AppleIDAuthorizationScopes.fullName,
        ],
      );
      navigationWithFadeAnimation(const ShimmerFaq(), context);

      final OAuthProvider oAuthProvider = OAuthProvider('apple.com');
      final AuthCredential credentialApple = oAuthProvider.credential(
        idToken: credential.identityToken,
        accessToken: credential.authorizationCode,
      );

      prefs.setString(
          'fullNameApple',
          credential.givenName == null
              ? fullNameApple ?? ''
              : '${credential.givenName} ${credential.familyName}');

      final UserCredential userCredential =
          await _auth.signInWithCredential(credentialApple);

      return userCredential;
    } catch (error) {
      return null;
    }
  }
}

Future login(
  BuildContext context,
  String? name,
  LoginStateController authLoginController,
  String email,
  String id,
  String fBToken,
  SharedPreferences prefs,
  bool? firtLogin,
  WidgetRef ref,
) async {
  AuthCustomer response =
      await authLoginController.login(email, id, fBToken.toString());

  if (response.status == 'success') {
    await prefs.setString('email', email);
    await prefs.setString('password', id);

    Future.delayed(const Duration(seconds: 1)).then((value) async {
      LocationPermission permission = await Geolocator.checkPermission();

      if (permission == LocationPermission.always ||
          permission == LocationPermission.whileInUse ||
          permission == LocationPermission.deniedForever) {
        if (firtLogin == true) {
          navigationWithFadeAnimation(
            OnBoarding(
              onBoardManagerImages: onboardingList(context),
              homePage: const HomePage(),
            ),
            context,
          );
          await prefs.setBool('firstLogin', false);
        } else {
          navigationWithFadeAnimation(
            const HomePage(),
            context,
          );
        }
      } else {
        if (firtLogin == true) {
          navigationWithFadeAnimation(
            OnBoarding(
              onBoardManagerImages: onboardingList(context),
              homePage: const PermissionPage(),
            ),
            context,
          );
          await prefs.setBool('firstLogin', false);
        } else {
          navigationWithFadeAnimation(
            const PermissionPage(),
            context,
          );
        }
      }
    });
  } else {
    if (response.id == 'bad_credentials') {
      navigationFadePush(const LoginPage(), context);
      final GoogleSignIn googleSignIn = GoogleSignIn();
      await googleSignIn.signOut();
      navigationWithFadeAnimation(const LoginPage(), context);
      showSnackBar(context, 'Esse email já foi cadastrado.');
    } else {
      navigationFadePush(
          RegistrationSocialNetworks(
            email: email,
            name: name,
            userId: id,
          ),
          context);
    }
  }
}
