// ignore_for_file: use_build_context_synchronously

import 'dart:async';
import 'package:dio/dio.dart';
import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';
import 'package:flutter_pw_validator/flutter_pw_validator.dart';
import 'package:geolocator/geolocator.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:navalha/core/colors.dart';
import 'package:navalha/mobile/home/home_page.dart';
import 'package:navalha/mobile/permission_loc/permission_page.dart';
import 'package:navalha/mobile/register/api/create_customer_endpoint.dart';
import 'package:navalha/mobile/register/provider/register_customer_provider.dart';
import 'package:navalha/mobile/register/repository/registration_repository.dart';
import 'package:navalha/mobile/register/usecase/create_customer_usecase.dart';
import 'package:navalha/shared/onboarding/onboarding_page.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:url_launcher/url_launcher.dart';
import '../change_password/change_password_page.dart';
import '../login/controller/login_controller.dart';
import '../../shared/animation/page_trasition.dart';
import '../../shared/providers.dart';
import '../../shared/utils.dart';
import '../../shared/widgets/text_edit.dart';
import 'model/req_create_customer.dart';

class RegistrationPassword extends StatefulHookConsumerWidget {
  RegistrationPassword({super.key});

  @override
  ConsumerState<RegistrationPassword> createState() => _MyWidgetState();
  static const route = '/register-password-page';
}

class _MyWidgetState extends ConsumerState<RegistrationPassword>
    with TickerProviderStateMixin {
  bool _isChecked = true;
  bool passedTest = false;
  bool _passwordVisible = false;
  int _state = 0;
  final TextEditingController passwordController = TextEditingController();
  final TextEditingController confirmPasswordController =
      TextEditingController();
  bool? firtLogin = true;

  final GlobalKey<FlutterPwValidatorState> validatorKey =
      GlobalKey<FlutterPwValidatorState>();

  final dio = Dio(BaseOptions(
    baseUrl: baseURLV1,
  ));

  @override
  void initState() {
    super.initState();
    _passwordVisible = false;
  }

  @override
  Widget build(BuildContext context) {
    @override
    final customerRegisterController =
        ref.watch(customerRegisterProvider.notifier);
    final loginController = ref.read(LoginStateController.provider.notifier);
    var fBTokenController = ref.watch(fBTokenProvider.state);

    ReqCreateCustomerModel customer;
    return SafeArea(
      top: false,
      child: Scaffold(
        extendBodyBehindAppBar: true,
        appBar: AppBar(
          backgroundColor: Colors.transparent,
          elevation: 0,
        ),
        floatingActionButton: FloatingActionButton(
          backgroundColor: Colors.transparent,
          splashColor: Colors.black,
          shape: const StadiumBorder(
            side:
                BorderSide(color: Color.fromARGB(255, 255, 228, 92), width: 4),
          ),
          child: setUpButtonChild(),
          onPressed: () async {
            SharedPreferences prefs = await SharedPreferences.getInstance();

            if (passwordController.text.isEmpty) {
              showSnackBar(context, 'Digite uma senha');
            } else if (passedTest) {
              showSnackBar(context, 'Senha não segura');
            } else if (passwordController.text.trim() !=
                confirmPasswordController.text.trim()) {
              showSnackBar(context, 'As senhas devem ser iguais');
            } else if (!possuiLetraMaiuscula(passwordController.text.trim())) {
              showSnackBar(
                  context, 'A senha deve conter alguma letra maiúscula!');
            } else if (!_isChecked) {
              showSnackBar(context,
                  'Você deve aceitar os termos e condições de uso do aplicativo!');
            } else {
              customerRegisterController.verifyValidProp([
                'password',
              ], [
                passwordController.text.trim(),
              ]);
              setState(() {
                _state = 1;
              });
              customer = customerRegisterController.generateFinalObject();
              final createCustomerResponse = await CreateCustomerUseCase(
                repository: CustomerRepository(
                  customerEndPoint: CustomerEndPoint(dio),
                ),
              ).execute(customer);
              firtLogin = prefs.getBool('firstLogin') ?? true;
              LocationPermission permission =
                  await Geolocator.checkPermission();
              if (createCustomerResponse.status == 'success') {
                await loginController.login(
                  customer.email!,
                  customer.password!,
                  fBTokenController.state,
                );
                setState(() {
                  _state = 2;
                });
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
                  if (permission == LocationPermission.always ||
                      permission == LocationPermission.whileInUse) {
                    navigationWithFadeAnimation(const HomePage(), context);
                  } else if (permission == LocationPermission.deniedForever) {
                    ScaffoldMessenger.of(context).showSnackBar(
                      const SnackBar(
                        duration: Duration(seconds: 5),
                        backgroundColor: Colors.white,
                        content: Text(
                          'Você negou as permissões de localização permanentemente, mude isso nas configurações do seu dispositivo, para ver as barbearias mais próximas a você',
                          style: TextStyle(color: Colors.black),
                        ),
                      ),
                    );
                    Timer(const Duration(milliseconds: 1000), () {
                      navigationWithFadeAnimation(const HomePage(), context);
                    });
                  } else {
                    navigationWithFadeAnimation(
                      const PermissionPage(),
                      context,
                    );
                  }
                }
              } else {
                showSnackBar(
                  context,
                  'Desculpe, ocorreu um problema. Por favor, entre em contato com o suporte pelo site para que possamos resolver o seu problema de cadastro.',
                );
              }
            }
          },
        ),
        backgroundColor: colorBackground181818,
        body: SingleChildScrollView(
          child: Column(children: [
            SizedBox(
              height: MediaQuery.of(context).size.height * 0.1,
            ),
            TextEditPattern(
              margin: EdgeInsets.symmetric(
                horizontal: MediaQuery.of(context).size.width * 0.03,
                vertical: MediaQuery.of(context).size.height * 0.03,
              ),
              width: MediaQuery.of(context).size.width,
              maxLength: 30,
              controller: passwordController,
              label: 'Senha',
              hint: 'Digite uma senha',
              keyboardType: TextInputType.visiblePassword,
              obscure: !_passwordVisible,
              suffixIcon: IconButton(
                splashColor: Colors.transparent,
                icon: Icon(
                  _passwordVisible ? Icons.visibility : Icons.visibility_off,
                  color: const Color.fromARGB(255, 255, 255, 255),
                ),
                onPressed: () {
                  setState(() {
                    _passwordVisible = !_passwordVisible;
                  });
                },
              ),
            ),
            TextEditPattern(
              margin: EdgeInsets.symmetric(
                horizontal: MediaQuery.of(context).size.width * 0.03,
              ),
              width: MediaQuery.of(context).size.width,
              maxLength: 30,
              controller: confirmPasswordController,
              label: 'Confirmar senha',
              hint: 'Confirme sua senha',
              keyboardType: TextInputType.visiblePassword,
              obscure: !_passwordVisible,
            ),
            Padding(
              padding: EdgeInsets.symmetric(
                horizontal: MediaQuery.of(context).size.width * 0.08,
                vertical: MediaQuery.of(context).size.height * 0.03,
              ),
              child: SizedBox(
                width: MediaQuery.of(context).size.width,
                child: FlutterPwValidator(
                  key: validatorKey,
                  controller: passwordController,
                  strings: FlutterPwValidatorNavalha(),
                  minLength: 8,
                  uppercaseCharCount: 1,
                  numericCharCount: 1,
                  failureColor: const Color.fromARGB(255, 227, 90, 80),
                  width: MediaQuery.of(context).size.width * 0.8,
                  height: MediaQuery.of(context).size.height * 0.17,
                  onSuccess: () {
                    passedTest = true;
                  },
                  onFail: () {},
                ),
              ),
            ),
            Row(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                const SizedBox(width: 10),
                Checkbox(
                  checkColor: Colors.black,
                  fillColor: MaterialStateProperty.all(Colors.white),
                  activeColor: colorContainers353535,
                  value: _isChecked,
                  onChanged: (bool? value) {
                    setState(() {
                      _isChecked = value!;
                    });
                  },
                ),
                RichText(
                  text: TextSpan(
                    text: 'Ao aceitar, você concorda em cumprir os\n',
                    style: const TextStyle(fontSize: 16.0, color: Colors.white),
                    children: [
                      TextSpan(
                        text: 'Termos e Condições',
                        style: const TextStyle(
                          fontWeight: FontWeight.bold,
                          decoration: TextDecoration.underline,
                        ),
                        recognizer: TapGestureRecognizer()..onTap = _launchUrl,
                      ),
                      const TextSpan(
                        text:
                            ' do nosso aplicativo.\nLeia-os atentamente antes de prosseguir.',
                      ),
                    ],
                  ),
                ),
                const SizedBox(height: 200)
              ],
            ),
          ]),
        ),
      ),
    );
  }

  Widget setUpButtonChild() {
    if (_state == 0) {
      return const Icon(Icons.navigate_next, color: Colors.white, size: 45);
    } else if (_state == 1) {
      return const CircularProgressIndicator(
        valueColor: AlwaysStoppedAnimation<Color>(Colors.white),
      );
    } else {
      return const Icon(Icons.check, color: Colors.white, size: 43);
    }
  }

  void insertCustomer(ReqCreateCustomerModel customer) {
    setState(() {
      _state = 1;
    });

    CreateCustomerUseCase(
      repository: CustomerRepository(
        customerEndPoint: CustomerEndPoint(dio),
      ),
    ).execute(customer).then((value) {
      setState(() {
        _state = 2;
      });
    });
  }
}

bool possuiLetraMaiuscula(String texto) {
  for (int i = 0; i < texto.length; i++) {
    if (texto[i].toUpperCase() == texto[i]) {
      return true;
    }
  }
  return false;
}

final Uri _url = Uri.parse('https://navalha.app.br/terms-of-use-client');

Future<void> _launchUrl() async {
  if (!await launchUrl(_url)) {
    throw Exception('Could not launch $_url');
  }
}
