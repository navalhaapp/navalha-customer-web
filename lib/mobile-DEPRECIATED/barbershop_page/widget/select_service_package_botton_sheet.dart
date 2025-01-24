import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:navalha/core/colors.dart';
import 'package:navalha/shared/widgets/header_button_sheet_pattern.dart';
import 'package:navalha/shared/widgets/page_transition.dart';
import '../../home/model/response_get_barber_shop_by_id.dart';
import '../../package_page/package_page.dart';
import '../../package_page/widgets/package_buy_button_sheet.dart';
import '../../schedule/schedule_page.dart';
import '../../schedule/widgets/body_schedule.dart';
import '../../schedule/widgets/select_service_botton_sheet.dart';
import '../../../shared/providers.dart';
import '../../../shared/utils.dart';
import '../../use_package/use_package_page.dart';
import '../../use_package/widgets/packages_use_botton_sheet.dart';

class SelectServicePackageBottonSheet extends StatefulWidget {
  const SelectServicePackageBottonSheet({
    Key? key,
    required this.listPackagesUser,
  }) : super(key: key);

  final List<CustomerPackages>? listPackagesUser;

  @override
  State<SelectServicePackageBottonSheet> createState() =>
      _SelectServiceBottonSheetState();
}

class _SelectServiceBottonSheetState
    extends State<SelectServicePackageBottonSheet> {
  @override
  Widget build(BuildContext context) {
    final size = MediaQuery.of(context).size;

    return SafeArea(
      minimum: EdgeInsets.only(top: size.height * 0.04),
      child: Scaffold(
        bottomSheet: GestureDetector(
          onTap: () {},
          child: Consumer(
            builder: (context, ref, child) {
              final reservedTime = ref.watch(reservedTimeProvider.state);
              var barberShopProvider =
                  ref.watch(barberShopSelectedProvider.state);
              return Container(
                decoration: BoxDecoration(
                  color: colorBackground181818,
                  borderRadius: const BorderRadius.only(
                    topLeft: Radius.circular(15),
                    topRight: Radius.circular(15),
                  ),
                ),
                child: Column(
                  mainAxisSize: MainAxisSize.min,
                  children: [
                    const HeaderBottonSheetPattern(),
                    SizedBox(height: MediaQuery.of(context).size.width * 0.02),
                    ContainerPackageServiceBuy(
                      icon: CupertinoIcons.scissors,
                      label: 'Agendar serviço',
                      description: 'Agende serviços de forma independente.',
                      onPressed: () {
                        navigationFadePushReplacement(
                            const SchedulePage(), context);
                        showModalBottomSheet<void>(
                          backgroundColor: Colors.transparent,
                          isScrollControlled: true,
                          isDismissible: true,
                          context: context,
                          builder: (BuildContext context) {
                            reservedTime.state.clear();
                            return GestureDetector(
                              onTap: () {
                                Navigator.of(context).pop();
                              },
                              child: SelectServiceBottonSheet(
                                barberShop: barberShopProvider.state,
                                listAllServicesWithProfessional: getAllServices(
                                    barberShopProvider.state.professionals!),
                                listProfessionals:
                                    barberShopProvider.state.professionals!,
                                listServices: findServicesWithProfessionals(
                                  barberShopProvider.state.professionals!,
                                  showActivatedServices(
                                      barberShopProvider.state.services!),
                                ),
                                onConfirm: () {
                                  setState(() {});
                                },
                              ),
                            );
                          },
                        );
                      },
                    ),
                    Visibility(
                      visible:
                          !isNullOrEmpty(barberShopProvider.state.packageList),
                      child: ContainerPackageServiceBuy(
                        icon: CupertinoIcons.cube_box,
                        label: 'Comprar pacote',
                        description: 'Compre um pacote e tenha mais economia.',
                        onPressed: () {
                          Navigator.of(context).pop();
                          navigationFadePushReplacement(
                              const PackagePage(), context);
                          showModalBottomSheet<void>(
                            backgroundColor: Colors.transparent,
                            isScrollControlled: true,
                            isDismissible: true,
                            context: context,
                            builder: (BuildContext context) {
                              reservedTime.state.clear();
                              return GestureDetector(
                                onTap: () {
                                  Navigator.of(context).pop();
                                },
                                child: const PackageBuyItemButtonSheet(),
                              );
                            },
                          );
                        },
                      ),
                    ),
                    Visibility(
                      visible: !isNullOrEmpty(widget.listPackagesUser),
                      child: ContainerPackageServiceBuy(
                        icon: CupertinoIcons.cube_box_fill,
                        label: 'Usar pacote',
                        description: 'Use os serviços que já estão pagos.',
                        onPressed: () {
                          Navigator.of(context).pop();

                          showModalBottomSheet<void>(
                            backgroundColor: Colors.transparent,
                            isScrollControlled: true,
                            isDismissible: true,
                            context: context,
                            builder: (BuildContext context) {
                              return GestureDetector(
                                onTap: () {
                                  Navigator.of(context).pop();
                                },
                                child: PackageUseButtonSheet(
                                  listPackagesUser: widget.listPackagesUser,
                                ),
                              );
                            },
                          );
                        },
                      ),
                    ),
                    const SizedBox(height: 15)
                  ],
                ),
              );
            },
          ),
        ),
      ),
    );
  }
}

class ContainerPackageServiceBuy extends StatelessWidget {
  const ContainerPackageServiceBuy({
    Key? key,
    required this.label,
    required this.description,
    required this.icon,
    required this.onPressed,
  }) : super(key: key);

  final String label;
  final String description;
  final IconData icon;
  final Function onPressed;

  @override
  Widget build(BuildContext context) {
    final size = MediaQuery.of(context).size;
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 5),
      child: ElevatedButton(
        style: ButtonStyle(
          overlayColor: MaterialStateProperty.all<Color>(
            colorContainers353535,
          ),
          elevation: MaterialStateProperty.all(0),
          backgroundColor: MaterialStateProperty.all<Color>(
              const Color.fromARGB(255, 24, 24, 24)),
          shape: MaterialStateProperty.all<RoundedRectangleBorder>(
            RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(12),
            ),
          ),
        ),
        onPressed: () => onPressed(),
        child: Padding(
          padding: const EdgeInsets.symmetric(vertical: 10, horizontal: 5),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Row(
                    children: [
                      Icon(
                        icon,
                        color: Colors.white,
                        size: size.width * 0.055,
                      ),
                      const SizedBox(width: 15),
                      Text(
                        label,
                        style: TextStyle(
                          color: Colors.white,
                          fontSize: size.width * 0.045,
                        ),
                      ),
                    ],
                  ),
                  const SizedBox(height: 5),
                  SizedBox(
                    width: size.width * 0.75,
                    child: Text(
                      description,
                      style: TextStyle(
                        color: colorFontUnable116116116,
                        fontSize: size.width * 0.035,
                      ),
                    ),
                  ),
                ],
              ),
              Icon(
                CupertinoIcons.chevron_forward,
                color: Colors.white,
                size: size.width * 0.035,
              ),
            ],
          ),
        ),
      ),
    );
  }
}
