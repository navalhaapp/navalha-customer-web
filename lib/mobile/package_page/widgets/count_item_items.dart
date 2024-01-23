import 'package:flutter/material.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:navalha/shared/providers.dart';
import '../../../shared/model/package_model.dart';
import '../../../shared/utils.dart';
import 'package_page_item.dart';

class CountItem extends StatefulHookConsumerWidget {
  const CountItem({
    Key? key,
    required this.i,
  }) : super(key: key);

  final int i;

  @override
  ConsumerState<CountItem> createState() => _CountServicesItemState();
}

class _CountServicesItemState extends ConsumerState<CountItem> {
  @override
  void initState() {
    WidgetsBinding.instance.addPostFrameCallback((_) async {
      final packageSelectController = ref.watch(packageSelectedProvider.state);
      final packageOptionalSelectedController =
          ref.watch(packageOptionalSelectedProvider.state);
      List<BarbershopPackageItems>? zerarQuantidadeDeProducts(
          List<BarbershopPackageItems>? lista) {
        if (lista == null) {
          return lista;
        } else {
          for (var product in lista) {
            product.barbershopPackageItemQuantity = 0;
          }
          return lista;
        }
      }

      packageOptionalSelectedController.state.barbershopPackageItems =
          zerarQuantidadeDeProducts(
        getNonRequiredItems(
            packageSelectController.state.barbershopPackageItems),
      );
      List<BarbershopPackageServices>? zerarQuantidadeDeServicos(
          List<BarbershopPackageServices>? lista) {
        if (lista == null) {
          return lista;
        } else {
          for (var service in lista) {
            service.barbershopPackageServiceQuantity = 0;
          }
          return lista;
        }
      }

      packageOptionalSelectedController.state.barbershopPackageServices =
          zerarQuantidadeDeServicos(getNonRequiredServices(
              packageSelectController.state.barbershopPackageServices));
    });
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    Size size = MediaQuery.of(context).size;
    return Consumer(
      builder: (context, ref, child) {
        final packageOptionalSelectedController =
            ref.watch(packageOptionalSelectedProvider.state);
        final packageAmountPriceController =
            ref.watch(packageAmountPriceProvider.state);
        return Row(
          children: [
            GestureDetector(
              onTap: () {
                setState(() {
                  if (packageOptionalSelectedController
                          .state
                          .barbershopPackageItems![widget.i]
                          .barbershopPackageItemQuantity! <=
                      0) {
                    null;
                  } else {
                    packageOptionalSelectedController
                            .state
                            .barbershopPackageItems![widget.i]
                            .barbershopPackageItemQuantity =
                        packageOptionalSelectedController
                                .state
                                .barbershopPackageItems![widget.i]
                                .barbershopPackageItemQuantity! -
                            1;

                    packageAmountPriceController.state -=
                        packageOptionalSelectedController
                            .state
                            .barbershopPackageItems![widget.i]
                            .barbershopPackageItemPrice!;
                  }
                });
              },
              child: Container(
                height: size.width * 0.06,
                width: size.width * 0.06,
                alignment: Alignment.center,
                decoration: const BoxDecoration(
                  borderRadius: BorderRadius.horizontal(
                    left: Radius.circular(5),
                  ),
                  color: Colors.white,
                ),
                child: const Text(
                  '-',
                  style: TextStyle(color: Colors.black),
                ),
              ),
            ),
            Container(
              decoration: const BoxDecoration(
                color: Colors.white,
                border: Border(
                    right: BorderSide(
                      color: Colors.black,
                      width: 1,
                    ),
                    left: BorderSide(
                      color: Colors.black,
                      width: 1,
                    )),
              ),
              height: size.width * 0.06,
              alignment: Alignment.center,
              child: Padding(
                padding: EdgeInsets.symmetric(
                  horizontal: size.width * 0.02,
                ),
                child: Text(
                  textAlign: TextAlign.center,
                  isNullOrEmpty(packageOptionalSelectedController
                          .state.barbershopPackageItems)
                      ? '0'
                      : packageOptionalSelectedController
                          .state
                          .barbershopPackageItems![widget.i]
                          .barbershopPackageItemQuantity!
                          .toString(),
                  style: const TextStyle(color: Colors.black),
                ),
              ),
            ),
            GestureDetector(
              onTap: () {
                setState(() {
                  packageOptionalSelectedController
                          .state
                          .barbershopPackageItems![widget.i]
                          .barbershopPackageItemQuantity =
                      packageOptionalSelectedController
                              .state
                              .barbershopPackageItems![widget.i]
                              .barbershopPackageItemQuantity! +
                          1;

                  packageAmountPriceController.state +=
                      packageOptionalSelectedController
                          .state
                          .barbershopPackageItems![widget.i]
                          .barbershopPackageItemPrice!;
                });
              },
              child: Container(
                height: size.width * 0.06,
                width: size.width * 0.06,
                alignment: Alignment.center,
                decoration: const BoxDecoration(
                  borderRadius:
                      BorderRadius.horizontal(right: Radius.circular(5)),
                  color: Colors.white,
                ),
                child: Padding(
                  padding: EdgeInsets.symmetric(
                    horizontal: size.width * 0.015,
                  ),
                  child: const Text(
                    '+',
                    style: TextStyle(color: Colors.black),
                  ),
                ),
              ),
            ),
          ],
        );
      },
    );
  }
}
