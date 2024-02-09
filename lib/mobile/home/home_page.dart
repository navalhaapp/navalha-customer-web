// Developer            Data              Descrição
// Vitor Daniel         22/08/2022        Criação da home page (client).

import 'package:firebase_messaging/firebase_messaging.dart';
import 'package:flutter/material.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:navalha/core/colors.dart';
import 'package:navalha/mobile/drawer/drawer_page.dart';
import 'package:navalha/mobile/home/widget/body_home.dart';
import 'package:navalha/mobile/login/controller/login_controller.dart';
import 'package:navalha/shared/utils.dart';

class HomePage extends StatefulWidget {
  const HomePage({Key? key}) : super(key: key);

  static const route = '/home-page';

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  @override
  void initState() {
    FirebaseMessaging.onMessage.listen((message) {
      if (message.notification != null) {
        RemoteNotification pushMessage = message.notification!;
        pushFcm(context, pushMessage.title, pushMessage.body);
      }
    });
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return WillPopScope(
      onWillPop: () async {
        return false;
      },
      child: SafeArea(
        child: Scaffold(
          endDrawer: const DrawerPage(),
          backgroundColor: colorBackground181818,
          body: const BodyHome(),
          appBar: AppBar(
            elevation: 0,
            backgroundColor: Colors.transparent,
            leadingWidth: 0,
            centerTitle: false,
            leading: const SizedBox(),
            title: Consumer(
              builder: (context, ref, child) {
                final loginController =
                    ref.read(LoginStateController.provider.notifier);
                return Column(
                  mainAxisAlignment: MainAxisAlignment.start,
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      '${UtilValidator.getSalute()},',
                      style: TextStyle(
                        fontSize: MediaQuery.of(context).size.height * 0.015,
                        color: const Color.fromARGB(255, 148, 148, 148),
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                    NameHeader(
                      name: loginController.user?.customer?.name ?? 'Usuário',
                    ),
                  ],
                );
              },
            ),
          ),
        ),
      ),
    );
  }
}
