// // ignore_for_file: use_build_context_synchronously

// import 'package:easy_debounce/easy_debounce.dart';
// import 'package:flutter/cupertino.dart';
// import 'package:flutter/material.dart';
// import 'package:hooks_riverpod/hooks_riverpod.dart';

// import 'package:navalha/core/assets.dart';
// import 'package:navalha/core/colors.dart';
// import 'package:navalha/mobile-DEPRECIATED/home/model/response_get_barber_shop_by_id.dart';
// import 'package:navalha/mobile-DEPRECIATED/login/controller/login_controller.dart';
// import 'package:navalha/mobile-DEPRECIATED/payment/model/response_create_pix_payment.dart';
// import 'package:navalha/mobile-DEPRECIATED/schedule/model/model_create_cache_service.dart';
// import 'package:navalha/mobile-DEPRECIATED/schedule/model/model_get_open_hours_by_date.dart';
// import 'package:navalha/mobile-DEPRECIATED/schedule/provider/provider_create_cache_service.dart';
// import 'package:navalha/mobile-DEPRECIATED/schedule/provider/provider_get_open_hours_by_date.dart';
// import 'package:navalha/mobile-DEPRECIATED/schedule/widgets/observation_botton_sheet.dart';
// import 'package:navalha/mobile-DEPRECIATED/use_package/model/service_package_request.dart';
// import 'package:navalha/shared/model/barber_shop_model.dart';

// import 'package:navalha/shared/model/open_hour_model.dart';
// import 'package:navalha/shared/providers.dart';
// import 'package:navalha/shared/utils.dart';
// import 'package:navalha/shared/widgets/button_pattern_botton_sheet.dart';
// import 'package:navalha/web/appointment/widgets/calendar_web.dart';
// import 'package:navalha/web/appointment/widgets/drawer_page_web.dart';
// import 'package:navalha/web/appointment/widgets/services_page_web.dart';
// import 'package:navalha/web/db/db_customer_shared.dart';

// class SelectHoursPageWeb extends StatefulWidget {
//   const SelectHoursPageWeb({
//     Key? key,
//     this.packageSelected,
//   }) : super(key: key);

//   final CustomerPackages? packageSelected;

//   @override
//   State<SelectHoursPageWeb> createState() => _SelectHoursPageWebState();
// }

// class _SelectHoursPageWebState extends State<SelectHoursPageWeb> {
//   String observation = '';
//   bool loading = false;
//   @override
//   Widget build(BuildContext context) {
//     final Map<String, dynamic> args =
//         ModalRoute.of(context)?.settings.arguments as Map<String, dynamic>;
//     final BarberShop barberShop = args['barbershop'] as BarberShop;
//     final retrievedCustomer = LocalStorageManager.getCustomer();
//     return Consumer(builder: (context, ref, child) {
//       return Scaffold(
//         backgroundColor: colorBackground181818,
//         drawer: DrawerPageWeb(barberShopId: barberShop.barbershopId!),
//         appBar: AppBar(
//           backgroundColor: colorBackground181818,
//           title: Text(barberShop.name!),
//           elevation: 0,
//           actions: [
//             retrievedCustomer == null
//                 ? Container(
//                     margin:
//                         const EdgeInsets.symmetric(horizontal: 10, vertical: 5),
//                     width: 40,
//                     height: 40,
//                     decoration: BoxDecoration(
//                       shape: BoxShape.circle,
//                       image: DecorationImage(
//                         image: AssetImage(iconLogoApp),
//                         fit: BoxFit.contain,
//                       ),
//                     ),
//                   )
//                 : Container(
//                     margin:
//                         const EdgeInsets.symmetric(horizontal: 10, vertical: 5),
//                     width: 40,
//                     height: 40,
//                     decoration: BoxDecoration(
//                       shape: BoxShape.circle,
//                       image: DecorationImage(
//                         image: NetworkImage(
//                           retrievedCustomer.image,
//                         ),
//                         fit: BoxFit.contain,
//                       ),
//                     ),
//                   ),
//           ],
//         ),
//         body: SingleChildScrollView(
//           child: Consumer(builder: (context, ref, child) {
//             final servicePackageSelected =
//                 ref.watch(servicePackageSelectedProvider.state);
//             final openHoursController =
//                 ref.watch(GetOpenHoursByDateStateController.provider.notifier);
//             final authLoginController =
//                 ref.watch(LoginStateController.provider.notifier);
//             final createCacheController =
//                 ref.watch(CreateCacheServiceStateController.provider.notifier);
//             var reservedTime = ref.watch(reservedTimeProvider.state);

//             var listResumePayment =
//                 ref.watch(listResumePaymentProvider.notifier);
//             var servicesUsePackage = ref.watch(servicesUsePackageList.notifier);
//             var serviceCache = ref.watch(listServicesCacheProvider.state);
//             var daySelectedController = ref.watch(daySelectedProvider.state);
//             final packageToUseSelected =
//                 ref.watch(packageSelectedToUseProvider.state);
//             return Column(
//               mainAxisAlignment: MainAxisAlignment.end,
//               children: [
//                 Center(
//                   child: Column(
//                     children: [
//                       Container(
//                         margin:
//                             const EdgeInsets.only(left: 20, right: 20, top: 18),
//                         width: 500,
//                         height: 465,
//                         decoration: BoxDecoration(
//                           borderRadius: BorderRadius.circular(15),
//                           color: colorContainers242424,
//                         ),
//                         child: Padding(
//                           padding: const EdgeInsets.all(8.0),
//                           child: SingleChildScrollView(
//                             child: Container(
//                               decoration: BoxDecoration(
//                                 color: colorContainers242424,
//                                 borderRadius: const BorderRadius.only(
//                                   topLeft: Radius.circular(15),
//                                   topRight: Radius.circular(15),
//                                 ),
//                               ),
//                               child: Column(
//                                 mainAxisSize: MainAxisSize.min,
//                                 children: [
//                                   Padding(
//                                     padding: const EdgeInsets.only(
//                                         left: 10, top: 20, bottom: 10),
//                                     child: Row(
//                                       mainAxisAlignment:
//                                           MainAxisAlignment.spaceBetween,
//                                       children: [
//                                         IconButton(
//                                           padding:
//                                               const EdgeInsets.only(left: 30),
//                                           onPressed: () {
//                                             Navigator.pop(context);
//                                           },
//                                           icon: const Icon(
//                                             CupertinoIcons.clear,
//                                             color: Colors.white,
//                                           ),
//                                         ),
//                                         Text(
//                                           'Escolha uma data',
//                                           style: TextStyle(
//                                             fontSize: 20,
//                                             shadows: shadow,
//                                             color: Colors.white,
//                                           ),
//                                         ),
//                                         IconButton(
//                                           padding:
//                                               const EdgeInsets.only(left: 30),
//                                           onPressed: () {},
//                                           icon: const Icon(
//                                             CupertinoIcons.clear,
//                                             color: Colors.transparent,
//                                           ),
//                                         ),
//                                       ],
//                                     ),
//                                   ),
//                                   const CalendarWeb(),
//                                 ],
//                               ),
//                             ),
//                           ),
//                         ),
//                       ),
//                       Visibility(
//                         visible: reservedTime.state.date != '',
//                         child: Container(
//                           width: 500,
//                           margin: const EdgeInsets.symmetric(
//                               vertical: 10, horizontal: 20),
//                           decoration: BoxDecoration(
//                             borderRadius: BorderRadius.circular(15),
//                             color: const Color.fromARGB(255, 28, 28, 28),
//                           ),
//                           child: Column(
//                             children: [
//                               Padding(
//                                 padding:
//                                     const EdgeInsets.symmetric(vertical: 5),
//                                 child: ElevatedButton(
//                                   style: ButtonStyle(
//                                     padding: MaterialStateProperty.all(
//                                         EdgeInsets.zero),
//                                     overlayColor:
//                                         MaterialStateProperty.all<Color>(
//                                       colorContainers353535,
//                                     ),
//                                     elevation: MaterialStateProperty.all(10),
//                                     backgroundColor:
//                                         MaterialStateProperty.all<Color>(
//                                             Colors.transparent),
//                                     shape: MaterialStateProperty.all<
//                                         RoundedRectangleBorder>(
//                                       RoundedRectangleBorder(
//                                         borderRadius: BorderRadius.circular(12),
//                                       ),
//                                     ),
//                                   ),
//                                   child: Row(
//                                     children: [
//                                       const SizedBox(width: 20),
//                                       Icon(Icons.add,
//                                           size: 17,
//                                           color: colorFontUnable116116116),
//                                       const SizedBox(width: 3),
//                                       Text(
//                                         '${observation.isNotEmpty ? 'Editar' : 'Adicionar uma'} observação',
//                                         style: TextStyle(
//                                           color: colorFontUnable116116116,
//                                         ),
//                                       ),
//                                     ],
//                                   ),
//                                   onPressed: () {
//                                     showModalBottomSheet<void>(
//                                       backgroundColor: Colors.black,
//                                       isScrollControlled: true,
//                                       shape: RoundedRectangleBorder(
//                                         borderRadius: BorderRadius.circular(20),
//                                       ),
//                                       context: context,
//                                       builder: (BuildContext context) {
//                                         return ObservationBottomSheet(
//                                           initialObservation: observation,
//                                           onChanged: (value) {
//                                             setState(() {
//                                               observation = value;
//                                             });
//                                           },
//                                         );
//                                       },
//                                     );
//                                   },
//                                 ),
//                               ),
//                               Visibility(
//                                 visible: observation.isNotEmpty,
//                                 child: SizedBox(
//                                   width: 500,
//                                   child: Padding(
//                                     padding: const EdgeInsets.symmetric(
//                                         horizontal: 20, vertical: 5),
//                                     child: Text(observation),
//                                   ),
//                                 ),
//                               ),
//                             ],
//                           ),
//                         ),
//                       ),
//                       ButtonPattern(
//                         margin: const EdgeInsets.symmetric(horizontal: 20),
//                         width: 500,
//                         elevation: false,
//                         child: !loading
//                             ? const Text(
//                                 'Confirmar',
//                                 style: TextStyle(
//                                   color: Colors.white,
//                                   fontSize: 15,
//                                 ),
//                               )
//                             : const SizedBox(
//                                 width: 20,
//                                 height: 20,
//                                 child: CircularProgressIndicator(
//                                   color: Colors.white,
//                                   strokeWidth: 2,
//                                 ),
//                               ),
//                         onPressed: () async {
//                           EasyDebounce.debounce(
//                             'create-pix',
//                             const Duration(milliseconds: 500),
//                             () async {
//                               if (reservedTime.state.initialHour == '') {
//                                 showSnackBar(context, 'Selecione um horário');
//                               } else {
//                                 setState(() {
//                                   loading = true;
//                                 });
//                                 ResponseCreateCacheService response =
//                                     await createCacheController
//                                         .createCacheService(
//                                   barberShop.barbershopId!,
//                                   reservedTime.state.professionalId!,
//                                   reservedTime.state.serviceId!,
//                                   reservedTime.state.date!,
//                                   reservedTime.state.initialHour!,
//                                   reservedTime.state.discount ?? 0,
//                                 );

//                                 if (response.status == 'success') {
//                                   showSnackBar(
//                                       context, 'Adicionado ao carrinho!');
//                                   serviceCache.state.add(response.result!);
//                                   serviceCache
//                                       .state[serviceCache.state.length - 1]
//                                       .observation = observation;
//                                   serviceCache
//                                           .state[serviceCache.state.length - 1]
//                                           .serviceOriginalPrice =
//                                       response.result!.service!.price!;
//                                   if (widget.packageSelected == null) {
//                                     ServiceRequest resumeItem = ServiceRequest(
//                                       cacheId: response.result.cachedId,
//                                       date: response.result.date!,
//                                       observation: observation,
//                                       price: response.result!.service!.price! -
//                                           calcDiscount(
//                                               response.result!.service!.price!,
//                                               reservedTime.state.discount ?? 0),
//                                       professionalId:
//                                           reservedTime.state.professionalId!,
//                                       professionalServiceId:
//                                           reservedTime.state.serviceId!,
//                                       promotionalHourDiscount: calcDiscount(
//                                           response.result!.service!.price!,
//                                           reservedTime.state.discount ?? 0),
//                                       promotionalHourPercent:
//                                           reservedTime.state.discount,
//                                       serviceInitialHour:
//                                           response.result.initialHour,
//                                       serviceFinalHour:
//                                           response.result.finalHour,
//                                     );
//                                     listResumePayment.state.services
//                                         .add(resumeItem);
//                                   } else {
//                                     servicesUsePackage.state.add(
//                                         UsePackageServiceRequest(
//                                             cacheId: response.result.cachedId,
//                                             date: response.result.date!,
//                                             professionalId: reservedTime
//                                                 .state.professionalId!,
//                                             professionalServiceId:
//                                                 reservedTime.state.serviceId!,
//                                             observation:
//                                                 reservedTime.state.observation,
//                                             serviceInitialHour:
//                                                 response.result.initialHour,
//                                             serviceFinalHour:
//                                                 response.result.finalHour,
//                                             customerPackageServiceId:
//                                                 servicePackageSelected.state
//                                                     .customerPackageServiceId));
//                                     CustomerPackageServices packageService =
//                                         packageToUseSelected
//                                             .state.customerPackageServices!
//                                             .firstWhere((packageService) =>
//                                                 packageService
//                                                     .packageServiceId ==
//                                                 servicePackageSelected
//                                                     .state.packageServiceId);
//                                     int indexOf = packageToUseSelected
//                                         .state.customerPackageServices!
//                                         .indexOf(packageService);
//                                     if (packageToUseSelected
//                                             .state
//                                             .customerPackageServices![indexOf]
//                                             .count! >
//                                         1) {
//                                       packageToUseSelected
//                                           .state
//                                           .customerPackageServices![indexOf]
//                                           .count = packageToUseSelected
//                                               .state
//                                               .customerPackageServices![indexOf]
//                                               .count! -
//                                           1;
//                                     } else {
//                                       packageToUseSelected
//                                           .state.customerPackageServices!
//                                           .removeAt(indexOf);
//                                     }
//                                   }
//                                   var barbershop = ref
//                                       .watch(barberShopSelectedProvider.state);
//                                   barbershop.state = barberShop;
//                                   Navigator.of(context).pushNamed('/resume');
//                                 } else {
//                                   if (response.result ==
//                                       'already_cached_service') {
//                                     setState(() {
//                                       loading = false;
//                                     });
//                                     showSnackBar(context,
//                                         'Desculpe, mas esse horário já foi agendado.');
//                                     ResponseGetOpenHoursByDate response =
//                                         await openHoursController
//                                             .getOpenHoursByDate(
//                                       token: authLoginController.user!.token!,
//                                       getAbbreviatedWeekday(
//                                           daySelectedController.state.weekday),
//                                       reservedTime.state.professionalId!,
//                                       reservedTime.state.serviceId!,
//                                       formatDate(daySelectedController.state),
//                                     );

//                                     if (response.status == 'success') {
//                                       reservedTime.state.date = formatDate(
//                                           daySelectedController.state);
//                                       reservedTime.state.listOpenHours =
//                                           response.result as List<OpenHour>;
//                                     }
//                                   } else if (response.result ==
//                                       'hour_has_passed') {
//                                     setState(() {
//                                       loading = false;
//                                     });
//                                     showSnackBar(context,
//                                         'Desculpe, mas esse horário já passou.');
//                                     ResponseGetOpenHoursByDate response =
//                                         await openHoursController
//                                             .getOpenHoursByDate(
//                                       token: authLoginController.user!.token!,
//                                       getAbbreviatedWeekday(
//                                           daySelectedController.state.weekday),
//                                       reservedTime.state.professionalId!,
//                                       reservedTime.state.serviceId!,
//                                       formatDate(daySelectedController.state),
//                                     );

//                                     if (response.status == 'success') {
//                                       reservedTime.state.date = formatDate(
//                                           daySelectedController.state);
//                                       reservedTime.state.listOpenHours =
//                                           response.result as List<OpenHour>;
//                                     }
//                                   } else {
//                                     setState(() {
//                                       loading = false;
//                                     });
//                                     showSnackBar(
//                                         context, 'Ops, algo aconteceu');
//                                   }
//                                 }
//                                 setState(() {
//                                   loading = false;
//                                 });
//                               }
//                             },
//                           );
//                         },
//                       ),
//                     ],
//                   ),
//                 ),
//                 const DownloadAppPromotion(),
//               ],
//             );
//           }),
//         ),
//       );
//     });
//   }
// }

// double calcDiscount(double preco, double desconto) {
//   double valorDesconto = preco * (desconto / 100);
//   return valorDesconto;
// }
