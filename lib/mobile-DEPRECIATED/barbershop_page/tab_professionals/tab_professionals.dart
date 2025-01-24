import 'package:flutter/material.dart';
import '../../../../../shared/model/professional_model.dart';
import '../../../shared/model/barber_shop_model.dart';
import '../../../shared/utils.dart';
import 'widgets/professional_item.dart';

class TabProfessional extends StatelessWidget {
  final BarberShop barberShop;
  const TabProfessional({
    Key? key,
    required this.barberShop,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    List<Professional>? listProfessionals =
        sortProfessionalsByRating(barberShop.professionals!);
    return Column(
      children: [
        for (int i = 0; i < listProfessionals.length; i++)
          ProfessionalItem(
            hidePriceAndTime: false,
            img: listProfessionals[i].imgProfile!,
            name: listProfessionals[i].name!,
            rating: listProfessionals[i].rating!,
            listImgServices: showActivatedServices(
                listProfessionals[i].professionalServices!),
            servicePrice: 0,
          ),
      ],
    );
  }
}

List<Professional> sortProfessionalsByRating(List<Professional> professionals) {
  professionals.sort((a, b) => (b.rating ?? 0).compareTo(a.rating ?? 0));
  return professionals;
}
