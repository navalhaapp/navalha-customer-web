import 'package:auto_size_text/auto_size_text.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_credit_card/extension.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:navalha/mobile/package_page/widgets/aditional_item_item.dart';
import 'package:navalha/shared/utils.dart';
import 'aditional_item_service.dart';
import 'package_buy_button_sheet.dart';
import '../../../core/assets.dart';
import '../../../core/colors.dart';
import '../../../shared/providers.dart';
import '../../../shared/widgets/top_container_star.dart';
import 'package_page_item.dart';

class PackageBody extends StatefulHookConsumerWidget {
  const PackageBody({super.key});

  @override
  ConsumerState<PackageBody> createState() => _PackageBodyState();
}

class _PackageBodyState extends ConsumerState<PackageBody> {
  @override
  Widget build(BuildContext context) {
    Size size = MediaQuery.of(context).size;

    return Consumer(
      builder: (context, ref, child) {
        var barberShopProvider = ref.watch(barberShopSelectedProvider.state);
        final packageSelectController =
            ref.watch(packageSelectedProvider.state);

        int countAditionalServices =
            packageSelectController.state.barbershopPackageServices == null
                ? 0
                : getNonRequiredServices(
                        packageSelectController.state.barbershopPackageServices)
                    .length;

        int countAditionalProducts =
            packageSelectController.state.barbershopPackageItems == null
                ? 0
                : getNonRequiredItems(
                        packageSelectController.state.barbershopPackageItems)
                    .length;

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
                visible: packageSelectController
                    .state.barbershopPackageName.isNullOrEmpty,
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
                          child: const PackageBuyItemButtonSheet(),
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
                            'Comprar um pacote',
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
              Visibility(
                visible: packageSelectController
                    .state.barbershopPackageName.isNotNullAndNotEmpty,
                child: PackagePageItem(
                  buttonClose: true,
                  packageSelected: packageSelectController.state,
                ),
              ),
              Visibility(
                visible: getNonRequiredItems(packageSelectController
                            .state.barbershopPackageItems)
                        .isNotEmpty ||
                    getNonRequiredServices(packageSelectController
                            .state.barbershopPackageServices)
                        .isNotEmpty,
                child: Padding(
                  padding: EdgeInsets.only(
                    left: size.width * .06,
                    top: size.height * 0.01,
                    bottom: size.height * 0.01,
                  ),
                  child: Text(
                    'Complete a sua compra',
                    maxLines: 1,
                    style: TextStyle(
                      color: Colors.white,
                      fontSize: size.width * .04,
                    ),
                  ),
                ),
              ),
              ListView.builder(
                padding: EdgeInsets.zero,
                shrinkWrap: true,
                physics: const NeverScrollableScrollPhysics(),
                itemCount: countAditionalServices,
                itemBuilder: (context, i) => AditionalItemService(
                  i: i,
                  package: getNonRequiredServices(
                      packageSelectController.state.barbershopPackageServices),
                ),
              ),
              !isNullOrEmpty(getNonRequiredItems(
                      packageSelectController.state.barbershopPackageItems))
                  ? ListView.builder(
                      padding: EdgeInsets.zero,
                      shrinkWrap: true,
                      physics: const NeverScrollableScrollPhysics(),
                      itemCount: countAditionalProducts,
                      itemBuilder: (context, i) => AditionalItemItem(
                        i: i,
                        package: getNonRequiredItems(packageSelectController
                            .state.barbershopPackageItems!),
                      ),
                    )
                  : const SizedBox(),
              SizedBox(height: size.height * 0.2)
            ],
          ),
        );
      },
    );
  }
}
