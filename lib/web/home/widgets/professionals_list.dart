import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:navalha/core/colors.dart';
import 'package:navalha/mobile-DEPRECIATED/home/model/response_get_barber_shop_by_id.dart';
import 'package:navalha/mobile-DEPRECIATED/schedule/model/model_reserved_time.dart';
import 'package:navalha/shared/model/professional_model.dart';
import 'package:navalha/shared/model/service_model.dart';
import 'package:navalha/shared/providers.dart';
import 'package:navalha/shared/utils.dart';
import 'package:navalha/web/home/widgets/professional_item_web.dart';

class ProfessionalListPageWeb extends StatefulWidget {
  const ProfessionalListPageWeb({
    Key? key,
    required this.serviceData,
    required this.onPreviousStep,
    required this.onNextStep,
  }) : super(key: key);

  final Map<String, dynamic> serviceData;
  final void Function() onPreviousStep;
  final Function(Object) onNextStep;

  @override
  State<ProfessionalListPageWeb> createState() =>
      _ProfessionalListPageWebState();
}

class _ProfessionalListPageWebState extends State<ProfessionalListPageWeb> {
  @override
  Widget build(BuildContext context) {
    final String? serviceName = widget.serviceData['serviceName'];
    late StateController<ReservedTime> reservedTime;
    final ResponseBarberShopById data = widget.serviceData['data'];
    final List<Professional> listProfessionals =
        widget.serviceData['listProfessionals'];
    final CustomerPackages? packageSelected =
        widget.serviceData['packageSelected'] ?? CustomerPackages();

    return Consumer(
      builder: (context, ref, child) {
        reservedTime = ref.watch(reservedTimeProvider.state);
        final resumePayment = ref.watch(resumePaymentProvider.state);
        return Center(
          child: Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              Padding(
                padding: const EdgeInsets.only(left: 30, bottom: 10, top: 10),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    InkWell(
                      onTap: () {
                        widget.onPreviousStep.call();
                      },
                      child: const Icon(
                        CupertinoIcons.clear,
                        color: Colors.white,
                      ),
                    ),
                    Text(
                      'Escolha um profissional',
                      style: TextStyle(
                        fontSize: 20,
                        shadows: shadow,
                        color: Colors.white,
                      ),
                    ),
                    IconButton(
                      padding: const EdgeInsets.only(left: 30),
                      onPressed: () {},
                      icon: const Icon(
                        CupertinoIcons.clear,
                        color: Colors.transparent,
                      ),
                    ),
                  ],
                ),
              ),
              SizedBox(
                child: ListView.builder(
                  padding: EdgeInsets.zero,
                  shrinkWrap: true,
                  physics: const NeverScrollableScrollPhysics(),
                  itemCount: listProfessionals.length,
                  itemBuilder: (context, i) {
                    final Service? selectedService = _getServiceByName(
                      listProfessionals[i].professionalServices,
                      serviceName,
                    );
                    return GestureDetector(
                      onTap: () {
                        reservedTime.state.professionalId =
                            listProfessionals[i].professionalId;
                        reservedTime.state.serviceId = getServiceIdByName(
                            serviceName ?? '',
                            listProfessionals[i].professionalServices);
                        resumePayment.state.professionalId =
                            reservedTime.state.professionalId;
                        resumePayment.state.professionalServiceId =
                            reservedTime.state.serviceId;
                        widget.onNextStep({
                          'barbershop': data.barbershop ?? '',
                        });
                      },
                      child: ProfessionalItemWeb(
                        i: i,
                        professionalId: listProfessionals[i].professionalId!,
                        listProfessionalServices:
                            listProfessionals[i].professionalServices!,
                        hidePriceAndTime: true,
                        img: listProfessionals[i].imgProfile!,
                        name: listProfessionals[i].name!,
                        rating: listProfessionals[i].rating!,
                        imgService: selectedService?.imgProfile,
                        listImgServices:
                            listProfessionals[i].professionalServices,
                        serviceTime: selectedService?.duration,
                        havePrice: false,
                        packageList: packageSelected,
                        barberShop: data.barbershop!,
                        servicePrice: selectedService?.price,
                        serviceName: selectedService?.name ?? serviceName ?? '',
                        serviceImg: selectedService?.imgProfile ?? '',
                        listProfessionals: getProfessionalsByService(
                          selectedService ?? Service(name: serviceName),
                          data.barbershop?.professionals ?? [],
                        ),
                        onConfirm: () {
                          setState(() {});
                        },
                      ),
                    );
                  },
                ),
              ),
            ],
          ),
        );
      },
    );
  }

  List<Professional> getProfessionalsByService(
      Service service, List<Professional> professionals) {
    final String? serviceName = service.name;
    if (serviceName == null) {
      return [];
    }

    return professionals.where((professional) {
      final professionalServices = professional.professionalServices;
      if (professionalServices == null) {
        return false;
      }

      final bool hasService = professionalServices.any((service) {
        return service.name == serviceName && service.activated == true;
      });

      return hasService;
    }).toList();
  }

  Service? _getServiceByName(
    List<Service>? services,
    String? serviceName,
  ) {
    if (services == null || services.isEmpty) {
      return null;
    }
    if (serviceName != null) {
      for (final service in services) {
        if (service.name == serviceName && service.activated == true) {
          return service;
        }
      }
      for (final service in services) {
        if (service.name == serviceName) {
          return service;
        }
      }
    }
    return services.first;
  }
}
