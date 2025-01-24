// ignore_for_file: use_build_context_synchronously

import 'dart:async';

import 'package:flutter/material.dart';
import 'package:geolocator/geolocator.dart';
import 'package:navalha/core/colors.dart';
import 'package:navalha/mobile-DEPRECIATED/permission_loc/permission_page.dart';
import 'package:navalha/shared/animation/page_trasition.dart';
import 'package:navalha/shared/utils.dart';
import 'package:page_view_indicators/page_view_indicators.dart';

class OnBoarding extends StatefulWidget {
  final List<ImageOnboarding> onBoardManagerImages;
  final Widget homePage;
  const OnBoarding(
      {super.key, required this.onBoardManagerImages, required this.homePage});

  @override
  OnBoardingState createState() {
    return OnBoardingState();
  }
}

class OnBoardingState extends State<OnBoarding> {
  final _pageController = PageController();
  final _currentPageNotifier = ValueNotifier<int>(0);

  @override
  Widget build(BuildContext context) {
    Size size = MediaQuery.of(context).size;
    return Scaffold(
        backgroundColor: const Color.fromARGB(255, 12, 12, 12),
        body: Column(
          children: [
            SizedBox(
              height: size.height * .7,
              child: PageView.builder(
                  physics: const BouncingScrollPhysics(),
                  itemCount: widget.onBoardManagerImages.length,
                  controller: _pageController,
                  itemBuilder: (BuildContext context, int index) {
                    return Center(
                      child: SizedBox(
                        height: widget.onBoardManagerImages[index].height,
                        child: Image(
                          image: widget.onBoardManagerImages[index].assetImage,
                        ),
                      ),
                    );
                  },
                  onPageChanged: (int index) {
                    setState(() {
                      _currentPageNotifier.value = index;
                    });
                  }),
            ),
            Container(
              margin: EdgeInsets.symmetric(horizontal: size.width * 0.05),
              height: size.height * 0.21,
              padding: const EdgeInsets.only(bottom: 40),
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Text(
                      textAlign: TextAlign.center,
                      style: TextStyle(
                        color: colorWhite255255255,
                        fontSize: 18,
                      ),
                      widget.onBoardManagerImages[_currentPageNotifier.value]
                          .title),
                  const SizedBox(
                    height: 10,
                  ),
                  Text(
                    maxLines: 3,
                    widget.onBoardManagerImages[_currentPageNotifier.value]
                        .description,
                    textAlign: TextAlign.center,
                    style: TextStyle(
                      color: colorIconesNoSelect125125125,
                      fontSize: 15,
                    ),
                  ),
                ],
              ),
            ),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceAround,
              children: [
                Padding(
                  padding: const EdgeInsets.all(8.0),
                  child: CirclePageIndicator(
                    itemCount: widget.onBoardManagerImages.length,
                    currentPageNotifier: _currentPageNotifier,
                  ),
                ),
                MaterialButton(
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(5),
                  ),
                  color: Colors.amber,
                  onPressed: () async {
                    LocationPermission permission =
                        await Geolocator.checkPermission();
                    if (widget.onBoardManagerImages.last ==
                        widget
                            .onBoardManagerImages[_currentPageNotifier.value]) {
                      if (permission == LocationPermission.always ||
                          permission == LocationPermission.whileInUse) {
                        navigationWithFadeAnimation(widget.homePage, context);
                      } else if (permission ==
                          LocationPermission.deniedForever) {
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
                          navigationWithFadeAnimation(widget.homePage, context);
                        });
                      } else {
                        navigationWithFadeAnimation(
                          const PermissionPage(),
                          context,
                        );
                      }
                    } else {
                      _pageController.nextPage(
                        duration: const Duration(milliseconds: 600),
                        curve: Curves.linear,
                      );
                    }
                  },
                  minWidth: 50,
                  height: 25,
                  child: Text(
                      widget.onBoardManagerImages.last ==
                              widget.onBoardManagerImages[
                                  _currentPageNotifier.value]
                          ? 'Entrar'
                          : 'Próximo',
                      style: const TextStyle(
                        fontWeight: FontWeight.bold,
                        color: Colors.black,
                      )),
                )
              ],
            ),
          ],
        ));
  }
}
