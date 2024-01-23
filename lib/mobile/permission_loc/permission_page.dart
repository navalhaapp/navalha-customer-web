// ignore_for_file: use_build_context_synchronously

import 'dart:io';
import 'package:flutter/material.dart';
import 'package:geolocator/geolocator.dart';
import 'package:navalha/mobile/home/home_page.dart';
import 'package:navalha/mobile/permission_notification/permission_notification_page.dart';
import 'package:navalha/shared/animation/page_trasition.dart';
import 'package:permission_handler/permission_handler.dart';

import '../../core/colors.dart';
import 'widgets/permission_body.dart';

class PermissionPage extends StatelessWidget {
  static const route = '/permission-page';

  const PermissionPage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    Size size = MediaQuery.of(context).size;
    return Scaffold(
      backgroundColor: colorBackground181818,
      body: const PermissionBody(),
      persistentFooterAlignment: AlignmentDirectional.center,
      persistentFooterButtons: [
        Padding(
          padding: EdgeInsets.only(bottom: size.height * 0.01),
          child: MaterialButton(
            shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(17),
            ),
            elevation: 5,
            minWidth: size.width * 0.65,
            height: size.height * 0.06,
            color: colorContainers242424,
            onPressed: () async {
              // LocationPermission permission =
              //     await Geolocator.checkPermission();

              // if (permission == LocationPermission.always ||
              //     permission == LocationPermission.whileInUse ||
              //     permission == LocationPermission.deniedForever ||
              //     permission == LocationPermission.denied) {
              //   permission = await Geolocator.requestPermission();
              // }
              // if (Platform.isIOS) {
              //   PermissionStatus statusNotification =
              //       await Permission.notification.status;
              //   if (statusNotification.isGranted) {
              //     navigationWithFadeAnimation(const HomePage(), context);
              //   } else {
              //     navigationWithFadeAnimation(
              //         const PermissionNotificationPage(), context);
              //   }
              // } else {
              navigationWithFadeAnimation(const HomePage(), context);
              // }
            },
            child: Text(
              'Próximo',
              style: TextStyle(
                color: Colors.white,
                fontSize: size.height * 0.02,
              ),
            ),
          ),
        )
      ],
    );
  }
}
