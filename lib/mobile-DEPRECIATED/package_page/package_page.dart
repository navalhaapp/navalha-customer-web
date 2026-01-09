// ignore_for_file: use_build_context_synchronously

import 'package:flutter/material.dart';
import 'package:flutter_credit_card/extension.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:navalha/core/colors.dart';
import 'package:navalha/mobile-DEPRECIATED/home/model/provider_family_model.dart';
import 'package:navalha/mobile-DEPRECIATED/home/model/response_get_barber_shop_by_id.dart';
import 'package:navalha/mobile-DEPRECIATED/login/controller/login_controller.dart';
import 'package:navalha/shared/animation/page_trasition.dart';
import 'package:navalha/shared/providers.dart';
import 'package:navalha/shared/shimmer/shimmer_top_container.dart';
import 'package:navalha/shared/utils.dart';
import '../barbershop_page/barbershop_page.dart';
import '../home/provider/provider_get_barber_shop_by_id.dart';
import 'widgets/footer_package_page.dart';
import 'widgets/package_body.dart';

class PackagePage extends StatelessWidget {
  const PackagePage({super.key});

  @override
  Widget build(BuildContext context) {
    Size size = MediaQuery.of(context).size;

    return WillPopScope(
      onWillPop: () async {
        return false;
      },
      child: Consumer(
        builder: (context, ref, child) {
          var barberShopProvider = ref.watch(barberShopSelectedProvider.state);
          final packageSelectController =
              ref.watch(packageSelectedProvider.state);
          var totalPriceProvider = ref.watch(totalPriceServiceProvider.state);
          final listResumePayment =
              ref.watch(listResumePaymentProvider.notifier);
          final authLoginController =
              ref.watch(LoginStateController.provider.notifier);
          var serviceCache = ref.watch(listServicesCacheProvider.state);
          final getBarberShopById =
              ref.watch(GetBarberShopByIdStateController.provider.notifier);
          final packageAmountPriceController =
              ref.watch(packageAmountPriceProvider.state);
          return SafeArea(
            top: false,
            child: Scaffold(
              backgroundColor: colorBackground181818,
              extendBody: true,
              extendBodyBehindAppBar: true,
              appBar: AppBar(
                leading: IconButton(
                  icon: const Icon(Icons.arrow_back_ios_new, size: 17),
                  onPressed: () async {
                    navigationWithFadeAnimation(
                        const ShimmerTopContainer(), context);
                    ResponseBarberShopById response =
                        await getBarberShopById.getAllBarberShopById(
                      ParamsBarberShopById(
                        barberShopName: barberShopProvider.state.name!,
                        customerId:
                            authLoginController.user?.customer.customerId,
                      ),
                    );
                    if (response.status == 'success') {
                      barberShopProvider.state = response.barbershop!;
                      serviceCache.state.clear();
                      totalPriceProvider.state.clear();
                      listResumePayment.state.clear();

                      Navigator.pop(context);
                      navigationWithFadeAnimation(
                        BarbershopPage(
                            listPackagesUser: response.customerPackages!),
                        context,
                      );
                    } else {
                      Navigator.pop(context);
                      showSnackBar(context, 'Ops, algo aconteceu.');
                    }
                  },
                ),
                automaticallyImplyLeading: false,
                title: Text(
                  barberShopProvider.state.name!,
                  style: TextStyle(
                    fontSize: size.width * 0.04,
                    shadows: shadow,
                  ),
                ),
                elevation: 0,
                centerTitle: true,
                backgroundColor: Colors.transparent,
              ),
              body: const PackageBody(),
              persistentFooterButtons: [
                packageSelectController
                        .state.barbershopPackageName.isNotNullAndNotEmpty
                    ? FooterPackagePage(
                        barberShop: barberShopProvider.state,
                        totalPrice: packageAmountPriceController.state,
                        totalPriceWithDiscount: packageSelectController
                            .state.barbershopPackagePrice!,
                      )
                    : const SizedBox()
              ],
            ),
          );
        },
      ),
    );
  }
}

// double sumPackageServicePrices(List<BarbershopPackageServices>? services) {
//   double total = 0.0;
//   if (services == null) {
//     return 0;
//   } else {
//     for (var service in services) {
//       total += service.barbershopPackageServicePrice!;
//     }
//     return total;
//   }
// }
