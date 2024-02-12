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
import 'widget/body_calendar.dart';

class CalendarPage extends StatefulWidget {
  const CalendarPage({Key? key}) : super(key: key);

  static const route = '/calendar-page';

  @override
  State<CalendarPage> createState() => _CalendarPageState();
}

class _CalendarPageState extends State<CalendarPage> {
  @override
  Widget build(BuildContext context) {
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
                return const BodyCalendar();
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
              "Minha agenda",
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
