import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:navalha/mobile-DEPRECIATED/calendar/model/model_get_schedule_customer.dart';
import 'package:navalha/mobile-DEPRECIATED/my_packages/my_packages_page.dart';
import 'package:navalha/mobile-DEPRECIATED/my_packages/widgets/my_packages_item.dart';
import 'package:navalha/shared/utils.dart';
import 'package:navalha/shared/widgets/top_container_title.dart';
import '../../../../core/assets.dart';
import '../../../../core/images_s3.dart';
import '../../login/controller/login_controller.dart';
import '../../../../shared/animation/page_trasition.dart';
import '../../../../shared/shimmer/shimmer_calendar.dart';
import '../../../../shared/widgets/widget_empty.dart';
import '../model/response_get_customer_packages.dart';
import '../provider/provider_get_customer_packages.dart';

class MyPackagesBody extends StatefulHookConsumerWidget {
  const MyPackagesBody({Key? key}) : super(key: key);

  @override
  ConsumerState<MyPackagesBody> createState() => _MyPackagesBodyState();
}

class _MyPackagesBodyState extends ConsumerState<MyPackagesBody> {
  late ProviderFamilyGetScheduleModel getPackagesModel;

  @override
  void initState() {
    super.initState();

    final loginController = ref.read(LoginStateController.provider.notifier);

    getPackagesModel = ProviderFamilyGetScheduleModel(
      token: loginController.user!.token!,
      customerId: loginController.user!.customer!.customerId!,
    );

    setState(() {});
  }

  @override
  Widget build(BuildContext context) {
    Size size = MediaQuery.of(context).size;
    final getPackages = ref.watch(
      getPackagesCustomerList(getPackagesModel),
    );
    return Consumer(
      builder: (context, ref, child) {
        final loginController =
            ref.read(LoginStateController.provider.notifier);
        return SingleChildScrollView(
          child: Column(
            children: [
              TopContainerTitle(
                imgProfile: loginController.user?.customer?.imgProfile ?? '',
                imgBackGround: imgBackgroundBarberShop,
                name: loginController.user?.customer?.name ?? 'Usuário',
              ),
              getPackages.when(
                data: (data) {
                  List<ResultGetCustomerPackages> listScheduleItem =
                      data.result!;
                  if (!isNullOrEmpty(listScheduleItem)) {
                    return Column(
                      children: [
                        ListView.builder(
                          padding: EdgeInsets.zero,
                          shrinkWrap: true,
                          physics: const NeverScrollableScrollPhysics(),
                          itemCount: listScheduleItem.length,
                          itemBuilder: (context, i) => MyPackagesItem(
                            listScheduleItem: listScheduleItem,
                            i: i,
                          ),
                        ),
                      ],
                    );
                  } else {
                    return Center(
                      child: WidgetEmpty(
                        titleSize: 20,
                        topSpace: 0,
                        title: 'Nenhum pacote',
                        subTitle: 'Você não possui nenhum pacote',
                        text: 'Atualizar',
                        onPressed: () => navigationWithFadeAnimation(
                            const MyPackagesPage(), context),
                      ),
                    );
                  }
                },
                error: (error, stackTrace) => WidgetEmpty(
                  title: 'Ops, Algo aconteceu!',
                  subTitle: 'Houve algum erro, tente novamente mais tarde.',
                  onPressed: () {
                    navigationWithFadeAnimation(
                        const MyPackagesPage(), context);
                  },
                  text: 'Tentar de novo',
                ),
                loading: () => const ShimmerCalendar(),
              ),
              SizedBox(height: size.height * 0.1)
            ],
          ),
        );
      },
    );
  }
}
