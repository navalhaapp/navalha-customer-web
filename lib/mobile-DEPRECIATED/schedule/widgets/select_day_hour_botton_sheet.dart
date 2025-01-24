// ignore_for_file: use_build_context_synchronously

import 'package:easy_debounce/easy_debounce.dart';
import 'package:flutter/material.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:navalha/core/colors.dart';
import 'package:navalha/mobile-DEPRECIATED/payment/model/response_create_pix_payment.dart';
import 'package:navalha/mobile-DEPRECIATED/schedule/model/model_get_open_hours_by_date.dart';
import 'package:navalha/mobile-DEPRECIATED/schedule/provider/provider_create_cache_service.dart';
import 'package:navalha/mobile-DEPRECIATED/schedule/provider/provider_get_open_hours_by_date.dart';
import 'package:navalha/mobile-DEPRECIATED/schedule/schedule_page.dart';
import 'package:navalha/mobile-DEPRECIATED/schedule/widgets/calendar.dart';
import 'package:navalha/shared/model/barber_shop_model.dart';
import 'package:navalha/shared/model/open_hour_model.dart';
import 'package:navalha/shared/providers.dart';
import 'package:navalha/shared/utils.dart';
import 'package:navalha/shared/widgets/button_pattern_botton_sheet.dart';
import 'package:navalha/shared/widgets/header_button_sheet_pattern.dart';
import 'package:navalha/shared/widgets/page_transition.dart';
import '../../home/model/response_get_barber_shop_by_id.dart';
import '../../login/controller/login_controller.dart';
import '../../use_package/model/service_package_request.dart';
import '../../use_package/use_package_page.dart';
import '../model/model_create_cache_service.dart';

class SelectDayHourBottonSheet extends StatefulWidget {
  const SelectDayHourBottonSheet({
    Key? key,
    required this.barberShop,
    this.packageSelected,
  }) : super(key: key);
  final BarberShop barberShop;
  final CustomerPackages? packageSelected;

  @override
  State<SelectDayHourBottonSheet> createState() =>
      _SelectDayHourBottonSheetState();
}

class _SelectDayHourBottonSheetState extends State<SelectDayHourBottonSheet> {
  var loading = false;

  @override
  Widget build(BuildContext context) {
    final size = MediaQuery.of(context).size;
    return SafeArea(
      minimum: EdgeInsets.only(top: size.height * 0.04),
      child: Scaffold(
        bottomSheet: GestureDetector(
          onTap: () {},
          child: SingleChildScrollView(
            child: Consumer(
              builder: (context, ref, child) {
                final servicePackageSelected =
                    ref.watch(servicePackageSelectedProvider.state);
                final openHoursController = ref
                    .watch(GetOpenHoursByDateStateController.provider.notifier);
                final authLoginController =
                    ref.watch(LoginStateController.provider.notifier);
                final createCacheCOntroller = ref
                    .watch(CreateCacheServiceStateController.provider.notifier);
                var reservedTime = ref.watch(reservedTimeProvider.state);
                var listResumePayment =
                    ref.watch(listResumePaymentProvider.notifier);
                var servicesUsePackage =
                    ref.watch(servicesUsePackageList.notifier);
                var serviceCache = ref.watch(listServicesCacheProvider.state);
                var daySelectedController =
                    ref.watch(daySelectedProvider.state);
                final packageToUseSelected =
                    ref.watch(packageSelectedToUseProvider.state);
                return Container(
                  decoration: BoxDecoration(
                    color: colorBackground181818,
                    borderRadius: const BorderRadius.only(
                      topLeft: Radius.circular(15),
                      topRight: Radius.circular(15),
                    ),
                  ),
                  child: Column(
                    mainAxisSize: MainAxisSize.min,
                    children: [
                      const HeaderBottonSheetPattern(),
                      Calendar(widget.packageSelected),
                      Row(
                        mainAxisAlignment: MainAxisAlignment.spaceAround,
                        children: [
                          ButtonPattern(
                            child: Text(
                              'Cancelar',
                              style: TextStyle(
                                color: colorRed1765959,
                                fontSize: 15,
                              ),
                            ),
                            onPressed: () {
                              Navigator.pop(context);
                            },
                          ),
                          ButtonPattern(
                            child: !loading
                                ? const Text(
                                    'Confirmar',
                                    style: TextStyle(
                                      fontSize: 15,
                                      color: Colors.white,
                                    ),
                                  )
                                : const SizedBox(
                                    width: 20,
                                    height: 20,
                                    child: CircularProgressIndicator(
                                      color: Colors.white,
                                      strokeWidth: 2,
                                    ),
                                  ),
                            onPressed: () async {
                              EasyDebounce.debounce(
                                'create-pix',
                                const Duration(milliseconds: 500),
                                () async {
                                  if (reservedTime.state.initialHour == '') {
                                    showSnackBar(
                                        context, 'Selecione um horário');
                                  } else {
                                    setState(() {
                                      loading = true;
                                    });
                                    ResponseCreateCacheService response =
                                        await createCacheCOntroller
                                            .createCacheService(
                                      widget.barberShop.barbershopId!,
                                      reservedTime.state.professionalId!,
                                      reservedTime.state.serviceId!,
                                      reservedTime.state.date!,
                                      reservedTime.state.initialHour!,
                                      reservedTime.state.discount ?? 0,
                                    );

                                    if (response.status == 'success') {
                                      showSnackBar(
                                          context, 'Adicionado ao carrinho!');
                                      serviceCache.state.add(response.result!);
                                      serviceCache
                                              .state[serviceCache.state.length - 1]
                                              .observation =
                                          reservedTime.state.observation;
                                      serviceCache
                                              .state[serviceCache.state.length - 1]
                                              .serviceOriginalPrice =
                                          response.result!.service!.price!;
                                      if (widget.packageSelected == null) {
                                        ServiceRequest resumeItem =
                                            ServiceRequest(
                                          cacheId: response.result.cachedId,
                                          date: response.result.date!,
                                          observation:
                                              reservedTime.state.observation,
                                          price:
                                              response.result!.service!.price! -
                                                  calcDiscount(
                                                      response.result!.service!
                                                          .price!,
                                                      reservedTime
                                                              .state.discount ??
                                                          0),
                                          professionalId: reservedTime
                                              .state.professionalId!,
                                          professionalServiceId:
                                              reservedTime.state.serviceId!,
                                          promotionalHourDiscount: calcDiscount(
                                              response.result!.service!.price!,
                                              reservedTime.state.discount ?? 0),
                                          promotionalHourPercent:
                                              reservedTime.state.discount,
                                          serviceInitialHour:
                                              response.result.initialHour,
                                          serviceFinalHour:
                                              response.result.finalHour,
                                        );
                                        listResumePayment.state.services
                                            .add(resumeItem);
                                      } else {
                                        servicesUsePackage.state.add(
                                            UsePackageServiceRequest(
                                                cacheId:
                                                    response.result.cachedId,
                                                date: response.result.date!,
                                                professionalId: reservedTime
                                                    .state.professionalId!,
                                                professionalServiceId:
                                                    reservedTime
                                                        .state.serviceId!,
                                                observation: reservedTime
                                                    .state.observation,
                                                serviceInitialHour:
                                                    response.result.initialHour,
                                                serviceFinalHour:
                                                    response.result.finalHour,
                                                customerPackageServiceId:
                                                    servicePackageSelected.state
                                                        .customerPackageServiceId));
                                        CustomerPackageServices packageService =
                                            packageToUseSelected
                                                .state.customerPackageServices!
                                                .firstWhere((packageService) =>
                                                    packageService
                                                        .packageServiceId ==
                                                    servicePackageSelected.state
                                                        .packageServiceId);
                                        int indexOf = packageToUseSelected
                                            .state.customerPackageServices!
                                            .indexOf(packageService);
                                        if (packageToUseSelected
                                                .state
                                                .customerPackageServices![
                                                    indexOf]
                                                .count! >
                                            1) {
                                          packageToUseSelected
                                              .state
                                              .customerPackageServices![indexOf]
                                              .count = packageToUseSelected
                                                  .state
                                                  .customerPackageServices![
                                                      indexOf]
                                                  .count! -
                                              1;
                                        } else {
                                          packageToUseSelected
                                              .state.customerPackageServices!
                                              .removeAt(indexOf);
                                        }
                                      }
                                      navigationFadePushReplacement(
                                          widget.packageSelected != null
                                              ? UsePackagePage(
                                                  packageSelected:
                                                      widget.packageSelected,
                                                )
                                              : const SchedulePage(),
                                          context);
                                    } else {
                                      if (response.result ==
                                          'already_cached_service') {
                                        showSnackBar(context,
                                            'Desculpe, mas esse horário já foi agendado.');
                                        ResponseGetOpenHoursByDate response =
                                            await openHoursController
                                                .getOpenHoursByDate(
                                          token:
                                              authLoginController.user!.token!,
                                          getAbbreviatedWeekday(
                                              daySelectedController
                                                  .state.weekday),
                                          reservedTime.state.professionalId!,
                                          reservedTime.state.serviceId!,
                                          formatDate(
                                              daySelectedController.state),
                                        );

                                        if (response.status == 'success') {
                                          reservedTime.state.date = formatDate(
                                              daySelectedController.state);
                                          reservedTime.state.listOpenHours =
                                              response.result as List<OpenHour>;
                                        }
                                      } else if (response.result ==
                                          'hour_has_passed') {
                                        showSnackBar(context,
                                            'Desculpe, mas esse horário já passou.');
                                        ResponseGetOpenHoursByDate response =
                                            await openHoursController
                                                .getOpenHoursByDate(
                                          token:
                                              authLoginController.user!.token!,
                                          getAbbreviatedWeekday(
                                              daySelectedController
                                                  .state.weekday),
                                          reservedTime.state.professionalId!,
                                          reservedTime.state.serviceId!,
                                          formatDate(
                                              daySelectedController.state),
                                        );

                                        if (response.status == 'success') {
                                          reservedTime.state.date = formatDate(
                                              daySelectedController.state);
                                          reservedTime.state.listOpenHours =
                                              response.result as List<OpenHour>;
                                        }
                                      } else {
                                        showSnackBar(
                                            context, 'Ops, algo aconteceu');
                                      }
                                    }
                                    setState(() {
                                      loading = false;
                                    });
                                  }
                                },
                              );
                            },
                          ),
                        ],
                      ),
                    ],
                  ),
                );
              },
            ),
          ),
        ),
      ),
    );
  }
}

double calcDiscount(double preco, double desconto) {
  double valorDesconto = preco * (desconto / 100);
  return valorDesconto;
}
