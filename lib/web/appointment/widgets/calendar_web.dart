// Developer            Data              Descrição
// Rovigo               24/08/2022        Criação da calendar (client).

// ignore_for_file: use_build_context_synchronously

import 'package:flutter/material.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:intl/date_symbol_data_local.dart';
import 'package:navalha/core/colors.dart';
import 'package:navalha/mobile/schedule/model/model_reserved_time.dart';
import 'package:navalha/mobile/schedule/widgets/observation_botton_sheet.dart';
import 'package:navalha/web/appointment/widgets/container_hours.dart';
import 'package:table_calendar/table_calendar.dart';
import 'package:navalha/mobile/schedule/model/model_get_open_hours_by_date.dart';
import 'package:navalha/mobile/schedule/provider/provider_get_open_hours_by_date.dart';
import 'package:navalha/shared/model/open_hour_model.dart';
import 'package:navalha/shared/shimmer/shimmer_faq.dart';
import '../../../shared/providers.dart';
import '../../../shared/utils.dart';
import '../../../shared/widgets/widget_empty.dart';

class CalendarWeb extends StatefulHookConsumerWidget {
  static const String page = '/calendar-page-web';
  const CalendarWeb({super.key});

  @override
  CalendarState createState() => CalendarState();
}

class CalendarState extends ConsumerState<CalendarWeb> {
  late StateController<ReservedTime> reservedTime;
  CalendarFormat _calendarFormat = CalendarFormat.week;
  DateTime _focusedDay = DateTime.now();
  DateTime? _selectedDay;
  String title = '';
  String subtitle = '';
  int selectedIndex = 10000;

  @override
  void initState() {
    super.initState();
    initializeDateFormatting();
  }

  @override
  Widget build(BuildContext context) {
    return Consumer(
      builder: (context, ref, child) {
        final openHoursController =
            ref.watch(GetOpenHoursByDateStateController.provider.notifier);
        reservedTime = ref.watch(reservedTimeProvider.state);
        var daySelectedController = ref.watch(daySelectedProvider.state);
        Future<ResponseGetOpenHoursByDate> fetchData(DateTime date) async {
          ResponseGetOpenHoursByDate response =
              await openHoursController.getOpenHoursByDate(
            getAbbreviatedWeekday(date.weekday),
            reservedTime.state.professionalId!,
            reservedTime.state.serviceId!,
            formatDate(date),
          );
          return response;
        }

        return FutureBuilder(
          future: fetchData(daySelectedController.state),
          builder: (BuildContext context,
              AsyncSnapshot<ResponseGetOpenHoursByDate> snapshot) {
            if (snapshot.connectionState == ConnectionState.waiting) {
              return const ShimmerFaq();
            } else if (snapshot.hasError) {
              return WidgetEmpty(
                topSpace: 0,
                havebutton: false,
                haveIcon: false,
                title: title,
                subTitle: subtitle,
                text: 'Atualizar',
                onPressed: () {
                  setState(() {});
                },
              );
            } else {
              if (snapshot.data!.result.runtimeType != String) {
                reservedTime.state.listOpenHours = snapshot.data!.result;
                reservedTime.state.date =
                    formatDate(daySelectedController.state);
                if (reservedTime.state.listOpenHours!.isEmpty) {
                  title = 'Sem horários disponíveis';
                  subtitle =
                      'O profissional está sem horários livres para hoje';
                }
              } else if (snapshot.data!.result ==
                  'professional_date_has_closed') {
                title = 'Sem atendimento';
                subtitle = 'O profissional não está atendendo';
              } else if (snapshot.data!.result ==
                  'barbershop_date_has_closed') {
                title = 'Barbearia fechada';
                subtitle = 'Barbearia sem atendimento nesse dia!';
              } else if (snapshot.data!.result ==
                  'barbershop_date_has_disabled') {
                title = 'Barbearia fechada';
                subtitle = 'Barbearia sem atendimento nesse dia!';
              } else if (snapshot.data!.result ==
                  'professional_date_has_disabled') {
                title = 'Sem atendimento';
                subtitle = 'O profissional não está atendendo';
              } else if (snapshot.data!.result == 'the_day_has_passed') {
                title = 'Esse dia já passou';
                subtitle = 'Não é possivel marcar horário em data passada';
              } else {
                showSnackBar(context, 'Ops, algo aconteceu.');
              }

              return Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  const Padding(
                    padding: EdgeInsets.only(
                      left: 12,
                      top: 20,
                    ),
                    child: Text(
                      '3. Escolha uma data',
                      style: TextStyle(
                        color: Colors.white,
                      ),
                    ),
                  ),
                  TableCalendar(
                    pageAnimationEnabled: true,
                    firstDay: DateTime(DateTime.now().year - 5,
                        DateTime.now().month, DateTime.now().day),
                    lastDay: DateTime(DateTime.now().year + 5,
                        DateTime.now().month, DateTime.now().day),
                    focusedDay: _focusedDay,
                    calendarFormat: reservedTime.state.date != ''
                        ? CalendarFormat.twoWeeks
                        : CalendarFormat.month,
                    selectedDayPredicate: (day) {
                      return isSameDay(_selectedDay, day);
                    },
                    daysOfWeekStyle: const DaysOfWeekStyle(
                      weekdayStyle: TextStyle(
                          color: Colors.white, fontWeight: FontWeight.bold),
                      weekendStyle: TextStyle(
                        color: Color.fromARGB(255, 121, 121, 121),
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                    calendarStyle: const CalendarStyle(
                      rangeHighlightColor: Colors.red,
                      disabledTextStyle: TextStyle(
                        color: Color.fromARGB(255, 255, 255, 255),
                      ),
                      defaultTextStyle: TextStyle(
                        color: Colors.white,
                        fontWeight: FontWeight.bold,
                      ),
                      weekendTextStyle: TextStyle(
                        color: Colors.white,
                        fontWeight: FontWeight.bold,
                      ),
                      selectedDecoration: BoxDecoration(
                        shape: BoxShape.circle,
                        color: Color.fromARGB(255, 230, 198, 18),
                      ),
                      selectedTextStyle: TextStyle(
                        color: Colors.black,
                        fontWeight: FontWeight.bold,
                      ),
                      todayDecoration: BoxDecoration(
                        shape: BoxShape.circle,
                        color: Color.fromARGB(123, 116, 116, 116),
                      ),
                    ),
                    headerStyle: const HeaderStyle(
                        titleCentered: true,
                        titleTextStyle: TextStyle(
                          color: Color.fromARGB(255, 255, 255, 255),
                          fontSize: 20,
                        ),
                        leftChevronIcon: Icon(
                          Icons.chevron_left,
                          color: Colors.white,
                          size: 20,
                        ),
                        rightChevronIcon: Icon(
                          Icons.chevron_right,
                          color: Colors.white,
                          size: 20,
                        ),
                        formatButtonVisible: false),
                    locale: 'pt_BR',
                    onDaySelected: (selectedDay, focusedDay) async {
                      reservedTime.state.initialHour = '';
                      selectedIndex = 10000;
                      daySelectedController.state = selectedDay;

                      if (!isSameDay(_selectedDay, selectedDay)) {
                        ResponseGetOpenHoursByDate response =
                            await openHoursController.getOpenHoursByDate(
                          getAbbreviatedWeekday(selectedDay.weekday),
                          reservedTime.state.professionalId!,
                          reservedTime.state.serviceId!,
                          formatDate(selectedDay),
                        );

                        if (response.status == 'success') {
                          reservedTime.state.date = formatDate(selectedDay);
                          reservedTime.state.listOpenHours =
                              response.result as List<OpenHour>;
                          if (reservedTime.state.listOpenHours!.isEmpty) {
                            title = 'Sem horários disponíveis';
                            subtitle =
                                'O profissional está sem horários livres para hoje';
                          }
                        } else {
                          reservedTime.state.listOpenHours = null;
                          String result = response.result.toString();
                          if (result == 'professional_date_has_closed') {
                            title = 'Sem atendimento';
                            subtitle = 'O profissional não está atendendo';
                          } else if (result == 'barbershop_date_has_closed') {
                            title = 'Barbearia fechada';
                            subtitle = 'Barbearia sem atendimento nesse dia!';
                          } else if (result == 'barbershop_date_has_disabled') {
                            title = 'Barbearia fechada';
                            subtitle = 'Barbearia sem atendimento nesse dia!';
                          } else if (result ==
                              'professional_date_has_disabled') {
                            title = 'Sem atendimento';
                            subtitle = 'O profissional não está atendendo';
                          } else if (result == 'the_day_has_passed') {
                            title = 'Esse dia já passou';
                            subtitle =
                                'Não é possivel marcar horário em data passada';
                          } else {
                            showSnackBar(context, 'Ops, algo aconteceu.');
                          }
                        }
                        setState(() {
                          _selectedDay = selectedDay;
                          _focusedDay = focusedDay;
                        });
                      } else {
                        setState(() {
                          _selectedDay = null;
                        });
                      }
                    },
                    onFormatChanged: (format) {
                      if (_calendarFormat != format) {
                        setState(() {
                          _calendarFormat = format;
                        });
                      }
                    },
                    onPageChanged: (focusedDay) {
                      _focusedDay = focusedDay;
                    },
                  ),
                  Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Visibility(
                        visible: reservedTime.state.date != '',
                        child: const Padding(
                          padding: EdgeInsets.only(
                            left: 12,
                            top: 20,
                          ),
                          child: Text(
                            textAlign: TextAlign.left,
                            '4. Escolha um horário',
                            style: TextStyle(
                              color: Colors.white,
                            ),
                          ),
                        ),
                      ),
                      reservedTime.state.listOpenHours != null
                          ? reservedTime.state.listOpenHours!.isNotEmpty
                              ? Padding(
                                  padding:
                                      const EdgeInsets.symmetric(horizontal: 8),
                                  child: GridView.builder(
                                    shrinkWrap: true,
                                    physics:
                                        const NeverScrollableScrollPhysics(),
                                    gridDelegate:
                                        const SliverGridDelegateWithFixedCrossAxisCount(
                                      crossAxisCount: 4,
                                      crossAxisSpacing: 5,
                                      mainAxisSpacing: 0,
                                      childAspectRatio: 1.2 / 0.5,
                                    ),
                                    itemBuilder: (context, index) {
                                      return ContainerHoursWeb(
                                        onPressed: () {
                                          setState(() {
                                            selectedIndex = index;
                                          });
                                          reservedTime.state.initialHour =
                                              reservedTime.state
                                                  .listOpenHours![index].hour!;
                                          reservedTime.state.discount =
                                              reservedTime
                                                  .state
                                                  .listOpenHours![index]
                                                  .discount;
                                        },
                                        dicount: reservedTime.state
                                            .listOpenHours![index].discount,
                                        hour: reservedTime
                                            .state.listOpenHours![index].hour!,
                                        selected: selectedIndex == index,
                                      );
                                    },
                                    itemCount: reservedTime
                                        .state.listOpenHours!.length,
                                  ),
                                )
                              : reservedTime.state.date != ''
                                  ? Center(
                                      child: Padding(
                                        padding: const EdgeInsets.symmetric(
                                            vertical: 30),
                                        child: WidgetEmpty(
                                          topSpace: 0,
                                          havebutton: false,
                                          haveIcon: false,
                                          title: title,
                                          subTitle: subtitle,
                                          text: 'Atualizar',
                                          onPressed: () {},
                                        ),
                                      ),
                                    )
                                  : const SizedBox()
                          : Center(
                              child: Padding(
                                padding:
                                    const EdgeInsets.symmetric(vertical: 2),
                                child: WidgetEmpty(
                                  topSpace: 0,
                                  havebutton: false,
                                  haveIcon: false,
                                  title: title,
                                  subTitle: subtitle,
                                  text: 'Atualizar',
                                  onPressed: () {},
                                ),
                              ),
                            ),
                      // Visibility(
                      //   visible: reservedTime.state.date != '',
                      //   child: Padding(
                      //     padding: const EdgeInsets.symmetric(vertical: 10),
                      //     child: ElevatedButton(
                      //       style: ButtonStyle(
                      //         overlayColor: MaterialStateProperty.all<Color>(
                      //           colorContainers353535,
                      //         ),
                      //         elevation: MaterialStateProperty.all(0),
                      //         backgroundColor: MaterialStateProperty.all<Color>(
                      //             Colors.transparent),
                      //         shape: MaterialStateProperty.all<
                      //             RoundedRectangleBorder>(
                      //           RoundedRectangleBorder(
                      //             borderRadius: BorderRadius.circular(12),
                      //           ),
                      //         ),
                      //       ),
                      //       child: const Row(
                      //         children: [
                      //           Icon(Icons.add, size: 17, color: Colors.white),
                      //           SizedBox(width: 3),
                      //           Text(
                      //             'Adicionar uma observação',
                      //             style: TextStyle(
                      //               color: Colors.white,
                      //             ),
                      //           ),
                      //         ],
                      //       ),
                      //       onPressed: () {
                      //         showModalBottomSheet<void>(
                      //           backgroundColor: Colors.black,
                      //           isScrollControlled: true,
                      //           shape: RoundedRectangleBorder(
                      //             borderRadius: BorderRadius.circular(20),
                      //           ),
                      //           context: context,
                      //           builder: (BuildContext context) {
                      //             return ObservationBottomSheet(
                      //               initialObservation: observation,
                      //               onChanged: (value) {
                      //                 setState(() {
                      //                   observation = value;
                      //                 });
                      //               },
                      //             );
                      //           },
                      //         );
                      //       },
                      //     ),
                      //   ),
                      // ),
                      // Padding(
                      //   padding: const EdgeInsets.symmetric(
                      //       horizontal: 20, vertical: 5),
                      //   child: Text(observation),
                      // )
                    ],
                  )
                ],
              );
            }
          },
        );
      },
    );
  }
}
