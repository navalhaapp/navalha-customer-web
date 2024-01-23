// ignore_for_file: use_build_context_synchronously

import 'package:firebase_messaging/firebase_messaging.dart';
import 'package:flutter/material.dart';
import 'package:navalha/mobile/home/home_page.dart';
import 'package:navalha/shared/widgets/page_transition.dart';
import '../../core/colors.dart';
import 'widgets/permission_notification_body.dart';

class PermissionNotificationPage extends StatefulWidget {
  static const route = '/permission-notification-page';

  const PermissionNotificationPage({Key? key}) : super(key: key);

  @override
  State<PermissionNotificationPage> createState() =>
      _PermissionNotificationPageState();
}

class _PermissionNotificationPageState
    extends State<PermissionNotificationPage> {
  @override
  Widget build(BuildContext context) {
    Size size = MediaQuery.of(context).size;
    return Scaffold(
      backgroundColor: colorBackground181818,
      body: const PermissionNotificationBody(),
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
              await FirebaseMessaging.instance.requestPermission();
              navigationFadePush(const HomePage(), context);
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
