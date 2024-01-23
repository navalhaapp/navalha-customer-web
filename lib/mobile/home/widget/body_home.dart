// Developer            Data              Descrição
// Vitor Daniel         22/08/2022        Criação da body page (client).

// ignore_for_file: use_build_context_synchronously

import 'package:auto_size_text/auto_size_text.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:navalha/mobile/change_location/change_location.dart';
import 'package:navalha/core/assets.dart';
import 'package:navalha/core/colors.dart';
import 'package:navalha/mobile/home/home_page.dart';
import 'package:navalha/mobile/home/model/provider_family_model.dart';
import 'package:navalha/mobile/home/model/response_get_barber_shop_by_id.dart';
import 'package:navalha/mobile/home/provider/provider_get_all_barber_shop_by_distance.dart';
import 'package:navalha/mobile/home/provider/provider_get_barber_shop_by_id.dart';
import 'package:navalha/mobile/home/widget/barber_list_item.dart';
import 'package:navalha/shared/animation/page_trasition.dart';
import 'package:navalha/shared/shimmer/shimmer_top_container.dart';
import 'package:navalha/shared/utils.dart';
import '../../barbershop_page/barbershop_page.dart';
import '../../login/controller/login_controller.dart';
import '../../../shared/providers.dart';
import '../../../shared/shimmer/shimmer_home.dart';
import '../../../shared/widgets/widget_empty.dart';
import '../model/response_get_all_barber_shop_by_distance.dart';
import 'package:geolocator/geolocator.dart';
import 'package:permission_handler/permission_handler.dart';
import 'barber_search_bar.dart';

class BodyHome extends StatefulHookConsumerWidget {
  const BodyHome({Key? key}) : super(key: key);
  @override
  BodyState createState() => BodyState();
}

class BodyState extends ConsumerState<BodyHome> {
  late var getAllBarberShopModel = null;
  late String latitude;
  late String longitude;

  late int orderButtonIndex = 0;

  void setIndex(int index) {
    setState(() {
      orderButtonIndex = index;
    });
  }

  @override
  void initState() {
    super.initState();

    WidgetsBinding.instance.addPostFrameCallback((_) async {
      // PermissionStatus? permissionStatus =
      //     await Permission.locationWhenInUse.status;
      final authLoginController =
          ref.watch(LoginStateController.provider.notifier);
      final locationModel = ref.watch(locationProvider.state);
      if (locationModel.state.latitude == '' ||
          locationModel.state.longitude == '') {
        // if (permissionStatus.isGranted == true) {
        //   Position position = await Geolocator.getCurrentPosition(
        //     desiredAccuracy: LocationAccuracy.high,
        //   );
        //   latitude = position.latitude.toString();
        //   longitude = position.longitude.toString();
        // } else {
        latitude =
            authLoginController.user?.customer?.postalCodeCoordinates?.lat ??
                "-26.885427573805845";
        longitude =
            authLoginController.user?.customer?.postalCodeCoordinates?.lng ??
                "-49.10885864818464";
        // }
      } else {
        latitude = locationModel.state.latitude;
        longitude = locationModel.state.longitude;
      }

      getAllBarberShopModel = ProviderFamilyGetAllBarberShopModel(
        deviceLat: latitude,
        deviceLng: longitude,
        maxDistance: authLoginController.user == null ? '1000000000' : '40',
      );

      setState(() {});
    });
  }

  @override
  Widget build(BuildContext context) {
    Size size = MediaQuery.of(context).size;
    ref.watch(editProfilePageCache.state).state.clear();
    if (getAllBarberShopModel == null) {
      return const ShimmerHome();
    }
    final getAllBarberShops = ref.watch(
      getAllBarberShopByDistanceList(getAllBarberShopModel),
    );
    final getBarberShopById =
        ref.watch(GetBarberShopByIdStateController.provider.notifier);
    var barberShopProvider = ref.watch(barberShopSelectedProvider.state);
    var serviceCache = ref.watch(listServicesCacheProvider.state);
    var totalPriceProvider = ref.watch(totalPriceServiceProvider.state);
    var indexProvider = ref.watch(filterIndexProvider.state);
    var textController = ref.watch(filterTextController.state);
    final listResumePayment = ref.watch(listResumePaymentProvider.notifier);
    final authLoginController =
        ref.watch(LoginStateController.provider.notifier);
    return SingleChildScrollView(
      child: Column(
        mainAxisAlignment: MainAxisAlignment.start,
        children: [
          Container(
            margin: EdgeInsets.symmetric(horizontal: size.width * 0.015),
            height: size.height * 0.28,
            decoration: BoxDecoration(
              borderRadius: const BorderRadius.all(Radius.circular(18)),
              image: DecorationImage(
                image: AssetImage(imgHome),
                fit: BoxFit.cover,
              ),
            ),
          ),
          Padding(
            padding: EdgeInsets.only(
              left: size.width * 0.015,
              right: size.width * 0.015,
              top: size.height * 0.015,
            ),
            child: const Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                BarberSearchBar(),
                ButtonChangeLocation(),
              ],
            ),
          ),
          Container(
            margin: EdgeInsets.only(
                left: size.width * 0.02, right: size.width * 0.02, top: 10),
            color: Colors.transparent,
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                _HomePageButton(
                  focusedOption: orderButtonIndex == 0,
                  image: imgFilterHomeMap,
                  icon: Icon(
                    CupertinoIcons.location_solid,
                    color: Colors.white,
                    size: size.width * 0.06,
                  ),
                  onTap: () {
                    setIndex(0);
                    indexProvider.state = 0;
                  },
                  buttonName: 'Distância',
                  width: 5,
                  widthFocus: size.width * 0.15,
                ),
                _HomePageButton(
                  image: imgFilterHomeStar,
                  icon: Icon(
                    CupertinoIcons.star_fill,
                    color: Colors.white,
                    size: size.width * 0.06,
                  ),
                  focusedOption: orderButtonIndex == 1,
                  onTap: () {
                    setIndex(1);
                    indexProvider.state = 1;
                  },
                  buttonName: 'Avaliação',
                  width: 5,
                  widthFocus: size.width * 0.15,
                ),
                _HomePageButton(
                  image: imgFilterHomeBarba,
                  focusedOption: orderButtonIndex == 2,
                  onTap: () {
                    setIndex(2);
                    indexProvider.state = 2;
                  },
                  buttonName: 'Barba',
                  width: size.width * 0.15,
                  widthFocus: size.width * 0.15,
                ),
                _HomePageButton(
                  image: imgFilterHomeTesoura,
                  focusedOption: orderButtonIndex == 3,
                  onTap: () {
                    setIndex(3);
                    indexProvider.state = 3;
                  },
                  buttonName: 'Tesoura',
                  width: size.width * 0.1,
                  widthFocus: size.width * 0.15,
                ),
                _HomePageButton(
                  image: imgFilterHomeMaquina,
                  focusedOption: orderButtonIndex == 4,
                  onTap: () {
                    setIndex(4);
                    indexProvider.state = 4;
                  },
                  buttonName: 'Máquina',
                  width: size.width * 0.1,
                  widthFocus: size.width * 0.15,
                ),
              ],
            ),
          ),
          getAllBarberShops.when(
            data: (data) {
              List<Barbershops> listBarbershops = textController.state == ''
                  ? sortBarbershops(
                      data.result!.barbershops!, indexProvider.state)
                  : filterBarbershops(
                      data.result!.barbershops!, textController.state);
              return listBarbershops.isNotEmpty
                  ? Column(
                      children: [
                        for (int i = 0; i < listBarbershops.length; i++)
                          GestureDetector(
                            onTap: () async {
                              navigationWithFadeAnimation(
                                const ShimmerTopContainer(),
                                context,
                              );
                              ResponseBarberShopById response =
                                  await getBarberShopById.getAllBarberShopById(
                                ParamsBarberShopById(
                                  barberShopId:
                                      listBarbershops[i].barbershopId!,
                                  customerId: authLoginController
                                          .user?.customer?.customerId ??
                                      '',
                                ),
                              );
                              if (response.status == 'success') {
                                barberShopProvider.state = response.barbershop!;
                                serviceCache.state.clear();
                                totalPriceProvider.state.clear();
                                listResumePayment.state.clear();

                                Navigator.pop(context);
                                navigationWithFadeAnimation(
                                  BarbershopPage(
                                      listPackagesUser:
                                          response.customerPackages),
                                  context,
                                );
                              } else {
                                Navigator.pop(context);
                                showSnackBar(context, 'Ops, algo aconteceu.');
                              }
                            },
                            child: BarberListItem(
                              rating: listBarbershops[i].rating!,
                              berbercutPrice: listBarbershops[i]
                                      .cheapServices
                                      ?.barba
                                      ?.servicePrice ??
                                  0,
                              haircutPrice: listBarbershops[i]
                                      .cheapServices
                                      ?.corteMaquina
                                      ?.servicePrice ??
                                  0,
                              scissorPrice: listBarbershops[i]
                                      .cheapServices
                                      ?.corteTesoura
                                      ?.servicePrice ??
                                  0,
                              barberShopName: listBarbershops[i].name!,
                              distance: listBarbershops[i].distance!,
                              imgBarberShop: listBarbershops[i].imgProfile!,
                              bottomCollor:
                                  const Color.fromARGB(255, 25, 25, 25),
                              berbercutVisible: listBarbershops[i]
                                      .cheapServices
                                      ?.barba
                                      ?.servicePrice ==
                                  null,
                              haircutVisible: listBarbershops[i]
                                      .cheapServices
                                      ?.corteMaquina
                                      ?.servicePrice ==
                                  null,
                              scissorVisible: listBarbershops[i]
                                      .cheapServices
                                      ?.corteTesoura
                                      ?.servicePrice ==
                                  null,
                            ),
                          ),
                        GestureDetector(
                          onTap: () => navigationWithFadeAnimation(
                              const ChangeLocations(), context),
                          child: Container(
                            margin: EdgeInsets.only(
                              left: size.width * 0.02,
                              right: size.width * 0.02,
                            ),
                            decoration: BoxDecoration(
                              color: colorContainers353535,
                              borderRadius: BorderRadius.circular(15),
                            ),
                            width: MediaQuery.of(context).size.width,
                            child: Padding(
                              padding: const EdgeInsets.all(12),
                              child: Row(
                                children: [
                                  Icon(
                                    Icons.edit_location_alt_rounded,
                                    color: Colors.white,
                                    size: size.width * 0.05,
                                  ),
                                  const SizedBox(width: 10),
                                  Text(
                                    textAlign: TextAlign.center,
                                    'Mudar localização',
                                    style: TextStyle(
                                      color: Colors.white,
                                      fontSize: size.width * 0.045,
                                    ),
                                  ),
                                ],
                              ),
                            ),
                          ),
                        ),
                        SizedBox(
                          height: MediaQuery.of(context).size.height * 0.05,
                        ),
                      ],
                    )
                  : Center(
                      child: WidgetEmpty(
                        titleSize: 20,
                        topSpace: 0,
                        title: 'Nenhuma Barberaria encontrada!',
                        subTitle:
                            'Não encontramos nenhuma barbearia próximo a você',
                        text: 'Mudar localização',
                        onPressed: () => navigationWithFadeAnimation(
                            const ChangeLocations(), context),
                      ),
                    );
            },
            error: (error, stackTrace) => WidgetEmpty(
              topSpace: 0,
              title: 'Ops, Algo aconteceu!',
              subTitle: 'Houve algum erro, tente novamente mais tarde.',
              onPressed: () {
                navigationWithFadeAnimation(const HomePage(), context);
              },
              text: 'Tentar de novo',
            ),
            loading: () => const ShimmerHome(),
          ),
        ],
      ),
    );
  }
}

List<Barbershops> sortBarbershops(List<Barbershops> barbershops, int index) {
  if (index == 0) {
    return List.from(barbershops)
      ..sort((a, b) =>
          double.parse(a.distance!).compareTo(double.parse(b.distance!)));
    //CASO QUEIRA DEIXAR AS BARBEARIAS SEM NENHUM SERVIÇO REQUERIDO POR ULTIMO
    //       if (a.cheapServices!.barba!.servicePrice == null &&
    //       a.cheapServices!.corteTesoura!.servicePrice == null &&
    //       a.cheapServices!.corteMaquina!.servicePrice == null &&
    //       b.cheapServices!.barba!.servicePrice == null &&
    //       b.cheapServices!.corteTesoura!.servicePrice == null &&
    //       b.cheapServices!.corteMaquina!.servicePrice == null) {
    //     return 0;
    //   } else if (a.cheapServices!.barba!.servicePrice == null ||
    //       a.cheapServices!.corteTesoura!.servicePrice == null ||
    //       a.cheapServices!.corteMaquina!.servicePrice == null) {
    //     return 1;
    //   } else if (b.cheapServices!.barba!.servicePrice == null ||
    //       b.cheapServices!.corteTesoura!.servicePrice == null ||
    //       b.cheapServices!.corteMaquina!.servicePrice == null) {
    //     return -1;
    //   } else {
    //     return double.parse(a.distance!).compareTo(double.parse(b.distance!));
    //   }
    // });
  } else if (index == 1) {
    return List.from(barbershops)
      ..sort((a, b) {
        if (a.rating != null && b.rating != null && a.rating! != b.rating!) {
          return b.rating!.compareTo(a.rating!);
        } else {
          return double.parse(a.distance!).compareTo(double.parse(b.distance!));
        }
      });
  } else if (index == 2) {
    return List.from(barbershops)
      ..sort((a, b) {
        if (a.cheapServices != null &&
            b.cheapServices != null &&
            a.cheapServices!.barba != null &&
            b.cheapServices!.barba != null &&
            a.cheapServices!.barba!.servicePrice != null &&
            b.cheapServices!.barba!.servicePrice != null &&
            a.cheapServices!.barba!.servicePrice! !=
                b.cheapServices!.barba!.servicePrice!) {
          return a.cheapServices!.barba!.servicePrice!
              .compareTo(b.cheapServices!.barba!.servicePrice!);
        } else {
          if (a.cheapServices?.barba?.servicePrice == null &&
              b.cheapServices?.barba?.servicePrice == null) {
            return 0; // Ambos são nulos, não há diferença
          } else if (a.cheapServices?.barba?.servicePrice == null) {
            return 1; // A é nulo, então B é considerado maior
          } else if (b.cheapServices?.barba?.servicePrice == null) {
            return -1; // B é nulo, então A é considerado maior
          } else {
            return a.cheapServices!.barba!.servicePrice!
                .compareTo(b.cheapServices!.barba!.servicePrice!);
          }
        }
      });
  } else if (index == 3) {
    return List.from(barbershops)
      ..sort((a, b) {
        if (a.cheapServices != null &&
            b.cheapServices != null &&
            a.cheapServices!.corteTesoura != null &&
            b.cheapServices!.corteTesoura != null &&
            a.cheapServices!.corteTesoura!.servicePrice != null &&
            b.cheapServices!.corteTesoura!.servicePrice != null &&
            a.cheapServices!.corteTesoura!.servicePrice! !=
                b.cheapServices!.corteTesoura!.servicePrice!) {
          return a.cheapServices!.corteTesoura!.servicePrice!
              .compareTo(b.cheapServices!.corteTesoura!.servicePrice!);
        } else {
          if (a.cheapServices?.corteTesoura?.servicePrice == null &&
              b.cheapServices?.corteTesoura?.servicePrice == null) {
            return 0; // Ambos são nulos, não há diferença
          } else if (a.cheapServices?.corteTesoura?.servicePrice == null) {
            return 1; // A é nulo, então B é considerado maior
          } else if (b.cheapServices?.corteTesoura?.servicePrice == null) {
            return -1; // B é nulo, então A é considerado maior
          } else {
            return a.cheapServices!.corteTesoura!.servicePrice!
                .compareTo(b.cheapServices!.corteTesoura!.servicePrice!);
          }
        }
      });
  } else if (index == 4) {
    return List.from(barbershops)
      ..sort((a, b) {
        if (a.cheapServices != null &&
            b.cheapServices != null &&
            a.cheapServices!.corteMaquina != null &&
            b.cheapServices!.corteMaquina != null &&
            a.cheapServices!.corteMaquina!.servicePrice != null &&
            b.cheapServices!.corteMaquina!.servicePrice != null &&
            a.cheapServices!.corteMaquina!.servicePrice! !=
                b.cheapServices!.corteMaquina!.servicePrice!) {
          return a.cheapServices!.corteMaquina!.servicePrice!
              .compareTo(b.cheapServices!.corteMaquina!.servicePrice!);
        } else {
          if (a.cheapServices?.corteMaquina?.servicePrice == null &&
              b.cheapServices?.corteMaquina?.servicePrice == null) {
            return 0; // Ambos são nulos, não há diferença
          } else if (a.cheapServices?.corteMaquina?.servicePrice == null) {
            return 1; // A é nulo, então B é considerado maior
          } else if (b.cheapServices?.corteMaquina?.servicePrice == null) {
            return -1; // B é nulo, então A é considerado maior
          } else {
            return a.cheapServices!.corteMaquina!.servicePrice!
                .compareTo(b.cheapServices!.corteMaquina!.servicePrice!);
          }
        }
      });
  } else {
    return barbershops;
  }
}

List<Barbershops> filterBarbershops(
    List<Barbershops> barbershops, String valorDigitado) {
  List<Barbershops> filteredBarbershops = [];

  for (var barbershop in barbershops) {
    if (barbershop.name!.toLowerCase().contains(valorDigitado.toLowerCase())) {
      filteredBarbershops.add(barbershop);
    }
  }

  filteredBarbershops.sort((a, b) => a.distance!.compareTo(b.distance!));

  return filteredBarbershops;
}

class _HomePageButton extends StatelessWidget {
  final String image;
  final Function onTap;
  final bool focusedOption;
  final String buttonName;
  final double widthFocus;
  final double width;
  final Widget? icon;

  const _HomePageButton({
    Key? key,
    required this.image,
    required this.onTap,
    required this.focusedOption,
    required this.buttonName,
    required this.widthFocus,
    required this.width,
    this.icon,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    Size size = MediaQuery.of(context).size;
    return Column(
      children: [
        GestureDetector(
          onTap: () {
            onTap();
          },
          child: Container(
            height: 50,
            width: size.width * .15,
            margin: const EdgeInsets.only(bottom: 5),
            decoration: BoxDecoration(
              color: colorContainers242424,
              borderRadius: BorderRadius.circular(18),
            ),
            child: Opacity(
              opacity: focusedOption ? 1 : 0.2,
              child: icon ??
                  Image.asset(
                    image,
                    fit: BoxFit.fitWidth,
                  ),
            ),
          ),
        ),
        Padding(
          padding: const EdgeInsets.only(bottom: 10),
          child: AutoSizeText(
            buttonName,
            style: TextStyle(
              shadows: shadow,
              color: focusedOption ? Colors.white : colorFontUnable116116116,
              fontSize: focusedOption ? 13.5 : 11,
            ),
          ),
        ),
      ],
    );
  }
}

class NameHeader extends StatelessWidget {
  const NameHeader({
    Key? key,
    required this.name,
  }) : super(key: key);

  final String name;

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      width: MediaQuery.of(context).size.width * 0.75,
      child: Text(
        name.contains(' ') ? name.substring(0, name.indexOf(' ')) : name,
        overflow: TextOverflow.ellipsis,
        style: TextStyle(
          color: Colors.white,
          fontSize: MediaQuery.of(context).size.height * 0.023,
          fontWeight: FontWeight.w400,
        ),
      ),
    );
  }
}
