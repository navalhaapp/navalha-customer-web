// Developer            Data              Description
// Rovigo              22/08/2022         register page 3 creation  (client).

// ignore_for_file: use_build_context_synchronously

import 'dart:async';
import 'package:brasil_fields/brasil_fields.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:navalha/core/colors.dart';
import 'package:navalha/mobile/register/provider/provider_auth_cep.dart';
import 'package:navalha/mobile/register/provider/register_customer_provider.dart';
import 'package:navalha/shared/animation/page_trasition.dart';
import 'package:navalha/shared/utils.dart';
import 'package:navalha/shared/widgets/text_edit.dart';
import 'package:navalha/web/appointment/widgets/register_web/registration_page_client_web.dart';
import 'package:navalha/web/appointment/widgets/register_web/registration_password_web.dart';

class RegistrationPageClientThirdWeb extends StatefulHookConsumerWidget {
  const RegistrationPageClientThirdWeb({super.key});

  @override
  ConsumerState<RegistrationPageClientThirdWeb> createState() =>
      _RegistrationPageClientThirdWebState();
  static const route = '/register-page-three-web';
}

class _RegistrationPageClientThirdWebState
    extends ConsumerState<RegistrationPageClientThirdWeb>
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
        body: Center(
          child: Container(
            margin: const EdgeInsets.all(18),
            width: 500,
            height: 500,
            decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(15),
              color: colorContainers242424,
            ),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.end,
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Column(
                  crossAxisAlignment: CrossAxisAlignment.center,
                  children: [
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        IconButton(
                          padding: const EdgeInsets.symmetric(
                              horizontal: 20, vertical: 15),
                          onPressed: () {
                            Navigator.pop(context);
                          },
                          icon: const Icon(
                            CupertinoIcons.back,
                            color: Colors.white,
                          ),
                        ),
                        Row(
                          children: [
                            const ContainerStepper(color: Colors.white),
                            const ContainerStepper(color: Colors.white),
                            const ContainerStepper(color: Colors.white),
                            ContainerStepper(color: Colors.grey.shade800),
                          ],
                        ),
                        IconButton(
                          padding: const EdgeInsets.symmetric(
                              horizontal: 20, vertical: 15),
                          onPressed: () {},
                          icon: const Icon(
                            CupertinoIcons.back,
                            color: Colors.transparent,
                          ),
                        ),
                      ],
                    ),
                    TextEditPattern(
                      margin: const EdgeInsets.symmetric(
                        horizontal: 20,
                        vertical: 10,
                      ),
                      width: MediaQuery.of(context).size.width,
                      maxLength: 30,
                      controller: phoneEditController,
                      label: 'Telefone',
                      hint: 'Digite o telefone',
                      obscure: false,
                      mask: TelefoneInputFormatter(),
                      keyboardType: TextInputType.number,
                    ),
                    TextEditPattern(
                      margin: const EdgeInsets.symmetric(
                          horizontal: 20, vertical: 10),
                      width: MediaQuery.of(context).size.width,
                      maxLength: 30,
                      controller: postalCodeEditController,
                      label: 'Cep',
                      hint: 'Digite o Cep',
                      obscure: false,
                      mask: CepInputFormatter(),
                      keyboardType: TextInputType.number,
                    ),
                    const Padding(
                      padding: EdgeInsets.symmetric(
                        horizontal: 26,
                        vertical: 15,
                      ),
                      child: Text(
                        'O CEP será utilizado para encontrar barbearias próximas a você. Além disso, dentro do aplicativo, você terá a opção de alterar sua localização.',
                        style: TextStyle(
                          color: Colors.white,
                        ),
                      ),
                    )
                  ],
                ),
                Padding(
                  padding: const EdgeInsets.all(25),
                  child: Consumer(
                    builder:
                        (BuildContext context, WidgetRef ref, Widget? child) {
                      final customerRegisterController =
                          ref.watch(customerRegisterProvider.notifier);
                      return FloatingActionButton(
                        backgroundColor: Colors.transparent,
                        splashColor: Colors.black,
                        shape: const StadiumBorder(
                          side: BorderSide(
                              color: Color.fromARGB(255, 255, 228, 92),
                              width: 4),
                        ),
                        child: setUpButtonChild(),
                        onPressed: () async {
                          if (phoneEditController.text.length < 14) {
                            showSnackBar(context, 'Telefone inválido');
                          } else if (postalCodeEditController.text.length <
                              10) {
                            showSnackBar(
                                context, 'Não conseguimos encontrar seu cep!');
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
                                        removeMaskCep(postalCodeEditController
                                            .text
                                            .trim())
                                      ],
                                    );
                                    navigationWithFadeAnimation(
                                        RegistrationPasswordWeb(), context);
                                  });
                                  break;
                                }
                              case AuthCepState.error:
                                showSnackBar(context,
                                    'Não conseguimos encontrar seu cep!');
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
              ],
            ),
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
