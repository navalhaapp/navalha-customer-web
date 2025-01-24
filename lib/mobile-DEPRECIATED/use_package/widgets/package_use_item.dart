// ignore_for_file: use_build_context_synchronously

import 'package:auto_size_text/auto_size_text.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:navalha/core/assets.dart';
import 'package:navalha/core/colors.dart';
import 'package:navalha/core/images_s3.dart';
import '../../home/model/response_get_barber_shop_by_id.dart';
import '../../schedule/widgets/body_schedule.dart';
import '../../schedule/widgets/select_service_botton_sheet.dart';
import '../../../shared/providers.dart';
import '../../../shared/utils.dart';
import '../../../shared/widgets/page_transition.dart';
import '../use_package_page.dart';

class PackageUseContainerItem extends StatefulWidget {
  const PackageUseContainerItem({
    Key? key,
    required this.packageList,
    required this.i,
  }) : super(key: key);

  final List<CustomerPackages> packageList;
  final int i;

  @override
  State<PackageUseContainerItem> createState() =>
      _PackageUseContainerItemState();
}

class _PackageUseContainerItemState extends State<PackageUseContainerItem> {
  @override
  Widget build(BuildContext context) {
    Size size = MediaQuery.of(context).size;

    return Consumer(
      builder: (context, ref, child) {
        final barberShopProvider = ref.watch(barberShopSelectedProvider.state);
        final packageToUseSelected =
            ref.watch(packageSelectedToUseProvider.state);

        return Padding(
          padding: const EdgeInsets.all(8.0),
          child: GestureDetector(
            onTap: () {
              packageToUseSelected.state = widget.packageList[widget.i];
              Navigator.of(context).pop();
              navigationFadePushReplacement(
                  UsePackagePage(packageSelected: widget.packageList[widget.i]),
                  context);
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
                    child: SelectServiceBottonSheet(
                      havePrice: false,
                      packageSelected: widget.packageList[widget.i],
                      barberShop: barberShopProvider.state,
                      listAllServicesWithProfessional: getAllServices(
                          barberShopProvider.state.professionals!),
                      listProfessionals:
                          barberShopProvider.state.professionals!,
                      //TODO
                      listServices: findPackageServicesWithProfessionals(
                          barberShopProvider.state.professionals!,
                          widget
                              .packageList[widget.i].customerPackageServices!),
                      onConfirm: () {
                        setState(() {});
                      },
                    ),
                  );
                },
              );
            },
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Column(
                  children: [
                    Container(
                      margin: EdgeInsets.only(
                        left: size.width * .03,
                        right: size.width * .03,
                      ),
                      decoration: BoxDecoration(
                        borderRadius: const BorderRadius.only(
                          topLeft: Radius.circular(15),
                          bottomLeft: Radius.circular(15),
                          topRight: Radius.circular(15),
                          bottomRight: Radius.circular(15),
                        ),
                        color: colorContainers242424,
                      ),
                      child: Column(
                        mainAxisAlignment: MainAxisAlignment.start,
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Row(
                            mainAxisAlignment: MainAxisAlignment.start,
                            children: [
                              Container(
                                margin: const EdgeInsets.only(
                                    left: 10, right: 10, top: 10),
                                width: MediaQuery.of(context).size.height * 0.1,
                                height:
                                    MediaQuery.of(context).size.height * 0.1,
                                child: Stack(
                                  alignment: Alignment.center,
                                  children: [
                                    Container(
                                      margin: EdgeInsets.symmetric(
                                        horizontal: size.width * 0.02,
                                        vertical: size.height * 0.01,
                                      ),
                                      padding: EdgeInsets.zero,
                                      width: size.height * 0.4,
                                      height: size.height * 0.4,
                                      child: ClipRRect(
                                        borderRadius:
                                            BorderRadius.circular(1000),
                                        child: FadeInImage.assetNetwork(
                                          placeholder: imgLoading3,
                                          image:
                                              '$baseUrlS3bucketProduct${widget.packageList[widget.i].packageModel!.barbershopPackageImgProfile}',
                                          fadeInDuration:
                                              const Duration(milliseconds: 500),
                                          fadeInCurve: Curves.easeIn,
                                        ),
                                      ),
                                    ),
                                    CircleAvatar(
                                      backgroundColor: widget
                                              .packageList[widget.i]
                                              .packageModel!
                                              .barbershopPackageActivated!
                                          ? Colors.transparent
                                          : const Color.fromARGB(122, 0, 0, 0),
                                      radius:
                                          MediaQuery.of(context).size.height *
                                              0.041,
                                    ),
                                  ],
                                ),
                              ),
                              Column(
                                mainAxisAlignment: MainAxisAlignment.center,
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  Row(
                                    mainAxisAlignment:
                                        MainAxisAlignment.spaceBetween,
                                    children: [
                                      SizedBox(
                                        width: size.width * 0.5,
                                        child: Text(
                                          widget.packageList[widget.i]
                                              .customerPackageBarbershopName!,
                                          overflow: TextOverflow.ellipsis,
                                          style: TextStyle(
                                            color: Colors.white,
                                            fontSize: size.height * .025,
                                          ),
                                        ),
                                      ),
                                    ],
                                  ),
                                  SizedBox(
                                    height: size.height * 0.01,
                                  ),
                                  Row(
                                    children: [
                                      Row(
                                        children: [
                                          Icon(
                                            CupertinoIcons.calendar,
                                            color: Colors.white,
                                            size: size.width * 0.04,
                                          ),
                                          Text(
                                            ' ${formatDays(widget.packageList[widget.i].packageModel!.barbershopPackageValidity!)}',
                                            style: const TextStyle(
                                              color: Colors.white,
                                              fontSize: 14,
                                            ),
                                          ),
                                        ],
                                      ),
                                      SizedBox(width: size.width * 0.05),
                                    ],
                                  ),
                                ],
                              ),
                            ],
                          ),
                          Padding(
                            padding: EdgeInsets.only(
                              top: size.height * 0.005,
                              left: size.width * .03,
                              bottom: size.height * 0.03,
                            ),
                            child: Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                Text(
                                  'Serviços/Produtos inclusos:',
                                  style: TextStyle(
                                    color: Colors.white,
                                    fontSize: size.height * .020,
                                  ),
                                  maxLines: 2,
                                ),
                                const SizedBox(height: 5),
                                ListView.builder(
                                  padding: EdgeInsets.zero,
                                  shrinkWrap: true,
                                  physics: const NeverScrollableScrollPhysics(),
                                  itemCount: widget.packageList[widget.i]
                                      .customerPackageProducts!.length,
                                  itemBuilder: (context, i) => Text(
                                    '${widget.packageList[widget.i].customerPackageProducts![i].count!}x ${widget.packageList[widget.i].customerPackageProducts![i].customerPackageProductId}',
                                    style: TextStyle(
                                        color: Colors.white,
                                        fontSize: size.height * .017),
                                    maxLines: 2,
                                  ),
                                ),
                                ListView.builder(
                                  padding: EdgeInsets.zero,
                                  shrinkWrap: true,
                                  physics: const NeverScrollableScrollPhysics(),
                                  itemCount: widget.packageList[widget.i]
                                      .customerPackageServices!.length,
                                  itemBuilder: (context, i) => Text(
                                    '${widget.packageList[widget.i].customerPackageServices![i].count!}x ${widget.packageList[widget.i].customerPackageServices![i].barbershopServiceId!.serviceName!}',
                                    style: TextStyle(
                                        color: Colors.white,
                                        fontSize: size.height * .017),
                                    maxLines: 2,
                                  ),
                                ),
                                const SizedBox(height: 15),
                                Text(
                                  'Descrição',
                                  style: TextStyle(
                                    color: Colors.white,
                                    fontSize: size.height * .020,
                                  ),
                                  maxLines: 2,
                                ),
                                const SizedBox(height: 5),
                                SizedBox(
                                  width: size.width * 0.90,
                                  child: AutoSizeText(
                                    style: TextStyle(
                                      color: Colors.grey,
                                      fontSize: size.height * .020,
                                    ),
                                    maxLines: 6,
                                    widget.packageList[widget.i].packageModel!
                                        .barbershopPackageDescription!,
                                  ),
                                ),
                              ],
                            ),
                          ),
                        ],
                      ),
                    ),
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

String formatDays(int numberOfDays) {
  if (numberOfDays == 1) {
    return '1 dia';
  } else if (numberOfDays > 1) {
    return '$numberOfDays dias';
  } else {
    return 'Número inválido de dias';
  }
}
