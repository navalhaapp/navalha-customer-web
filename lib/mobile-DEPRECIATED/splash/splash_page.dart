// ignore_for_file: use_build_context_synchronously, curly_braces_in_flow_control_structures

import 'dart:async';
import 'package:dio/dio.dart';
import 'package:flutter/material.dart';
import 'package:flutter_credit_card/extension.dart';
import 'package:geolocator/geolocator.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:navalha/shared/onboarding/onboarding_page.dart';
import 'package:navalha/shared/providers.dart';
import 'package:navalha/shared/utils.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:video_player/video_player.dart';
import '../calendar/widget/evaluate_botton_sheet.dart';
import '../../core/assets.dart';
import '../home/home_page.dart';
import '../login/controller/login_controller.dart';
import '../permission_loc/permission_page.dart';
import '../../shared/animation/page_trasition.dart';
import '../../shared/model/customer_model.dart';
import '../../shared/widgets/page_transition.dart';

class SplashPage extends StatefulHookConsumerWidget {
  const SplashPage({Key? key}) : super(key: key);
  static const route = '/splash';

  @override
  ConsumerState<SplashPage> createState() => _SplashPageState();
}

class _SplashPageState extends ConsumerState<SplashPage> {
  late VideoPlayerController _videoController;
  late List<ServicePendingReview>? listReviewsPending;
  late final LoginStateController loginController;
  bool? firstLogin = true;

  @override
  void initState() {
    super.initState();
    WidgetsBinding.instance.addPostFrameCallback((_) async {
      loginController = ref.read(LoginStateController.provider.notifier);
      var fBTokenController = ref.watch(fBTokenProvider.state);
      SharedPreferences prefs = await SharedPreferences.getInstance();
      firstLogin = prefs.getBool('firstLogin') ?? true;
      if (firstLogin == true) {
        Timer(const Duration(milliseconds: 1000), () {
          navigationWithFadeAnimation(
            OnBoarding(
              onBoardManagerImages: onboardingList(context),
              homePage: const HomePage(),
            ),
            context,
          );
        });
        await prefs.setBool('firstLogin', false);
      } else {
        if (prefs.getString('email').isNullOrEmpty) {
          Timer(const Duration(milliseconds: 1000), () {
            navigationFadePush(const HomePage(), context);
          });
        } else {
          var response = await loginController.login(
            prefs.getString('email') ?? '',
            prefs.getString('password') ?? '',
            fBTokenController.state,
          );
          if (response.runtimeType == DioError) {
            Timer(const Duration(milliseconds: 1000), () {
              loginController.user = null;
              navigationFadePush(const HomePage(), context);
            });
          } else if (response.status == 'success') {
            Timer(const Duration(milliseconds: 1000), () {
              _checkIfUserLoggedIn();
            });
          } else {
            Timer(const Duration(milliseconds: 1000), () {
              loginController.user = null;
              navigationFadePush(const HomePage(), context);
            });
          }
        }
      }
    });
    _videoController = VideoPlayerController.asset(
      splashvideo,
    )..initialize().then((_) {
        _videoController.play();
        setState(() {});
      });
  }

  Future _checkIfUserLoggedIn() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    firstLogin = prefs.getBool('firstLogin') ?? true;

    LocationPermission permission = await Geolocator.checkPermission();

    if (firstLogin == true) {
      navigationWithFadeAnimation(
        OnBoarding(
          onBoardManagerImages: onboardingList(context),
          homePage: const HomePage(),
        ),
        context,
      );
      await prefs.setBool('firstLogin', false);
    } else {
      if (permission == LocationPermission.always ||
          permission == LocationPermission.whileInUse) {
        navigationWithFadeAnimation(const HomePage(), context);
        listReviewsPending =
            loginController.user?.customer?.servicePendingReview ?? [];
        for (int i = 0; i < listReviewsPending!.length; i++)
          showModalBottomSheet(
            backgroundColor: Colors.transparent,
            isScrollControlled: true,
            isDismissible: true,
            context: context,
            builder: (BuildContext context) {
              return GestureDetector(
                onTap: () {
                  Navigator.of(context).pop();
                },
                child: EvaluateBottonSheet(
                  barberShopName:
                      listReviewsPending![i].barbershop!.barbershopName!,
                  day: listReviewsPending![i].date!.replaceAll('-', '/'),
                  imgProfessional:
                      listReviewsPending![i].professional!.imgProfile!,
                  serviceName: listReviewsPending![i].service!.serviceName!,
                  serviceId: listReviewsPending![i].service!.serviceId!,
                  customerId: loginController.user!.customer!.customerId!,
                ),
              );
            },
          );
      } else if (permission == LocationPermission.deniedForever) {
        ScaffoldMessenger.of(context).showSnackBar(
          const SnackBar(
            duration: Duration(seconds: 5),
            backgroundColor: Colors.white,
            content: Text(
              'Você negou as permissões de localização permanentemente, mude isso nas configurações do seu dispositivo, para ver as barbearias mais próximas a você',
              style: TextStyle(color: Colors.black),
            ),
          ),
        );
        Timer(const Duration(milliseconds: 1000), () {
          navigationWithFadeAnimation(const HomePage(), context);
        });
      } else {
        navigationWithFadeAnimation(
          const PermissionPage(),
          context,
        );
      }
    }
  }

  @override
  void dispose() {
    _videoController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return WillPopScope(
      onWillPop: () async {
        return false;
      },
      child: Scaffold(
        body: SizedBox.expand(
          child: FittedBox(
            fit: BoxFit.cover,
            child: SizedBox(
              width: _videoController.value.size.width,
              height: _videoController.value.size.height,
              child: VideoPlayer(_videoController),
            ),
          ),
        ),
      ),
    );
  }
}
