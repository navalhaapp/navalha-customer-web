// ignore_for_file: use_build_context_synchronously

import 'package:flutter/material.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:navalha/core/colors.dart';
import 'package:navalha/shared/providers.dart';
import 'package:navalha/shared/shimmer/shimmer_top_container.dart';
import 'package:navalha/mobile-DEPRECIATED/use_package/widgets/use_package_footer.dart';
import '../barbershop_page/barbershop_page.dart';
import '../home/model/provider_family_model.dart';
import '../home/model/response_get_barber_shop_by_id.dart';
import '../home/provider/provider_get_barber_shop_by_id.dart';
import '../login/controller/login_controller.dart';
import '../../shared/animation/page_trasition.dart';
import '../../shared/utils.dart';
import 'widgets/use_package_body.dart';

class UsePackagePage extends StatelessWidget {
  const UsePackagePage({
    Key? key,
    this.packageSelected,
  }) : super(key: key);

  final CustomerPackages? packageSelected;

  @override
  Widget build(BuildContext context) {
    Size size = MediaQuery.of(context).size;

    return WillPopScope(
      onWillPop: () async {
        return false;
      },
      child: Consumer(
        builder: (context, ref, child) {
          var totalPriceProvider = ref.watch(totalPriceServiceProvider.state);
          final listResumePayment =
              ref.watch(listResumePaymentProvider.notifier);
          final authLoginController =
              ref.watch(LoginStateController.provider.notifier);
          var serviceCache = ref.watch(listServicesCacheProvider.state);
          var barberShopProvider = ref.watch(barberShopSelectedProvider.state);
          final getBarberShopById =
              ref.watch(GetBarberShopByIdStateController.provider.notifier);
          return SafeArea(
            top: false,
            child: Scaffold(
              persistentFooterButtons: [
                UsePackageFooter(
                  totalTime: calcTotalTime(serviceCache.state).toString(),
                )
              ],
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
                        barberShopId: barberShopProvider.state.barbershopId!,
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
              body: UsePackageBody(packagesUser: packageSelected),
            ),
          );
        },
      ),
    );
  }
}
