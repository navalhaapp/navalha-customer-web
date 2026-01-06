import 'package:flutter/material.dart';
import 'package:navalha/core/colors.dart';
import 'package:navalha/mobile-DEPRECIATED/home/model/response_get_barber_shop_by_id.dart';
import 'package:navalha/mobile-DEPRECIATED/schedule/widgets/body_schedule.dart';
import 'package:navalha/shared/model/professional_model.dart';
import 'package:navalha/shared/model/service_model.dart';
import 'package:navalha/shared/utils.dart';
import 'package:navalha/web/home/widgets/service_item_web.dart';

class ServicesList extends StatelessWidget {
  const ServicesList({
    Key? key,
    required this.data,
    this.packageSelected,
    this.havePrice,
    required this.onNextStep,
  }) : super(key: key);

  final ResponseBarberShopById data;
  final CustomerPackages? packageSelected;
  final bool? havePrice;
  final Function(Object) onNextStep;

  @override
  Widget build(BuildContext context) {
    final professionals = data.barbershop?.professionals ?? [];
    final services = showActivatedServices(data.barbershop?.services ?? []);
    List<Service> listServices = findServicesWithProfessionals(
      professionals,
      services,
    );
    return Column(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: [
        Padding(
          padding: const EdgeInsets.only(left: 10, top: 15, bottom: 10),
          child: Text(
            'Escolha um serviço',
            style: TextStyle(
              fontSize: 20,
              shadows: shadow,
              color: Colors.white,
            ),
          ),
        ),
        const SizedBox(height: 10),
        SizedBox(
          child: ListView.builder(
            padding: EdgeInsets.zero,
            shrinkWrap: true,
            physics: const NeverScrollableScrollPhysics(),
            itemCount: listServices.length,
            itemBuilder: (context, iService) {
              List<Professional> listProfessionals = getProfessionalsByService(
                listServices[iService],
                data.barbershop!.professionals!,
              );
              return GestureDetector(
                child: ServiceItemWeb(
                  havePrice: havePrice,
                  packageSelected: packageSelected,
                  description: listServices[iService].description!,
                  duration: getDurationRange(
                      getAllServices(professionals),
                      listServices[iService].name!),
                  img: listServices[iService].imgProfile,
                  name: listServices[iService].name!,
                  price: getPriceRange(
                      getAllServices(professionals),
                      listServices[iService].name!),
                ),
                onTap: () {
                  onNextStep(
                    {
                      'serviceName': listServices[iService].name!,
                      'data': data,
                      'iService': iService,
                      'listProfessionals': listProfessionals,
                      'packageSelected': packageSelected,
                    },
                  );
                },
              );
            },
          ),
        ),
      ],
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
}
