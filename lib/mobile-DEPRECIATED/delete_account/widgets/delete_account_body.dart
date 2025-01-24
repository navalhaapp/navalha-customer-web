// ignore_for_file: use_build_context_synchronously

import 'package:flutter/material.dart';
import 'package:google_sign_in/google_sign_in.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:navalha/core/colors.dart';
import 'package:navalha/mobile-DEPRECIATED/delete_account/model/model_verification_desactive_account.dart';
import 'package:navalha/mobile-DEPRECIATED/delete_account/provider/provider_desactivate_account.dart';
import 'package:navalha/mobile-DEPRECIATED/delete_account/provider/provider_verification_desactive_account.dart';
import 'package:navalha/mobile-DEPRECIATED/login/controller/login_controller.dart';
import 'package:navalha/mobile-DEPRECIATED/login/login_page.dart';
import 'package:navalha/shared/utils.dart';
import 'package:navalha/shared/widgets/page_transition.dart';
import 'package:shared_preferences/shared_preferences.dart';
import '../../../shared/shows_dialogs/dialog.dart';
import '../../../shared/widgets/button_pattern_botton_sheet.dart';
import '../model/model_desactivate_account.dart';

enum SingingCharacter { appSlow1, appSlow2, appSlow3, appSlow4, appSlow5 }

String getSingingCharacterString(SingingCharacter character) {
  switch (character) {
    case SingingCharacter.appSlow1:
      return 'Quero remover aplicativos do meu dispositivo';
    case SingingCharacter.appSlow2:
      return 'Estou preocupado com meus dados pessoais';
    case SingingCharacter.appSlow3:
      return 'Estou recebendo muitas notificações do app';
    case SingingCharacter.appSlow4:
      return 'Não achei a minha barbearia';
    case SingingCharacter.appSlow5:
      return 'Outro motivo';
    default:
      return '';
  }
}

class DeleteAccountBody extends StatefulWidget {
  const DeleteAccountBody({Key? key}) : super(key: key);

  @override
  State<DeleteAccountBody> createState() => _DeleteAccountBodyState();
}

class _DeleteAccountBodyState extends State<DeleteAccountBody> {
  SingingCharacter? _character = SingingCharacter.appSlow1;
  bool loading = false;
  TextEditingController descriptionController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return SingleChildScrollView(
      child: Consumer(
        builder: (context, ref, child) {
          final loginController =
              ref.watch(LoginStateController.provider.notifier);
          final verificationAccount = ref.watch(
              VerificationDesactiveAccountStateController.provider.notifier);
          return Column(
            children: [
              const Padding(
                padding: EdgeInsets.all(15),
                child: Text(
                  'Lamentamos vê-lo partir. Por favor, ajude-nos a aprimorar nossos serviços ao informar o motivo pelo qual está deixando nosso aplicativo.',
                  style: TextStyle(color: Colors.white, fontSize: 16),
                ),
              ),
              Column(
                children: [
                  ListTile(
                    title: Text(
                      'Quero remover aplicativos do meu dispositivo',
                      style: TextStyle(
                        color: _character == SingingCharacter.appSlow1
                            ? colorWhite255255255
                            : colorFontUnable116116116,
                      ),
                    ),
                    leading: Radio<SingingCharacter>(
                      activeColor: const Color.fromARGB(255, 108, 229, 232),
                      value: SingingCharacter.appSlow1,
                      groupValue: _character,
                      onChanged: (SingingCharacter? value) {
                        setState(() {
                          _character = value;
                        });
                      },
                    ),
                  ),
                  ListTile(
                    title: Text(
                      'Estou preocupado com meus dados pessoais',
                      style: TextStyle(
                        color: _character == SingingCharacter.appSlow2
                            ? colorWhite255255255
                            : colorFontUnable116116116,
                      ),
                    ),
                    leading: Radio<SingingCharacter>(
                      activeColor: const Color.fromARGB(255, 108, 229, 232),
                      value: SingingCharacter.appSlow2,
                      groupValue: _character,
                      onChanged: (SingingCharacter? value) {
                        setState(() {
                          _character = value;
                        });
                      },
                    ),
                  ),
                  ListTile(
                    title: Text(
                      'Estou recebendo muitas notificações do app',
                      style: TextStyle(
                        color: _character == SingingCharacter.appSlow3
                            ? colorWhite255255255
                            : colorFontUnable116116116,
                      ),
                    ),
                    leading: Radio<SingingCharacter>(
                      activeColor: const Color.fromARGB(255, 108, 229, 232),
                      value: SingingCharacter.appSlow3,
                      groupValue: _character,
                      onChanged: (SingingCharacter? value) {
                        setState(() {
                          _character = value;
                        });
                      },
                    ),
                  ),
                  ListTile(
                    title: Text(
                      'Não achei a minha barbearia',
                      style: TextStyle(
                        color: _character == SingingCharacter.appSlow4
                            ? colorWhite255255255
                            : colorFontUnable116116116,
                      ),
                    ),
                    leading: Radio<SingingCharacter>(
                      activeColor: const Color.fromARGB(255, 108, 229, 232),
                      value: SingingCharacter.appSlow4,
                      groupValue: _character,
                      onChanged: (SingingCharacter? value) {
                        setState(() {
                          _character = value;
                        });
                      },
                    ),
                  ),
                  ListTile(
                    title: Column(
                      mainAxisAlignment: MainAxisAlignment.end,
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(
                          'Outro motivo',
                          style: TextStyle(
                            color: _character == SingingCharacter.appSlow5
                                ? colorWhite255255255
                                : colorFontUnable116116116,
                          ),
                        ),
                      ],
                    ),
                    leading: Radio<SingingCharacter>(
                      activeColor: const Color.fromARGB(255, 108, 229, 232),
                      value: SingingCharacter.appSlow5,
                      groupValue: _character,
                      onChanged: (SingingCharacter? value) {
                        setState(() {
                          _character = value;
                        });
                      },
                    ),
                  ),
                  Container(
                    margin: EdgeInsets.only(
                      bottom: MediaQuery.of(context).size.width * 0.05,
                    ),
                    height: MediaQuery.of(context).size.height * 0.15,
                    width: MediaQuery.of(context).size.width * 0.94,
                    decoration: const BoxDecoration(
                      borderRadius: BorderRadius.all(Radius.circular(17)),
                      color: Color.fromARGB(255, 44, 44, 44),
                    ),
                    child: Padding(
                      padding: const EdgeInsets.symmetric(
                          horizontal: 15, vertical: 8),
                      child: TextFormField(
                        maxLines: 3,
                        maxLength: 200,
                        controller: descriptionController,
                        cursorColor: Colors.white,
                        obscureText: false,
                        style: TextStyle(
                          fontSize: MediaQuery.of(context).size.width * 0.050,
                          color: const Color.fromARGB(255, 255, 255, 255),
                          fontStyle: FontStyle.normal,
                        ),
                        decoration: const InputDecoration(
                          hintText: 'Escreva um comentário',
                          hintStyle: TextStyle(
                            color: Color.fromARGB(255, 119, 119, 119),
                            fontSize: 15,
                          ),
                          border: InputBorder.none,
                          focusedBorder: InputBorder.none,
                        ),
                      ),
                    ),
                  ),
                ],
              ),
              Padding(
                padding:
                    const EdgeInsets.symmetric(horizontal: 15, vertical: 5),
                child: Text(
                  'Observação: Caso encontre algum problema ao utilizar o aplicativo, não hesite em entrar em contato conosco por meio do menu de ajuda. No entanto, lembre-se de que, ao excluir sua conta, você perderá o saldo do Navalha Cash, se houver, e essa ação não poderá ser desfeita. Por favor, proceda com cautela! Informamos que todos os seus dados serão permanentemente excluídos de nossa base de dados.',
                  style:
                      TextStyle(color: colorFontUnable116116116, fontSize: 15),
                ),
              ),
              Padding(
                padding: const EdgeInsets.only(top: 20, bottom: 50),
                child: SizedBox(
                  width: MediaQuery.of(context).size.width * 0.94,
                  height: 50,
                  child: ElevatedButton(
                    style: ButtonStyle(
                      overlayColor: MaterialStateProperty.all<Color>(
                        colorContainers353535,
                      ),
                      backgroundColor: MaterialStateProperty.all<Color>(
                          colorContainers242424),
                      shape: MaterialStateProperty.all<RoundedRectangleBorder>(
                        RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(15),
                        ),
                      ),
                    ),
                    onPressed: () async {
                      if (_character == SingingCharacter.appSlow5 &&
                          descriptionController.text == '') {
                        showSnackBar(context, 'Escreva uma descrição');
                      } else {
                        setState(() {
                          loading = true;
                        });
                        ResponseVerificationDesactiveAccount response =
                            await verificationAccount
                                .verificationDesactiveAccount(
                          loginController.user!.token!,
                          loginController.user!.customer!.customerId!,
                        );
                        setState(() {
                          loading = false;
                        });
                        if (response.status == 'success') {
                          showCustomDialog(
                            context,
                            _CheckDeleteDialog(
                              haveServices: response.result!,
                              description:
                                  _character != SingingCharacter.appSlow5
                                      ? getSingingCharacterString(_character!)
                                      : descriptionController.text,
                            ),
                          );
                        } else {
                          showSnackBar(context, 'Ops, algo aconteceu');
                        }
                      }
                    },
                    child: !loading
                        ? Padding(
                            padding: EdgeInsets.symmetric(
                                horizontal:
                                    MediaQuery.of(context).size.width * 0.1),
                            child: const Text(
                              'Excluir minha conta',
                              style: TextStyle(color: Colors.white),
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
                  ),
                ),
              ),
            ],
          );
        },
      ),
    );
  }
}

class _CheckDeleteDialog extends StatefulWidget {
  const _CheckDeleteDialog({
    Key? key,
    required this.haveServices,
    required this.description,
  }) : super(key: key);

  final bool haveServices;
  final String description;

  @override
  State<_CheckDeleteDialog> createState() => _CheckDeleteDialogState();
}

class _CheckDeleteDialogState extends State<_CheckDeleteDialog> {
  bool loading = false;

  @override
  Widget build(BuildContext context) {
    final size = MediaQuery.of(context).size;

    return Consumer(
      builder: (context, ref, child) {
        final loginController =
            ref.watch(LoginStateController.provider.notifier);
        final desactivateAccount =
            ref.watch(DesactiveAccountStateController.provider.notifier);
        return AlertDialog(
          alignment: Alignment.center,
          shape: const RoundedRectangleBorder(
            borderRadius: BorderRadius.all(
              Radius.circular(32.0),
            ),
          ),
          scrollable: true,
          backgroundColor: colorContainers242424,
          title: SizedBox(
            width: size.width * 0.6,
            child: const Column(
              children: [
                Text(
                  textAlign: TextAlign.center,
                  'Atenção!',
                  style: TextStyle(color: Colors.white),
                ),
              ],
            ),
          ),
          content: Column(
            children: [
              Text(
                textAlign: TextAlign.center,
                widget.haveServices
                    ? 'Você possui serviços agendados, caso decida por continuar a exclusão da conta, seus agendamentos serão cancelados e você perderá seu saldo no Navalha Cash e não poderá mais recuperá-lo'
                    : 'Caso decida por continuar a exclusão da conta, perderá seu saldo no Navalha Cash e não poderá mais recuperá-lo',
                style: const TextStyle(color: Colors.white),
              ),
            ],
          ),
          actions: [
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
              children: [
                ButtonPattern(
                  width: size.width * 0.3,
                  color: colorContainers242424,
                  child: const Text(
                    'Cancelar',
                    style: TextStyle(
                      fontSize: 15,
                    ),
                  ),
                  onPressed: () {
                    Navigator.pop(context);
                  },
                ),
                ButtonPattern(
                  width: size.width * 0.3,
                  color: colorContainers242424,
                  child: !loading
                      ? Text(
                          'Excluir',
                          style: TextStyle(
                            color: colorRed1765959,
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
                    setState(() {
                      loading = true;
                    });

                    ResponseDesactiveAccount response =
                        await desactivateAccount.desactiveAccount(
                      loginController.user!.token!,
                      loginController.user!.customer!.customerId!,
                      widget.description,
                    );
                    setState(() {
                      loading = false;
                    });
                    if (response.status == 'success') {
                      SharedPreferences prefs =
                          await SharedPreferences.getInstance();
                      await prefs.setString('email', '');
                      await prefs.setString('password', '');
                      loginController.user = null;
                      final GoogleSignIn googleSignIn = GoogleSignIn();
                      Future signOutWithGoogle() async {
                        await googleSignIn.signOut();
                      }

                      signOutWithGoogle();
                      showSnackBar(
                          context, 'Conta excluída, esperamos que você volte.');

                      navigationFadePush(const LoginPage(), context);
                    } else {
                      showSnackBar(context, 'Ops, algo aconteceu');
                    }
                  },
                ),
              ],
            ),
          ],
        );
      },
    );
  }
}
