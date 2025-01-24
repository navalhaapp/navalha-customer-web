import 'package:flutter/material.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:navalha/mobile-DEPRECIATED/calendar/calendar_page.dart';
import 'package:navalha/mobile-DEPRECIATED/calendar/model/model_get_schedule_customer.dart';
import 'package:navalha/mobile-DEPRECIATED/calendar/provider/provider_get_schedule_customer.dart';
import 'package:navalha/shared/widgets/top_container_title.dart';
import '../../../core/assets.dart';
import '../../../core/images_s3.dart';
import '../../login/controller/login_controller.dart';
import '../../../shared/animation/page_trasition.dart';
import '../../../shared/shimmer/shimmer_calendar.dart';
import '../../../shared/widgets/widget_empty.dart';
import 'container_calendar_web.dart';

class BodyCalendar extends StatefulHookConsumerWidget {
  const BodyCalendar({
    Key? key,
  }) : super(key: key);

  @override
  ConsumerState<BodyCalendar> createState() => _BodyCalendarState();
}

class _BodyCalendarState extends ConsumerState<BodyCalendar> {
  late ProviderFamilyGetScheduleModel getScheduleModel;

  @override
  void initState() {
    super.initState();

    final loginController = ref.read(LoginStateController.provider.notifier);

    getScheduleModel = ProviderFamilyGetScheduleModel(
      token: loginController.user!.token!,
      customerId: loginController.user!.customer!.customerId!,
    );

    setState(() {});
  }

  @override
  Widget build(BuildContext context) {
    final getSchedule = ref.watch(getScheduleCustomerList(getScheduleModel));

    return Consumer(
      builder: (context, ref, child) {
        final loginController =
            ref.read(LoginStateController.provider.notifier);
        return SingleChildScrollView(
          child: Column(
            children: [
              TopContainerTitle(
                imgProfile: loginController.user?.customer?.imgProfile ?? '',
                imgBackGround: imgBackgroundBarberShop,
                name: loginController.user?.customer?.name ?? 'Usuário',
              ),
              getSchedule.when(
                data: (data) {
                  List<ScheduleItemModel> listScheduleItem =
                      orderScheduleList(data.result!);
                  if (listScheduleItem.isNotEmpty) {
                    return Column(
                      children: [
                        for (int i = 0; i < listScheduleItem.length; i++)
                          ContainerCalendar(
                            birthDate:
                                loginController.user!.customer!.birthDate!,
                            canceled: listScheduleItem[i].canceled!,
                            reviewed: listScheduleItem[i].reviewed!,
                            professionalId: listScheduleItem[i]
                                .professional!
                                .professionalId,
                            serviceId: listScheduleItem[i].scheduleServiceId!,
                            customerId:
                                loginController.user!.customer!.customerId!,
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
                    );
                  } else {
                    return Center(
                      child: WidgetEmpty(
                        titleSize: 20,
                        topSpace: 0,
                        title: 'Nenhum agendamento',
                        subTitle: 'Você não possui nenhum agendamento',
                        text: 'Atualizar',
                        onPressed: () => navigationWithFadeAnimation(
                            const CalendarPage(), context),
                      ),
                    );
                  }
                },
                error: (error, stackTrace) => WidgetEmpty(
                  title: 'Ops, Algo aconteceu!',
                  subTitle: 'Houve algum erro, tente novamente mais tarde.',
                  onPressed: () {
                    navigationWithFadeAnimation(const CalendarPage(), context);
                  },
                  text: 'Tentar de novo',
                ),
                loading: () => const ShimmerCalendar(),
              ),
              SizedBox(height: MediaQuery.of(context).size.height * 0.1)
            ],
          ),
        );
      },
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
    // Extrai os anos das datas
    int yearA = int.parse(a.date!.split('-')[2]);
    int yearB = int.parse(b.date!.split('-')[2]);

    // Compara os anos
    final yearComparison = yearB.compareTo(yearA);
    if (yearComparison != 0) {
      return yearComparison;
    }

    // Compara as datas se os anos forem iguais
    final dateComparison = b.date!.compareTo(a.date!);
    if (dateComparison != 0) {
      return dateComparison;
    }

    // Compara as horas iniciais se as datas forem iguais
    return a.initialHour!.compareTo(b.initialHour!);
  });

  return scheduleList;
}
