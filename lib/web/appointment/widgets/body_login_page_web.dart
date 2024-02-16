// Developer            Data              Decription
// Vitor               22/08/2022        Extracting body login
// ignore_for_file: use_build_context_synchronously, curly_braces_in_flow_control_structures

import 'dart:async';
import 'package:dio/dio.dart';
import 'package:email_validator/email_validator.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:navalha/core/colors.dart';
import 'package:navalha/mobile/login/controller/login_controller.dart';
import 'package:navalha/shared/model/customer_model.dart';
import 'package:navalha/web/appointment/text_edit_web.dart';
import 'package:navalha/web/appointment/widgets/button_login_web.dart';
import 'package:navalha/web/appointment/widgets/row_register_and_forget_web.dart';
import 'package:navalha/web/appointment/widgets/row_social_networks_google_web.dart';
import 'package:navalha/web/appointment/widgets/services_page_web.dart';
import 'package:navalha/web/db/db_customer_shared.dart';
import 'package:navalha/web/db/db_resume_last_page.dart';
import 'package:shared_preferences/shared_preferences.dart';
import '../../../shared/providers.dart';
import '../../../shared/utils.dart';

class BodyLoginWeb extends StatefulHookConsumerWidget {
  const BodyLoginWeb({super.key});

  @override
  ConsumerState<BodyLoginWeb> createState() => _BodyLoginWebState();
}

class _BodyLoginWebState extends ConsumerState<BodyLoginWeb>
    with TickerProviderStateMixin {
  bool _passwordVisible = false;
  int _state = 0;

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
      child: Column(
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
              child: Center(
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  crossAxisAlignment: CrossAxisAlignment.center,
                  children: [
                    Form(
                      child: TextEditPatternWeb(
                        label: 'Email',
                        obscure: false,
                        maxLength: 300,
                        controller: emailController,
                        hint: 'Digite o seu email',
                        keyboardType: TextInputType.emailAddress,
                      ),
                    ),
                    const SizedBox(height: 20),
                    TextEditPatternWeb(
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
                    const SizedBox(height: 5),
                    const RowRegisterAndForgetWeb(),
                    Padding(
                      padding: const EdgeInsets.symmetric(
                          vertical: 20, horizontal: 20),
                      child: ButtonLoginWeb(
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
                                Navigator.of(context).pushNamed('/login');
                              });
                            } else if (response.status == 'success') {
                              loginController.user.customer = response.customer;
                              LocalStorageManager.saveCustomer(
                                CustomerDB(
                                  name: response.customer.name,
                                  image: response.customer.imgProfile,
                                  customerId: response.customer.customerId,
                                  token: response.token,
                                  email: response.customer.email,
                                  birthDate: response.customer.birthDate,
                                  userID: '',
                                ),
                              );
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
                                String url = Uri.base.toString();
                                String params =
                                    Uri.splitQueryString(url).values.first;

                                bool? resumeLastPageValue =
                                    LocalStorageManagerLastPage
                                        .getResumeLastPage();
                                if (resumeLastPageValue) {
                                  Navigator.of(context).pushNamed(
                                    '/resume',
                                    arguments: {'barbershop_id': params},
                                  );
                                } else {
                                  Navigator.pushNamed(context, '/');
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
                                showSnackBar(context,
                                    'Suas credenciais estão incorretas.');
                              } else if (response.id == 'not_found') {
                                showSnackBar(context,
                                    'Suas credenciais estão incorretas.');
                              } else {
                                showSnackBar(context, 'Ops, algo aconteceu!');
                              }
                            }
                          }
                        },
                      ),
                    ),
                    const Padding(
                      padding: EdgeInsets.only(
                        bottom: 20,
                      ),
                      child: Text(
                        'ou',
                        style: TextStyle(color: Colors.white),
                      ),
                    ),
                    const RowSocialNetworksWeb(),
                    Padding(
                      padding: const EdgeInsets.symmetric(
                          horizontal: 20, vertical: 5),
                      child: ButtonSocialNetwork(
                        color: Colors.white,
                        icon: const Icon(CupertinoIcons.mail_solid,
                            color: Colors.black),
                        label: const Text(
                          'Cadastrar com Email',
                          style: TextStyle(
                            color: Colors.black,
                            fontWeight: FontWeight.bold,
                          ),
                        ),
                        onTap: () => Navigator.pushNamed(context, '/register'),
                        textColor: Colors.white,
                      ),
                    )
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

  Widget setUpButtonChild() {
    if (_state == 0) {
      return const Text(
        'Entrar',
        style: TextStyle(
          color: Colors.white,
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
