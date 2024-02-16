import 'package:auto_size_text/auto_size_text.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';
import '../../../core/assets.dart';
import '../../../core/colors.dart';
import '../../home/model/response_get_barber_shop_by_id.dart';
import '../../schedule/widgets/add_coupon_botton_sheet.dart';
import '../../schedule/widgets/body_schedule.dart';
import '../../schedule/widgets/card_service_selected.dart';
import '../../schedule/widgets/select_service_botton_sheet.dart';
import '../../../shared/providers.dart';
import '../../../shared/utils.dart';
import '../../../shared/widgets/top_container_star.dart';

class UsePackageBody extends StatefulHookConsumerWidget {
  const UsePackageBody({
    super.key,
    this.packagesUser,
  });

  final CustomerPackages? packagesUser;

  @override
  ConsumerState<UsePackageBody> createState() => _UsePackageBodyState();
}

class _UsePackageBodyState extends ConsumerState<UsePackageBody> {
  @override
  Widget build(BuildContext context) {
    Size size = MediaQuery.of(context).size;
    return Consumer(
      builder: (context, ref, child) {
        var barberShopProvider = ref.watch(barberShopSelectedProvider.state);
        final packageSelectController =
            ref.watch(packageSelectedProvider.state);
        var serviceCache = ref.watch(listServicesCacheProvider.state);
        return SingleChildScrollView(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              TopContainerPatternStar(
                rating: barberShopProvider.state.rating!,
                imgProfile: barberShopProvider.state.imgProfile!,
                imgBackGround: barberShopProvider.state.imgBackground,
              ),
              Visibility(
                visible: serviceCache.state.isEmpty,
                child: GestureDetector(
                  onTap: () {
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
                            child: SelectServiceBottonSheet(
                              packageSelected: widget.packagesUser,
                              barberShop: barberShopProvider.state,
                              listAllServicesWithProfessional: getAllServices(
                                  barberShopProvider.state.professionals!),
                              listProfessionals:
                                  barberShopProvider.state.professionals!,
                              listServices:
                                  findPackageServicesWithProfessionals(
                                barberShopProvider.state.professionals!,
                                widget.packagesUser!.customerPackageServices!,
                              ),
                              onConfirm: () {
                                setState(() {});
                              },
                            ));
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
                            'Usar um serviço do pacote',
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
                                packageSchedule: true,
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
                                professionalName: serviceCache
                                    .state[index].professional!.name!,
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
                                          borderRadius:
                                              BorderRadius.circular(10),
                                        ),
                                        child: Visibility(
                                          visible:
                                              serviceCache.state.isNotEmpty,
                                          child: const Padding(
                                            padding: EdgeInsets.only(
                                                left: 15, bottom: 10),
                                            child: Row(
                                              mainAxisAlignment:
                                                  MainAxisAlignment.start,
                                              children: [
                                                // Text(
                                                //   totalPriceProvider.state
                                                //                   .discount ==
                                                //               null ||
                                                //           totalPriceProvider
                                                //                   .state
                                                //                   .discount ==
                                                //               0
                                                //       ? 'Adicionar cupom de desconto'
                                                //       : 'Trocar cupom de desconto',
                                                //   style: const TextStyle(
                                                //     color: Colors.white,
                                                //   ),
                                                // ),
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
              // Visibility(
              //   visible: packageSelectController
              //       .state.barbershopPackageName.isNotNullAndNotEmpty,
              //   child: PackagePageItem(
              //     buttonClose: true,
              //     packageSelected: packageSelectController.state,
              //   ),
              // ),
              // ListView.builder(
              //   padding: EdgeInsets.zero,
              //   shrinkWrap: true,
              //   physics: const NeverScrollableScrollPhysics(),
              //   itemCount: widget.listPackagesUser!.length,
              //   itemBuilder: (context, i) => PackageUseContainerItem(
              //     i: i,
              //     packageList: widget.listPackagesUser!,
              //   ),
              // ),
              // ListView.builder(
              //   padding: EdgeInsets.zero,
              //   shrinkWrap: true,
              //   physics: const NeverScrollableScrollPhysics(),
              //   itemCount: countAditionalServices,
              //   itemBuilder: (context, i) => AditionalItemItem(
              //     i: i,
              //     package: getNonRequiredItems(
              //         packageSelectController.state.barbershopPackageItems!),
              //   ),
              // ),
              SizedBox(height: size.height * 0.2)
            ],
          ),
        );
      },
    );
  }
}
