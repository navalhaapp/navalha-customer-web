// Developer            Data              Descrição
// Rovigo               24/08/2022        Criação da body schadule page (client).
// Vitor                19/11/2022        added service container animation

import 'package:auto_size_text/auto_size_text.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:navalha/mobile-DEPRECIATED/schedule/model/model_reserved_time.dart';
import 'package:navalha/mobile-DEPRECIATED/schedule/widgets/card_service_selected.dart';
import 'package:navalha/mobile-DEPRECIATED/schedule/widgets/select_service_botton_sheet.dart';
import 'package:navalha/shared/model/professional_model.dart';
import 'package:navalha/shared/model/service_model.dart';
import '../../../core/assets.dart';
import '../../../core/colors.dart';
import '../../../shared/providers.dart';
import '../../../shared/utils.dart';
import '../../../shared/widgets/top_container_star.dart';
import 'add_coupon_botton_sheet.dart';

class BodySchedule extends StatefulHookConsumerWidget {
  final Function onConfirm;
  const BodySchedule({super.key, required this.onConfirm});

  @override
  ConsumerState<ConsumerStatefulWidget> createState() => _BodyScheduleState();
}

class _BodyScheduleState extends ConsumerState<BodySchedule> {
  late StateController<ReservedTime> reservedTime;
  final ScrollController scrollController = ScrollController();

  void updateHomePage() {
    setState(() {});
  }

  @override
  Widget build(BuildContext context) {
    var serviceCache = ref.watch(listServicesCacheProvider.state);
    reservedTime = ref.watch(reservedTimeProvider.state);
    var totalPriceProvider = ref.watch(totalPriceServiceProvider.state);
    var barberShopProvider = ref.watch(barberShopSelectedProvider.state);
    Size size = MediaQuery.of(context).size;
    return SingleChildScrollView(
      child: Column(
        children: [
          TopContainerPatternStar(
            rating: barberShopProvider.state.rating!,
            imgProfile: barberShopProvider.state.imgProfile!,
            imgBackGround: barberShopProvider.state.imgBackground,
            height: size.height * 0.2,
            heightImage: size.height * 0.085,
          ),
          const SizedBox(height: 10),
          GestureDetector(
            onTap: () {
              showModalBottomSheet<void>(
                backgroundColor: Colors.transparent,
                isScrollControlled: true,
                isDismissible: true,
                context: context,
                builder: (BuildContext context) {
                  reservedTime.state.clear();
                  return GestureDetector(
                    onTap: () {
                      Navigator.of(context).pop();
                    },
                    child: SelectServiceBottonSheet(
                      barberShop: barberShopProvider.state,
                      listAllServicesWithProfessional: getAllServices(
                          barberShopProvider.state.professionals!),
                      listProfessionals:
                          barberShopProvider.state.professionals!,
                      listServices: findServicesWithProfessionals(
                        barberShopProvider.state.professionals!,
                        showActivatedServices(
                            barberShopProvider.state.services!),
                      ),
                      onConfirm: () {
                        setState(() {});
                      },
                    ),
                  );
                },
              );
            },
            child: Container(
              margin: EdgeInsets.only(
                left: size.width * .03,
                right: size.width * .03,
                bottom: size.height * 0.01,
              ),
              decoration: BoxDecoration(
                borderRadius: const BorderRadius.all(Radius.circular(18)),
                color: colorContainers242424,
              ),
              height: 50,
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceAround,
                children: [
                  SizedBox(
                    width: size.width * 0.65,
                    child: AutoSizeText(
                      'Marcar um serviço',
                      maxLines: 1,
                      style: TextStyle(
                        color: Colors.white,
                        fontSize: size.height * .022,
                      ),
                    ),
                  ),
                  Padding(
                    padding: EdgeInsets.only(left: size.width * 0.02),
                    child: const Icon(
                      CupertinoIcons.add_circled_solid,
                      color: Colors.white,
                      size: 25,
                    ),
                  ),
                ],
              ),
            ),
          ),
          serviceCache.state.isNotEmpty
              ? SizedBox(
                  height: size.height * 0.5,
                  child: ListView.builder(
                    padding: EdgeInsets.only(top: size.height * 0.005),
                    itemCount: serviceCache.state.length,
                    itemBuilder: (context, index) {
                      return Column(
                        children: [
                          CardServiceSelected(
                            barberShop: barberShopProvider.state,
                            date: serviceCache.state[index].date!,
                            finalHour: serviceCache.state[index].finalHour!,
                            initialHour: serviceCache.state[index].initialHour!,
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
                          ),
                          serviceCache.state.length - 1 == index
                              ? GestureDetector(
                                  onTap: () async {
                                    // showModalBottomSheet<void>(
                                    //   backgroundColor: Colors.transparent,
                                    //   isScrollControlled: true,
                                    //   isDismissible: true,
                                    //   context: context,
                                    //   builder: (BuildContext context) {
                                    //     return GestureDetector(
                                    //       onTap: () {
                                    //         Navigator.of(context).pop();
                                    //       },
                                    //       child: AddCouponHourBottonSheet(
                                    //         barberShop:
                                    //             barberShopProvider.state,
                                    //         onConfirm: () {
                                    //           // setState(() {});
                                    //         },
                                    //       ),
                                    //     );
                                    //   },
                                    // );
                                  },
                                  child: Container(
                                    margin: EdgeInsets.only(
                                      left: size.width * .01,
                                      right: size.width * .03,
                                      top: size.width * .01,
                                    ),
                                    decoration: BoxDecoration(
                                      color: Colors.transparent,
                                      borderRadius: BorderRadius.circular(10),
                                    ),
                                    child: Visibility(
                                      visible: serviceCache.state.isNotEmpty,
                                      child: Padding(
                                        padding: const EdgeInsets.only(
                                            left: 15, bottom: 10),
                                        child: Row(
                                          mainAxisAlignment:
                                              MainAxisAlignment.start,
                                          children: [
                                            Text(
                                              totalPriceProvider
                                                              .state.discount ==
                                                          null ||
                                                      totalPriceProvider
                                                              .state.discount ==
                                                          0
                                                  ? 'Adicionar cupom de desconto'
                                                  : 'Trocar cupom de desconto',
                                              style: const TextStyle(
                                                color: Colors.white,
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
                            height: serviceCache.state.length - 1 == index
                                ? size.height * 0.12
                                : 0,
                          ),
                        ],
                      );
                    },
                  ),
                )
              : Padding(
                  padding: EdgeInsets.only(top: size.height * 0.18),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Image(
                        image: AssetImage(iconEmpyYellow),
                        height: MediaQuery.of(context).size.height * .04,
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
    );
  }
}

List<Service> getAllServices(List<Professional> professionals) {
  List<Service> services = [];
  for (Professional professional in professionals) {
    List<Service> professionalServices = professional.professionalServices!;
    for (Service service in professionalServices) {
      services.add(service);
    }
  }
  return services;
}
