import 'package:flutter/material.dart';

import 'package:navalha/core/assets.dart';
import 'package:navalha/core/colors.dart';

import '../../../../../shared/utils.dart';
import '../../../shared/model/barber_shop_model.dart';
import 'widgets/about_us.dart';
import 'widgets/carrousel_slider_gallery.dart';

class TabDetails extends StatelessWidget {
  final BarberShop barberShop;
  const TabDetails({
    Key? key,
    required this.barberShop,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    Size size = MediaQuery.of(context).size;

    var adress = barberShop.adress!;
    String? street = barberShop.adress!.street == ''
        ? ''
        : '${barberShop.adress!.street} - ${barberShop.adress!.number.toString()}, ';
    String? district = barberShop.adress!.district == ''
        ? ''
        : '${barberShop.adress!.district} ';
    final String path =
        "/maps/place/${adress.street}+${adress.number},+${adress.district},+${adress.city},+${adress.state}+-+${adress.postalCode}";

    final Uri urlMaps = Uri(
      scheme: 'https',
      host: 'www.google.com',
      path: path,
    );
    return Column(
      children: [
        CarrouselSliderGallery(galleyImages: barberShop.galleryImages),
        barberShop.aboutUs == null
            ? const SizedBox()
            : AboutUs(description: barberShop.aboutUs!),
        Container(
          margin: EdgeInsets.only(
            bottom: size.height * .015,
            left: size.width * .03,
            right: size.width * .03,
          ),
          decoration: BoxDecoration(
            color: colorContainers242424,
            borderRadius: BorderRadius.circular(18),
          ),
          width: double.maxFinite,
          child: Padding(
            padding: const EdgeInsets.all(15.0),
            child: Column(
              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  'Endereço',
                  style: TextStyle(
                      fontSize: size.height * 0.025, color: Colors.white),
                ),
                Text(
                  '$street$district${barberShop.adress!.city} - ${barberShop.adress!.state}${barberShop.adress!.complement == null ? '' : '\n'}${barberShop.adress!.complement ?? ''}',
                  style: TextStyle(
                    fontSize: size.height * 0.022,
                    color: const Color.fromARGB(255, 182, 182, 182),
                  ),
                ),
                const SizedBox(height: 10),
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  crossAxisAlignment: CrossAxisAlignment.end,
                  children: [
                    Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(
                          'Fone',
                          style: TextStyle(
                              fontSize: size.height * 0.025,
                              color: Colors.white),
                        ),
                        Text(
                          barberShop.phone!,
                          style: TextStyle(
                            fontSize: size.height * 0.022,
                            color: const Color.fromARGB(255, 182, 182, 182),
                          ),
                        ),
                      ],
                    ),
                  ],
                ),
                const SizedBox(height: 5),
                Text(
                  '${barberShop.physical! ? 'Atende' : 'Não atende'} em espaço comercial.',
                  style: const TextStyle(
                    fontSize: 17,
                    color: Color.fromARGB(255, 182, 182, 182),
                  ),
                ),
                Row(
                  mainAxisAlignment: MainAxisAlignment.end,
                  children: [
                    Expanded(
                      child: Row(
                        children: [
                          Icon(
                            size: 30,
                            barberShop.accessibility!
                                ? Icons.accessible
                                : Icons.not_accessible_sharp,
                            color: Colors.white,
                          ),
                          SizedBox(width: barberShop.park! ? 12 : 20),
                          Icon(
                            size: 30,
                            barberShop.internet! ? Icons.wifi : Icons.wifi_off,
                            color: Colors.white,
                          ),
                          const SizedBox(width: 10),
                          barberShop.park!
                              ? const Icon(
                                  size: 30,
                                  Icons.directions_car,
                                  color: Colors.white,
                                )
                              : SizedBox(
                                  width: size.width * 0.14,
                                  child: Image.asset(noPark),
                                ),
                        ],
                      ),
                    ),
                    GestureDetector(
                      onTap: () => launchInBrowser(urlMaps),
                      child: Image.asset(
                        imgGoogleMap,
                        height: size.height * 0.05,
                        width: size.width * 0.1,
                      ),
                    )
                  ],
                )
              ],
            ),
          ),
        ),
      ],
    );
  }
}
