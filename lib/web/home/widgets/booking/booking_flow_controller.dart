// import 'package:flutter/material.dart';
// import 'package:navalha/mobile-DEPRECIATED/home/model/response_get_barber_shop_by_id.dart';
// import 'package:navalha/web/home/widgets/services_list.dart';
// import 'package:navalha/web/home/widgets/professionals_list.dart';
// import 'package:navalha/web/home/widgets/select_hours_page_web.dart';
// import 'package:navalha/web/home/widgets/resume_page_web.dart';

// class BookingFlowController {
//   int _currentStep = 0;
//   Map<String, dynamic>? _selectedServiceData;
//   Map<String, dynamic> _selectedDataMap = {};

//   int get currentStep => _currentStep;

//   void nextStep(VoidCallback setState, [Object? selectedData]) {
//     if (selectedData != null && selectedData is Map<String, dynamic>) {
//       _selectedDataMap = selectedData;
//     } else {
//       _selectedDataMap = {};
//     }
//     setState();
//     _currentStep++;
//   }

//   void previousStep(VoidCallback setState) {
//     setState();
//     _currentStep = 0;
//   }

//   Widget getStepContent(
//       ResponseBarberShopById data,
//       CustomerPackages? packageSelected,
//       bool? havePrice,
//       VoidCallback setState) {
//     switch (_currentStep) {
//       case 0:
//         return ServicesList(
//           data: data,
//           havePrice: havePrice,
//           packageSelected: packageSelected,
//           onNextStep: (selectedData) => nextStep(setState, selectedData),
//         );
//       case 1:
//         return ProfessionalListPageWeb(
//           serviceData: _selectedServiceData ?? _selectedDataMap,
//           onPreviousStep: () => previousStep(setState),
//           onNextStep: (selectedData) => nextStep(setState, selectedData),
//         );
//       case 2:
//         return SelectHoursPageWeb(
//           serviceData: _selectedServiceData ?? _selectedDataMap,
//           onPreviousStep: () => previousStep(setState),
//           onNextStep: ([selectedData]) => nextStep(setState, selectedData),
//         );
//       case 3:
//         return ResumePageWeb(
//           serviceData: _selectedServiceData ?? _selectedDataMap,
//           onPreviousStep: () => previousStep(setState),
//           onNextStep: (selectedData) => nextStep(setState, selectedData),
//         );
//       default:
//         return ServicesList(
//           data: data,
//           havePrice: havePrice,
//           packageSelected: packageSelected,
//           onNextStep: (selectedData) => nextStep(setState, selectedData),
//         );
//     }
//   }
// }
