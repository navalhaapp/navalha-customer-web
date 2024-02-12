import 'package:flutter/material.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:navalha/core/assets.dart';
import 'package:navalha/core/colors.dart';
import 'package:navalha/mobile/home/model/provider_family_model.dart';
import 'package:navalha/mobile/home/provider/provider_get_barber_shop_by_id.dart';
import 'package:navalha/mobile/schedule/widgets/body_schedule.dart';
import 'package:navalha/shared/model/professional_model.dart';
import 'package:navalha/shared/providers.dart';
import 'package:navalha/shared/shimmer/shimmer_calendar.dart';
import 'package:navalha/shared/utils.dart';
import 'package:navalha/shared/widgets/widget_empty.dart';
import 'package:navalha/web/appointment/widgets/drawer_page_web.dart';
import 'package:navalha/web/appointment/widgets/service_item_web.dart';
import 'package:navalha/web/db/db_customer_shared.dart';
import '../../../mobile/home/model/response_get_barber_shop_by_id.dart';
import '../../../shared/model/service_model.dart';

class ServicesPageWeb extends StatefulHookConsumerWidget {
  const ServicesPageWeb({
    Key? key,
    this.packageSelected,
    this.havePrice,
    this.barberShopId,
  }) : super(key: key);

  final CustomerPackages? packageSelected;
  final bool? havePrice;
  final String? barberShopId;

  @override
  ConsumerState<ServicesPageWeb> createState() => _ServicesPageWebState();
}

class _ServicesPageWebState extends ConsumerState<ServicesPageWeb> {
  late ParamsBarberShopById getBarberShopModel;
  CustomerDB? retrievedCustomer;
  @override
  void initState() {
    super.initState();
    getBarberShopModel = ParamsBarberShopById(
      barberShopId: widget.barberShopId!,
      customerId: null,
    );
  }

  bool loading = false;
  @override
  Widget build(BuildContext context) {
    final getBarbershopController =
        ref.watch(getAllBarberShopById(getBarberShopModel));

    return getBarbershopController.when(
      data: (data) {
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

        List<Service> listServices = findServicesWithProfessionals(
          data.barbershop!.professionals!,
          showActivatedServices(data.barbershop!.services!),
        );
        return Consumer(
          builder: (context, ref, child) {
            WidgetsBinding.instance.addPostFrameCallback((_) async {
              retrievedCustomer = LocalStorageManager.getCustomer();

              ref.watch(barberShopSelectedProvider.state).state =
                  data.barbershop!;
            });
            return Scaffold(
              backgroundColor: colorBackground181818,
              drawer: DrawerPageWeb(
                barberShopId: widget.barberShopId!,
              ),
              appBar: AppBar(
                elevation: 0,
                backgroundColor: colorBackground181818,
                title: Text(data.barbershop!.name ?? ''),
                actions: [
                  retrievedCustomer == null
                      ? Container(
                          margin: const EdgeInsets.symmetric(
                              horizontal: 10, vertical: 5),
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
                          margin: const EdgeInsets.symmetric(
                              horizontal: 10, vertical: 5),
                          width: 40,
                          height: 40,
                          decoration: BoxDecoration(
                            shape: BoxShape.circle,
                            image: DecorationImage(
                              image: NetworkImage(
                                retrievedCustomer!.image,
                              ),
                              fit: BoxFit.contain,
                            ),
                          ),
                        ),
                ],
              ),
              body: Center(
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
                      child: Column(
                        mainAxisSize: MainAxisSize.min,
                        children: [
                          Padding(
                            padding: const EdgeInsets.only(
                                left: 10, top: 20, bottom: 20),
                            child: Text(
                              'Escolha um serviço',
                              style: TextStyle(
                                fontSize: 20,
                                shadows: shadow,
                                color: Colors.white,
                              ),
                            ),
                          ),
                          SizedBox(
                            height: 410,
                            child: ListView.builder(
                              padding: EdgeInsets.zero,
                              shrinkWrap: true,
                              itemCount: listServices.length,
                              itemBuilder: (context, iService) {
                                List<Professional> listProfessionals =
                                    getProfessionalsByService(
                                  listServices[iService],
                                  data.barbershop!.professionals!,
                                );
                                return GestureDetector(
                                  child: ServiceItemWeb(
                                    havePrice: widget.havePrice,
                                    packageSelected: widget.packageSelected,
                                    description:
                                        listServices[iService].description!,
                                    duration: getDurationRange(
                                        getAllServices(
                                            data.barbershop!.professionals!),
                                        listServices[iService].name!),
                                    img: listServices[iService].imgProfile!,
                                    name: listServices[iService].name!,
                                    price: getPriceRange(
                                        getAllServices(
                                            data.barbershop!.professionals!),
                                        listServices[iService].name!),
                                  ),
                                  onTap: () {
                                    Navigator.of(context).pushNamed(
                                      '/select-professional',
                                      arguments: {
                                        'serviceName':
                                            listServices[iService].name!,
                                        'data': data,
                                        'iService': iService,
                                        'listProfessionals': listProfessionals,
                                        'packageSelected':
                                            widget.packageSelected,
                                      },
                                    );
                                  },
                                );
                              },
                            ),
                          ),
                        ],
                      ),
                    ),
                    const DownloadAppPromotion(),
                  ],
                ),
              ),
            );
          },
        );
      },
      error: (error, stackTrace) => Scaffold(
        body: Center(
          child: WidgetEmpty(
            title: 'Ops, Algo aconteceu!',
            subTitle: 'Houve algum erro, tente novamente mais tarde.',
            onPressed: () {
              Navigator.of(context).pushNamed('/');
            },
            text: 'Tentar de novo',
          ),
        ),
      ),
      loading: () => const Scaffold(
          body: Center(
        child: SizedBox(width: 500, height: 500, child: ShimmerCalendar()),
      )),
    );
  }
}

class DownloadAppPromotion extends StatelessWidget {
  const DownloadAppPromotion({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    Size size = MediaQuery.of(context).size;
    return Container(
      margin: const EdgeInsets.only(top: 18),
      height: 200,
      decoration: BoxDecoration(
        boxShadow: const [
          BoxShadow(color: Colors.white10, spreadRadius: 2),
        ],
        borderRadius: const BorderRadius.only(
          topLeft: Radius.circular(15),
          topRight: Radius.circular(15),
        ),
        // color: colorYellow25020050,
        image: DecorationImage(
          image: AssetImage(imgBackgroundBarberLogin),
          fit: BoxFit.cover,
          // opacity: 0.3,
        ),
      ),
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.end,
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Container(
                width: size.width > 500 ? 350 : 200,
                decoration: const BoxDecoration(
                    borderRadius: BorderRadius.only(
                      topRight: Radius.circular(18),
                      bottomRight: Radius.circular(18),
                    ),
                    color: Colors.black),
                child: const Center(
                  child: Padding(
                    padding: EdgeInsets.only(
                        left: 10, right: 10, top: 10, bottom: 10),
                    child: Text(
                      textAlign: TextAlign.center,
                      'Para uma experiência completa, baixe nosso aplicativo.',
                      style:
                          TextStyle(color: Color.fromARGB(255, 212, 212, 212)),
                    ),
                  ),
                ),
              ),
              Visibility(
                visible: size.width < 920,
                child: SizedBox(
                    height: size.width < 500 ? 38 : 60,
                    child: Image.asset(imgStore2)),
              ),
            ],
          ),
          Padding(
            padding: const EdgeInsets.only(top: 10),
            child: SizedBox(
              child: Image.asset(
                height: 190,
                imgMockup1,
              ),
            ),
          ),
          Visibility(
            visible: size.width > 720,
            child: SizedBox(height: 200, child: Image.asset(imgMockup2)),
          ),
          Visibility(
            visible: size.width > 920,
            child: Padding(
              padding: const EdgeInsets.only(right: 50),
              child: SizedBox(height: 120, child: Image.asset(imgStore)),
            ),
          ),
        ],
      ),
    );
  }
}
