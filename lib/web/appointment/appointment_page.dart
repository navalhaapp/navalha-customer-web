import 'package:flutter/material.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:navalha/core/assets.dart';
import 'package:navalha/core/colors.dart';
import 'package:navalha/mobile/home/model/provider_family_model.dart';
import 'package:navalha/mobile/home/provider/provider_get_barber_shop_by_id.dart';
import 'package:navalha/shared/widgets/widget_empty.dart';
import 'package:navalha/web/appointment/widgets/choose_service_package_dialog.dart';
import '../drawer/drawer_web_page.dart';

class AppointmentWebPage extends StatefulHookConsumerWidget {
  const AppointmentWebPage({
    Key? key,
  }) : super(key: key);

  static const route = '/appointment/:nome';

  @override
  ConsumerState<AppointmentWebPage> createState() => _AppointmentWebPageState();
}

class _AppointmentWebPageState extends ConsumerState<AppointmentWebPage> {
  late ParamsBarberShopById getBarberShopModel;

  @override
  void initState() {
    super.initState();
    setState(() {});
  }

  @override
  Widget build(BuildContext context) {
    final getBarbershopController =
        ref.watch(getAllBarberShopById(getBarberShopModel));

    return getBarbershopController.when(
      data: (data) {
        return Scaffold(
          extendBody: true,
          extendBodyBehindAppBar: true,
          endDrawer: const DrawerWebPage(),
          backgroundColor: colorBackground181818,
          body: ChooseServicePackage(data: data),
          appBar: AppBar(
            actionsIconTheme: const IconThemeData(color: Colors.white),
            leadingWidth: MediaQuery.of(context).size.width < 600 ? 100 : 150,
            leading: Padding(
              padding: const EdgeInsets.all(15),
              child: Image.asset(logoBottonNav),
            ),
            automaticallyImplyLeading: false,
            title: Text(
              data.barbershop!.name!,
              style: TextStyle(
                fontSize: 20,
                shadows: shadow,
                color: Colors.white,
              ),
            ),
            elevation: 0,
            centerTitle: true,
            backgroundColor: Colors.transparent,
          ),
        );
      },
      error: (error, stackTrace) => Scaffold(
        body: WidgetEmpty(
          title: 'Ops, Algo aconteceu!',
          subTitle: 'Houve algum erro, tente novamente mais tarde.',
          onPressed: () {
            Navigator.of(context).pushNamed('/');
          },
          text: 'Tentar de novo',
        ),
      ),
      loading: () => const Scaffold(body: SizedBox()),
    );
  }
}
