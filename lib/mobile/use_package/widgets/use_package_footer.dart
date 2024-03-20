// ignore_for_file: use_build_context_synchronously, prefer_const_constructors

import 'dart:async';
import 'package:easy_debounce/easy_debounce.dart';
import 'package:flutter/material.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:navalha/approved_schedule/approved_schedule_page.dart';
import 'package:navalha/shared/providers.dart';
import 'package:navalha/shared/utils.dart';
import 'package:navalha/shared/widgets/page_transition.dart';
import '../../calendar/calendar_page.dart';
import '../../../core/colors.dart';
import '../../login/controller/login_controller.dart';
import '../model/response_use_package.dart';
import '../provider/provider_use_package.dart';

class UsePackageFooter extends StatefulWidget {
  const UsePackageFooter({
    required this.totalTime,
    Key? key,
  }) : super(key: key);
  final String totalTime;
  @override
  State<UsePackageFooter> createState() => _UsePackageFooter();
}

class _UsePackageFooter extends State<UsePackageFooter> {
  bool loading = false;
  @override
  Widget build(BuildContext context) {
    final size = MediaQuery.of(context).size;
    return Consumer(
      builder: (context, ref, child) {
        var servicesUsePackage = ref.watch(servicesUsePackageList.notifier);
        final packageToUseSelected =
            ref.watch(packageSelectedToUseProvider.state);
        final loginController =
            ref.watch(LoginStateController.provider.notifier);
        final usePackage =
            ref.watch(UsePackageStateController.provider.notifier);
        var serviceCache = ref.watch(listServicesCacheProvider.state);

        return Visibility(
          visible: serviceCache.state.isNotEmpty,
          child: Container(
            decoration: BoxDecoration(
              color: colorBackground181818,
            ),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.center,
              mainAxisAlignment: MainAxisAlignment.start,
              children: [
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Padding(
                      padding: const EdgeInsets.symmetric(horizontal: 8),
                      child: Column(
                        mainAxisAlignment: MainAxisAlignment.center,
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          SizedBox(
                            width: size.width * 0.5,
                            child: Text(
                              overflow: TextOverflow.ellipsis,
                              maxLines: 1,
                              'Pacote: ${packageToUseSelected.state.customerPackageName}',
                              style: TextStyle(
                                color: colorFontUnable116116116,
                                fontWeight: FontWeight.w600,
                              ),
                            ),
                          ),
                          Text(
                            '${widget.totalTime}min',
                            style: TextStyle(
                              color: colorFontUnable116116116,
                              fontWeight: FontWeight.w600,
                            ),
                          ),
                        ],
                      ),
                    ),
                    Visibility(
                      visible: serviceCache.state.isNotEmpty,
                      child: Container(
                        margin: EdgeInsets.symmetric(horizontal: 8),
                        width: size.width * 0.35,
                        height: size.height * 0.05,
                        decoration: BoxDecoration(
                          color: colorContainers242424,
                          borderRadius: const BorderRadius.all(
                            Radius.circular(18),
                          ),
                        ),
                        child: ElevatedButton(
                          style: ButtonStyle(
                            elevation: MaterialStateProperty.all(0),
                            backgroundColor: MaterialStateProperty.all<Color>(
                              colorContainers242424,
                            ),
                            overlayColor: MaterialStateProperty.all<Color>(
                              colorContainers353535,
                            ),
                            shape: MaterialStateProperty.all<
                                RoundedRectangleBorder>(
                              RoundedRectangleBorder(
                                borderRadius: BorderRadius.circular(14),
                              ),
                            ),
                          ),
                          child: !loading
                              ? const Text(
                                  'Finalizar',
                                  style: TextStyle(
                                    fontSize: 17,
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
                          onPressed: () {
                            EasyDebounce.debounce('finalized-use-package',
                                const Duration(milliseconds: 500), () async {
                              setState(() => loading = true);
                              ResponseUsePackage request =
                                  await usePackage.usePackage(
                                loginController.user!.customer!.customerId!,
                                packageToUseSelected.state.customerPackageId!,
                                loginController.user!.token!,
                                servicesUsePackage.state,
                              );
                              if (request.hasSucess()) {
                                // navigationFadePush(
                                //     ApprovedSchedulePage(page: CalendarPage()),
                                //     context);

                                servicesUsePackage.state.clear();
                              } else {
                                showSnackBar(context, 'Erro ao marcar serviço');
                              }
                              setState(() => loading = false);
                            });
                          },
                        ),
                      ),
                    )
                  ],
                ),
              ],
            ),
          ),
        );
      },
    );
  }
}
