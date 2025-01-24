import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:navalha/mobile-DEPRECIATED/login/controller/login_controller.dart';

import '../../../core/colors.dart';
import '../../../shared/widgets/button_pattern_dialog.dart';

class OrientationVerificationDialog extends StatefulWidget {
  const OrientationVerificationDialog({Key? key}) : super(key: key);

  @override
  State<OrientationVerificationDialog> createState() =>
      _OrientationVerificationDialogState();
}

class _OrientationVerificationDialogState
    extends State<OrientationVerificationDialog> {
  @override
  Widget build(BuildContext context) {
    final size = MediaQuery.of(context).size;
    return Consumer(
      builder: (context, ref, child) {
        final loginController =
            ref.watch(LoginStateController.provider.notifier);
        return AlertDialog(
          alignment: Alignment.center,
          shape: const RoundedRectangleBorder(
            borderRadius: BorderRadius.all(
              Radius.circular(32.0),
            ),
          ),
          scrollable: true,
          backgroundColor: colorBackground181818,
          title: SizedBox(
            width: size.width * 0.6,
            child: const Text(
              textAlign: TextAlign.center,
              'Atenção!',
              style: TextStyle(color: Colors.white),
            ),
          ),
          content: Padding(
            padding: const EdgeInsets.all(8.0),
            child: Column(
              children: [
                const Text(
                  textAlign: TextAlign.center,
                  'Para autenticar seu agendamento no dia do seu serviço.',
                  style: TextStyle(color: Colors.white),
                ),
                Icon(
                  CupertinoIcons.qrcode_viewfinder,
                  size: size.width * 0.4,
                  color: Colors.white,
                ),
                const SizedBox(height: 10),
                Text(
                  textAlign: TextAlign.center,
                  'Você poderá levar seu celular e mostrar o QR CODE ou informar os 8 digitos da sua',
                  style: TextStyle(color: colorFontUnable116116116),
                ),
                const SizedBox(height: 15),
                const Text(
                  textAlign: TextAlign.center,
                  'Data de nascimento',
                  style: TextStyle(color: Colors.white, fontSize: 20),
                ),
                Container(
                  margin: const EdgeInsets.only(top: 10),
                  decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(18),
                    color: colorYellow25020050,
                  ),
                  child: Padding(
                    padding: const EdgeInsets.all(8.0),
                    child: Text(
                      textAlign: TextAlign.center,
                      formatarData(loginController.user!.customer!.birthDate!),
                      style: const TextStyle(
                        color: Colors.black,
                        fontSize: 22,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                  ),
                ),
              ],
            ),
          ),
          actionsAlignment: MainAxisAlignment.center,
          actions: [
            ButtonPatternDialog(
              width: size.width * 0.6,
              onPressed: () {
                Navigator.pop(context);
              },
              color: colorContainers242424,
              child: const Text(
                'Ok, entendi',
                style: TextStyle(
                  fontSize: 15,
                ),
              ),
            ),
          ],
        );
      },
    );
  }
}

String formatarData(String data) {
  List<String> partes = data.split('-');
  String ano = partes[0];
  String mes = partes[1];
  String dia = partes[2];

  return '$dia$mes$ano';
}
