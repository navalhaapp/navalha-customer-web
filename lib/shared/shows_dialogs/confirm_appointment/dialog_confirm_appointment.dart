import 'package:flutter/material.dart';
import 'package:navalha/core/colors.dart';
import 'package:navalha/mobile-DEPRECIATED/calendar/calendar_page.dart';

Future<void> confirmAppointmentDialog(BuildContext context) {
  final size = MediaQuery.of(context).size;
  return showDialog<void>(
    context: context,
    builder: (BuildContext context) {
      return AlertDialog(
        alignment: Alignment.center,
        shape: const RoundedRectangleBorder(
          borderRadius: BorderRadius.all(
            Radius.circular(32.0),
          ),
        ),
        scrollable: true,
        backgroundColor: const Color.fromARGB(150, 0, 0, 0),
        title: SizedBox(
          width: size.width * 0.6,
          child: const Text(
            textAlign: TextAlign.center,
            'Agendamento realizado com sucesso!',
            style: TextStyle(color: Colors.white),
          ),
        ),
        content: const Icon(
          Icons.check_circle_rounded,
          color: Colors.white,
          size: 80,
        ),
        actions: <Widget>[
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
                      borderRadius: BorderRadius.circular(15),
                    ),
                  ),
                ),
                child: const Padding(
                  padding: EdgeInsets.symmetric(horizontal: 10),
                  child: Text(
                    'Ok',
                    style: TextStyle(color: Colors.white),
                  ),
                ),
                onPressed: () =>
                    Navigator.pushNamed(context, CalendarPage.route),
              ),
            ],
          ),
        ],
      );
    },
  );
}
