import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:navalha/core/colors.dart';
import 'package:navalha/mobile-DEPRECIATED/calendar/model/model_get_schedule_customer.dart';
import 'package:navalha/mobile-DEPRECIATED/calendar/provider/provider_get_schedule_customer.dart';
import 'package:navalha/web/appointment/widgets/calendar_page_web.dart';
import 'package:navalha/web/appointment/widgets/container_calendar_web.dart';
import 'package:navalha/web/db/db_customer_shared.dart';
import '../../../shared/animation/page_trasition.dart';
import '../../../shared/shimmer/shimmer_calendar.dart';
import '../../../shared/widgets/widget_empty.dart';

class BodyCalendarWeb extends StatefulHookConsumerWidget {
  const BodyCalendarWeb({
    Key? key,
  }) : super(key: key);

  @override
  ConsumerState<BodyCalendarWeb> createState() => _BodyCalendarWebState();
}

class _BodyCalendarWebState extends ConsumerState<BodyCalendarWeb> {
  late ProviderFamilyGetScheduleModel getScheduleModel;

  @override
  void initState() {
    super.initState();
    final retrievedCustomer = LocalStorageManager.getCustomer();

    getScheduleModel = ProviderFamilyGetScheduleModel(
      token: retrievedCustomer!.token,
      customerId: retrievedCustomer.customerId,
    );

    // setState(() {});
  }

  @override
  Widget build(BuildContext context) {
    CustomerDB? retrievedCustomer = LocalStorageManager.getCustomer();
    final getSchedule = ref.watch(getScheduleCustomerList(getScheduleModel));
    return getSchedule.when(
      data: (data) {
        String url = Uri.base.toString();
        String params = Uri.splitQueryString(url).values.first;
        List<ScheduleItemModel> listScheduleItem =
            orderScheduleList(data.result!);
        if (listScheduleItem.isNotEmpty) {
          return Consumer(
            builder: (context, ref, child) {
              return SingleChildScrollView(
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Padding(
                      padding:
                          const EdgeInsets.only(left: 10, top: 20, bottom: 20),
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          IconButton(
                            padding: const EdgeInsets.only(left: 30),
                            onPressed: () {
                              Navigator.of(context).pushNamed(
                                '/',
                                arguments: {'barbershop_id': params},
                              );
                            },
                            icon: const Icon(
                              CupertinoIcons.clear,
                              color: Colors.white,
                            ),
                          ),
                          Text(
                            'Meus agendamentos',
                            style: TextStyle(
                              fontSize: 20,
                              shadows: shadow,
                              color: Colors.white,
                            ),
                          ),
                          IconButton(
                            padding: const EdgeInsets.only(left: 30),
                            onPressed: () {},
                            icon: const Icon(
                              CupertinoIcons.clear,
                              color: Colors.transparent,
                            ),
                          ),
                        ],
                      ),
                    ),
                    Padding(
                      padding: const EdgeInsets.only(
                        left: 20,
                        right: 20,
                        top: 10,
                        bottom: 10,
                      ),
                      child: ElevatedButton(
                        style: ButtonStyle(
                          overlayColor: MaterialStateProperty.all<Color>(
                            colorContainers353535,
                          ),
                          elevation: MaterialStateProperty.all(0),
                          backgroundColor: MaterialStateProperty.all<Color>(
                              const Color.fromARGB(255, 28, 28, 28)),
                          shape:
                              MaterialStateProperty.all<RoundedRectangleBorder>(
                            RoundedRectangleBorder(
                              borderRadius: BorderRadius.circular(12),
                            ),
                          ),
                        ),
                        onPressed: () {
                          Navigator.of(context).pushNamed(
                            '/',
                            arguments: {'barbershop_id': params},
                          );
                        },
                        child: const Padding(
                          padding:
                              EdgeInsets.symmetric(vertical: 10, horizontal: 5),
                          child: Row(
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            children: [
                              Column(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  Row(
                                    children: [
                                      Icon(
                                        CupertinoIcons.add_circled_solid,
                                        color: Colors.white,
                                      ),
                                      SizedBox(width: 15),
                                      Text(
                                        'Marcar um serviço',
                                        style: TextStyle(
                                          color: Colors.white,
                                        ),
                                      ),
                                    ],
                                  ),
                                ],
                              ),
                              Icon(
                                CupertinoIcons.chevron_forward,
                                color: Colors.white,
                              ),
                            ],
                          ),
                        ),
                      ),
                    ),
                    for (int i = 0; i < listScheduleItem.length; i++)
                      ContainerCalendarWeb(
                        birthDate: retrievedCustomer!.birthDate,
                        canceled: listScheduleItem[i].canceled!,
                        reviewed: listScheduleItem[i].reviewed!,
                        professionalId:
                            listScheduleItem[i].professional!.professionalId,
                        serviceId: listScheduleItem[i].scheduleServiceId!,
                        customerId: retrievedCustomer!.customerId,
                        nameService: listScheduleItem[i].service!.name!,
                        priceService: listScheduleItem[i].service!.price,
                        nameBarberShop:
                            listScheduleItem[i].barbershop!.barbershopName!,
                        day: listScheduleItem[i].date!.substring(3, 5),
                        mouth: pickMonth(
                            listScheduleItem[i].date!.substring(0, 2)),
                        hour: listScheduleItem[i].initialHour!,
                        imgProfessional:
                            listScheduleItem[i].professional!.imgProfile!,
                        imgBarberShop:
                            listScheduleItem[i].barbershop!.imgProfile!,
                        nameProfessional:
                            listScheduleItem[i].professional!.name!,
                        finalized: listScheduleItem[i].finalized!,
                        i: i,
                      ),
                    SizedBox(
                      height: MediaQuery.of(context).size.height * 0.05,
                    )
                  ],
                ),
              );
            },
          );
        } else {
          return WidgetEmpty(
            titleSize: 20,
            topSpace: 0,
            title: 'Nenhum agendamento',
            subTitle: 'Você não possui nenhum agendamento',
            text: 'Atualizar',
            onPressed: () =>
                navigationWithFadeAnimation(const CalendarPageWeb(), context),
          );
        }
      },
      error: (error, stackTrace) => WidgetEmpty(
        title: 'Ops, Algo aconteceu!',
        subTitle: 'Houve algum erro, tente novamente mais tarde.',
        onPressed: () {
          Navigator.pushNamed(context, '/login');
          LocalStorageManager.clearCustomer();
        },
        text: 'Tentar de novo',
      ),
      loading: () => const ShimmerCalendar(),
    );
  }
}

String pickMonth(String numeroMes) {
  switch (numeroMes) {
    case '01':
      return 'Janeiro';
    case '02':
      return 'Fevereiro';
    case '03':
      return 'Março';
    case '04':
      return 'Abril';
    case '05':
      return 'Maio';
    case '06':
      return 'Junho';
    case '07':
      return 'Julho';
    case '08':
      return 'Agosto';
    case '09':
      return 'Setembro';
    case '10':
      return 'Outubro';
    case '11':
      return 'Novembro';
    case '12':
      return 'Dezembro';
    default:
      return 'Mês inválido';
  }
}

List<ScheduleItemModel> orderScheduleList(
    List<ScheduleItemModel> scheduleList) {
  scheduleList.sort((a, b) {
    final dateComparison = b.date!.compareTo(a.date!);
    if (dateComparison != 0) {
      return dateComparison;
    }

    return a.initialHour!.compareTo(b.initialHour!);
  });

  return scheduleList;
}
