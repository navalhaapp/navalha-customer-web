import 'package:dio/dio.dart';
import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:navalha/core/assets.dart';
import 'package:navalha/core/colors.dart';
import 'package:navalha/mobile-DEPRECIATED/home/model/provider_family_model.dart';
import 'package:navalha/mobile-DEPRECIATED/home/provider/provider_get_barber_shop_by_id.dart';
import 'package:navalha/mobile-DEPRECIATED/login/controller/login_controller.dart';
import 'package:navalha/mobile-DEPRECIATED/schedule/widgets/body_schedule.dart';
import 'package:navalha/shared/model/professional_model.dart';
import 'package:navalha/shared/providers.dart';
import 'package:navalha/shared/shimmer/shimmer_calendar.dart';
import 'package:navalha/shared/utils.dart';
import 'package:navalha/shared/widgets/widget_empty.dart';
import 'package:navalha/shared/widgets/network_image_fallback.dart';
import 'package:navalha/web/appointment/widgets/drawer_page_web.dart';
import 'package:navalha/web/home/widgets/service_item_web.dart';
import 'package:navalha/web/db/db_customer_shared.dart';
import 'package:navalha/web/shared/downloadAppPromotionBanner.dart';
import 'package:url_launcher/url_launcher.dart';
import '../../../mobile-DEPRECIATED/home/model/response_get_barber_shop_by_id.dart';
import '../../../shared/model/service_model.dart';

class ServicesPageWeb extends StatefulHookConsumerWidget {
  const ServicesPageWeb({
    Key? key,
    this.packageSelected,
    this.havePrice,
    this.barberShopName,
  }) : super(key: key);

  final CustomerPackages? packageSelected;
  final bool? havePrice;
  final String? barberShopName;

  @override
  ConsumerState<ServicesPageWeb> createState() => _ServicesPageWebState();
}

class _ServicesPageWebState extends ConsumerState<ServicesPageWeb> {
  late ParamsBarberShopById getBarberShopModel;
  CustomerDB? retrievedCustomer;

  final Uri _url = Uri.parse('https://navalha.app.br');

  Future<void> _launchUrl() async {
    if (!await launchUrl(_url)) {
      throw Exception('Could not launch $_url');
    }
  }

  @override
  void initState() {
    super.initState();
    getBarberShopModel = ParamsBarberShopById(
      barberShopName: widget.barberShopName!,
      customerId: null,
    );
  }

  bool loading = false;
  @override
  Widget build(BuildContext context) {
    final getBarbershopController =
        ref.watch(getAllBarberShopById(getBarberShopModel));
    final loginController = ref.read(LoginStateController.provider.notifier);
    return getBarbershopController.when(
      data: (data) {
        void loginCustomer() async {
          var response = await loginController.login(
            retrievedCustomer!.email,
            retrievedCustomer!.password,
            '',
          );
          if (response.runtimeType == DioError) {
            showSnackBar(context, 'Sua acesso expirou, faça o login novamente');
            Navigator.of(context).pushNamed('/login');
          } else if (response.status == 'success') {
            LocalStorageManager.saveCustomer(
              CustomerDB(
                name: response.customer.name,
                image: response.customer.imgProfile,
                customerId: response.customer.customerId,
                token: response.token,
                email: response.customer.email,
                birthDate: response.customer.birthDate,
                userID: '',
                password: response.customer!.password!,
              ),
            );
          }
        }

        retrievedCustomer = LocalStorageManager.getCustomer();
        if (retrievedCustomer != null) {
          loginCustomer();
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

        if (data.status != 'error') {
          final professionals = data.barbershop?.professionals ?? [];
          final services =
              showActivatedServices(data.barbershop?.services ?? []);
          List<Service> listServices = findServicesWithProfessionals(
            professionals,
            services,
          );
          return Consumer(
            builder: (context, ref, child) {
              WidgetsBinding.instance.addPostFrameCallback((_) async {
                ref.watch(barberShopSelectedProvider.state).state =
                    data.barbershop!;
              });
              return Scaffold(
                backgroundColor: colorBackground181818,
                drawer: DrawerPageWeb(barberShopId: widget.barberShopName!),
                appBar: AppBar(
                  elevation: 0,
                  backgroundColor: colorBackground181818,
                  title: Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    crossAxisAlignment: CrossAxisAlignment.center,
                    children: [
                      Container(
                        margin: const EdgeInsets.only(left: 10, right: 10),
                        width: 25,
                        height: 25,
                        child: ClipOval(
                          child: NetworkImageFallback(
                            url: data.barbershop!.imgProfile,
                            placeholderAsset: imgLoading3,
                            errorAsset: iconLogoApp,
                            fit: BoxFit.fill,
                          ),
                        ),
                      ),
                      Text(data.barbershop!.name ?? ''),
                    ],
                  ),
                  actions: [
                    retrievedCustomer == null
                        ? Row(
                            children: [
                              TextButton(
                                onPressed: () {
                                  Navigator.of(context).pushNamed('/login');
                                },
                                style: ButtonStyle(
                                  overlayColor:
                                      MaterialStateProperty.resolveWith<Color?>(
                                    (Set<MaterialState> states) {
                                      if (states
                                          .contains(MaterialState.pressed)) {
                                        return colorContainers242424;
                                      }
                                      return null;
                                    },
                                  ),
                                ),
                                child: const Text(
                                  'Entrar',
                                  style: TextStyle(color: Colors.white),
                                ),
                              ),
                              Container(
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
                              ),
                            ],
                          )
                        : Container(
                            margin: const EdgeInsets.symmetric(
                                horizontal: 10, vertical: 5),
                            width: 40,
                            height: 40,
                            child: ClipOval(
                              child: NetworkImageFallback(
                                url: retrievedCustomer!.image,
                                placeholderAsset: imgLoading3,
                                errorAsset: iconLogoApp,
                                fit: BoxFit.contain,
                              ),
                            ),
                          ),
                  ],
                ),
                body: SingleChildScrollView(
                  padding: EdgeInsets.zero,
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    mainAxisSize: MainAxisSize.min,
                    children: [
                      Center(
                        child: Container(
                          margin: const EdgeInsets.all(18),
                          width: 500,
                          height: 550,
                          decoration: BoxDecoration(
                            borderRadius: BorderRadius.circular(15),
                            color: colorContainers242424,
                          ),
                          child: Column(
                            mainAxisSize: MainAxisSize.min,
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            children: [
                              Padding(
                                padding: const EdgeInsets.only(
                                    left: 10, top: 20, bottom: 0),
                                child: Text(
                                  'Escolha um serviço',
                                  style: TextStyle(
                                    fontSize: 20,
                                    shadows: shadow,
                                    color: Colors.white,
                                  ),
                                ),
                              ),
                              const Center(
                                child: AlertContainer(
                                  backgroundColor: Colors.black26,
                                  message:
                                      'Atenção: para agendar ou comprar um pacote, baixe o nosso aplicativo.',
                                ),
                              ),
                              const SizedBox(height: 10),
                              SizedBox(
                                height: 360,
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
                                            getAllServices(professionals),
                                            listServices[iService].name!),
                                        img: listServices[iService].imgProfile,
                                        name: listServices[iService].name!,
                                        price: getPriceRange(
                                            getAllServices(professionals),
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
                                            'listProfessionals':
                                                listProfessionals,
                                            'packageSelected':
                                                widget.packageSelected,
                                          },
                                        );
                                      },
                                    );
                                  },
                                ),
                              ),
                              SizedBox(
                                height: 40,
                                child: Image.asset(
                                  logoBrancaCustomer,
                                  fit: BoxFit.contain,
                                ),
                              ),
                            ],
                          ),
                        ),
                      ),
                      // const DownloadAppPromotion(),
                    ],
                  ),
                ),
              );
            },
          );
        } else if (data.status == 'error') {
          return Scaffold(
            body: Center(
              child: SizedBox(
                width: 500,
                child: WidgetEmpty(
                  title: 'Barbearia não encontrada',
                  subTitle: 'Parece que não conseguimos localizar a barbearia.',
                  text: 'Escolher outra barbearia',
                  onPressed: () => _launchUrl(),
                ),
              ),
            ),
          );
        } else {
          return const SizedBox();
        }
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

class AlertContainer extends StatelessWidget {
  final String message;
  final Color backgroundColor;
  final Color textColor;

  const AlertContainer({
    super.key,
    required this.message,
    this.backgroundColor = Colors.blue,
    this.textColor = Colors.white,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.all(16.0),
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(15),
        color: backgroundColor,
      ),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Icon(
            Icons.info_outline,
            color: textColor,
          ),
          const SizedBox(width: 10),
          Expanded(
            child: Text(
              message,
              style: TextStyle(color: textColor),
            ),
          ),
          const Icon(
            size: 1,
            Icons.info_outline,
            color: Colors.transparent,
          ),
        ],
      ),
    );
  }
}
