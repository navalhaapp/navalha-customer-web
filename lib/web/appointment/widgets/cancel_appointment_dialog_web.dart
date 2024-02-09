// ignore_for_file: use_build_context_synchronously

import 'package:flutter/material.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:navalha/mobile/calendar/model/model_cancel_appointment.dart';
import 'package:navalha/mobile/calendar/provider/provider_cancel_appointment.dart';
import 'package:navalha/mobile/login/controller/login_controller.dart';
import 'package:navalha/shared/utils.dart';
import 'package:navalha/shared/widgets/page_transition.dart';
import 'package:navalha/web/appointment/widgets/calendar_page_web.dart';
import '../../../core/colors.dart';
import '../../../shared/widgets/button_pattern_dialog.dart';

class CancelAppointmentDialogWeb extends StatefulWidget {
  const CancelAppointmentDialogWeb({
    Key? key,
    required this.scheduleServiceId,
    required this.professionalId,
  }) : super(key: key);
  final String scheduleServiceId;
  final String? professionalId;

  @override
  State<CancelAppointmentDialogWeb> createState() =>
      _CancelAppointmentDialogWebState();
}

class _CancelAppointmentDialogWebState
    extends State<CancelAppointmentDialogWeb> {
  bool loading = false;
  @override
  Widget build(BuildContext context) {
    final size = MediaQuery.of(context).size;
    return Consumer(
      builder: (context, ref, child) {
        final loginController =
            ref.read(LoginStateController.provider.notifier);
        final cancelAppointment =
            ref.watch(CancelAppointmentStateController.provider.notifier);
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
          content: Column(
            children: [
              const Text(
                textAlign: TextAlign.center,
                'Tem certeza de que deseja cancelar seu agendamento?',
                style: TextStyle(color: Colors.white),
              ),
              const SizedBox(height: 10),
              Text(
                textAlign: TextAlign.center,
                'Para uma melhor organização por parte do profissional, só é permitido o cancelamento de serviços com até 4 horas de antecedência.',
                style: TextStyle(color: colorFontUnable116116116),
              ),
            ],
          ),
          actions: [
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
              children: [
                ButtonPatternDialog(
                  color: colorContainers242424,
                  child: const Text(
                    'Voltar',
                    style: TextStyle(fontSize: 15, color: Colors.white),
                  ),
                  onPressed: () {
                    Navigator.pop(context);
                  },
                ),
                ButtonPatternDialog(
                  onPressed: () async {
                    setState(() {
                      loading = true;
                    });
                    ResponseCancelAppointment response =
                        await cancelAppointment.cancelAppointment(
                      loginController.user!.token!,
                      widget.scheduleServiceId,
                      loginController.user!.customer!.customerId!,
                    );
                    if (response.status == 'success') {
                      setState(() => loading = false);
                      showSnackBar(context, 'Agendamento cancelado!');
                      Navigator.of(context).pushNamed('/calendar');
                    } else {
                      if (response.result == 'less_than_4_hours_left') {
                        showSnackBar(context,
                            'Agendamento só pode ser cancelado com 4 horas de antecedência!');
                        Navigator.pop(context);
                      } else {
                        Navigator.pop(context);
                        showSnackBar(context, 'Ops, algo aconteceu');
                      }
                      setState(() => loading = false);
                    }
                  },
                  color: colorContainers242424,
                  child: !loading
                      ? Text(
                          'Confirmar',
                          style: TextStyle(
                            color: colorRed1765959,
                            fontSize: 15,
                          ),
                        )
                      : const SizedBox(
                          width: 18,
                          height: 18,
                          child: CircularProgressIndicator(
                            color: Colors.white,
                            strokeWidth: 2,
                          ),
                        ),
                ),
              ],
            ),
          ],
        );
      },
    );
  }
}

class CalncelAppointmentDialog extends StatelessWidget {
  const CalncelAppointmentDialog({
    Key? key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final size = MediaQuery.of(context).size;

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
      content: const Text(
        textAlign: TextAlign.center,
        'Lamentamos, mas para cancelar o serviço, é necessário fazê-lo com pelo menos 4 horas de antecedência ao horário agendado. Se você passou por alguma situação em que o barbeiro não pôde atendê-lo ou a barbearia estava fechada, por favor, entre em contato com nosso suporte. Estamos aqui para resolver qualquer problema de forma justa e adequada para você.',
        style: TextStyle(color: Colors.white),
      ),
      actions: [
        Row(
          mainAxisAlignment: MainAxisAlignment.spaceEvenly,
          children: [
            ElevatedButton(
              style: ButtonStyle(
                overlayColor: MaterialStateProperty.all<Color>(
                  colorContainers353535,
                ),
                backgroundColor: MaterialStateProperty.all<Color>(
                    const Color.fromARGB(255, 24, 24, 24)),
                shape: MaterialStateProperty.all<RoundedRectangleBorder>(
                  RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(18),
                  ),
                ),
              ),
              child: const Padding(
                padding: EdgeInsets.symmetric(horizontal: 30),
                child: Text(
                  'Ok',
                  style: TextStyle(color: Colors.white),
                ),
              ),
              onPressed: () {
                Navigator.pop(context);
              },
            ),
          ],
        ),
      ],
    );
  }
}
