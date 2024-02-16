// ignore_for_file: use_build_context_synchronously, prefer_const_constructors

import 'package:easy_debounce/easy_debounce.dart';
import 'package:firebase_analytics_web/firebase_analytics_web.dart';
import 'package:flutter/material.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:navalha/mobile/payment/model/response_schedule.dart';
import 'package:navalha/mobile/payment/provider/provider_create_schedule.dart';
import 'package:navalha/mobile/schedule/model/model_service_cache.dart';
import 'package:navalha/mobile/schedule/model/model_total_price.dart';
import 'package:navalha/mobile/schedule/schedule_page.dart';
import 'package:navalha/mobile/schedule/widgets/add_coupon_botton_sheet.dart';
import 'package:navalha/shared/utils.dart';
import 'package:navalha/web/db/db_customer_shared.dart';
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
  FirebaseAnalyticsWeb analytics = FirebaseAnalyticsWeb();
  String? couponName;

  void _trackFinalizeEvent(String customerId) {
    analytics.logEvent(
      name: 'finalize_service',
      parameters: <String, dynamic>{
        'customer_id': customerId,
      },
    );
  }

  bool loading = false;
  @override
  Widget build(BuildContext context) {
    return Consumer(
      builder: (context, ref, child) {
        CustomerDB? retrievedCustomer = LocalStorageManager.getCustomer();
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
              GestureDetector(
                onTap: () async {
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
                        child: AddCouponHourBottonSheet(
                          barberShop: barberShopProvider.state,
                          onChanged: (value) {
                            setState(() {
                              couponName = value;
                            });
                          },
                        ),
                      );
                    },
                  );
                },
                child: Visibility(
                  visible: serviceCache.state.isNotEmpty,
                  child: Padding(
                    padding: const EdgeInsets.only(left: 10, bottom: 5),
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.start,
                      children: [
                        Text(
                          couponName == null
                              ? 'Adicionar cupom de desconto'
                              : 'Trocar cupom de desconto',
                          style: const TextStyle(
                            color: Colors.white,
                          ),
                        ),
                        Visibility(
                          visible: couponName != null,
                          child: Text(
                            ': $couponName',
                            style: TextStyle(
                              color: colorFontUnable116116116,
                            ),
                          ),
                        ),
                      ],
                    ),
                  ),
                ),
              ),
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
                          if (retrievedCustomer != null) {
                            EasyDebounce.debounce('finalized-buy-service-web',
                                const Duration(milliseconds: 500), () async {
                              setState(() => loading = true);

                              ResponseCreateSchedule response =
                                  await createSchedule.createSchedule(
                                retrievedCustomer.customerId,
                                widget.barberShop.barbershopId!,
                                retrievedCustomer.token,
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
                                _trackFinalizeEvent(
                                    retrievedCustomer.customerId);
                                serviceCache.state.clear();
                                listResumePayment.state.clear();
                                Navigator.of(context).pushNamed('/approved');
                              } else {
                                setState(() {
                                  loading = false;
                                });
                                showSnackBar(context, 'Erro ao marcar serviço');
                              }

                              setState(() => loading = false);
                            });
                          } else {
                            Navigator.of(context).pushNamed('/login');
                            showSnackBar(context,
                                'Faça o login para agendar o serviço!');
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
