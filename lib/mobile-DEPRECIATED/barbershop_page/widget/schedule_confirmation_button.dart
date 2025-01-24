// Developer            Data              Decription
// Vitor               22/08/2022        Schedule confirmation button creation

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:navalha/core/colors.dart';
import 'package:navalha/mobile-DEPRECIATED/login/controller/login_controller.dart';
import 'package:navalha/mobile-DEPRECIATED/registration_types_page/registration_types_page.dart';
import 'package:navalha/mobile-DEPRECIATED/schedule/widgets/select_service_botton_sheet.dart';
import '../../home/model/response_get_barber_shop_by_id.dart';
import '../../schedule/model/model_reserved_time.dart';
import '../../schedule/schedule_page.dart';
import '../../schedule/widgets/body_schedule.dart';
import '../../../shared/model/barber_shop_model.dart';
import '../../../shared/providers.dart';
import '../../../shared/utils.dart';
import '../../../shared/widgets/page_transition.dart';
import 'select_service_package_botton_sheet.dart';

class ScheduleConfirmationButton extends StatefulWidget {
  const ScheduleConfirmationButton({
    Key? key,
    required this.barberShop,
    required this.listPackagesUser,
  }) : super(key: key);

  final BarberShop barberShop;
  final List<CustomerPackages>? listPackagesUser;
  @override
  State<ScheduleConfirmationButton> createState() =>
      _ScheduleConfirmationButtonState();
}

class _ScheduleConfirmationButtonState
    extends State<ScheduleConfirmationButton> {
  late StateController<ReservedTime> reservedTime;

  @override
  Widget build(BuildContext context) {
    Size size = MediaQuery.of(context).size;
    return Consumer(
      builder: (context, ref, child) {
        reservedTime = ref.watch(reservedTimeProvider.state);
        final loginController =
            ref.read(LoginStateController.provider.notifier);
        return AnimatedContainer(
          duration: const Duration(milliseconds: 40),
          height: size.height * .05,
          width: size.width * .35,
          margin: EdgeInsets.symmetric(vertical: size.height * 0.04),
          decoration: BoxDecoration(
            border: Border.all(color: colorYellow25020050, width: 2),
            borderRadius: BorderRadius.circular(40),
            color: colorYellow25020050,
          ),
          child: InkWell(
            borderRadius: BorderRadius.circular(25),
            onTap: () {
              if (loginController.user == null) {
                navigationFadePushReplacement(
                    const RegistrationTypesPage(), context);
              } else if (isNullOrEmpty(widget.listPackagesUser) &&
                  isNullOrEmpty(widget.barberShop.packageList)) {
                navigationFadePushReplacement(const SchedulePage(), context);
                showModalBottomSheet<void>(
                  backgroundColor: Colors.transparent,
                  isScrollControlled: true,
                  isDismissible: true,
                  context: context,
                  builder: (BuildContext context) {
                    reservedTime.state.clear();
                    return GestureDetector(
                      onTap: () {
                        Navigator.of(context).pop();
                      },
                      child: SelectServiceBottonSheet(
                        barberShop: widget.barberShop,
                        listAllServicesWithProfessional:
                            getAllServices(widget.barberShop.professionals!),
                        listProfessionals: widget.barberShop.professionals!,
                        listServices: findServicesWithProfessionals(
                          widget.barberShop.professionals!,
                          showActivatedServices(widget.barberShop.services!),
                        ),
                        onConfirm: () {
                          setState(() {});
                        },
                      ),
                    );
                  },
                );
              } else {
                showModalBottomSheet<void>(
                  backgroundColor: Colors.transparent,
                  isScrollControlled: true,
                  isDismissible: true,
                  context: context,
                  builder: (BuildContext context) {
                    return GestureDetector(
                      onTap: () {
                        Navigator.of(context).pop();
                      },
                      child: SelectServicePackageBottonSheet(
                        listPackagesUser: widget.listPackagesUser,
                      ),
                    );
                  },
                );
              }
            },
            child: Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Icon(
                  CupertinoIcons.calendar_badge_plus,
                  color: Colors.black,
                  size: size.width * 0.06,
                ),
                const SizedBox(width: 7),
                Text(
                  'Agendar',
                  style: TextStyle(
                    color: Colors.black,
                    fontSize: size.width * 0.045,
                    fontWeight: FontWeight.w600,
                  ),
                )
              ],
            ),
          ),
        );
      },
    );
  }
}
