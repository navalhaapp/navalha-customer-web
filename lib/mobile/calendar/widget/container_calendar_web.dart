import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:navalha/core/colors.dart';
import 'package:navalha/mobile/calendar/widget/status_item.dart';
import 'package:navalha/shared/shows_dialogs/dialog.dart';
import 'cancel_appointment_dialog.dart';
import 'evaluate_botton_sheet.dart';

class ContainerCalendar extends StatelessWidget {
  final String nameBarberShop;
  final String day;
  final String mouth;
  final String hour;
  final String imgBarberShop;
  final String imgProfessional;
  final String nameProfessional;
  final String nameService;
  final double? priceService;
  final bool finalized;
  final String serviceId;
  final String customerId;
  final bool canceled;
  final bool reviewed;
  final String? professionalId;
  final int i;
  final String birthDate;

  const ContainerCalendar({
    Key? key,
    required this.nameBarberShop,
    required this.day,
    required this.mouth,
    required this.hour,
    required this.imgBarberShop,
    required this.imgProfessional,
    required this.nameProfessional,
    required this.nameService,
    required this.priceService,
    required this.finalized,
    required this.serviceId,
    required this.customerId,
    required this.canceled,
    required this.reviewed,
    required this.professionalId,
    required this.i,
    required this.birthDate,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    Size size = MediaQuery.of(context).size;

    return Column(
      children: [
        Container(
          margin: EdgeInsets.only(
            left: size.height * 0.01,
            right: size.height * 0.01,
            top: i != 0 ? size.height * 0.02 : 0,
          ),
          decoration: BoxDecoration(
            borderRadius: (!canceled)
                ? const BorderRadius.vertical(
                    top: Radius.circular(18),
                  )
                : const BorderRadius.all(Radius.circular(18)),
            color: colorContainers242424,
          ),
          child: Padding(
            padding: EdgeInsets.symmetric(
              horizontal: size.width * 0.03,
              vertical: size.height * 0.015,
            ),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.start,
              children: [
                SizedBox(
                  width: size.width * 0.59,
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Row(
                        mainAxisAlignment: MainAxisAlignment.start,
                        children: [
                          Container(
                            padding: EdgeInsets.zero,
                            width: size.height * 0.03,
                            height: size.height * 0.03,
                            child: CircleAvatar(
                              radius: size.height * 0.015,
                              backgroundColor: Colors.transparent,
                              backgroundImage: NetworkImage(imgBarberShop),
                            ),
                          ),
                          const SizedBox(width: 5),
                          SizedBox(
                            width: size.width * 0.5,
                            child: Text(
                              nameBarberShop,
                              overflow: TextOverflow.ellipsis,
                              style: const TextStyle(
                                fontSize: 20,
                                color: Colors.white,
                                fontWeight: FontWeight.w600,
                              ),
                            ),
                          ),
                        ],
                      ),
                      const SizedBox(height: 10),
                      Row(
                        children: [
                          getStatusContainer(finalized, canceled),
                        ],
                      ),
                      Row(
                        children: [
                          const Text(
                            'Serviço',
                            style: TextStyle(
                              color: Colors.white,
                              fontSize: 15,
                            ),
                          ),
                          const SizedBox(width: 10),
                          SizedBox(
                            width: size.width * 0.35,
                            child: Text(
                              nameService,
                              style: const TextStyle(
                                overflow: TextOverflow.ellipsis,
                                color: Color.fromARGB(255, 153, 153, 153),
                                fontSize: 14,
                              ),
                            ),
                          ),
                        ],
                      ),
                      Row(
                        children: [
                          const Text(
                            'Profissional',
                            style: TextStyle(
                              color: Colors.white,
                              fontSize: 15,
                            ),
                          ),
                          const SizedBox(width: 10),
                          SizedBox(
                            width: size.width * 0.31,
                            child: Text(
                              nameProfessional,
                              style: const TextStyle(
                                overflow: TextOverflow.ellipsis,
                                color: Color.fromARGB(255, 153, 153, 153),
                                fontSize: 14,
                              ),
                            ),
                          ),
                          const SizedBox(width: 10),
                        ],
                      ),
                      const SizedBox(height: 10),
                      Visibility(
                        visible: priceService != null,
                        child: Text(
                          'Total: R\$ ${priceService?.toStringAsFixed(2).replaceAll('.', ',')}',
                          style: const TextStyle(
                            color: Colors.white,
                            fontSize: 17,
                            fontWeight: FontWeight.w600,
                          ),
                        ),
                      ),
                    ],
                  ),
                ),
                Container(
                  margin: EdgeInsets.symmetric(horizontal: size.width * 0.06),
                  height: size.height * 0.12,
                  width: 1,
                  color: const Color.fromARGB(255, 68, 68, 68),
                ),
                Column(
                  children: [
                    Text(
                      mouth,
                      style: const TextStyle(
                        color: Colors.white,
                        fontSize: 14,
                      ),
                    ),
                    Text(
                      day,
                      style: const TextStyle(
                        color: Colors.white,
                        fontSize: 26,
                      ),
                    ),
                    Text(
                      hour,
                      style: const TextStyle(
                        color: Colors.white,
                        fontSize: 14,
                      ),
                    ),
                  ],
                ),
              ],
            ),
          ),
        ),
        Visibility(
          visible: !canceled,
          child: Row(
            children: [
              Visibility(
                visible: finalized && !reviewed,
                child: Expanded(
                  flex: 1,
                  child: _ContainerEvaluate(
                    barberShopName: nameBarberShop,
                    day: day,
                    imgProfessional: imgProfessional,
                    serviceName: nameService,
                    serviceId: serviceId,
                    customerId: customerId,
                    nameProfessional: nameProfessional,
                  ),
                ),
              ),
              Visibility(
                visible: !finalized,
                child: Expanded(
                  flex: 1,
                  child: _ContainerActive(
                    birthDate: birthDate,
                    professionalId: professionalId,
                    scheduleServiceId: serviceId,
                  ),
                ),
              )
            ],
          ),
        ),
      ],
    );
  }
}

class _ContainerEvaluate extends StatelessWidget {
  const _ContainerEvaluate({
    Key? key,
    required this.imgProfessional,
    required this.day,
    required this.serviceName,
    required this.barberShopName,
    required this.serviceId,
    required this.customerId,
    required this.nameProfessional,
  }) : super(key: key);

  final String imgProfessional;
  final String day;
  final String serviceName;
  final String barberShopName;
  final String serviceId;
  final String customerId;
  final String nameProfessional;

  @override
  Widget build(BuildContext context) {
    final size = MediaQuery.of(context).size;

    return Container(
      height: size.height * 0.045,
      margin: EdgeInsets.only(
        left: size.height * 0.01,
        right: size.height * 0.01,
      ),
      decoration: BoxDecoration(
        borderRadius: const BorderRadius.vertical(bottom: Radius.circular(18)),
        color: colorContainers353535,
      ),
      child: InkWell(
        borderRadius: const BorderRadius.vertical(bottom: Radius.circular(18)),
        onTap: () {
          showModalBottomSheet<void>(
            backgroundColor: Colors.transparent,
            isScrollControlled: true,
            isDismissible: true,
            context: context,
            builder: (BuildContext context) {
              return GestureDetector(
                onTap: () {
                  Navigator.of(context).pop();
                },
                child: EvaluateBottonSheet(
                  barberShopName: barberShopName,
                  day: day.replaceAll('-', '/'),
                  imgProfessional: imgProfessional,
                  serviceName: serviceName,
                  serviceId: serviceId,
                  customerId: customerId,
                ),
              );
            },
          );
        },
        child: Row(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            const Icon(
              CupertinoIcons.person_crop_circle_fill_badge_checkmark,
              color: Colors.white,
            ),
            SizedBox(width: size.width * 0.05),
            const Text(
              overflow: TextOverflow.ellipsis,
              textAlign: TextAlign.center,
              'Avaliar',
              style: TextStyle(
                color: Color.fromARGB(255, 219, 219, 219),
                fontSize: 15,
              ),
            ),
          ],
        ),
      ),
    );
  }
}

class _ContainerActive extends StatelessWidget {
  const _ContainerActive({
    Key? key,
    required this.scheduleServiceId,
    required this.professionalId,
    required this.birthDate,
  }) : super(key: key);

  final String scheduleServiceId;
  final String? professionalId;
  final String birthDate;

  @override
  Widget build(BuildContext context) {
    final size = MediaQuery.of(context).size;

    return Container(
      height: 35,
      margin: EdgeInsets.only(
        left: size.height * 0.01,
        right: size.height * 0.01,
      ),
      decoration: BoxDecoration(
        // boxShadow: shadow,
        borderRadius: const BorderRadius.vertical(bottom: Radius.circular(18)),
        color: colorContainers353535,
      ),
      child: Row(
        children: [
          Expanded(
            child: TextButton(
              style: TextButton.styleFrom(
                elevation: 0,
                foregroundColor: const Color.fromARGB(255, 36, 36, 36),
              ),
              onPressed: () => {
                showCustomDialog(
                  context,
                  CancelAppointmentDialog(
                    professionalId: professionalId,
                    scheduleServiceId: scheduleServiceId,
                  ),
                ),
              },
              child: const Text(
                textAlign: TextAlign.center,
                'Cancelar agendamento',
                style: TextStyle(
                  color: Colors.white,
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }
}

Widget getStatusContainer(bool finalized, bool canceled) {
  if (canceled) {
    return StatusItem(
      status: "Cancelado",
      color: colorRed1765959,
      textColor: Colors.black,
    );
  } else if (finalized) {
    return const StatusItem(
      status: "Finalizado",
      color: Colors.black,
      textColor: Colors.white,
    );
  } else {
    return StatusItem(
      status: "Agendado",
      color: colorYellow25020050,
      textColor: Colors.black,
    );
  }
}