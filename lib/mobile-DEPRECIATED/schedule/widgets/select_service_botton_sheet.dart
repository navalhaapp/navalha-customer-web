import 'package:flutter/material.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:navalha/mobile-DEPRECIATED/schedule/schedule_page.dart';
import 'package:navalha/mobile-DEPRECIATED/schedule/widgets/select_professional_botton_sheet.dart';
import 'package:navalha/mobile-DEPRECIATED/schedule/widgets/service_item_schedule.dart';
import 'package:navalha/shared/widgets/header_button_sheet_pattern.dart';
import '../../../core/colors.dart';
import '../../home/model/response_get_barber_shop_by_id.dart';
import '../../../shared/model/barber_shop_model.dart';
import '../../../shared/model/professional_model.dart';
import '../../../shared/model/service_model.dart';
import '../../../shared/providers.dart';
import '../../../shared/utils.dart';
import '../../../shared/widgets/button_pattern_botton_sheet.dart';
import '../../../shared/widgets/page_transition.dart';
import '../../../shared/widgets/widget_empty.dart';

class SelectServiceBottonSheet extends StatefulWidget {
  const SelectServiceBottonSheet({
    Key? key,
    required this.onConfirm,
    required this.listServices,
    required this.listAllServicesWithProfessional,
    required this.listProfessionals,
    required this.barberShop,
    this.packageSelected,
    this.havePrice,
  }) : super(key: key);

  final Function onConfirm;
  final List<Service> listServices;
  final List<Service> listAllServicesWithProfessional;
  final List<Professional> listProfessionals;
  final BarberShop barberShop;
  final CustomerPackages? packageSelected;
  final bool? havePrice;

  @override
  State<SelectServiceBottonSheet> createState() =>
      _SelectServiceBottonSheetState();
}

class _SelectServiceBottonSheetState extends State<SelectServiceBottonSheet> {
  List<Professional> getProfessionalsByService(
    Service service,
    List<Professional> professionals,
  ) {
    final String serviceName = service.name!;

    return professionals.where((professional) {
      final List<Service> professionalServices =
          professional.professionalServices!;

      final bool hasService = professionalServices.any((service) {
        return service.name == serviceName && service.activated == true;
      });

      return hasService;
    }).toList();
  }

  @override
  Widget build(BuildContext context) {
    final size = MediaQuery.of(context).size;

    return SafeArea(
      minimum: EdgeInsets.only(top: size.height * 0.04),
      child: Scaffold(
        bottomSheet: GestureDetector(
          onTap: (() {}),
          child: Consumer(
            builder: (context, ref, child) {
              final packageToUseSelected =
                  ref.watch(packageSelectedToUseProvider.state);
              final servicePackageSelected =
                  ref.watch(servicePackageSelectedProvider.state);
              return Container(
                decoration: BoxDecoration(
                  color: colorBackground181818,
                  borderRadius: const BorderRadius.only(
                    topLeft: Radius.circular(15),
                    topRight: Radius.circular(15),
                  ),
                ),
                child: SingleChildScrollView(
                  child: Column(
                    mainAxisSize: MainAxisSize.min,
                    children: [
                      const HeaderBottonSheetPattern(),
                      isNullOrEmpty(widget.listServices)
                          ? WidgetEmpty(
                              havebutton: false,
                              title: 'Nenhum serviço disponivel',
                              subTitle:
                                  'Seu pacote não possui mais serviços disponíveis.',
                              text: 'Atualizar',
                              topSpace: size.height * 0.01,
                              onPressed: () {
                                navigationFadePush(
                                    const SchedulePage(), context);
                              },
                            )
                          : const SizedBox(),
                      for (int i = 0; i < widget.listServices.length; i++)
                        GestureDetector(
                          onTap: () {
                            if (!isNullOrEmpty(widget.packageSelected)) {
                              servicePackageSelected.state =
                                  packageToUseSelected
                                      .state.customerPackageServices!
                                      .firstWhere((customerPackageService) =>
                                          customerPackageService
                                              .barbershopServiceId!.serviceId ==
                                          widget.listServices[i].serviceId);
                            }
                            Navigator.pop(context);
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
                                  child: SelectProfessionalBottonSheet(
                                    havePrice: false,
                                    packageList: widget.packageSelected,
                                    barberShop: widget.barberShop,
                                    servicePrice: widget.listServices[i].price!,
                                    serviceName: widget.listServices[i].name!,
                                    serviceImg:
                                        widget.listServices[i].imgProfile!,
                                    listProfessionals:
                                        getProfessionalsByService(
                                      widget.listServices[i],
                                      widget.listProfessionals,
                                    ),
                                    onConfirm: () {
                                      setState(() {});
                                    },
                                  ),
                                );
                              },
                            );
                          },
                          child: ServiceItemSchedule(
                            havePrice: widget.havePrice,
                            packageSelected: widget.packageSelected,
                            description: widget.listServices[i].description!,
                            duration: getDurationRange(
                                widget.listAllServicesWithProfessional,
                                widget.listServices[i].name!),
                            img: widget.listServices[i].imgProfile!,
                            name: widget.listServices[i].name!,
                            price: getPriceRange(
                                widget.listAllServicesWithProfessional,
                                widget.listServices[i].name!),
                          ),
                        ),
                      ButtonPattern(
                        width: size.width * 0.94,
                        child: const Text(
                          'Cancelar',
                          style: TextStyle(
                            fontSize: 15,
                            color: Colors.white,
                          ),
                        ),
                        onPressed: () {
                          Navigator.pop(context);
                        },
                      ),
                    ],
                  ),
                ),
              );
            },
          ),
        ),
      ),
    );
  }
}
