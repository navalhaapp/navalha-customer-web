// Developer            Data              Decription
// Vitor               22/08/2022        Extracting body login
// ignore_for_file: use_build_context_synchronously, curly_braces_in_flow_control_structures

import 'dart:async';
import 'package:dio/dio.dart';
import 'package:email_validator/email_validator.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:geolocator/geolocator.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:navalha/mobile/calendar/widget/evaluate_botton_sheet.dart';
import 'package:navalha/mobile/login/login_page.dart';
import 'package:navalha/shared/model/customer_model.dart';
import 'package:navalha/shared/onboarding/onboarding_page.dart';
import 'package:navalha/shared/widgets/page_transition.dart';
import 'package:shared_preferences/shared_preferences.dart';
import '../../../core/assets.dart';
import '../../home/home_page.dart';
import '../../permission_loc/permission_page.dart';
import '../../../shared/animation/page_trasition.dart';
import '../../../shared/providers.dart';
import '../../../shared/utils.dart';
import '../../../shared/widgets/text_edit.dart';
import '../controller/login_controller.dart';
import 'back_ground_login_top.dart';
import 'button_login.dart';
import 'row_register_and_forget.dart';
import 'row_social_networks_google.dart';

class BodyLogin extends StatefulHookConsumerWidget {
  const BodyLogin({super.key});

  @override
  ConsumerState<BodyLogin> createState() => _BodyLoginState();
}

class _BodyLoginState extends ConsumerState<BodyLogin>
    with TickerProviderStateMixin {
  bool _passwordVisible = false;
  int _state = 0;
  bool _isLoggedIn = false;
  String _savedEmail = '';
  String _savedPassword = '';
  TextEditingController emailController = TextEditingController();
  TextEditingController passwordController = TextEditingController();
  late List<ServicePendingReview>? listReviewsPending;
  String fbToken = '';
  bool? firtLogin = true;

  @override
  void initState() {
    super.initState();
    emailController = TextEditingController();
    passwordController = TextEditingController();
    _passwordVisible = false;
  }

  Future<void> _login() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    await prefs.setString('email', emailController.text.trim());
    await prefs.setString('password', passwordController.text);
    await prefs.setString('fBToken', fbToken);

    setState(() {
      _isLoggedIn = true;
      _savedEmail = emailController.text.trim();
      _savedPassword = passwordController.text;
    });
  }

  @override
  void dispose() {
    emailController.dispose();
    passwordController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final loginController = ref.read(LoginStateController.provider.notifier);
    final locationModel = ref.watch(locationProvider.state);
    var fBTokenController = ref.watch(fBTokenProvider.state);
    fbToken = fBTokenController.state;
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
                SizedBox(
                  height: size.height * 0.70,
                ),
              ],
            ),
            Positioned(
              top: getSizeException(
                  currentValue: size.height * .25,
                  exceptSize: 900,
                  exceptValue: size.height * .28,
                  deviceSize: size.height),
              child: Column(
                mainAxisAlignment: MainAxisAlignment.start,
                crossAxisAlignment: CrossAxisAlignment.center,
                children: [
                  Form(
                    child: TextEditPattern(
                      height: 50,
                      maxLines: 1,
                      margin: const EdgeInsets.only(top: 10),
                      label: 'Email',
                      obscure: false,
                      maxLength: 300,
                      controller: emailController,
                      hint: 'Digite o seu email',
                      keyboardType: TextInputType.emailAddress,
                    ),
                  ),
                  TextEditPattern(
                    height: 50,
                    maxLines: 1,
                    margin: EdgeInsets.only(
                      left: MediaQuery.of(context).size.width * 0.03,
                      right: MediaQuery.of(context).size.width * 0.03,
                      top: MediaQuery.of(context).size.width * 0.03,
                    ),
                    maxLength: 30,
                    label: 'Senha',
                    controller: passwordController,
                    hint: 'Informe sua senha',
                    keyboardType: TextInputType.visiblePassword,
                    obscure: !_passwordVisible,
                    suffixIcon: IconButton(
                      padding: EdgeInsets.only(right: size.width * 0.0),
                      splashColor: Colors.transparent,
                      icon: Icon(
                        _passwordVisible
                            ? CupertinoIcons.eye_solid
                            : CupertinoIcons.eye_slash_fill,
                        color: const Color.fromARGB(255, 255, 255, 255),
                      ),
                      onPressed: () {
                        setState(() {
                          _passwordVisible = !_passwordVisible;
                        });
                      },
                    ),
                  ),
                  const RowRegisterAndForget(),
                  ButtonLogin(
                    child: setUpButtonChild(),
                    onPressed: () async {
                      SharedPreferences prefs =
                          await SharedPreferences.getInstance();
                      firtLogin = prefs.getBool('firstLogin') ?? true;
                      locationModel.state.clear();
                      if (!EmailValidator.validate(
                          emailController.text.trim())) {
                        showSnackBar(context, 'Digite um email válido');
                      } else if (passwordController.text.trim().isEmpty) {
                        showSnackBar(context, 'Digite uma senha!');
                      } else {
                        setState(() {
                          _state = 1;
                        });

                        var response = await loginController.login(
                          emailController.text.trim(),
                          passwordController.text,
                          fbToken,
                        );

                        if (response.runtimeType == DioError) {
                          setState(() {
                            _state = 0;
                          });

                          Timer(const Duration(milliseconds: 1000), () {
                            loginController.user = null;
                            navigationFadePush(const LoginPage(), context);
                          });
                        } else if (response.status == 'success') {
                          _login();
                          setState(() {
                            _state = 2;
                          });
                          Future.delayed(const Duration(seconds: 1))
                              .then((value) {
                            setState(() {
                              _state = 0;
                            });
                          });
                          Future.delayed(const Duration(seconds: 1))
                              .then((value) async {
                            LocationPermission permission =
                                await Geolocator.checkPermission();

                            if (permission == LocationPermission.always ||
                                permission == LocationPermission.whileInUse ||
                                permission ==
                                    LocationPermission.deniedForever) {
                              if (firtLogin == true) {
                                navigationWithFadeAnimation(
                                  OnBoarding(
                                    onBoardManagerImages:
                                        onboardingList(context),
                                    homePage: const HomePage(),
                                  ),
                                  context,
                                );
                                await prefs.setBool('firstLogin', false);
                              } else {
                                listReviewsPending = loginController
                                        .user?.customer?.servicePendingReview ??
                                    [];
                                navigationWithFadeAnimation(
                                    const HomePage(), context);
                                for (int i = 0;
                                    i < listReviewsPending!.length;
                                    i++)
                                  showModalBottomSheet<void>(
                                    backgroundColor: Colors.transparent,
                                    isScrollControlled: true,
                                    isDismissible: true,
                                    context: context,
                                    builder: (BuildContext context) {
                                      return GestureDetector(
                                        onTap: () {
                                          Navigator.of(context).pop();
                                        },
                                        child: EvaluateBottonSheet(
                                          barberShopName: listReviewsPending![i]
                                              .barbershop!
                                              .barbershopName!,
                                          day: listReviewsPending![i]
                                              .date!
                                              .replaceAll('-', '/'),
                                          imgProfessional:
                                              listReviewsPending![i]
                                                  .professional!
                                                  .imgProfile!,
                                          serviceName: listReviewsPending![i]
                                              .service!
                                              .serviceName!,
                                          serviceId: listReviewsPending![i]
                                              .service!
                                              .serviceId!,
                                          customerId: loginController
                                              .user!.customer!.customerId!,
                                        ),
                                      );
                                    },
                                  );
                              }
                            } else {
                              if (firtLogin == true) {
                                navigationWithFadeAnimation(
                                  OnBoarding(
                                    onBoardManagerImages:
                                        onboardingList(context),
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
                          setState(() {
                            _state = 0;
                          });
                          if (response.id ==
                              'external_account_bad_credendials') {
                            showSnackBar(context,
                                'Sua conta foi criada usando o Google. Por favor, clique em Continuar com o Google para fazer login.');
                          } else if (response.id == 'bad_credentials') {
                            showSnackBar(
                                context, 'Suas credenciais estão incorretas.');
                          } else if (response.id == 'not_found') {
                            showSnackBar(
                                context, 'Suas credenciais estão incorretas.');
                          } else {
                            showSnackBar(context, 'Ops, algo aconteceu!');
                          }
                        }
                      }
                    },
                  ),
                  const Padding(
                    padding: EdgeInsets.all(10.0),
                    child: Text(
                      'Ou',
                      style: TextStyle(color: Colors.white),
                    ),
                  ),
                  const RowSocialNetworks(),
                ],
              ),
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
          ],
        ),
      ),
    );
  }

  Widget setUpButtonChild() {
    if (_state == 0) {
      return Text(
        'Entrar',
        style: TextStyle(
          color: Colors.white,
          fontSize: MediaQuery.of(context).size.height * .025,
        ),
      );
    } else if (_state == 1) {
      return const SizedBox(
        width: 25,
        height: 25,
        child: CircularProgressIndicator(
          strokeWidth: 2.5,
          valueColor: AlwaysStoppedAnimation<Color>(Colors.white),
        ),
      );
    } else {
      return const Icon(Icons.check, color: Colors.white, size: 43);
    }
  }
}
