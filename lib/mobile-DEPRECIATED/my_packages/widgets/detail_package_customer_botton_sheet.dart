import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:navalha/core/colors.dart';
import 'package:navalha/shared/widgets/header_button_sheet_pattern.dart';
import '../../login/controller/login_controller.dart';
import '../../../shared/providers.dart';
import '../../../shared/utils.dart';
import '../../../shared/widgets/widget_empty.dart';
import '../model/response_get_customer_packages.dart';
import 'cupertino_sliding.dart';
import 'products_item_package.dart';
import 'services_item_package.dart';

class DetailPackageCustomerBottonSheet extends StatefulWidget {
  const DetailPackageCustomerBottonSheet({
    Key? key,
    required this.listScheduleItem,
    required this.i,
  }) : super(key: key);

  final List<ResultGetCustomerPackages> listScheduleItem;
  final int i;

  @override
  State<DetailPackageCustomerBottonSheet> createState() =>
      _DetailPackageCustomerBottonSheetState();
}

class _DetailPackageCustomerBottonSheetState
    extends State<DetailPackageCustomerBottonSheet> {
  @override
  Widget build(BuildContext context) {
    final size = MediaQuery.of(context).size;

    return Consumer(
      builder: (context, ref, child) {
        final tabServicePackageController =
            ref.watch(tabServicePackageProvider.state);
        final loginController =
            ref.read(LoginStateController.provider.notifier);
        return SafeArea(
          minimum: EdgeInsets.only(top: size.height * 0.04),
          child: GestureDetector(
            onTap: () {},
            child: Scaffold(
              bottomSheet: Container(
                color: colorBackground181818,
                child: Column(
                  mainAxisSize: MainAxisSize.min,
                  children: [
                    const HeaderBottonSheetPattern(),
                    Column(
                      children: [
                        SlidingServicePackage(onSegmentChanged: (selected) {
                          setState(() {
                            tabServicePackageController.state = selected;
                          });
                        }),
                        const SizedBox(height: 10),
                        tabServicePackageController.state ==
                                EnumPackageService.products
                            ? !isNullOrEmpty(widget.listScheduleItem[widget.i]
                                    .customerPackageProducts)
                                ? Column(
                                    children: [
                                      ListView.builder(
                                        padding: EdgeInsets.zero,
                                        shrinkWrap: true,
                                        physics:
                                            const NeverScrollableScrollPhysics(),
                                        itemCount: widget
                                            .listScheduleItem[widget.i]
                                            .customerPackageProducts!
                                            .length,
                                        itemBuilder: (context, i) =>
                                            ProductsItemMyPackage(
                                          birthDate: loginController
                                              .user!.customer!.birthDate!,
                                          i: i,
                                          listProducts: widget
                                              .listScheduleItem[widget.i]
                                              .customerPackageProducts!,
                                        ),
                                      ),
                                      const SizedBox(height: 10)
                                    ],
                                  )
                                : Center(
                                    child: Padding(
                                      padding: EdgeInsets.symmetric(
                                        horizontal: size.height * 0.01,
                                        vertical: size.height * 0.07,
                                      ),
                                      child: WidgetEmpty(
                                        topSpace: 0,
                                        haveIcon: false,
                                        havebutton: false,
                                        title: 'Nenhum Produto',
                                        subTitle:
                                            'Você não tem nenhum produto disponível.',
                                        text: 'Tentar novamente',
                                        onPressed: () {},
                                      ),
                                    ),
                                  )
                            : !isNullOrEmpty(widget.listScheduleItem[widget.i]
                                    .customerPackageServices)
                                ? Column(
                                    children: [
                                      Container(
                                        margin: EdgeInsets.only(
                                            left: size.width * 0.03,
                                            right: size.width * 0.03,
                                            bottom: 10),
                                        decoration: BoxDecoration(
                                          borderRadius:
                                              BorderRadius.circular(18),
                                          color: colorBrown626262,
                                        ),
                                        child: Padding(
                                          padding:
                                              EdgeInsets.all(size.width * 0.03),
                                          child: Row(
                                            children: [
                                              SizedBox(
                                                width: size.width * 0.18,
                                                child: Icon(
                                                  CupertinoIcons
                                                      .exclamationmark_shield,
                                                  size: size.width * 0.08,
                                                  color: Colors.white,
                                                ),
                                              ),
                                              SizedBox(
                                                width: size.width * 0.67,
                                                child: const Text(
                                                  'Para agendar os serviços desejados, acesse a página inicial e clique na opção "Agendar".',
                                                  style: TextStyle(
                                                      color: Colors.white,
                                                      fontSize: 15),
                                                ),
                                              ),
                                            ],
                                          ),
                                        ),
                                      ),
                                      ListView.builder(
                                        padding: EdgeInsets.zero,
                                        shrinkWrap: true,
                                        physics:
                                            const NeverScrollableScrollPhysics(),
                                        itemCount: widget
                                            .listScheduleItem[widget.i]
                                            .customerPackageServices!
                                            .length,
                                        itemBuilder: (context, i) =>
                                            ServicesItemMyPackage(
                                          i: i,
                                          listProducts: widget
                                              .listScheduleItem[widget.i]
                                              .customerPackageServices!,
                                        ),
                                      ),
                                      const SizedBox(height: 10)
                                    ],
                                  )
                                : Center(
                                    child: Padding(
                                      padding: EdgeInsets.symmetric(
                                        horizontal: size.height * 0.01,
                                        vertical: size.height * 0.07,
                                      ),
                                      child: WidgetEmpty(
                                        topSpace: 0,
                                        haveIcon: false,
                                        havebutton: false,
                                        title: 'Nenhum Serviço',
                                        subTitle:
                                            'Você não tem nenhum serviço disponível.',
                                        text: 'Tentar novamente',
                                        onPressed: () {},
                                      ),
                                    ),
                                  )
                      ],
                    ),
                  ],
                ),
              ),
            ),
          ),
        );
      },
    );
  }
}
