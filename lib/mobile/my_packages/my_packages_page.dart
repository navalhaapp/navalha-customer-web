import 'package:flutter/material.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:navalha/core/colors.dart';
import 'package:navalha/mobile/drawer/drawer_page.dart';
import 'package:navalha/mobile/login/controller/login_controller.dart';
import 'package:navalha/mobile/registration_types_page/registration_types_page.dart';
import 'package:navalha/shared/animation/page_trasition.dart';
import 'package:navalha/shared/widgets/page_transition.dart';
import 'package:navalha/shared/widgets/widget_empty.dart';
import '../home/home_page.dart';
import 'widgets/my_packages_body.dart';

class MyPackagesPage extends StatefulWidget {
  const MyPackagesPage({Key? key}) : super(key: key);

  static const route = '/calendar-page';

  @override
  State<MyPackagesPage> createState() => _MyPackagesPageState();
}

class _MyPackagesPageState extends State<MyPackagesPage> {
  @override
  Widget build(BuildContext context) {
    Size size = MediaQuery.of(context).size;

    return WillPopScope(
      onWillPop: () async {
        Navigator.pushNamed(context, HomePage.route);
        return true;
      },
      child: SafeArea(
        top: false,
        child: Scaffold(
          extendBody: true,
          extendBodyBehindAppBar: true,
          endDrawer: const DrawerPage(),
          backgroundColor: colorBackground181818,
          body: Consumer(
            builder: (context, ref, child) {
              final loginController =
                  ref.read(LoginStateController.provider.notifier);
              if (loginController.user == null) {
                return Center(
                  child: WidgetEmpty(
                    title: 'Você não possui conta!',
                    subTitle:
                        'Crie uma conta para começar a aproveitar o navalha',
                    text: 'Registrar-se',
                    onPressed: () {
                      navigationWithFadeAnimation(
                          const RegistrationTypesPage(), context);
                    },
                  ),
                );
              } else {
                return const MyPackagesBody();
              }
            },
          ),
          appBar: AppBar(
            leading: IconButton(
              icon: const Icon(Icons.arrow_back_ios_new, size: 17),
              onPressed: () {
                navigationFadePush(const HomePage(), context);
              },
            ),
            automaticallyImplyLeading: false,
            title: Text(
              'Meus pacotes',
              style: TextStyle(
                fontSize: 17,
                shadows: shadow,
              ),
            ),
            elevation: 0,
            centerTitle: true,
            backgroundColor: Colors.transparent,
          ),
        ),
      ),
    );
  }
}
