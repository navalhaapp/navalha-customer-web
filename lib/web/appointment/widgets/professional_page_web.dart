import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:navalha/core/assets.dart';
import 'package:navalha/core/colors.dart';
import 'package:navalha/mobile/home/model/response_get_barber_shop_by_id.dart';
import 'package:navalha/mobile/login/controller/login_controller.dart';
import 'package:navalha/mobile/schedule/model/model_reserved_time.dart';
import 'package:navalha/shared/model/professional_model.dart';
import 'package:navalha/shared/providers.dart';
import 'package:navalha/shared/utils.dart';
import 'package:navalha/shared/widgets/page_transition.dart';
import 'package:navalha/web/appointment/widgets/drawer_page_web.dart';
import 'package:navalha/web/appointment/widgets/professional_item_web.dart';
import 'package:navalha/web/appointment/widgets/select_hours_page_web.dart';
import 'package:navalha/web/appointment/widgets/services_page_web.dart';
import '../../../shared/model/service_model.dart';

class ProfessionalPageWeb extends StatefulWidget {
  static const route = '/professional-web-page';
  const ProfessionalPageWeb({
    Key? key,
    required this.data,
    required this.listProfessionals,
    required this.iService,
    required this.serviceName,
    this.packageSelected,
  }) : super(key: key);

  final ResponseBarberShopById data;
  final List<Professional> listProfessionals;
  final int iService;
  final String serviceName;
  final CustomerPackages? packageSelected;

  @override
  State<ProfessionalPageWeb> createState() => _ProfessionalPageWebState();
}

class _ProfessionalPageWebState extends State<ProfessionalPageWeb> {
  late StateController<ReservedTime> reservedTime;
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

  bool loading = false;
  @override
  Widget build(BuildContext context) {
    return Consumer(builder: (context, ref, child) {
      final loginController = ref.read(LoginStateController.provider.notifier);
      return Scaffold(
        backgroundColor: colorBackground181818,
        drawer: const DrawerPageWeb(),
        appBar: AppBar(
          elevation: 0,
          title: Text(widget.data.barbershop!.name!),
          backgroundColor: colorBackground181818,
          actions: [
            loginController.user?.customer?.imgProfile == null
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
                          loginController.user?.customer?.imgProfile,
                        ),
                        fit: BoxFit.contain,
                      ),
                    ),
                  ),
          ],
        ),
        body: Consumer(
          builder: (context, ref, child) {
            reservedTime = ref.watch(reservedTimeProvider.state);
            final resumePayment = ref.watch(resumePaymentProvider.state);
            return Center(
              child: SingleChildScrollView(
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
                                  itemCount: widget.listProfessionals.length,
                                  itemBuilder: (context, i) {
                                    return GestureDetector(
                                      onTap: () {
                                        reservedTime.state.professionalId =
                                            widget.listProfessionals[i]
                                                .professionalId!;
                                        reservedTime.state.serviceId =
                                            getServiceIdByName(
                                                widget.serviceName,
                                                widget.listProfessionals[i]
                                                    .professionalServices!);
                                        resumePayment.state.professionalId =
                                            reservedTime.state.professionalId;
                                        resumePayment
                                                .state.professionalServiceId =
                                            reservedTime.state.serviceId;
                                        navigationFadePush(
                                            SelectHoursPageWeb(
                                                barberShop:
                                                    widget.data.barbershop!),
                                            context);
                                      },
                                      child: ProfessionalItemWeb(
                                        i: i,
                                        professionalId: widget
                                            .listProfessionals[i]
                                            .professionalId!,
                                        listProfessionalServices: widget
                                            .listProfessionals[i]
                                            .professionalServices!,
                                        hidePriceAndTime: true,
                                        img: widget
                                            .listProfessionals[i].imgProfile!,
                                        name: widget.listProfessionals[i].name!,
                                        rating:
                                            widget.listProfessionals[i].rating!,
                                        imgService: widget
                                            .listProfessionals[i]
                                            .professionalServices![
                                                widget.iService]
                                            .imgProfile,
                                        listImgServices: widget
                                            .listProfessionals[i]
                                            .professionalServices,
                                        serviceTime: widget
                                            .listProfessionals[i]
                                            .professionalServices![
                                                widget.iService]
                                            .duration,
                                        havePrice: false,
                                        packageList: widget.packageSelected,
                                        barberShop: widget.data.barbershop!,
                                        servicePrice: widget
                                            .listProfessionals[i]
                                            .professionalServices![
                                                widget.iService]
                                            .price!,
                                        serviceName: widget
                                            .listProfessionals[i]
                                            .professionalServices![
                                                widget.iService]
                                            .name!,
                                        serviceImg: widget
                                            .listProfessionals[i]
                                            .professionalServices![
                                                widget.iService]
                                            .imgProfile!,
                                        listProfessionals:
                                            getProfessionalsByService(
                                          widget.listProfessionals[i]
                                                  .professionalServices![
                                              widget.iService],
                                          widget
                                              .data.barbershop!.professionals!,
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
              ),
            );
          },
        ),
      );
    });
  }
}