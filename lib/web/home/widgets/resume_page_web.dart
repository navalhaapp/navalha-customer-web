// ignore_for_file: use_build_context_synchronously

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:navalha/core/assets.dart';
import 'package:navalha/core/colors.dart';
import 'package:navalha/mobile-DEPRECIATED/home/model/response_get_barber_shop_by_id.dart';
import 'package:navalha/mobile-DEPRECIATED/schedule/model/model_reserved_time.dart';
import 'package:navalha/mobile-DEPRECIATED/schedule/schedule_page.dart';
import 'package:navalha/shared/providers.dart';
import 'package:navalha/shared/utils.dart';
import 'package:navalha/web/appointment/widgets/card_service_selected_web.dart';
import 'package:navalha/web/appointment/widgets/footer_total_price_web.dart';
import 'package:navalha/web/db/db_customer_shared.dart';

class ResumePageWeb extends StatefulWidget {
  const ResumePageWeb({
    Key? key,
    this.packageSelected,
    required this.serviceData,
    required this.onPreviousStep,
    required this.onNextStep,
  }) : super(key: key);

  final Map<String, dynamic> serviceData;
  final CustomerPackages? packageSelected;
  final void Function() onPreviousStep;
  final Function(Object) onNextStep;

  @override
  State<ResumePageWeb> createState() => _ResumePageWebState();
}

class _ResumePageWebState extends State<ResumePageWeb> {
  late StateController<ReservedTime> reservedTime;

  bool loading = false;
  String? couponName;
  @override
  Widget build(BuildContext context) {
    final barberShopId = Uri.base.queryParameters['id'] ??
        (Uri.base.queryParameters.values.isNotEmpty
            ? Uri.base.queryParameters.values.first
            : '');
    return AnimatedSize(
      duration: const Duration(milliseconds: 500),
      curve: Curves.easeInOut,
      child: Consumer(
        builder: (context, ref, child) {
          final retrievedCustomer = LocalStorageManager.getCustomer();
          var serviceCache = ref.watch(listServicesCacheProvider.state);
          var totalPriceProvider = ref.watch(totalPriceServiceProvider.state);
          totalPriceProvider.state.totalPriceWithoutDicount =
              calcTotalPrice(serviceCache.state);
          var barberShopProvider = ref.watch(barberShopSelectedProvider.state);
          final listResumePayment =
              ref.watch(listResumePaymentProvider.notifier);
          listResumePayment.state.barbershopId =
              barberShopProvider.state.barbershopId;
          listResumePayment.state.transactionAmount = calcPriceWithDiscount(
            totalPriceProvider.state.totalPriceWithoutDicount!,
            totalPriceProvider.state.discount ?? 0,
          );
          listResumePayment.state.promotionalCodeDiscount = calcDiscount(
              totalPriceProvider.state.totalPriceWithoutDicount!,
              totalPriceProvider.state.discount ?? 0);
          listResumePayment.state.promotionalCodePercent =
              totalPriceProvider.state.discount;
          Size size = MediaQuery.of(context).size;
          return Column(
            children: [
              Column(
                mainAxisSize: MainAxisSize.min,
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
                            widget.onPreviousStep.call();
                          },
                          icon: const Icon(
                            CupertinoIcons.clear,
                            color: Colors.white,
                          ),
                        ),
                        Text(
                          'Resumo',
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
                    padding: const EdgeInsets.symmetric(horizontal: 20),
                    child: Container(
                      decoration: BoxDecoration(
                        color: const Color(0xFF1C1C1C),
                        borderRadius: BorderRadius.circular(12),
                        border: Border.all(
                            color: Colors.white.withOpacity(0.06), width: 1),
                        boxShadow: [
                          BoxShadow(
                            color: Colors.black.withOpacity(0.20),
                            blurRadius: 10,
                            offset: const Offset(0, 6),
                          ),
                        ],
                      ),
                      child: Material(
                        color: Colors.transparent,
                        borderRadius: BorderRadius.circular(12),
                        child: InkWell(
                          borderRadius: BorderRadius.circular(12),
                          splashColor: colorContainers353535,
                          onTap: () {
                            widget.onPreviousStep.call();
                          },
                          child: Padding(
                            padding: const EdgeInsets.symmetric(
                                vertical: 10, horizontal: 5),
                            child: Row(
                              mainAxisAlignment: MainAxisAlignment.spaceBetween,
                              children: [
                                Column(
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  children: [
                                    Row(
                                      children: [
                                        const SizedBox(width: 10),
                                        const Icon(
                                          CupertinoIcons.add_circled_solid,
                                          color: Colors.white,
                                        ),
                                        const SizedBox(width: 15),
                                        Text(
                                          serviceCache.state.isEmpty
                                              ? 'Adicionar um serviço'
                                              : 'Adicionar outro serviço',
                                          style: const TextStyle(
                                              color: Colors.white),
                                        ),
                                      ],
                                    ),
                                  ],
                                ),
                                const Icon(
                                  CupertinoIcons.chevron_forward,
                                  color: Colors.white,
                                ),
                              ],
                            ),
                          ),
                        ),
                      ),
                    ),
                  ),

                  serviceCache.state.isNotEmpty
                      ? ListView.builder(
                          padding: EdgeInsets.zero,
                          shrinkWrap: true,
                          physics: const NeverScrollableScrollPhysics(),
                          itemCount: serviceCache.state.length,
                          itemBuilder: (context, index) {
                            return CardServiceSelectedWeb(
                              barberShop: barberShopProvider.state,
                              date: serviceCache.state[index].date!,
                              finalHour: serviceCache.state[index].finalHour!,
                              initialHour:
                                  serviceCache.state[index].initialHour!,
                              price: serviceCache.state[index].servicePrice!,
                              originalprice: serviceCache
                                      .state[index].serviceOriginalPrice ??
                                  0,
                              professionalImg: serviceCache
                                  .state[index].professional!.imgProfile!,
                              professionalName:
                                  serviceCache.state[index].professional!.name!,
                              observation:
                                  serviceCache.state[index].observation ?? '',
                              nameService:
                                  serviceCache.state[index].service!.name!,
                              cacheId: serviceCache.state[index].cachedId!,
                              i: index,
                              onConfirm: () => setState(() {}),
                            );
                          },
                        )
                      : Padding(
                          padding: const EdgeInsets.symmetric(vertical: 80),
                          child: Row(
                            mainAxisAlignment: MainAxisAlignment.center,
                            children: [
                              Image(
                                image: AssetImage(iconEmpyYellow),
                                height:
                                    MediaQuery.of(context).size.height * .04,
                              ),
                              SizedBox(
                                width: MediaQuery.of(context).size.width * 0.03,
                              ),
                              const Text(
                                'Nenhum serviço selecionado',
                                style: TextStyle(
                                  color: Colors.white,
                                  fontSize: 20,
                                ),
                              ),
                            ],
                          ),
                        ),
                ],
              ),
              FooterTotalPriceWeb(
                barberShop: barberShopProvider.state,
                haveDiscount: calcPriceWithDiscount(
                      totalPriceProvider.state.totalPriceWithoutDicount!,
                      totalPriceProvider.state.discount ?? 0,
                    ) !=
                    totalPriceProvider.state.totalPriceWithoutDicount!,
                totalPrice: calcTotalPrice(serviceCache.state),
                totalTime: calcTotalTime(serviceCache.state).toString(),
                totalPriceWithDiscount: calcPriceWithDiscount(
                  totalPriceProvider.state.totalPriceWithoutDicount!,
                  totalPriceProvider.state.discount ?? 0,
                ),
                onChangedCoupon: () => setState(() {}),
              ),
            ],
          );
        },
      ),
    );
  }
}
