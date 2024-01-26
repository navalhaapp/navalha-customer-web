// ignore_for_file: use_build_context_synchronously

import 'dart:html';

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:navalha/core/assets.dart';
import 'package:navalha/core/colors.dart';
import 'package:navalha/mobile/login/controller/login_controller.dart';
import 'package:navalha/mobile/schedule/model/model_reserved_time.dart';
import 'package:navalha/mobile/schedule/schedule_page.dart';
import 'package:navalha/mobile/schedule/widgets/add_coupon_botton_sheet.dart';
import 'package:navalha/shared/providers.dart';
import 'package:navalha/shared/utils.dart';
import 'package:navalha/shared/widgets/page_transition.dart';
import 'package:navalha/web/appointment/widgets/card_service_selected_web.dart';
import 'package:navalha/web/appointment/widgets/drawer_page_web.dart';
import 'package:navalha/web/appointment/widgets/footer_total_price_web.dart';
import 'package:navalha/web/appointment/widgets/services_page_web.dart';

class ResumePageWeb extends StatefulWidget {
  static const route = '/resume-page';
  const ResumePageWeb({
    Key? key,
  }) : super(key: key);

  @override
  State<ResumePageWeb> createState() => _ResumePageWebState();
}

class _ResumePageWebState extends State<ResumePageWeb> {
  late StateController<ReservedTime> reservedTime;

  bool loading = false;
  @override
  Widget build(BuildContext context) {
    return Consumer(
      builder: (context, ref, child) {
        final loginController =
            ref.read(LoginStateController.provider.notifier);
        var serviceCache = ref.watch(listServicesCacheProvider.state);
        var totalPriceProvider = ref.watch(totalPriceServiceProvider.state);
        totalPriceProvider.state.totalPriceWithoutDicount =
            calcTotalPrice(serviceCache.state);
        var barberShopProvider = ref.watch(barberShopSelectedProvider.state);
        final listResumePayment = ref.watch(listResumePaymentProvider.notifier);
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
        return Scaffold(
          backgroundColor: colorBackground181818,
          drawer: const DrawerPageWeb(),
          appBar: AppBar(
            title: Text(barberShopProvider.state.name ?? ''),
            elevation: 0,
            backgroundColor: colorBackground181818,
            actions: [
              loginController.user?.customer?.imgProfile == null
                  ? Container(
                      margin: const EdgeInsets.symmetric(
                          horizontal: 10, vertical: 5),
                      width: 40,
                      height: 40,
                      decoration: BoxDecoration(
                        shape: BoxShape.circle,
                        image: DecorationImage(
                          image: AssetImage(iconLogoApp),
                          fit: BoxFit.contain,
                        ),
                      ),
                    )
                  : Container(
                      margin: const EdgeInsets.symmetric(
                          horizontal: 10, vertical: 5),
                      width: 40,
                      height: 40,
                      decoration: BoxDecoration(
                        shape: BoxShape.circle,
                        image: DecorationImage(
                          image: NetworkImage(
                            loginController.user?.customer?.imgProfile,
                          ),
                          fit: BoxFit.contain,
                        ),
                      ),
                    ),
            ],
          ),
          body: SingleChildScrollView(
            child: Column(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Center(
                  child: Container(
                    margin: const EdgeInsets.all(18),
                    width: 500,
                    height: 500,
                    decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(15),
                      color: colorContainers242424,
                    ),
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Column(
                          children: [
                            Padding(
                              padding: const EdgeInsets.only(
                                  left: 10, top: 20, bottom: 20),
                              child: Row(
                                mainAxisAlignment:
                                    MainAxisAlignment.spaceBetween,
                                children: [
                                  IconButton(
                                    padding: const EdgeInsets.only(left: 30),
                                    onPressed: () {
                                      Navigator.pop(context);
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
                              padding:
                                  const EdgeInsets.symmetric(horizontal: 15),
                              child: ElevatedButton(
                                style: ButtonStyle(
                                  overlayColor:
                                      MaterialStateProperty.all<Color>(
                                    colorContainers353535,
                                  ),
                                  elevation: MaterialStateProperty.all(0),
                                  backgroundColor: MaterialStateProperty.all<
                                          Color>(
                                      const Color.fromARGB(255, 28, 28, 28)),
                                  shape: MaterialStateProperty.all<
                                      RoundedRectangleBorder>(
                                    RoundedRectangleBorder(
                                      borderRadius: BorderRadius.circular(12),
                                    ),
                                  ),
                                ),
                                onPressed: () {
                                  final url =
                                      Uri.dataFromString(window.location.href);
                                  Map<String, String> params =
                                      url.queryParameters;
                                  var origin = params['id'];
                                  navigationFadePush(
                                      ServicesPageWeb(url: origin), context);
                                },
                                child: Padding(
                                  padding: const EdgeInsets.symmetric(
                                      vertical: 10, horizontal: 5),
                                  child: Row(
                                    mainAxisAlignment:
                                        MainAxisAlignment.spaceBetween,
                                    children: [
                                      Column(
                                        crossAxisAlignment:
                                            CrossAxisAlignment.start,
                                        children: [
                                          Row(
                                            children: [
                                              const Icon(
                                                CupertinoIcons
                                                    .add_circled_solid,
                                                color: Colors.white,
                                              ),
                                              const SizedBox(width: 15),
                                              Text(
                                                serviceCache.state.isEmpty
                                                    ? 'Adicionar um serviço'
                                                    : 'Adicionar outro serviço',
                                                style: const TextStyle(
                                                  color: Colors.white,
                                                ),
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
                            serviceCache.state.isNotEmpty
                                ? SizedBox(
                                    height: 300,
                                    child: ListView.builder(
                                      padding: EdgeInsets.only(
                                          top: size.height * 0.005),
                                      itemCount: serviceCache.state.length,
                                      itemBuilder: (context, index) {
                                        return Column(
                                          children: [
                                            CardServiceSelectedWeb(
                                              barberShop:
                                                  barberShopProvider.state,
                                              date: serviceCache
                                                  .state[index].date!,
                                              finalHour: serviceCache
                                                  .state[index].finalHour!,
                                              initialHour: serviceCache
                                                  .state[index].initialHour!,
                                              price: serviceCache
                                                  .state[index].servicePrice!,
                                              originalprice: serviceCache
                                                      .state[index]
                                                      .serviceOriginalPrice ??
                                                  0,
                                              professionalImg: serviceCache
                                                  .state[index]
                                                  .professional!
                                                  .imgProfile!,
                                              professionalName: serviceCache
                                                  .state[index]
                                                  .professional!
                                                  .name!,
                                              observation: serviceCache
                                                      .state[index]
                                                      .observation ??
                                                  '',
                                              nameService: serviceCache
                                                  .state[index].service!.name!,
                                              cacheId: serviceCache
                                                  .state[index].cachedId!,
                                              i: index,
                                              onConfirm: () => setState(() {}),
                                            ),
                                            serviceCache.state.length - 1 ==
                                                    index
                                                ? GestureDetector(
                                                    onTap: () async {
                                                      showModalBottomSheet<
                                                          void>(
                                                        backgroundColor:
                                                            Colors.transparent,
                                                        isScrollControlled:
                                                            true,
                                                        isDismissible: true,
                                                        context: context,
                                                        builder: (BuildContext
                                                            context) {
                                                          return GestureDetector(
                                                            onTap: () {
                                                              Navigator.of(
                                                                      context)
                                                                  .pop();
                                                            },
                                                            child:
                                                                AddCouponHourBottonSheet(
                                                              barberShop:
                                                                  barberShopProvider
                                                                      .state,
                                                              onConfirm: () {
                                                                // setState(() {});
                                                              },
                                                            ),
                                                          );
                                                        },
                                                      );
                                                    },
                                                    child: Container(
                                                      margin: EdgeInsets.only(
                                                        left: size.width * .01,
                                                        right: size.width * .03,
                                                        top: size.width * .01,
                                                      ),
                                                      decoration: BoxDecoration(
                                                        color:
                                                            Colors.transparent,
                                                        borderRadius:
                                                            BorderRadius
                                                                .circular(10),
                                                      ),
                                                      child: Visibility(
                                                        visible: serviceCache
                                                            .state.isNotEmpty,
                                                        child: Padding(
                                                          padding:
                                                              const EdgeInsets
                                                                  .only(
                                                                  left: 25,
                                                                  bottom: 10),
                                                          child: Row(
                                                            mainAxisAlignment:
                                                                MainAxisAlignment
                                                                    .start,
                                                            children: [
                                                              Text(
                                                                totalPriceProvider.state.discount ==
                                                                            null ||
                                                                        totalPriceProvider.state.discount ==
                                                                            0
                                                                    ? 'Adicionar cupom de desconto'
                                                                    : 'Trocar cupom de desconto',
                                                                style:
                                                                    const TextStyle(
                                                                  color: Colors
                                                                      .white,
                                                                ),
                                                              ),
                                                            ],
                                                          ),
                                                        ),
                                                      ),
                                                    ),
                                                  )
                                                : const SizedBox(),
                                            SizedBox(
                                              height:
                                                  serviceCache.state.length -
                                                              1 ==
                                                          index
                                                      ? size.height * 0.12
                                                      : 0,
                                            ),
                                          ],
                                        );
                                      },
                                    ),
                                  )
                                : Padding(
                                    padding: EdgeInsets.only(
                                        top: size.height * 0.18),
                                    child: Row(
                                      mainAxisAlignment:
                                          MainAxisAlignment.center,
                                      children: [
                                        Image(
                                          image: AssetImage(iconEmpyYellow),
                                          height: MediaQuery.of(context)
                                                  .size
                                                  .height *
                                              .04,
                                        ),
                                        SizedBox(
                                          width: MediaQuery.of(context)
                                                  .size
                                                  .width *
                                              0.03,
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
                                totalPriceProvider
                                    .state.totalPriceWithoutDicount!,
                                totalPriceProvider.state.discount ?? 0,
                              ) !=
                              totalPriceProvider
                                  .state.totalPriceWithoutDicount!,
                          totalPrice: calcTotalPrice(serviceCache.state),
                          totalTime:
                              calcTotalTime(serviceCache.state).toString(),
                          totalPriceWithDiscount: calcPriceWithDiscount(
                            totalPriceProvider.state.totalPriceWithoutDicount!,
                            totalPriceProvider.state.discount ?? 0,
                          ),
                        ),
                      ],
                    ),
                  ),
                ),
                const DownloadAppPromotion(),
              ],
            ),
          ),
        );
      },
    );
  }
}
