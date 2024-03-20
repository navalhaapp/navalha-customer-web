// ignore_for_file: use_build_context_synchronously, prefer_const_constructors

import 'package:easy_debounce/easy_debounce.dart';
import 'package:firebase_analytics_web/firebase_analytics_web.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:navalha/mobile/payment/model/response_schedule.dart';
import 'package:navalha/mobile/payment/provider/provider_create_schedule.dart';
import 'package:navalha/mobile/schedule/schedule_page.dart';
import 'package:navalha/mobile/schedule/widgets/add_coupon_botton_sheet.dart';
import 'package:navalha/shared/shows_dialogs/dialog.dart';
import 'package:navalha/shared/utils.dart';
import 'package:navalha/web/appointment/fit_service/provider/provider_create_schedule.dart';
import 'package:navalha/web/appointment/text_edit_web.dart';
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

                                Navigator.of(context).pushNamed('/approved');
                                serviceCache.state.clear();
                                listResumePayment.state.clear();
                              } else {
                                showSnackBar(context, 'Erro ao marcar serviço');
                              }
                            });
                          } else {
                            showCustomDialog(
                              context,
                              FittingServiceDialog(
                                barberShop: widget.barberShop,
                              ),
                            );
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

class FittingServiceDialog extends StatefulWidget {
  const FittingServiceDialog({
    Key? key,
    required this.barberShop,
  }) : super(key: key);

  final BarberShop barberShop;

  @override
  State<FittingServiceDialog> createState() => _FittingServiceDialogState();
}

class _FittingServiceDialogState extends State<FittingServiceDialog> {
  var loading = false;

  @override
  Widget build(BuildContext context) {
    TextEditingController nameController = TextEditingController();
    return Consumer(
      builder: (context, ref, child) {
        final createSchedule =
            ref.watch(CreateScheduleFitStateController.provider.notifier);
        var serviceCache = ref.watch(listServicesCacheProvider.state);
        final listResumePayment = ref.watch(listResumePaymentProvider.notifier);
        return SizedBox(
          width: 500,
          child: AlertDialog(
            titlePadding: EdgeInsets.zero,
            contentPadding: EdgeInsets.zero,
            alignment: Alignment.center,
            shape: const RoundedRectangleBorder(
              borderRadius: BorderRadius.all(
                Radius.circular(32.0),
              ),
            ),
            scrollable: true,
            backgroundColor: colorBackground181818,
            title: Padding(
              padding: const EdgeInsets.only(top: 20),
              child: SizedBox(
                width: 22,
                child: const Text(
                  textAlign: TextAlign.center,
                  'Falta pouco...',
                  style: TextStyle(color: Colors.white),
                ),
              ),
            ),
            content: Column(
              children: [
                Padding(
                  padding: const EdgeInsets.symmetric(vertical: 20),
                  child: TextEditPatternWeb(
                    label: 'Nome',
                    obscure: false,
                    maxLength: 300,
                    controller: nameController,
                    hint: 'Digite o seu nome',
                    keyboardType: TextInputType.emailAddress,
                  ),
                ),
                Padding(
                  padding:
                      const EdgeInsets.symmetric(horizontal: 20, vertical: 20),
                  child: ElevatedButton(
                    style: ButtonStyle(
                      overlayColor: MaterialStateProperty.all<Color>(
                        colorContainers353535,
                      ),
                      elevation: MaterialStateProperty.all(0),
                      backgroundColor: MaterialStateProperty.all<Color>(
                          const Color.fromARGB(255, 28, 28, 28)),
                      shape: MaterialStateProperty.all<RoundedRectangleBorder>(
                        RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(12),
                        ),
                      ),
                    ),
                    onPressed: () async {
                      if (nameController.text == '') {
                        showSnackBar(context, 'Digite um nome');
                      } else {
                        setState(() => loading = true);
                        ResponseCreateSchedule response =
                            await createSchedule.createSchedule(
                          nameController.text,
                          widget.barberShop.barbershopId!,
                          listResumePayment.state.transactionAmount!,
                          listResumePayment.state.promotionalCodeDiscount ?? 0,
                          listResumePayment.state.promotionalCodePercent ?? 0,
                          listResumePayment.state.services,
                        );
                        if (response.status == 'success') {
                          setState(() => loading = false);
                          Navigator.of(context)
                              .pushNamed('/approved/fit-service');
                          serviceCache.state.clear();
                          listResumePayment.state.clear();
                        } else {
                          setState(() => loading = false);
                          showSnackBar(context, 'Erro ao marcar serviço');
                        }
                      }
                    },
                    child: Padding(
                      padding: const EdgeInsets.symmetric(
                          vertical: 10, horizontal: 5),
                      child: Center(
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: [
                            loading
                                ? const SizedBox(
                                    width: 20,
                                    height: 20,
                                    child: CircularProgressIndicator(
                                      color: Colors.white,
                                      strokeWidth: 2,
                                    ),
                                  )
                                : Row(
                                    children: const [
                                      Icon(
                                        CupertinoIcons.check_mark,
                                        color: Colors.white,
                                      ),
                                      SizedBox(width: 15),
                                      Text(
                                        'Agendar',
                                        style: TextStyle(
                                          color: Colors.white,
                                        ),
                                      ),
                                    ],
                                  ),
                          ],
                        ),
                      ),
                    ),
                  ),
                ),
              ],
            ),
          ),
        );
      },
    );
  }
}
