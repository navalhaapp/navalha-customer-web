// Developer            Data              Decription
// Vitor               22/08/2022        Scaffold Pattern creation
// Vitor               03/10/2022        Change Scaffold Pattern to BottomNavBar

// ignore_for_file: use_build_context_synchronously

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:navalha/core/app_routes.dart';
import 'package:navalha/core/colors.dart';
import 'package:navalha/shared/animation/page_trasition.dart';
import 'package:navalha/shared/shimmer/shimmer_faq.dart';
import 'package:navalha/shared/shimmer/shimmer_top_container.dart';
import '../../core/assets.dart';
import '../../mobile/login/controller/login_controller.dart';
import '../../mobile/login/model/auth_model.dart';
import '../../mobile/payment/provider/provider_refresh.dart';
import '../shimmer/shimmer_payment.dart';
import '../utils.dart';

class BottomNavBar extends HookConsumerWidget {
  const BottomNavBar(
    this.indexPage, {
    Key? key,
  }) : super(key: key);
  final int indexPage;
  @override
  Widget build(BuildContext context, WidgetRef ref) {
    Size size = MediaQuery.of(context).size;
    List listOfIcons = [
      Icon(
        CupertinoIcons.calendar,
        size: size.width * .065,
        color: Colors.white,
      ),
      Icon(
        CupertinoIcons.person_alt_circle,
        size: size.width * .065,
        color: Colors.white,
      ),
      const IconHomeBottonNavBar(),
      Icon(
        CupertinoIcons.cube_box_fill,
        size: size.width * .065,
        color: Colors.white,
      ),
      Icon(
        CupertinoIcons.headphones,
        size: size.width * .065,
        color: Colors.white,
      ),
    ];

    return Consumer(
      builder: (context, ref, child) {
        final loginController =
            ref.read(LoginStateController.provider.notifier);
        final refresh = ref.watch(RefreshStateController.provider.notifier);
        return Container(
          decoration: BoxDecoration(
            boxShadow: shadow,
            color: colorBackground181818,
          ),
          height: size.width * .15,
          child: ListView.builder(
            itemCount: 5,
            physics: const NeverScrollableScrollPhysics(),
            scrollDirection: Axis.horizontal,
            padding: EdgeInsets.symmetric(
                horizontal: size.width * .024, vertical: 0),
            itemBuilder: (context, index) => InkWell(
              onTap: () async {
                if (index == 0) {
                  navigationWithFadeAnimation(
                      const ShimmerTopContainer(), context);
                } else if (index == 1) {
                  navigationWithFadeAnimation(const ShimmerFaq(), context);
                } else if (index == 3) {
                  navigationWithFadeAnimation(const ShimmerPayment(), context);
                } else if (index == 4) {
                  navigationWithFadeAnimation(
                      const ShimmerTopContainer(), context);
                } else {
                  navigationWithFadeAnimation(
                      const ShimmerTopContainer(), context);
                }
                if (loginController.user == null) {
                  Navigator.pop(context);
                  navigationWithFadeAnimation(listPage[index], context);
                } else {
                  AuthCustomer response = await refresh.refresh(
                    loginController.user!.customer!.customerId!,
                    loginController.user!.token!,
                  );
                  if (response.status == 'success') {
                    loginController.user = response;
                    Navigator.pop(context);
                    navigationWithFadeAnimation(listPage[index], context);
                  } else {
                    Navigator.pop(context);
                    showSnackBar(context, 'Ops, algo aconteceu');
                  }
                }
              },
              splashColor: Colors.transparent,
              highlightColor: Colors.transparent,
              child: Column(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  SizedBox(height: index == 2 ? 0 : size.width * .014),
                  listOfIcons[index],
                  AnimatedContainer(
                    duration: const Duration(milliseconds: 1500),
                    curve: Curves.fastLinearToSlowEaseIn,
                    margin: EdgeInsets.only(
                      top: index == 2
                          ? 0
                          : index == indexPage
                              ? 0
                              : size.width * .01,
                      right: size.width * .0422,
                      left: size.width * .0422,
                    ),
                    width: index == 2 ? size.width * .295 : size.width * .06,
                    height: index == 2
                        ? 0
                        : index == indexPage
                            ? size.width * .014
                            : 0,
                    decoration: BoxDecoration(
                      color:
                          index == 2 ? Colors.transparent : colorYellow25020050,
                      borderRadius: const BorderRadius.vertical(
                        top: Radius.circular(20),
                      ),
                    ),
                  ),
                ],
              ),
            ),
          ),
        );
      },
    );
  }
}

class IconHomeBottonNavBar extends StatelessWidget {
  const IconHomeBottonNavBar({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    Size size = MediaQuery.of(context).size;
    return Container(
      height: size.width * .1,
      width: size.width * 0.32,
      decoration: BoxDecoration(
        color: baseURLV1 == baseUrlProd ? colorYellow25020050 : Colors.red,
        borderRadius: BorderRadius.circular(15),
      ),
      child: Padding(
        padding: EdgeInsets.symmetric(horizontal: size.width * 0.05),
        child: Image.asset(
          baseURLV1 == baseUrlProd
              ? logoBottonNav
              : baseURLV1 == baseUrlDev
                  ? logoBottonDevelop
                  : logoBottonStage,
          color: Colors.black,
          fit: BoxFit.fitWidth,
        ),
      ),
    );
  }
}
