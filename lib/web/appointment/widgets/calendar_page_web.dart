import 'package:flutter/material.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:navalha/core/assets.dart';
import 'package:navalha/core/colors.dart';
import 'package:navalha/shared/providers.dart';
import 'package:navalha/shared/widgets/widget_empty.dart';
import 'package:navalha/web/appointment/widgets/calendar_body_web.dart';
import 'package:navalha/web/appointment/widgets/drawer_page_web.dart';
import 'package:navalha/web/db/db_customer_shared.dart';
import 'package:navalha/web/shared/downloadAppPromotionBanner.dart';

class CalendarPageWeb extends StatefulWidget {
  const CalendarPageWeb({Key? key}) : super(key: key);

  static const route = '/calendar-web-page';

  @override
  State<CalendarPageWeb> createState() => _CalendarPageWebState();
}

class _CalendarPageWebState extends State<CalendarPageWeb> {
  @override
  Widget build(BuildContext context) {
    return SafeArea(
      top: false,
      child: Consumer(builder: (context, ref, child) {
        String url = Uri.base.toString();
        String params = Uri.splitQueryString(url).values.first;
        final retrievedCustomer = LocalStorageManager.getCustomer();
        return Scaffold(
          backgroundColor: colorBackground181818,
          drawer: DrawerPageWeb(barberShopId: params),
          appBar: AppBar(
            elevation: 0,
            title: Text(
                ref.watch(barberShopSelectedProvider.state).state.name ?? ''),
            backgroundColor: colorBackground181818,
            actions: [
              Row(
                children: [
                  TextButton(
                      onPressed: () {
                        Navigator.of(context).pushNamed('/');
                      },
                      style: ButtonStyle(
                        overlayColor: WidgetStateProperty.resolveWith<Color?>(
                          (Set<WidgetState> states) {
                            if (states.contains(WidgetState.pressed)) {
                              return colorContainers242424;
                            }
                            return null;
                          },
                        ),
                      ),
                      child: const Icon(
                        Icons.home,
                        color: Colors.white,
                      )),
                  retrievedCustomer == null
                  ? Container(
                          margin: const EdgeInsets.symmetric(
                              horizontal: 10, vertical: 5),
                          width: 40,
                          height: 40,
                          decoration: BoxDecoration(
                            shape: BoxShape.circle,
                            image: DecorationImage(
                              image: AssetImage(iconLogoApp),
                              fit: BoxFit.contain,
                            ),
                          ),
                        )
                      : Container(
                      margin: const EdgeInsets.symmetric(
                          horizontal: 10, vertical: 5),
                      width: 40,
                      height: 40,
                      decoration: BoxDecoration(
                        shape: BoxShape.circle,
                        image: DecorationImage(
                          image: NetworkImage(
                            retrievedCustomer.image,
                          ),
                          fit: BoxFit.contain,
                        ),
                      ),
                    ),
                  
                ],
              )
                 
            ],
          ),
          body: Center(
            child: SingleChildScrollView(
              child: Container(
                margin: const EdgeInsets.all(10),
                width: 500,
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(15),
                  color: colorContainers242424,
                ),
                child: Consumer(
                  builder: (context, ref, child) {
                    if (retrievedCustomer == null) {
                      return Center(
                        child: WidgetEmpty(
                          heightIcon: 100,
                          topSpace: 0,
                          title: 'Vamos começar!',
                          subTitle:
                              'Por favor, entre ou registre-se para continuar.',
                          text: 'Entrar',
                          onPressed: () {
                            Navigator.of(context).pushNamed('/login');
                          },
                        ),
                      );
                    } else {
                      return const BodyCalendarWeb();
                    }
                  },
                ),
              ),
            ),
          ),
          // persistentFooterButtons: const [DownloadAppPromotion()],
        );
      }),
    );
  }
}
