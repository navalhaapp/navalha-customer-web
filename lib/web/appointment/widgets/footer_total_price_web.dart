// ignore_for_file: use_build_context_synchronously, prefer_const_constructors

import 'package:easy_debounce/easy_debounce.dart';
import 'package:flutter/material.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:navalha/approved_schedule/approved_schedule_page.dart';
import 'package:navalha/mobile/login/controller/login_controller.dart';
import 'package:navalha/mobile/payment/model/response_schedule.dart';
import 'package:navalha/mobile/payment/provider/provider_create_schedule.dart';
import 'package:navalha/mobile/schedule/schedule_page.dart';
import 'package:navalha/shared/utils.dart';
import 'package:navalha/shared/widgets/page_transition.dart';
import 'package:navalha/web/appointment/widgets/calendar_page_web.dart';
import 'package:navalha/web/appointment/widgets/login_page_web.dart';
import '../../../core/colors.dart';
import '../../../shared/model/barber_shop_model.dart';
import '../../../shared/providers.dart';

class FooterTotalPriceWeb extends StatefulWidget {
  const FooterTotalPriceWeb({
    Key? key,
    required this.totalPrice,
    required this.totalPriceWithDiscount,
    required this.totalTime,
    required this.haveDiscount,
    required this.barberShop,
  }) : super(key: key);

  final double totalPrice;
  final double totalPriceWithDiscount;
  final String totalTime;
  final bool haveDiscount;
  final BarberShop barberShop;

  @override
  State<FooterTotalPriceWeb> createState() => _FooterTotalPriceWebState();
}

class _FooterTotalPriceWebState extends State<FooterTotalPriceWeb> {
  bool loading = false;
  @override
  Widget build(BuildContext context) {
    final size = MediaQuery.of(context).size;
    return Consumer(
      builder: (context, ref, child) {
        final loginController =
            ref.watch(LoginStateController.provider.notifier);
        var serviceCache = ref.watch(listServicesCacheProvider.state);
        final listResumePayment = ref.watch(listResumePaymentProvider.notifier);
        final createSchedule =
            ref.watch(CreateScheduleStateController.provider.notifier);
        var barberShopProvider = ref.watch(barberShopSelectedProvider.state);
        listResumePayment.state.barbershopId =
            barberShopProvider.state.barbershopId;
        var totalPriceProvider = ref.watch(totalPriceServiceProvider.state);
        listResumePayment.state.transactionAmount = calcPriceWithDiscount(
          totalPriceProvider.state.totalPriceWithoutDicount!,
          totalPriceProvider.state.discount ?? 0,
        );
        listResumePayment.state.promotionalCodeDiscount = calcDiscount(
            totalPriceProvider.state.totalPriceWithoutDicount!,
            totalPriceProvider.state.discount ?? 0);
        listResumePayment.state.promotionalCodePercent =
            totalPriceProvider.state.discount;
        return Container(
          decoration: BoxDecoration(
            color: colorContainers242424,
            borderRadius: BorderRadius.circular(15),
          ),
          margin: EdgeInsets.only(bottom: 15, left: 30),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.center,
            mainAxisAlignment: MainAxisAlignment.start,
            children: [
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Padding(
                    padding: const EdgeInsets.symmetric(horizontal: 8),
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.center,
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Column(
                          mainAxisAlignment: MainAxisAlignment.start,
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Text(
                              'R\$ ${widget.totalPrice.toStringAsFixed(2).replaceAll('.', ',')}',
                              style: widget.haveDiscount
                                  ? TextStyle(
                                      color: colorFontUnable116116116,
                                      fontWeight: FontWeight.w600,
                                      fontSize: 15,
                                      decoration: TextDecoration.lineThrough,
                                    )
                                  : const TextStyle(
                                      color: Colors.white,
                                      fontWeight: FontWeight.w600,
                                      fontSize: 20,
                                    ),
                            ),
                            Visibility(
                              visible: widget.haveDiscount,
                              child: Text(
                                'R\$ ${widget.totalPriceWithDiscount.toStringAsFixed(2).replaceAll('.', ',')}',
                                style: const TextStyle(
                                  color: Colors.white,
                                  fontWeight: FontWeight.w600,
                                  fontSize: 20,
                                ),
                              ),
                            ),
                          ],
                        ),
                        Text(
                          '${widget.totalTime}min',
                          style: TextStyle(
                            color: colorFontUnable116116116,
                            fontWeight: FontWeight.w600,
                          ),
                        ),
                      ],
                    ),
                  ),
                  Visibility(
                    visible: serviceCache.state.isNotEmpty,
                    child: Container(
                      margin: EdgeInsets.symmetric(horizontal: 8),
                      width: 150,
                      height: 50,
                      decoration: BoxDecoration(
                        color: colorContainers242424,
                        borderRadius: const BorderRadius.all(
                          Radius.circular(18),
                        ),
                      ),
                      child: ElevatedButton(
                        style: ButtonStyle(
                          elevation: MaterialStateProperty.all(0),
                          backgroundColor: MaterialStateProperty.all<Color>(
                            Color.fromARGB(255, 28, 28, 28),
                          ),
                          overlayColor: MaterialStateProperty.all<Color>(
                            colorContainers353535,
                          ),
                          shape:
                              MaterialStateProperty.all<RoundedRectangleBorder>(
                            RoundedRectangleBorder(
                              borderRadius: BorderRadius.circular(14),
                            ),
                          ),
                        ),
                        child: !loading
                            ? const Text(
                                'Finalizar',
                                style: TextStyle(
                                  fontSize: 17,
                                  color: Colors.white,
                                ),
                              )
                            : const SizedBox(
                                width: 20,
                                height: 20,
                                child: CircularProgressIndicator(
                                  color: Colors.white,
                                  strokeWidth: 2,
                                ),
                              ),
                        onPressed: () {
                          if (loginController.user != null) {
                            EasyDebounce.debounce('finalized-buy-service-web',
                                const Duration(milliseconds: 500), () async {
                              setState(() => loading = true);

                              ResponseCreateSchedule response =
                                  await createSchedule.createSchedule(
                                loginController.user!.customer!.customerId!,
                                widget.barberShop.barbershopId!,
                                loginController.user!.token!,
                                listResumePayment.state.transactionAmount!,
                                listResumePayment
                                        .state.promotionalCodeDiscount ??
                                    0,
                                listResumePayment
                                        .state.promotionalCodePercent ??
                                    0,
                                listResumePayment.state.services,
                              );
                              if (response.status == 'success') {
                                navigationFadePush(
                                    ApprovedSchedulePage(
                                        page: CalendarPageWeb()),
                                    context);
                              } else {
                                setState(() {
                                  loading = false;
                                });
                                showSnackBar(context, 'Erro ao marcar serviço');
                              }

                              setState(() => loading = false);
                            });
                          } else {
                            navigationFadePushReplacement(
                                const LoginPageWeb(), context);
                          }
                        },
                      ),
                    ),
                  )
                ],
              ),
            ],
          ),
        );
      },
    );
  }
}