// ignore_for_file: use_build_context_synchronously

import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:google_sign_in/google_sign_in.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:navalha/core/colors.dart';
import 'package:navalha/web/appointment/widgets/services_page_web.dart';
import 'package:navalha/web/db/db_customer_shared.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:navalha/core/assets.dart';
import 'package:navalha/mobile/login/controller/login_controller.dart';
import 'package:navalha/mobile/login/model/auth_model.dart';
import 'package:navalha/shared/animation/page_trasition.dart';
import 'package:navalha/shared/providers.dart';
import 'package:navalha/shared/utils.dart';
import 'package:shimmer/shimmer.dart';

class RowSocialNetworksWeb extends StatefulHookConsumerWidget {
  const RowSocialNetworksWeb({Key? key}) : super(key: key);

  @override
  ConsumerState<RowSocialNetworksWeb> createState() =>
      _RowSocialNetworksWebState();
}

class _RowSocialNetworksWebState extends ConsumerState<RowSocialNetworksWeb> {
  final FirebaseAuth _auth = FirebaseAuth.instance;
  final GoogleSignIn _googleSignIn = GoogleSignIn();
  bool? firtLogin = true;
  String? fullNameApple;
  late SharedPreferences prefs;
  CustomerDB? retrievedCustomer;
  @override
  Widget build(BuildContext context) {
    return Consumer(
      builder: (context, ref, child) {
        final authLoginController =
            ref.watch(LoginStateController.provider.notifier);
        var fBTokenController = ref.watch(fBTokenProvider.state);

        return Padding(
          padding: const EdgeInsets.symmetric(horizontal: 20),
          child: _ButtonSocialNetwork(
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
            label: const Text(
              'Continuar com Google',
              style: TextStyle(
                color: Colors.black,
                fontWeight: FontWeight.bold,
              ),
            ),
          ),
        );
      },
    );
  }

  Future<UserCredential?> signInWithGoogle() async {
    GoogleAuthProvider authProvider = GoogleAuthProvider();
    try {
      final UserCredential userCredential =
          await _auth.signInWithPopup(authProvider);

      navigationWithFadeAnimation(const ShimmerLoginGoogle(), context);

      await _auth.signInWithCredential(userCredential.credential!);
      print(userCredential);
      return userCredential;
    } catch (error) {
      print(error);
      return null;
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
      LocalStorageManager.saveCustomer(
        CustomerDB(
          name: response.customer!.name ?? '',
          image: response.customer!.imgProfile ?? '',
          customerId: response.customer!.customerId ?? '',
          token: response.token ?? '',
          email: response.customer!.email ?? '',
          birthDate: response.customer!.birthDate ?? '',
          userID: '',
        ),
      );
      Navigator.of(context).pushNamed('/resume');
    } else {
      if (response.id == 'bad_credentials') {
        Navigator.of(context).pop();
        showSnackBar(context, 'Esse email já foi cadastrado.');
      } else {
        LocalStorageManager.saveCustomer(
          CustomerDB(
            name: name ?? '',
            image: '',
            customerId: '',
            token: '',
            email: email,
            birthDate: '',
            userID: id,
          ),
        );
        Navigator.pushNamed(context, '/register-social');
      }
    }
  }
}

class ShimmerLoginGoogle extends StatelessWidget {
  const ShimmerLoginGoogle({super.key});

  @override
  Widget build(BuildContext context) {
    Size size = MediaQuery.of(context).size;

    return Scaffold(
      backgroundColor: colorBackground181818,
      body: Column(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Center(
            child: Container(
              margin: const EdgeInsets.all(18),
              width: 500,
              height: 500,
              decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(15),
                color: colorContainers242424,
              ),
              child: SingleChildScrollView(
                child: Column(
                  children: [
                    Padding(
                      padding: const EdgeInsets.all(8.0),
                      child: Shimmer.fromColors(
                        baseColor: const Color.fromARGB(150, 18, 18, 18),
                        highlightColor: const Color.fromARGB(150, 58, 58, 58),
                        child: SafeArea(
                          child: SingleChildScrollView(
                            child: Column(
                              crossAxisAlignment: CrossAxisAlignment.center,
                              children: [
                                Container(
                                  margin:
                                      const EdgeInsets.symmetric(vertical: 10),
                                  height: size.height * 0.1,
                                  width: size.width * 0.97,
                                  decoration: const BoxDecoration(
                                    borderRadius:
                                        BorderRadius.all(Radius.circular(15)),
                                    color: Color.fromARGB(255, 172, 172, 172),
                                  ),
                                ),
                                Container(
                                  margin:
                                      const EdgeInsets.symmetric(vertical: 10),
                                  height: size.height * 0.1,
                                  width: size.width * 0.97,
                                  decoration: const BoxDecoration(
                                    borderRadius:
                                        BorderRadius.all(Radius.circular(15)),
                                    color: Color.fromARGB(255, 172, 172, 172),
                                  ),
                                ),
                                Container(
                                  margin:
                                      const EdgeInsets.symmetric(vertical: 10),
                                  height: size.height * 0.1,
                                  width: size.width * 0.97,
                                  decoration: const BoxDecoration(
                                    borderRadius:
                                        BorderRadius.all(Radius.circular(15)),
                                    color: Color.fromARGB(255, 172, 172, 172),
                                  ),
                                ),
                                Container(
                                  margin:
                                      const EdgeInsets.symmetric(vertical: 10),
                                  height: size.height * 0.1,
                                  width: size.width * 0.97,
                                  decoration: const BoxDecoration(
                                    borderRadius:
                                        BorderRadius.all(Radius.circular(15)),
                                    color: Color.fromARGB(255, 172, 172, 172),
                                  ),
                                ),
                                Container(
                                  margin:
                                      const EdgeInsets.symmetric(vertical: 10),
                                  height: size.height * 0.1,
                                  width: size.width * 0.97,
                                  decoration: const BoxDecoration(
                                    borderRadius:
                                        BorderRadius.all(Radius.circular(15)),
                                    color: Color.fromARGB(255, 172, 172, 172),
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
            ),
          ),
          const DownloadAppPromotion(),
        ],
      ),
    );
  }
}

class _ButtonSocialNetwork extends StatelessWidget {
  const _ButtonSocialNetwork({
    Key? key,
    required this.label,
    required this.img,
    required this.color,
    required this.textColor,
    required this.onTap,
  }) : super(key: key);

  final Widget label;
  final String img;
  final Color color;
  final Color textColor;
  final Function onTap;

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () => onTap(),
      child: Container(
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(15),
          color: color,
        ),
        height: 40,
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceAround,
          children: [
            SizedBox(
              height: 20,
              child: Image.asset(img),
            ),
            label,
            const SizedBox()
          ],
        ),
      ),
    );
  }
}
