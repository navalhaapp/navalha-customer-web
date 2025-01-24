import 'package:flutter/material.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';

import 'package:navalha/core/colors.dart';

import '../../../../../shared/model/hour_model.dart';
import '../../../shared/model/barber_shop_model.dart';
import '../../../shared/utils.dart';

class TabHours extends StatelessWidget {
  final BarberShop barberShop;
  const TabHours({
    Key? key,
    required this.barberShop,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Consumer(
      builder: (context, ref, child) {
        Size size = MediaQuery.of(context).size;
        List<HourModel> listHours = barberShop.openingHourList!;

        return Container(
          margin: EdgeInsets.only(
            bottom: size.height * .015,
            left: size.width * .03,
            right: size.width * .03,
          ),
          decoration: BoxDecoration(
            color: colorContainers242424,
            borderRadius: BorderRadius.circular(18),
          ),
          width: double.maxFinite,
          child: Padding(
            padding: const EdgeInsets.all(15.0),
            child: Column(
              mainAxisAlignment: MainAxisAlignment.start,
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Padding(
                  padding: const EdgeInsets.only(bottom: 30),
                  child: Text(
                    'Horário de funcionamento',
                    style: TextStyle(
                      fontSize: size.height * 0.025,
                      color: Colors.white,
                    ),
                  ),
                ),
                Column(
                  mainAxisAlignment: MainAxisAlignment.start,
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    RowHour(listHours: listHours, day: 'Segunda', i: 0),
                    RowHour(listHours: listHours, day: 'Terça', i: 1),
                    RowHour(listHours: listHours, day: 'Quarta', i: 2),
                    RowHour(listHours: listHours, day: 'Quinta', i: 3),
                    RowHour(listHours: listHours, day: 'Sexta', i: 4),
                    RowHour(listHours: listHours, day: 'Sábado', i: 5),
                    RowHour(listHours: listHours, day: 'Domingo', i: 6),
                  ],
                ),
              ],
            ),
          ),
        );
      },
    );
  }
}

class RowHour extends StatelessWidget {
  const RowHour({
    Key? key,
    required this.listHours,
    required this.i,
    required this.day,
  }) : super(key: key);

  final List<HourModel> listHours;
  final int i;
  final String day;

  @override
  Widget build(BuildContext context) {
    Size size = MediaQuery.of(context).size;
    return Row(
      mainAxisAlignment: MainAxisAlignment.start,
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        SizedBox(
          width: size.width * 0.24,
          child: Text(
            '$day: ',
            style: TextStyle(color: Colors.white, fontSize: size.width * 0.04),
          ),
        ),
        Text(
          listHours[i].activated!
              ? '${formatTime(listHours[i].startAm ?? 'vazio')}${listHours[i].startAm == null ? '' : ' - '}${formatTime(listHours[i].endAm ?? 'vazio')}${listHours[i].startAm == null || listHours[i].endAm == null || listHours[i].startPm == null || listHours[i].endPm == null ? '' : ' | '}${formatTime(listHours[i].startPm ?? 'vazio')}${listHours[i].startPm == null ? '' : ' - '}${formatTime(listHours[i].endPm ?? 'vazio')}'
              : 'Fechado',
          style: TextStyle(color: Colors.white, fontSize: size.width * 0.04),
        ),
      ],
    );
  }
}
