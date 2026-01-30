import 'package:flutter/material.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:intl/date_symbol_data_local.dart';
import 'package:intl/intl.dart';
import 'package:table_calendar/table_calendar.dart';
import 'package:navalha/mobile-DEPRECIATED/schedule/model/model_get_open_hours_by_date.dart';
import 'package:navalha/mobile-DEPRECIATED/schedule/provider/provider_get_open_hours_by_date.dart';
import 'package:navalha/shared/shimmer/shimmer_faq.dart';
import 'package:navalha/web/appointment/widgets/container_hours.dart';
import '../../../shared/providers.dart';
import '../../../shared/utils.dart';
import '../../../shared/widgets/widget_empty.dart';

final fetchOpenHoursProvider =
    FutureProvider.family<ResponseGetOpenHoursByDate, DateTime>(
        (ref, date) async {
  final openHoursController =
      ref.watch(GetOpenHoursByDateStateController.provider.notifier);
  final reservedTime = ref.watch(reservedTimeProvider);

  return openHoursController.getOpenHoursByDate(
    getAbbreviatedWeekday(date.weekday),
    reservedTime.professionalId!,
    reservedTime.serviceId!,
    formatDate(date),
  );
});

class CalendarWeb extends StatefulHookConsumerWidget {
  const CalendarWeb({
    super.key,
    required this.scrollToEnd,
  });

  final Function() scrollToEnd;

  @override
  CalendarState createState() => CalendarState();
}

class CalendarState extends ConsumerState<CalendarWeb> {
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
    final reservedTime = ref.read(reservedTimeProvider.state);
    DateTime initialDate = DateTime.now();

    final reservedDate = reservedTime.state.date;
    if (reservedDate != null && reservedDate.isNotEmpty) {
      try {
        initialDate = DateFormat('MM-dd-yyyy').parse(reservedDate);
      } catch (_) {
        initialDate = DateTime.now();
      }
    }

    _focusedDay = initialDate;
    _selectedDay = initialDate;
    WidgetsBinding.instance.addPostFrameCallback((_) {
      if (!mounted) {
        return;
      }
      final daySelectedController = ref.read(daySelectedProvider.state);
      daySelectedController.state = initialDate;
      ref.refresh(fetchOpenHoursProvider(initialDate));
    });
  }

  Key calendarKey = UniqueKey();

  @override
  Widget build(BuildContext context) {
    final reservedTime = ref.watch(reservedTimeProvider.state);
    final daySelectedController = ref.watch(daySelectedProvider.state);
    final response =
        ref.watch(fetchOpenHoursProvider(daySelectedController.state));
    final barberShop = ref.watch(barberShopSelectedProvider);

    // Define o lastDay baseado no scheduleAdvanceDays da barbearia
    final int advanceDays = barberShop.scheduleAdvanceDays ?? 30;
    final DateTime lastDay = DateTime.now().add(Duration(days: advanceDays));

    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        const Padding(
          padding: EdgeInsets.only(left: 12, top: 20),
          child: Text(
            '3. Escolha uma data',
            style: TextStyle(color: Colors.white),
          ),
        ),
        TableCalendar(
          key: calendarKey,
          pageAnimationEnabled: true,
          firstDay: DateTime(DateTime.now().year - 5, DateTime.now().month,
              DateTime.now().day),
          lastDay: lastDay,
          focusedDay: _focusedDay,
          calendarFormat: reservedTime.state.date != ''
              ? CalendarFormat.twoWeeks
              : CalendarFormat.month,
          selectedDayPredicate: (day) => isSameDay(_selectedDay, day),
          enabledDayPredicate: (day) {
            // Desabilita dias após o lastDay
            return !day.isAfter(lastDay);
          },
          daysOfWeekStyle: const DaysOfWeekStyle(
            weekdayStyle:
                TextStyle(color: Colors.white, fontWeight: FontWeight.bold),
            weekendStyle: TextStyle(
              color: Color.fromARGB(255, 121, 121, 121),
              fontWeight: FontWeight.bold,
            ),
          ),
          calendarStyle: const CalendarStyle(
            rangeHighlightColor: Colors.red,
            defaultTextStyle:
                TextStyle(color: Colors.white, fontWeight: FontWeight.bold),
            weekendTextStyle:
                TextStyle(color: Colors.white, fontWeight: FontWeight.bold),
            selectedDecoration: BoxDecoration(
              shape: BoxShape.circle,
              color: Color.fromARGB(255, 230, 198, 18),
            ),
            selectedTextStyle:
                TextStyle(color: Colors.black, fontWeight: FontWeight.bold),
            todayDecoration: BoxDecoration(
              shape: BoxShape.circle,
              color: Color.fromARGB(123, 116, 116, 116),
            ),
            // Estilo visual para dias desabilitados/bloqueados
            disabledDecoration: BoxDecoration(
              shape: BoxShape.circle,
              color: Color.fromARGB(50, 255, 0, 0),
            ),
            disabledTextStyle: TextStyle(
              color: Color.fromARGB(100, 255, 100, 100),
              fontWeight: FontWeight.bold,
              decoration: TextDecoration.lineThrough,
            ),
            outsideDecoration: BoxDecoration(
              shape: BoxShape.circle,
              color: Colors.transparent,
            ),
            outsideTextStyle: TextStyle(
              color: Color.fromARGB(80, 150, 150, 150),
            ),
          ),
          headerStyle: const HeaderStyle(
              titleCentered: true,
              titleTextStyle: TextStyle(
                color: Colors.white,
                fontSize: 20,
              ),
              leftChevronIcon:
                  Icon(Icons.chevron_left, color: Colors.white, size: 20),
              rightChevronIcon:
                  Icon(Icons.chevron_right, color: Colors.white, size: 20),
              formatButtonVisible: false),
          locale: 'pt_BR',
          onDaySelected: (selectedDay, focusedDay) {
            reservedTime.state.initialHour = '';
            selectedIndex = 10000;

            setState(() {
              daySelectedController.state = selectedDay;
              _selectedDay = selectedDay;
              _focusedDay = focusedDay;
            });

            ref.refresh(fetchOpenHoursProvider(selectedDay));
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
        response.when(
          loading: () => const ShimmerFaq(),
          error: (error, stackTrace) => WidgetEmpty(
            topSpace: 0,
            havebutton: false,
            haveIcon: false,
            title: title,
            subTitle: subtitle,
            text: 'Atualizar',
            onPressed: () => ref
                .refresh(fetchOpenHoursProvider(daySelectedController.state)),
          ),
          data: (data) {
            if (data.status == 'success') {
              reservedTime.state.listOpenHours = data.result;
              reservedTime.state.date = formatDate(daySelectedController.state);
              if (reservedTime.state.listOpenHours!.isEmpty) {
                title = 'Sem horários disponíveis';
                subtitle = 'O profissional está sem horários livres para hoje';
              }
            } else {
              reservedTime.state.listOpenHours = [];
              if (data.result == 'professional_date_has_closed') {
                title = 'Sem atendimento';
                subtitle = 'O profissional não está atendendo';
              } else if (data.result == 'barbershop_date_has_closed') {
                title = 'Barbearia fechada';
                subtitle = 'Barbearia sem atendimento nesse dia!';
              } else if (data.result == 'barbershop_date_has_disabled') {
                title = 'Barbearia fechada';
                subtitle = 'Barbearia sem atendimento nesse dia!';
              } else if (data.result == 'professional_date_has_disabled') {
                title = 'Sem atendimento';
                subtitle = 'O profissional não está atendendo';
              } else if (data.result == 'the_day_has_passed') {
                title = 'Esse dia já passou';
                subtitle = 'Não é possivel marcar horário em data passada';
              } else {
                showSnackBar(context, 'Ops, algo aconteceu.');
              }
            }
            return Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Visibility(
                  visible: reservedTime.state.listOpenHours!.isNotEmpty,
                  child: const Padding(
                    padding: EdgeInsets.only(left: 12, top: 20),
                    child: Text(
                      '4. Escolha um horário',
                      style: TextStyle(color: Colors.white),
                    ),
                  ),
                ),
                reservedTime.state.listOpenHours != null
                    ? reservedTime.state.listOpenHours!.isNotEmpty
                        ? Padding(
                            padding: const EdgeInsets.symmetric(horizontal: 8),
                            child: GridView.builder(
                              shrinkWrap: true,
                              physics: const NeverScrollableScrollPhysics(),
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
                                        reservedTime
                                            .state.listOpenHours![index].hour!;
                                    reservedTime.state.discount = reservedTime
                                        .state.listOpenHours![index].discount;
                                    widget.scrollToEnd();
                                  },
                                  dicount: reservedTime
                                      .state.listOpenHours![index].discount,
                                  hour: reservedTime
                                      .state.listOpenHours![index].hour!,
                                  selected: selectedIndex == index,
                                );
                              },
                              itemCount:
                                  reservedTime.state.listOpenHours!.length,
                            ),
                          )
                        : Center(
                            child: Padding(
                              padding: const EdgeInsets.symmetric(vertical: 40),
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
                    : const SizedBox(),
              ],
            );
          },
        ),
      ],
    );
  }
}
