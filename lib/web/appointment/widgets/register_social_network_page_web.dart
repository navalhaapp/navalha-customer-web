// ignore_for_file: use_build_context_synchronously

import 'dart:async';

import 'package:brasil_fields/brasil_fields.dart';
import 'package:dio/dio.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';
import 'package:flutter_credit_card/extension.dart';
import 'package:google_sign_in/google_sign_in.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:navalha/core/colors.dart';
import 'package:navalha/mobile/login/controller/login_controller.dart';
import 'package:navalha/mobile/register/api/create_customer_endpoint.dart';
import 'package:navalha/mobile/register/model/req_create_customer.dart';
import 'package:navalha/mobile/register/provider/provider_auth_cep.dart';
import 'package:navalha/mobile/register/provider/register_customer_provider.dart';
import 'package:navalha/mobile/register/registration_page_client_second.dart';
import 'package:navalha/mobile/register/repository/registration_repository.dart';
import 'package:navalha/mobile/register/usecase/create_customer_usecase.dart';
import 'package:navalha/shared/providers.dart';
import 'package:navalha/shared/utils.dart';
import 'package:navalha/shared/widgets/cupertino_date_picker.dart';
import 'package:navalha/shared/widgets/cupertino_piker_list.dart';
import 'package:navalha/shared/widgets/text_edit.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:url_launcher/url_launcher.dart';

class RegistrationSocialNetworksWeb extends StatefulHookConsumerWidget {
  const RegistrationSocialNetworksWeb({super.key});

  @override
  ConsumerState<RegistrationSocialNetworksWeb> createState() =>
      _RegistrationSocialNetworksWebState();
}

class _RegistrationSocialNetworksWebState
    extends ConsumerState<RegistrationSocialNetworksWeb> {
  DateTime date = DateTime(2018, 28, 10);
  final List<String> _listgener = <String>[
    'Selecione o gênero',
    'Masculino',
    'Feminino'
  ];
  int selectedItem = 0;
  int _state = 0;
  bool _isChecked = true;
  final TextEditingController nameEditController = TextEditingController();
  final TextEditingController phoneEditController = TextEditingController();
  final TextEditingController postalCodeEditController =
      TextEditingController();
  String? emailApple;
  String? fullNameApple;
  final dio = Dio(BaseOptions(
    baseUrl: baseURLV1,
  ));

  @override
  Widget build(BuildContext context) {
    final Map<String, dynamic> args =
        ModalRoute.of(context)!.settings.arguments as Map<String, dynamic>;
    final String email = args['email'];
    final String name = args['name'];
    final String userId = args['userId'];
    final customerRegisterController =
        ref.watch(customerRegisterProvider.notifier);
    final loginController = ref.read(LoginStateController.provider.notifier);
    final authCepController =
        ref.read(AuthCepStateController.provider.notifier);
    var fBTokenController = ref.watch(fBTokenProvider.state);
    return SafeArea(
      top: false,
      child: Scaffold(
        appBar: AppBar(
          elevation: 0,
          leading: IconButton(
            icon: const Icon(Icons.arrow_back_ios_new, size: 17),
            onPressed: () async {
              final GoogleSignIn googleSignIn = GoogleSignIn();
              await googleSignIn.signOut();
              Navigator.of(context).pushNamed('/login');
            },
          ),
          backgroundColor: Colors.transparent,
          title: Center(
            child: Text(
              'Complete seu cadastro',
              maxLines: 1,
              style: TextStyle(
                fontSize: MediaQuery.of(context).size.width * 0.05,
              ),
            ),
          ),
          actions: [
            IconButton(
              icon: const Icon(
                Icons.arrow_back_ios_new,
                size: 17,
                color: Colors.transparent,
              ),
              onPressed: () {},
            ),
          ],
        ),
        backgroundColor: colorBackground181818,
        body: SingleChildScrollView(
          child: Column(
            children: [
              CupertinoDataPicker(
                label: 'Data de nascimento',
                color: colorContainers242424,
                marginHorizontal: MediaQuery.of(context).size.width * 0.03,
                date: date,
                picker: CupertinoDatePicker(
                  dateOrder: DatePickerDateOrder.dmy,
                  initialDateTime: date,
                  mode: CupertinoDatePickerMode.date,
                  use24hFormat: true,
                  maximumYear: DateTime.now().year,
                  onDateTimeChanged: (DateTime newDate) {
                    setState(() => date = newDate);
                  },
                ),
              ),
              CupertinoPickerList(
                picker: CupertinoPicker(
                  magnification: 1.22,
                  squeeze: 1.2,
                  useMagnifier: true,
                  itemExtent: 32,
                  onSelectedItemChanged: (int selected) {
                    setState(() {
                      selectedItem = selected;
                    });
                  },
                  children:
                      List<Widget>.generate(_listgener.length, (int index) {
                    return Center(
                      child: Text(
                        _listgener[index],
                        style: TextStyle(
                          fontSize: MediaQuery.of(context).size.width * 0.050,
                          color: colorWhite255255255,
                          fontStyle: FontStyle.normal,
                        ),
                      ),
                    );
                  }),
                ),
                label: 'Gênero',
                list: _listgener,
                optional: '*Opcional',
                textEdit: _listgener[selectedItem],
                color: colorContainers242424,
                marginHorizontal: MediaQuery.of(context).size.width * 0.03,
              ),
              TextEditPattern(
                margin: EdgeInsets.symmetric(
                  horizontal: MediaQuery.of(context).size.width * 0.03,
                  vertical: MediaQuery.of(context).size.height * 0.01,
                ),
                width: MediaQuery.of(context).size.width,
                maxLength: 30,
                controller: phoneEditController,
                label: 'Telefone',
                hint: '(99) 99999-9999',
                obscure: false,
                mask: TelefoneInputFormatter(),
                keyboardType: TextInputType.number,
              ),
              TextEditPattern(
                margin: EdgeInsets.symmetric(
                  horizontal: MediaQuery.of(context).size.width * 0.03,
                  vertical: MediaQuery.of(context).size.height * 0.01,
                ),
                width: MediaQuery.of(context).size.width,
                maxLength: 30,
                controller: postalCodeEditController,
                label: 'Cep',
                hint: '99.999-999',
                obscure: false,
                mask: CepInputFormatter(),
                keyboardType: TextInputType.number,
              ),
              Padding(
                padding: EdgeInsets.symmetric(
                  horizontal: MediaQuery.of(context).size.width * 0.04,
                ),
                child: Text(
                  'O CEP será utilizado para encontrar barbearias próximas a você. Além disso, dentro do aplicativo, você terá a opção de alterar sua localização.',
                  style: TextStyle(
                    color: colorFontUnable116116116,
                  ),
                ),
              ),
              const SizedBox(height: 10),
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
                      style:
                          const TextStyle(fontSize: 16.0, color: Colors.white),
                      children: [
                        TextSpan(
                          text: 'Termos e Condições',
                          style: const TextStyle(
                            fontWeight: FontWeight.bold,
                            decoration: TextDecoration.underline,
                          ),
                          recognizer: TapGestureRecognizer()
                            ..onTap = _launchUrl,
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
            ],
          ),
        ),
        floatingActionButton: Consumer(
          builder: (BuildContext context, WidgetRef ref, Widget? child) {
            return FloatingActionButton(
              backgroundColor: Colors.transparent,
              splashColor: Colors.black,
              shape: const StadiumBorder(
                side: BorderSide(
                    color: Color.fromARGB(255, 255, 228, 92), width: 4),
              ),
              child: setUpButtonChild(),
              onPressed: () async {
                late SharedPreferences prefs;
                prefs = await SharedPreferences.getInstance();
                emailApple = prefs.getString('emailApple');
                fullNameApple = prefs.getString('fullNameApple');
                if (verificarDataFutura(UtilText.formatDate(date))) {
                  showSnackBar(
                      context, 'Não é possível adicionar datas futuras!');
                }
                if (phoneEditController.text.length < 14) {
                  showSnackBar(context, 'Telefone inválido');
                } else if (postalCodeEditController.text.length < 10) {
                  showSnackBar(context, 'Não conseguimos encontrar seu cep!');
                } else if (!_isChecked) {
                  showSnackBar(context,
                      'Você deve aceitar os termos e condições de uso do aplicativo!');
                } else {
                  setState(() {
                    _state = 1;
                  });

                  await authCepController
                      .authCep(postalCodeEditController.text);
                  final authCepState =
                      ref.watch(AuthCepStateController.provider);

                  switch (authCepState) {
                    case AuthCepState.loggedOut:
                      {
                        break;
                      }
                    case AuthCepState.loading:
                      {
                        break;
                      }
                    case AuthCepState.loggedIn:
                      {
                        setState(() {
                          _state = 3;
                        });

                        customerRegisterController.verifyValidProp([
                          'name',
                          'email',
                          'birth_date',
                          'gener',
                          'phone',
                          'postal_code',
                          'password',
                          'external_account'
                        ], [
                          fullNameApple.isNullOrEmpty
                              ? name ?? 'Usuário'
                              : fullNameApple,
                          email,
                          UtilText.formatDate(date),
                          UtilText.registerGener[selectedItem] == 'undefined'
                              ? null
                              : UtilText.registerGener[selectedItem],
                          phoneEditController.text.trim(),
                          removeMaskCep(postalCodeEditController.text.trim()),
                          userId,
                          true,
                        ]);

                        ReqCreateCustomerModel customer =
                            customerRegisterController.generateFinalObject();
                        ResponseCreateCustomer response =
                            await CreateCustomerUseCase(
                          repository: CustomerRepository(
                            customerEndPoint: CustomerEndPoint(dio),
                          ),
                        ).execute(customer);
                        SharedPreferences prefs =
                            await SharedPreferences.getInstance();
                        await prefs.setString('email', email);
                        await prefs.setString('password', userId);
                        prefs.setString('emailApple', '');
                        prefs.setString('fullNameApple', '');
                        if (response.status == 'success') {
                          await loginController.login(
                            customer.email!,
                            customer.password!,
                            fBTokenController.state,
                          );
                          setState(() {
                            _state = 2;
                          });
                          Timer(const Duration(milliseconds: 1000), () {
                            Navigator.of(context).pushNamed('/resume');
                          });
                          await prefs.setBool('firstLogin', false);
                        } else {
                          showSnackBar(context, 'Ops, algo aconteceu!');
                        }
                        break;
                      }
                    case AuthCepState.error:
                      showSnackBar(
                          context, 'Não conseguimos encontrar seu cep!');
                      setState(() {
                        _state = 0;
                      });
                      break;
                  }
                }
              },
            );
          },
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
}

final Uri _url = Uri.parse('https://navalha.app.br/terms-of-use-client');

Future<void> _launchUrl() async {
  if (!await launchUrl(_url)) {
    throw Exception('Could not launch $_url');
  }
}
