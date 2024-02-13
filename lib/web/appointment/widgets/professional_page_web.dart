import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:navalha/core/assets.dart';
import 'package:navalha/core/colors.dart';
import 'package:navalha/mobile/home/model/response_get_barber_shop_by_id.dart';
import 'package:navalha/mobile/schedule/model/model_reserved_time.dart';
import 'package:navalha/shared/model/professional_model.dart';
import 'package:navalha/shared/providers.dart';
import 'package:navalha/shared/utils.dart';
import 'package:navalha/web/appointment/widgets/drawer_page_web.dart';
import 'package:navalha/web/appointment/widgets/professional_item_web.dart';
import 'package:navalha/web/appointment/widgets/services_page_web.dart';
import 'package:navalha/web/db/db_customer_shared.dart';
import '../../../shared/model/service_model.dart';

class ProfessionalPageWeb extends StatefulWidget {
  // static const route = '/professional-web-page';

  @override
  State<ProfessionalPageWeb> createState() => _ProfessionalPageWebState();
}

class _ProfessionalPageWebState extends State<ProfessionalPageWeb> {
  late StateController<ReservedTime> reservedTime;

  @override
  Widget build(BuildContext context) {
    var args =
        ModalRoute.of(context)?.settings.arguments as Map<String, dynamic>?;

    final String? serviceName = args?['serviceName'];
    final ResponseBarberShopById? data = args?['data'];
    final int? iService = args?['iService'];
    final List<Professional>? listProfessionals = args?['listProfessionals'];
    final CustomerPackages? packageSelected = args?['packageSelected'];
    final retrievedCustomer = LocalStorageManager.getCustomer();

    return Consumer(builder: (context, ref, child) {
      return Scaffold(
        backgroundColor: colorBackground181818,
        drawer:
            DrawerPageWeb(barberShopId: data?.barbershop?.barbershopId ?? ''),
        appBar: AppBar(
          elevation: 0,
          title: Text(data?.barbershop?.name ?? ''),
          backgroundColor: colorBackground181818,
          actions: [
            retrievedCustomer == null
                ? Container(
                    margin:
                        const EdgeInsets.symmetric(horizontal: 10, vertical: 5),
                    width: 40,
                    height: 40,
                    decoration: BoxDecoration(
                      shape: BoxShape.circle,
                      image: DecorationImage(
                        image: AssetImage(iconLogoApp),
                        fit: BoxFit.contain,
                      ),
                    ),
                  )
                : Container(
                    margin:
                        const EdgeInsets.symmetric(horizontal: 10, vertical: 5),
                    width: 40,
                    height: 40,
                    decoration: BoxDecoration(
                      shape: BoxShape.circle,
                      image: DecorationImage(
                        image: NetworkImage(
                          retrievedCustomer.image,
                        ),
                        fit: BoxFit.contain,
                      ),
                    ),
                  ),
          ],
        ),
        body: SingleChildScrollView(
          child: Consumer(
            builder: (context, ref, child) {
              reservedTime = ref.watch(reservedTimeProvider.state);
              final resumePayment = ref.watch(resumePaymentProvider.state);
              return Center(
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Container(
                      margin: const EdgeInsets.all(18),
                      width: 500,
                      height: 500,
                      decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(15),
                        color: colorContainers242424,
                      ),
                      child: SingleChildScrollView(
                        child: Column(
                          children: [
                            Padding(
                              padding: const EdgeInsets.only(
                                  left: 10, top: 20, bottom: 20),
                              child: Row(
                                mainAxisAlignment:
                                    MainAxisAlignment.spaceBetween,
                                children: [
                                  IconButton(
                                    padding: const EdgeInsets.only(left: 30),
                                    onPressed: () {
                                      Navigator.pop(context);
                                    },
                                    icon: const Icon(
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
                              height: 600,
                              child: ListView.builder(
                                  padding: EdgeInsets.zero,
                                  shrinkWrap: true,
                                  itemCount: listProfessionals!.length,
                                  itemBuilder: (context, i) {
                                    return GestureDetector(
                                      onTap: () {
                                        reservedTime.state.professionalId =
                                            listProfessionals[i].professionalId;
                                        reservedTime.state.serviceId =
                                            getServiceIdByName(
                                                serviceName ?? '',
                                                listProfessionals[i]
                                                    .professionalServices);
                                        resumePayment.state.professionalId =
                                            reservedTime.state.professionalId;
                                        resumePayment
                                                .state.professionalServiceId =
                                            reservedTime.state.serviceId;

                                        Navigator.of(context).pushNamed(
                                          '/select-hour',
                                          arguments: {
                                            'barbershop': data?.barbershop ?? ''
                                          },
                                        );
                                      },
                                      child: ProfessionalItemWeb(
                                        i: i,
                                        professionalId: listProfessionals[i]
                                            .professionalId!,
                                        listProfessionalServices:
                                            listProfessionals[i]
                                                .professionalServices!,
                                        hidePriceAndTime: true,
                                        img: listProfessionals[i].imgProfile!,
                                        name: listProfessionals[i].name!,
                                        rating: listProfessionals[i].rating!,
                                        imgService: listProfessionals[i]
                                            .professionalServices![iService!]
                                            .imgProfile,
                                        listImgServices: listProfessionals[i]
                                            .professionalServices,
                                        serviceTime: listProfessionals[i]
                                            .professionalServices![iService]
                                            .duration,
                                        havePrice: false,
                                        packageList: packageSelected,
                                        barberShop: data!.barbershop!,
                                        servicePrice: listProfessionals[i]
                                            .professionalServices![iService]
                                            .price!,
                                        serviceName: listProfessionals[i]
                                            .professionalServices![iService]
                                            .name!,
                                        serviceImg: listProfessionals[i]
                                            .professionalServices![iService]
                                            .imgProfile!,
                                        listProfessionals:
                                            getProfessionalsByService(
                                          listProfessionals[i]
                                              .professionalServices![iService],
                                          data.barbershop!.professionals!,
                                        ),
                                        onConfirm: () {
                                          setState(() {});
                                        },
                                      ),
                                    );
                                  }),
                            ),
                          ],
                        ),
                      ),
                    ),
                    const DownloadAppPromotion(),
                  ],
                ),
              );
            },
          ),
        ),
      );
    });
  }
}

List<Professional> getProfessionalsByService(
    Service service, List<Professional> professionals) {
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
