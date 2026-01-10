import 'package:auto_size_text/auto_size_text.dart';
import 'package:dio/dio.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:navalha/core/assets.dart';
import 'package:navalha/core/colors.dart';
import 'package:navalha/core/cors_helper.dart';
import 'package:navalha/core/images_s3.dart';
import 'package:navalha/mobile-DEPRECIATED/home/model/provider_family_model.dart';
import 'package:navalha/mobile-DEPRECIATED/home/provider/provider_get_barber_shop_by_id.dart';
import 'package:navalha/mobile-DEPRECIATED/login/controller/login_controller.dart';
import 'package:navalha/shared/providers.dart';
import 'package:navalha/shared/shimmer/shimmer_calendar.dart';
import 'package:navalha/shared/utils.dart';
import 'package:navalha/shared/widgets/network_image_fallback.dart';
import 'package:navalha/shared/widgets/widget_empty.dart';
import 'package:navalha/web/appointment/widgets/drawer_page_web.dart';
import 'package:navalha/web/appointment/widgets/services_page_web.dart';
import 'package:navalha/web/db/db_customer_shared.dart';
import 'package:navalha/web/home/widgets/professionals_list.dart';
import 'package:navalha/web/home/widgets/resume_page_web.dart';
import 'package:navalha/web/home/widgets/select_hours_page_web.dart';
import 'package:navalha/web/home/widgets/services_list.dart';
import 'package:navalha/web/shared/downloadAppPromotionBanner.dart';
import 'package:url_launcher/url_launcher.dart';
import '../../../mobile-DEPRECIATED/home/model/response_get_barber_shop_by_id.dart';

class HomePageWeb extends StatefulHookConsumerWidget {
  const HomePageWeb({
    Key? key,
    this.packageSelected,
    this.havePrice,
    this.barberShopName,
  }) : super(key: key);

  final CustomerPackages? packageSelected;
  final bool? havePrice;
  final String? barberShopName;

  @override
  ConsumerState<HomePageWeb> createState() => _HomePageWebState();
}

class _HomePageWebState extends ConsumerState<HomePageWeb> {
  final ScrollController _scrollController = ScrollController();
  int _currentStep = 0;
  Map<String, dynamic>? _selectedServiceData;
  Map<String, dynamic>? _selectedDataMap = {};

  void _nextStep([Object? selectedData]) {
    if (selectedData != null && selectedData is Map<String, dynamic>) {
      _selectedServiceData = selectedData;
    } else {
      _selectedServiceData = {};
    }
    setState(() => _currentStep++);
  }

  void _previousStep() {
    setState(() => _currentStep = 0);
  }

  Widget _getStepContent(ResponseBarberShopById data,
      CustomerPackages? packageSelected, bool? havePrice) {
    switch (_currentStep) {
      case 0:
        return ServicesList(
          data: data,
          havePrice: havePrice,
          packageSelected: packageSelected,
          onNextStep: _nextStep,
        );
      case 1:
        return ProfessionalListPageWeb(
          serviceData: _selectedServiceData ?? _selectedDataMap ?? {},
          onPreviousStep: _previousStep,
          onNextStep: _nextStep,
        );
      case 2:
        return SelectHoursPageWeb(
          serviceData: _selectedServiceData ?? _selectedDataMap ?? {},
          onPreviousStep: _previousStep,
          onNextStep: _nextStep,
          scrollToEnd: () => _scrollController.animateTo(
            _scrollController.position.maxScrollExtent,
            duration: const Duration(milliseconds: 1000),
            curve: Curves.easeInOut,
          ),
        );
      case 3:
        return ResumePageWeb(
          serviceData: _selectedServiceData ?? _selectedDataMap ?? {},
          onPreviousStep: _previousStep,
          onNextStep: _nextStep,
        );
      default:
        return ServicesList(
          data: data,
          havePrice: havePrice,
          packageSelected: packageSelected,
          onNextStep: _nextStep,
        );
    }
  }

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
        retrievedCustomer = LocalStorageManager.getCustomer();
        // if (_currentStep == 0 && retrievedCustomer != null) {
        //   loginCustomer();
        // }

        if (data.status != 'error') {
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
                  backgroundColor: Colors.transparent,
                  title: Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    crossAxisAlignment: CrossAxisAlignment.center,
                    children: [
                      Container(
                        margin: const EdgeInsets.only(left: 0, right: 10),
                        width: 30,
                        height: 30,
                        child: ClipOval(
                          child: NetworkImageFallback(
                            url: data.barbershop!.imgProfile,
                            placeholderAsset: imgLoading3,
                            errorAsset: iconLogoApp,
                            fit: BoxFit.fill,
                          ),
                        ),
                      ),
                      Text(data.barbershop!.name ?? '',
                          textAlign: TextAlign.center),
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
                                child: ClipOval(
                                  child: NetworkImageFallback(
                                    url: imgProfileDefaultS3,
                                    placeholderAsset: imgLoading3,
                                    errorAsset: iconLogoApp,
                                    fit: BoxFit.contain,
                                  ),
                                ),
                              ),
                            ],
                          )
                        : Row(
                            children: [
                              TextButton(
                                  onPressed: () {
                                    Navigator.of(context)
                                        .pushNamed('/calendar');
                                  },
                                  style: ButtonStyle(
                                    overlayColor: MaterialStateProperty
                                        .resolveWith<Color?>(
                                      (Set<MaterialState> states) {
                                        if (states
                                            .contains(MaterialState.pressed)) {
                                          return colorContainers242424;
                                        }
                                        return null;
                                      },
                                    ),
                                  ),
                                  child: const Icon(
                                    CupertinoIcons.calendar,
                                    color: Colors.white,
                                  )),
                              Container(
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
                  ],
                ),
                body: Center(
                  child: SingleChildScrollView(
                    padding: EdgeInsets.zero,
                    controller: _scrollController,
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        // Visibility(
                        //   visible:
                        //       data.barbershop?.packageList?.isNotEmpty ?? true,
                        //   child: Padding(
                        //     padding: const EdgeInsets.symmetric(
                        //         vertical: 10, horizontal: 10),
                        //     child: SizedBox(
                        //       width: getResponsiveWidth(context),
                        //       child: Center(
                        //         child: AlertContainer(
                        //           textColor: Colors.white,
                        //           backgroundColor: colorContainers353535,
                        //           message:
                        //               'Atenção: Aqui na barbearia você também encontra pacotes com vários serviços por um preço especial. Baixe o app e aproveite esse benefício.',
                        //         ),
                        //       ),
                        //     ),
                        //   ),
                        // ),
                        Center(
                          child: Container(
                            margin: const EdgeInsets.all(10),
                            width: getResponsiveWidth(context),
                            decoration: BoxDecoration(
                              borderRadius: BorderRadius.circular(15),
                              color: colorContainers242424,
                              border: Border.all(
                                  color: Colors.white.withOpacity(0.06),
                                  width: 1),
                              boxShadow: [
                                BoxShadow(
                                  color: Colors.black.withOpacity(0.20),
                                  blurRadius: 10,
                                  offset: const Offset(0, 6),
                                ),
                              ],
                            ),
                            child: Column(
                              mainAxisSize: MainAxisSize.min,
                              children: [
                                AnimatedSize(
                                  duration: const Duration(milliseconds: 500),
                                  curve: Curves.easeInOut,
                                  child: AnimatedSwitcher(
                                    duration: const Duration(milliseconds: 500),
                                    transitionBuilder: (child, animation) {
                                      return FadeTransition(
                                        opacity: animation,
                                        child: child,
                                      );
                                    },
                                    child: _getStepContent(
                                        data,
                                        widget.packageSelected,
                                        widget.havePrice),
                                  ),
                                ),
                                Visibility(
                                  visible: _currentStep < 2,
                                  child: SizedBox(
                                    height: 40,
                                    child: Image.asset(
                                      logoBrancaCustomer,
                                      fit: BoxFit.contain,
                                    ),
                                  ),
                                ),
                              ],
                            ),
                          ),
                        ),
                      ],
                    ),
                  ),
                ),
                persistentFooterAlignment: AlignmentDirectional.bottomCenter,
                // persistentFooterButtons: const [DownloadAppPromotion()],
              );
            },
          );
        } else if (data.status == 'error') {
          return Scaffold(
            body: Center(
              child: SizedBox(
                width: 500,
                child: WidgetEmpty(
                  title: 'Barbearia Inativa',
                  subTitle:
                      'Parece que a barbearia não está disponível no momento.',
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
        ),
      ),
    );
  }
}

double getResponsiveWidth(BuildContext context) {
  double screenWidth = MediaQuery.of(context).size.width;

  if (screenWidth < 400) {
    return 400;
  } else if (screenWidth < 500) {
    return 500;
  } else if (screenWidth < 600) {
    return 550;
  } else {
    return 550;
  }
}
