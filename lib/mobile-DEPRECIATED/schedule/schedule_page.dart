// Developer            Data              Descrição
// Rovigo               24/08/2022        Criação da schedule page (client).

// ignore_for_file: use_build_context_synchronously

import 'package:flutter/material.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:navalha/mobile-DEPRECIATED/barbershop_page/barbershop_page.dart';
import 'package:navalha/core/colors.dart';
import 'package:navalha/mobile-DEPRECIATED/drawer/drawer_page.dart';
import 'package:navalha/mobile-DEPRECIATED/schedule/widgets/footer_total_price.dart';
import 'package:navalha/shared/animation/page_trasition.dart';
import 'package:navalha/shared/shimmer/shimmer_top_container.dart';
import '../home/model/provider_family_model.dart';
import '../home/model/response_get_barber_shop_by_id.dart';
import '../home/provider/provider_get_barber_shop_by_id.dart';
import '../login/controller/login_controller.dart';
import '../../shared/providers.dart';
import '../../shared/utils.dart';
import 'widgets/body_schedule.dart';

class SchedulePage extends StatefulWidget {
  const SchedulePage({
    super.key,
  });

  static const route = '/schedule-page';

  @override
  State<SchedulePage> createState() => _SchedulePageState();
}

class _SchedulePageState extends State<SchedulePage> {
  @override
  Widget build(BuildContext context) {
    Size size = MediaQuery.of(context).size;

    return WillPopScope(
      onWillPop: () async {
        return false;
      },
      child: Consumer(
        builder: (context, ref, child) {
          final authLoginController =
              ref.watch(LoginStateController.provider.notifier);
          final getBarberShopById =
              ref.watch(GetBarberShopByIdStateController.provider.notifier);
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
          return SafeArea(
            top: false,
            child: Scaffold(
              extendBody: true,
              extendBodyBehindAppBar: true,
              endDrawer: const DrawerPage(),
              persistentFooterAlignment: AlignmentDirectional.bottomCenter,
              persistentFooterButtons: [
                FooterTotalPrice(
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
                )
              ],
              backgroundColor: colorBackground181818,
              body: BodySchedule(onConfirm: () => setState(() {})),
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
            ),
          );
        },
      ),
    );
  }
}

double calcPriceWithDiscount(double total, double descontoPercentual) {
  double desconto = total * (descontoPercentual / 100);
  double precoFinal = total - desconto;
  return precoFinal;
}

double calcDiscount(double preco, double desconto) {
  double valorDesconto = preco * (desconto / 100);
  return valorDesconto;
}
