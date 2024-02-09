import 'package:animator/animator.dart';
import 'package:flutter/material.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';

import 'package:navalha/mobile/barbershop_page/widget/schedule_confirmation_button.dart';
import 'package:navalha/core/colors.dart';
import 'package:navalha/mobile/drawer/drawer_page.dart';
import 'package:navalha/mobile/home/home_page.dart';
import 'package:navalha/mobile/home/model/response_get_barber_shop_by_id.dart';
import 'package:navalha/shared/widgets/page_transition.dart';

import '../../shared/providers.dart';
import 'widget/barbershop_body.dart';

class BarbershopPage extends StatefulWidget {
  static const route = '/barbershop-page';

  const BarbershopPage({
    Key? key,
    this.listPackagesUser,
  }) : super(key: key);

  final List<CustomerPackages>? listPackagesUser;

  @override
  State<BarbershopPage> createState() => _BarbershopPageState();
}

class _BarbershopPageState extends State<BarbershopPage> {
  @override
  Widget build(BuildContext context) {
    Size size = MediaQuery.of(context).size;
    return SafeArea(
      top: false,
      child: Consumer(
        builder: (context, ref, child) {
          final barberShopProvider =
              ref.watch(barberShopSelectedProvider.state);
          return WillPopScope(
            onWillPop: () async {
              navigationFadePushReplacement(const HomePage(), context);
              return true;
            },
            child: Scaffold(
              extendBody: true,
              extendBodyBehindAppBar: true,
              floatingActionButtonLocation:
                  FloatingActionButtonLocation.endDocked,
              body: BarbershopBody(barberShop: barberShopProvider.state),
              endDrawer: const DrawerPage(),
              appBar: AppBar(
                leading: IconButton(
                  icon: const Icon(Icons.arrow_back_ios_new, size: 17),
                  onPressed: () {
                    navigationFadePush(const HomePage(), context);
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
              backgroundColor: colorBackground181818,
              floatingActionButton: Column(
                crossAxisAlignment: CrossAxisAlignment.end,
                mainAxisAlignment: MainAxisAlignment.end,
                children: [
                  ScheduleConfirmationButton(
                    listPackagesUser: widget.listPackagesUser,
                    barberShop: barberShopProvider.state,
                  ),
                  Animator<double>(
                      duration: const Duration(milliseconds: 700),
                      cycles: 0,
                      builder: (context, animatorState, child) {
                        return AnimatedContainer(
                          color: Colors.transparent,
                          duration: const Duration(milliseconds: 1),
                          height: animatorState.value * 8.5,
                        );
                      }),
                  const SizedBox(
                    height: 50,
                  )
                ],
              ),
            ),
          );
        },
      ),
    );
  }
}
