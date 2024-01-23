import 'package:flutter/material.dart';
import 'package:navalha/mobile/barbershop_page/tab_services/widgets/service_item.dart';

import '../../../../../shared/model/service_model.dart';
import '../../schedule/widgets/body_schedule.dart';
import '../../../shared/model/barber_shop_model.dart';
import '../../../shared/widgets/page_transition.dart';
import '../../../shared/widgets/widget_empty.dart';
import '../barbershop_page.dart';

class TabServices extends StatelessWidget {
  final BarberShop barberShop;
  const TabServices({
    Key? key,
    required this.barberShop,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    List<Service> listServices =
        getCheapestServices(getAllServices(barberShop.professionals!));
    List<Service> servicosAtivos = [];

    for (int i = 0; i < listServices.length; i++) {
      if (listServices[i].activated!) {
        servicosAtivos.add(listServices[i]);
      }
    }

    return servicosAtivos.isNotEmpty
        ? Column(
            children: [
              for (int i = 0; i < servicosAtivos.length; i++)
                ServiceItem(
                  description: servicosAtivos[i].description!,
                  duration: servicosAtivos[i].duration!,
                  img: servicosAtivos[i].imgProfile!,
                  name: servicosAtivos[i].name!,
                  price: servicosAtivos[i].price!,
                )
            ],
          )
        : Center(
            child: WidgetEmpty(
              onPressed: () {
                navigationFadePush(const BarbershopPage(), context);
              },
              topSpace: 0,
              title: 'Nenhum serviço!',
              subTitle: 'A barbearia não possui nenhum serviço ativo.',
              text: 'Tentar novamente',
            ),
          );
  }
}

double? getLowestPrice(List<Service> services) {
  double? lowestPrice;
  for (var service in services) {
    if (service.price != null &&
        (lowestPrice == null || service.price! < lowestPrice)) {
      lowestPrice = service.price;
    }
  }
  return lowestPrice;
}

int? getShortestDuration(List<Service> services) {
  int? shortestDuration;
  for (var service in services) {
    if (service.duration != null &&
        (shortestDuration == null || service.duration! < shortestDuration)) {
      shortestDuration = service.duration;
    }
  }
  return shortestDuration;
}

List<Service> getCheapestServices(List<Service> services) {
  Map<String, Service> cheapestServices = {};

  for (Service service in services) {
    if (service.activated == true) {
      if (cheapestServices.containsKey(service.name!)) {
        if (service.price! < cheapestServices[service.name!]!.price!) {
          cheapestServices[service.name!] = service;
        }
      } else {
        cheapestServices[service.name!] = service;
      }
    }
  }

  List<Service> result = cheapestServices.values.toList();

  return result;
}
