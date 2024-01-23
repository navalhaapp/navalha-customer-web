import 'package:flutter/material.dart';

class DayAndHour extends StatelessWidget {
  final String day;
  final String hour;
  final bool disabled;

  const DayAndHour({
    Key? key,
    required this.day,
    required this.hour,
    required this.disabled,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.only(top: 10),
      child: Row(
        children: [
          Text(
            'Dia $day',
            style: TextStyle(
              color: disabled
                  ? Colors.white
                  : const Color.fromARGB(255, 62, 62, 62),
              fontSize: 16,
            ),
          ),
          Text(
            ' às $hour',
            style: TextStyle(
              color: disabled
                  ? Colors.white
                  : const Color.fromARGB(255, 62, 62, 62),
              fontSize: 16,
            ),
          ),
        ],
      ),
    );
  }
}
