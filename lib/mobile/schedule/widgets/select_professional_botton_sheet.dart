import 'package:flutter/material.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:navalha/mobile/schedule/widgets/select_day_hour_botton_sheet.dart';
import 'package:navalha/shared/model/professional_model.dart';
import '../../barbershop_page/tab_professionals/widgets/professional_item.dart';
import '../../../core/colors.dart';
import '../../home/model/response_get_barber_shop_by_id.dart';
import '../../../shared/model/barber_shop_model.dart';
import '../../../shared/model/service_model.dart';
import '../../../shared/providers.dart';
import '../../../shared/utils.dart';
import '../../../shared/widgets/button_pattern_botton_sheet.dart';
import '../../../shared/widgets/header_button_sheet_pattern.dart';
import '../model/model_reserved_time.dart';

class SelectProfessionalBottonSheet extends StatefulWidget {
  const SelectProfessionalBottonSheet({
    Key? key,
    required this.onConfirm,
    required this.listProfessionals,
    required this.serviceName,
    required this.serviceImg,
    required this.servicePrice,
    required this.barberShop,
    this.packageList,
    this.havePrice,
  }) : super(key: key);

  final Function onConfirm;
  final List<Professional> listProfessionals;
  final String serviceName;
  final String serviceImg;
  final double servicePrice;
  final BarberShop barberShop;
  final CustomerPackages? packageList;
  final bool? havePrice;

  @override
  State<SelectProfessionalBottonSheet> createState() =>
      _SelectProfessionalBottonSheetState();
}

class _SelectProfessionalBottonSheetState
    extends State<SelectProfessionalBottonSheet> {
  late StateController<ReservedTime> reservedTime;

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
              reservedTime = ref.watch(reservedTimeProvider.state);
              final resumePayment = ref.watch(resumePaymentProvider.state);
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
                    for (int i = 0; i < widget.listProfessionals.length; i++)
                      GestureDetector(
                        onTap: () {
                          reservedTime.state.professionalId =
                              widget.listProfessionals[i].professionalId!;
                          reservedTime.state.serviceId = getServiceIdByName(
                              widget.serviceName,
                              widget
                                  .listProfessionals[i].professionalServices!);
                          resumePayment.state.professionalId =
                              reservedTime.state.professionalId;
                          resumePayment.state.professionalServiceId =
                              reservedTime.state.serviceId;
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
                                child: SelectDayHourBottonSheet(
                                  packageSelected: widget.packageList,
                                  barberShop: widget.barberShop,
                                ),
                              );
                            },
                          );
                        },
                        child: ProfessionalItem(
                          havePrice: widget.havePrice,
                          serviceTime: getDurationOfServiceWithName(
                              widget.serviceName,
                              widget
                                  .listProfessionals[i].professionalServices!),
                          hidePriceAndTime: true,
                          servicePrice: getPriceOfServiceWithName(
                              widget.serviceName,
                              widget
                                  .listProfessionals[i].professionalServices!),
                          img: widget.listProfessionals[i].imgProfile!,
                          name: widget.listProfessionals[i].name!,
                          imgService: getImgByName(
                            widget.serviceImg,
                            widget.listProfessionals[i].professionalServices!,
                          ),
                          rating: widget.listProfessionals[i].rating!,
                        ),
                      ),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceAround,
                      children: [
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

double? getPriceOfServiceWithName(String name, List<Service> services) {
  for (var service in services) {
    if (service.name == name) {
      return service.price;
    }
  }
  return null;
}

int? getDurationOfServiceWithName(String name, List<Service> services) {
  for (var service in services) {
    if (service.name == name) {
      return service.duration;
    }
  }
  return null;
}
