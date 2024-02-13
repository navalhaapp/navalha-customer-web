// ignore_for_file: use_build_context_synchronously

import 'dart:async';

import 'package:brasil_fields/brasil_fields.dart';
import 'package:dio/dio.dart';
import 'package:easy_debounce/easy_debounce.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';
import 'package:flutter_credit_card/extension.dart';
import 'package:google_sign_in/google_sign_in.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:navalha/core/colors.dart';
import 'package:navalha/mobile/login/controller/login_controller.dart';
import 'package:navalha/mobile/login/model/auth_model.dart';
import 'package:navalha/mobile/register/api/create_customer_endpoint.dart';
import 'package:navalha/mobile/register/model/req_create_customer.dart';
import 'package:navalha/mobile/register/provider/provider_auth_cep.dart';
import 'package:navalha/mobile/register/provider/register_customer_provider.dart';
import 'package:navalha/mobile/register/registration_page_client_second.dart';
import 'package:navalha/mobile/register/repository/registration_repository.dart';
import 'package:navalha/mobile/register/usecase/create_customer_usecase.dart';
import 'package:navalha/shared/providers.dart';
import 'package:navalha/shared/utils.dart';
import 'package:navalha/shared/widgets/button_pattern_botton_sheet.dart';
import 'package:navalha/shared/widgets/cupertino_date_picker.dart';
import 'package:navalha/shared/widgets/cupertino_piker_list.dart';
import 'package:navalha/shared/widgets/text_edit.dart';
import 'package:navalha/web/db/db_customer_shared.dart';
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
  bool loading = false;
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
    final retrievedCustomer = LocalStorageManager.getCustomer();
    final String email = retrievedCustomer!.email;
    final String name = retrievedCustomer.name;
    final String userId = retrievedCustomer.userID;
    final customerRegisterController =
        ref.watch(customerRegisterProvider.notifier);
    final loginController = ref.read(LoginStateController.provider.notifier);
    final authCepController =
        ref.read(AuthCepStateController.provider.notifier);
    var fBTokenController = ref.watch(fBTokenProvider.state);
    return SafeArea(
      top: false,
      child: Scaffold(
        backgroundColor: colorBackground181818,
        body: Center(
          child: Column(
            children: [
              Container(
                margin: const EdgeInsets.all(18),
                width: 500,
                height: 500,
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(15),
                  color: colorContainers242424,
                ),
                child: SingleChildScrollView(
                  child: Column(
                    mainAxisSize: MainAxisSize.min,
                    children: [
                      Padding(
                        padding: const EdgeInsets.only(
                            left: 10, top: 20, bottom: 20),
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            IconButton(
                              padding: const EdgeInsets.only(left: 30),
                              onPressed: () {
                                Navigator.of(context).pushNamed('/login');
                              },
                              icon: const Icon(
                                CupertinoIcons.clear,
                                color: Colors.white,
                              ),
                            ),
                            Text(
                              'Complete seu cadastro',
                              style: TextStyle(
                                fontSize: 20,
                                shadows: shadow,
                                color: Colors.white,
                              ),
                            ),
                            IconButton(
                              padding: const EdgeInsets.only(left: 30),
                              onPressed: () {},
                              icon: const Icon(
                                CupertinoIcons.clear,
                                color: Colors.transparent,
                              ),
                            ),
                          ],
                        ),
                      ),
                      CupertinoDataPicker(
                        label: 'Data de nascimento',
                        color: const Color.fromARGB(255, 28, 28, 28),
                        marginHorizontal: 30,
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
                          children: List<Widget>.generate(_listgener.length,
                              (int index) {
                            return Center(
                              child: Text(
                                _listgener[index],
                                style: TextStyle(
                                  fontSize:
                                      MediaQuery.of(context).size.width * 0.050,
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
                        color: const Color.fromARGB(255, 28, 28, 28),
                        marginHorizontal: 30,
                      ),
                      TextEditPattern(
                        padding: const EdgeInsets.only(left: 20),
                        sizeHint: 20,
                        sizeLabel: 22,
                        color: const Color.fromARGB(255, 28, 28, 28),
                        margin: const EdgeInsets.symmetric(
                          horizontal: 30,
                          vertical: 10,
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
                        padding: const EdgeInsets.only(left: 20),
                        sizeHint: 20,
                        sizeLabel: 22,
                        color: const Color.fromARGB(255, 28, 28, 28),
                        margin: const EdgeInsets.symmetric(
                          horizontal: 30,
                          vertical: 10,
                        ),
                        width: MediaQuery.of(context).size.width,
                        maxLength: 30,
                        controller: postalCodeEditController,
                        label: 'CEP',
                        hint: 'Digite o CEP',
                        obscure: false,
                        mask: CepInputFormatter(),
                        keyboardType: TextInputType.number,
                      ),
                      Padding(
                        padding: const EdgeInsets.symmetric(
                          horizontal: 50,
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
                          const SizedBox(width: 40),
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
                          const SizedBox(width: 10),
                          RichText(
                            text: TextSpan(
                              text: 'Ao aceitar, você concorda em cumprir os\n',
                              style: const TextStyle(
                                  fontSize: 16.0, color: Colors.white),
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
                          const SizedBox(height: 100)
                        ],
                      ),
                    ],
                  ),
                ),
              ),
              ButtonPattern(
                margin: const EdgeInsets.symmetric(horizontal: 18),
                width: 500,
                elevation: false,
                child: !loading
                    ? const Text(
                        'Confirmar',
                        style: TextStyle(
                          color: Colors.white,
                          fontSize: 15,
                        ),
                      )
                    : const SizedBox(
                        width: 20,
                        height: 20,
                        child: CircularProgressIndicator(
                          color: Colors.white,
                          strokeWidth: 2,
                        ),
                      ),
                onPressed: () async {
                  EasyDebounce.debounce(
                      'register', const Duration(milliseconds: 500), () async {
                    setState(() {
                      loading = true;
                    });
                    late SharedPreferences prefs;
                    prefs = await SharedPreferences.getInstance();
                    emailApple = prefs.getString('emailApple');
                    fullNameApple = prefs.getString('fullNameApple');
                    if (verificarDataFutura(UtilText.formatDate(date))) {
                      showSnackBar(
                          context, 'Não é possível adicionar datas futuras!');
                      setState(() {
                        loading = false;
                      });
                    }
                    if (phoneEditController.text.length < 14) {
                      showSnackBar(context, 'Telefone inválido');
                      setState(() {
                        loading = false;
                      });
                    } else if (postalCodeEditController.text.length < 10) {
                      setState(() {
                        loading = false;
                      });
                      showSnackBar(
                          context, 'Não conseguimos encontrar seu cep!');
                    } else if (!_isChecked) {
                      showSnackBar(context,
                          'Você deve aceitar os termos e condições de uso do aplicativo!');
                      setState(() {
                        loading = false;
                      });
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
                                  ? name
                                  : fullNameApple,
                              email,
                              UtilText.formatDate(date),
                              UtilText.registerGener[selectedItem] ==
                                      'undefined'
                                  ? null
                                  : UtilText.registerGener[selectedItem],
                              phoneEditController.text.trim(),
                              removeMaskCep(
                                  postalCodeEditController.text.trim()),
                              userId,
                              true,
                            ]);

                            ReqCreateCustomerModel customer =
                                customerRegisterController
                                    .generateFinalObject();
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
                              AuthCustomer response =
                                  await loginController.login(
                                customer.email!,
                                customer.password!,
                                fBTokenController.state,
                              );
                              if (response.status == 'success') {
                                LocalStorageManager.saveCustomer(
                                  CustomerDB(
                                    name: response.customer!.name ?? '',
                                    image: response.customer!.imgProfile ?? '',
                                    customerId:
                                        response.customer!.customerId ?? '',
                                    token: response.token ?? '',
                                    email: response.customer!.email ?? '',
                                    birthDate:
                                        response.customer!.birthDate ?? '',
                                    userID: '',
                                  ),
                                );
                                Navigator.of(context).pushNamed('/resume');
                                await prefs.setBool('firstLogin', false);
                                setState(() {
                                  _state = 2;
                                });
                              }
                            } else {
                              showSnackBar(context, 'Ops, algo aconteceu!');
                            }
                            break;
                          }
                        case AuthCepState.error:
                          showSnackBar(
                              context, 'Não conseguimos encontrar seu cep!');
                          setState(() {
                            loading = false;
                          });
                          break;
                      }
                      setState(() {
                        loading = false;
                      });
                    }
                  });
                  setState(() {
                    loading = false;
                  });
                },
              ),
            ],
          ),
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
