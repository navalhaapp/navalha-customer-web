// Developer            Data              Description
// Rovigo              22/08/2022         register page 3 creation  (client).

// ignore_for_file: use_build_context_synchronously

import 'dart:async';

import 'package:brasil_fields/brasil_fields.dart';
import 'package:flutter/material.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:navalha/core/colors.dart';
import 'package:navalha/mobile/register/provider/provider_auth_cep.dart';
import 'package:navalha/mobile/register/provider/register_customer_provider.dart';
import 'package:navalha/mobile/register/registration_password.dart';
import 'package:navalha/shared/animation/page_trasition.dart';
import '../../shared/utils.dart';
import '../../shared/widgets/text_edit.dart';

class RegistrationPageClientThird extends StatefulHookConsumerWidget {
  const RegistrationPageClientThird({super.key});

  @override
  ConsumerState<RegistrationPageClientThird> createState() =>
      _RegistrationPageClientThirdState();
  static const route = '/register-page-three';
}

class _RegistrationPageClientThirdState
    extends ConsumerState<RegistrationPageClientThird>
    with TickerProviderStateMixin {
  int _state = 0;

  final TextEditingController phoneEditController = TextEditingController();

  final TextEditingController postalCodeEditController =
      TextEditingController();

  @override
  Widget build(BuildContext context) {
    final authCepController =
        ref.read(AuthCepStateController.provider.notifier);
    return SafeArea(
      top: false,
      child: Scaffold(
        extendBodyBehindAppBar: true,
        appBar: AppBar(
          backgroundColor: Colors.transparent,
          elevation: 0,
        ),
        backgroundColor: colorBackground181818,
        body: Column(
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            SizedBox(
              height: MediaQuery.of(context).size.height * 0.08,
            ),
            TextEditPattern(
              margin: EdgeInsets.symmetric(
                horizontal: MediaQuery.of(context).size.width * 0.03,
                vertical: MediaQuery.of(context).size.height * 0.03,
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
                horizontal: MediaQuery.of(context).size.width * 0.03,
                vertical: 15,
              ),
              child: const Text(
                'O CEP será utilizado para encontrar barbearias próximas a você. Além disso, dentro do aplicativo, você terá a opção de alterar sua localização.',
                style: TextStyle(
                  color: Colors.white,
                ),
              ),
            )
          ],
        ),
        floatingActionButton: Consumer(
          builder: (BuildContext context, WidgetRef ref, Widget? child) {
            final customerRegisterController =
                ref.watch(customerRegisterProvider.notifier);
            return FloatingActionButton(
              backgroundColor: Colors.transparent,
              splashColor: Colors.black,
              shape: const StadiumBorder(
                side: BorderSide(
                    color: Color.fromARGB(255, 255, 228, 92), width: 4),
              ),
              child: setUpButtonChild(),
              onPressed: () async {
                if (phoneEditController.text.length < 14) {
                  showSnackBar(context, 'Telefone inválido');
                } else if (postalCodeEditController.text.length < 10) {
                  showSnackBar(context, 'Não conseguimos encontrar seu cep!');
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
                        Future.delayed(const Duration(seconds: 1))
                            .then((value) {
                          customerRegisterController.verifyValidProp(
                            [
                              'phone',
                              'postal_code',
                            ],
                            [
                              phoneEditController.text.trim(),
                              removeMaskCep(
                                  postalCodeEditController.text.trim())
                            ],
                          );
                          navigationWithFadeAnimation(
                              RegistrationPassword(), context);
                        });
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
