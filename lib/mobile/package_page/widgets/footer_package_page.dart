// ignore_for_file: use_build_context_synchronously

import 'package:easy_debounce/easy_debounce.dart';
import 'package:flutter/material.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:navalha/approved_schedule/approved_schedule_page.dart';
import 'package:navalha/core/assets.dart';
import 'package:navalha/core/colors.dart';
import 'package:navalha/mobile/login/controller/login_controller.dart';
import 'package:navalha/mobile/my_packages/my_packages_page.dart';
import 'package:navalha/mobile/package_page/model/response_create_package.dart';
import 'package:navalha/shared/model/barber_shop_model.dart';
import 'package:navalha/shared/model/package_model.dart';
import 'package:navalha/shared/providers.dart';
import 'package:navalha/shared/utils.dart';
import 'package:navalha/shared/widgets/page_transition.dart';
import '../model/params_create_package.dart';
import '../provider/provider_create_package.dart';

class FooterPackagePage extends StatefulWidget {
  const FooterPackagePage({
    Key? key,
    required this.totalPrice,
    required this.totalPriceWithDiscount,
    required this.barberShop,
  }) : super(key: key);

  final double totalPrice;
  final double totalPriceWithDiscount;
  final BarberShop barberShop;

  @override
  State<FooterPackagePage> createState() => _FooterTotalPriceState();
}

class _FooterTotalPriceState extends State<FooterPackagePage> {
  bool loading = false;
  @override
  Widget build(BuildContext context) {
    final size = MediaQuery.of(context).size;
    return Consumer(
      builder: (context, ref, child) {
        ref.watch(CreatePackageController.provider.notifier);
        final loginController =
            ref.watch(LoginStateController.provider.notifier);
        final packageAmountPriceController =
            ref.watch(packageAmountPriceProvider.state);
        final createPackageController =
            ref.watch(CreatePackageController.provider.notifier);
        final packageSelectController =
            ref.watch(packageSelectedProvider.state);
        final packageOptionalSelectedController =
            ref.watch(packageOptionalSelectedProvider.state);
        return Container(
          decoration: BoxDecoration(
            color: colorBackground181818,
          ),
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
                              'Total',
                              style: TextStyle(
                                color: colorFontUnable116116116,
                                fontWeight: FontWeight.w600,
                              ),
                            ),
                            Text(
                              'R\$ ${packageAmountPriceController.state.toStringAsFixed(2).replaceAll('.', ',')}',
                              style: const TextStyle(
                                color: Colors.white,
                                fontWeight: FontWeight.w600,
                                fontSize: 20,
                              ),
                            ),
                          ],
                        ),
                      ],
                    ),
                  ),
                  Visibility(
                    visible: true,
                    child: Container(
                        margin: const EdgeInsets.symmetric(horizontal: 8),
                        width: size.width * 0.35,
                        height: size.height * 0.05,
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
                                colorContainers242424,
                              ),
                              overlayColor: MaterialStateProperty.all<Color>(
                                colorContainers353535,
                              ),
                              shape: MaterialStateProperty.all<
                                  RoundedRectangleBorder>(
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
                              EasyDebounce.debounce('finalized-buy-package',
                                  const Duration(milliseconds: 500), () async {
                                setState(() => loading = true);

                                ResponseCreatePackage response =
                                    await createPackageController.createPackage(
                                  ParamsCreatePackage(
                                    token: loginController.user!.token!,
                                    customerId: loginController
                                        .user!.customer!.customerId!,
                                    transactionAmount:
                                        packageAmountPriceController.state,
                                    barbershopPackageId: packageSelectController
                                        .state.barbershopPackageId,
                                    barbershopOptionalItems:
                                        convertToParamsListItens(
                                            packageOptionalSelectedController
                                                .state.barbershopPackageItems),
                                    barbershopOptionalServices:
                                        convertToParamsListServices(
                                            packageOptionalSelectedController
                                                .state
                                                .barbershopPackageServices),
                                  ),
                                );
                                if (response.status == 'success') {
                                  navigationFadePush(
                                      const ApprovedSchedulePage(
                                        page: MyPackagesPage(),
                                        title: 'Compra realizada!',
                                        subTitle:
                                            'Compra realizada com sucesso!',
                                      ),
                                      context);
                                } else {
                                  showSnackBar(context, 'Ops, algo aconteceu');
                                }

                                setState(() => loading = false);
                              });
                            })),
                  ),
                ],
              ),
            ],
          ),
        );
      },
    );
  }
}

class NavalhaCashSelected extends StatelessWidget {
  const NavalhaCashSelected({
    super.key,
    required this.both,
  });

  final bool both;

  @override
  Widget build(BuildContext context) {
    final size = MediaQuery.of(context).size;
    return Row(
      children: [
        Padding(
          padding: EdgeInsets.only(
            left: both ? size.width * 0.03 : 0,
            right: size.width * 0.03,
          ),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.center,
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              Container(
                padding: const EdgeInsets.symmetric(horizontal: 4),
                decoration: BoxDecoration(
                  color: Colors.black,
                  borderRadius: BorderRadius.circular(5),
                ),
                width: size.width * 0.08,
                height: 25,
                child: Image.asset(
                  logoBottonNav,
                ),
              ),
            ],
          ),
        ),
        const Text(
          'Navalha cash',
          style: TextStyle(
            color: Colors.white,
            fontSize: 16,
            fontWeight: FontWeight.bold,
          ),
        )
      ],
    );
  }
}

List<ParamsBuyPackageServiceItem>? convertToParamsListItens(
    List<BarbershopPackageItems>? barbershopItems) {
  List<ParamsBuyPackageServiceItem> paramsList = [];

  if (barbershopItems != null) {
    for (var item in barbershopItems) {
      paramsList.add(ParamsBuyPackageServiceItem(
        barbershopPackageServiceId: item.barbershopPackageItemId,
        quantity: item.barbershopPackageItemQuantity,
      ));
    }
  }

  return paramsList;
}

List<ParamsBuyPackageService> convertToParamsListServices(
    List<BarbershopPackageServices>? barbershopItems) {
  List<ParamsBuyPackageService> paramsList = [];

  if (barbershopItems != null) {
    for (var item in barbershopItems) {
      paramsList.add(ParamsBuyPackageService(
        barbershopPackageServiceId: item.barbershopPackageServiceId,
        quantity: item.barbershopPackageServiceQuantity,
      ));
    }
  }

  return paramsList;
}
