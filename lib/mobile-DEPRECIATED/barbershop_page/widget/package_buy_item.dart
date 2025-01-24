// ignore_for_file: use_build_context_synchronously

import 'package:auto_size_text/auto_size_text.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:navalha/core/assets.dart';
import 'package:navalha/core/colors.dart';
import 'package:navalha/core/images_s3.dart';
import 'package:navalha/shared/utils.dart';
import '../../../shared/model/package_model.dart';
import '../../../shared/providers.dart';

class PackageContainerItem extends StatefulWidget {
  const PackageContainerItem({
    Key? key,
    required this.packageList,
    required this.i,
  }) : super(key: key);

  final List<PackageModel> packageList;
  final int i;

  @override
  State<PackageContainerItem> createState() => _PackageContainerItemState();
}

class _PackageContainerItemState extends State<PackageContainerItem> {
  @override
  Widget build(BuildContext context) {
    Size size = MediaQuery.of(context).size;

    return Consumer(
      builder: (context, ref, child) {
        final packageSelectController =
            ref.watch(packageSelectedProvider.state);
        final packageAmountPriceController =
            ref.watch(packageAmountPriceProvider.state);

        return Padding(
          padding: const EdgeInsets.all(8.0),
          child: GestureDetector(
            onTap: () {
              packageSelectController.state = PackageModel(
                barbershopPackageActivated:
                    widget.packageList[widget.i].barbershopPackageActivated,
                barbershopPackageDescription:
                    widget.packageList[widget.i].barbershopPackageDescription,
                barbershopPackageId:
                    widget.packageList[widget.i].barbershopPackageId,
                barbershopPackageImgProfile:
                    widget.packageList[widget.i].barbershopPackageImgProfile,
                barbershopPackageItems:
                    widget.packageList[widget.i].barbershopPackageItems,
                barbershopPackageName:
                    widget.packageList[widget.i].barbershopPackageName,
                barbershopPackagePrice:
                    widget.packageList[widget.i].barbershopPackagePrice,
                barbershopPackageServices:
                    widget.packageList[widget.i].barbershopPackageServices,
                barbershopPackageValidity:
                    widget.packageList[widget.i].barbershopPackageValidity,
              );
              Navigator.of(context).pop();
              packageAmountPriceController.state =
                  packageSelectController.state.barbershopPackagePrice ?? 0;
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
                                              '$baseUrlS3bucketProduct${widget.packageList[widget.i].barbershopPackageImgProfile!}',
                                          fadeInDuration:
                                              const Duration(milliseconds: 500),
                                          fadeInCurve: Curves.easeIn,
                                        ),
                                      ),
                                    ),
                                    CircleAvatar(
                                      backgroundColor: widget
                                              .packageList[widget.i]
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
                                              .barbershopPackageName!,
                                          maxLines: 2,
                                          overflow: TextOverflow.ellipsis,
                                          style: TextStyle(
                                            color: widget.packageList[widget.i]
                                                    .barbershopPackageActivated!
                                                ? Colors.white
                                                : colorFontUnable116116116,
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
                                            color: widget.packageList[widget.i]
                                                    .barbershopPackageActivated!
                                                ? Colors.white
                                                : colorFontUnable116116116,
                                            size: size.width * 0.04,
                                          ),
                                          Text(
                                            ' ${formatDays(widget.packageList[widget.i].barbershopPackageValidity!)}',
                                            style: TextStyle(
                                              color: widget
                                                      .packageList[widget.i]
                                                      .barbershopPackageActivated!
                                                  ? Colors.white
                                                  : colorFontUnable116116116,
                                              fontSize: 14,
                                            ),
                                          ),
                                        ],
                                      ),
                                      SizedBox(width: size.width * 0.05),
                                      Row(
                                        children: [
                                          Text(
                                            'R\$ ',
                                            style: TextStyle(
                                              color: widget
                                                      .packageList[widget.i]
                                                      .barbershopPackageActivated!
                                                  ? Colors.white
                                                  : colorFontUnable116116116,
                                              fontSize: 14,
                                            ),
                                          ),
                                          Text(
                                            widget.packageList[widget.i]
                                                .barbershopPackagePrice!
                                                .toStringAsFixed(2)
                                                .replaceAll('.', ','),
                                            style: TextStyle(
                                              color: widget
                                                      .packageList[widget.i]
                                                      .barbershopPackageActivated!
                                                  ? Colors.white
                                                  : colorFontUnable116116116,
                                              fontSize: 14,
                                            ),
                                          ),
                                        ],
                                      ),
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
                                  'Serviços',
                                  style: TextStyle(
                                    color: widget.packageList[widget.i]
                                            .barbershopPackageActivated!
                                        ? Colors.white
                                        : colorFontUnable116116116,
                                    fontSize: size.height * .020,
                                  ),
                                  maxLines: 2,
                                ),
                                const SizedBox(height: 5),
                                Visibility(
                                  visible: !isNullOrEmpty(getRequiredServices(
                                      widget.packageList[widget.i]
                                          .barbershopPackageServices!)),
                                  child: ListView.builder(
                                    padding: EdgeInsets.zero,
                                    shrinkWrap: true,
                                    physics:
                                        const NeverScrollableScrollPhysics(),
                                    itemCount: getRequiredServices(widget
                                            .packageList[widget.i]
                                            .barbershopPackageServices!)
                                        .length,
                                    itemBuilder: (context, i) => Text(
                                      '${getRequiredServices(widget.packageList[widget.i].barbershopPackageServices!)[i].barbershopPackageServiceQuantity!}x ${getRequiredServices(widget.packageList[widget.i].barbershopPackageServices!)[i].barbershopServiceId!.serviceName!}',
                                      style: TextStyle(
                                          color: colorFontUnable116116116,
                                          fontSize: size.height * .017),
                                      maxLines: 2,
                                    ),
                                  ),
                                ),
                                const SizedBox(height: 10),
                                Visibility(
                                  visible: !isNullOrEmpty(getRequiredItems(
                                      widget.packageList[widget.i]
                                          .barbershopPackageItems!)),
                                  child: Text(
                                    'Produtos',
                                    style: TextStyle(
                                      color: widget.packageList[widget.i]
                                              .barbershopPackageActivated!
                                          ? Colors.white
                                          : colorFontUnable116116116,
                                      fontSize: size.height * .020,
                                    ),
                                    maxLines: 2,
                                  ),
                                ),
                                const SizedBox(height: 5),
                                ListView.builder(
                                  padding: EdgeInsets.zero,
                                  shrinkWrap: true,
                                  physics: const NeverScrollableScrollPhysics(),
                                  itemCount: getRequiredItems(widget
                                          .packageList[widget.i]
                                          .barbershopPackageItems!)
                                      .length,
                                  itemBuilder: (context, i) => Text(
                                    '${getRequiredItems(widget.packageList[widget.i].barbershopPackageItems!)[i].barbershopPackageItemQuantity!}x ${getRequiredItems(widget.packageList[widget.i].barbershopPackageItems!)[i].barberShopProductId!.productName}',
                                    style: TextStyle(
                                        color: colorFontUnable116116116,
                                        fontSize: size.height * .017),
                                    maxLines: 2,
                                  ),
                                ),
                                const SizedBox(height: 15),
                                Text(
                                  'Descrição',
                                  style: TextStyle(
                                    color: widget.packageList[widget.i]
                                            .barbershopPackageActivated!
                                        ? Colors.white
                                        : colorFontUnable116116116,
                                    fontSize: size.height * .020,
                                  ),
                                  maxLines: 2,
                                ),
                                const SizedBox(height: 5),
                                SizedBox(
                                  width: size.width * 0.90,
                                  child: AutoSizeText(
                                    style: TextStyle(
                                      color: widget.packageList[widget.i]
                                                  .barbershopPackageActivated ==
                                              true
                                          ? Colors.grey
                                          : colorFontUnable116116116,
                                      fontSize: size.height * .020,
                                    ),
                                    maxLines: 6,
                                    widget.packageList[widget.i]
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

List<BarbershopPackageServices> getRequiredServices(
    List<BarbershopPackageServices> services) {
  return services
      .where((service) => service.barbershopPackageServiceRequired == true)
      .toList();
}

List<BarbershopPackageServices> getNonRequiredServices(
    List<BarbershopPackageServices> services) {
  return services
      .where((service) => service.barbershopPackageServiceRequired == false)
      .toList();
}

List<BarbershopPackageItems> getRequiredItems(
    List<BarbershopPackageItems> items) {
  return items
      .where((item) => item.barbershopPackageItemRequired == true)
      .toList();
}

List<BarbershopPackageItems> getNonRequiredItems(
    List<BarbershopPackageItems> items) {
  return items
      .where((item) => item.barbershopPackageItemRequired == false)
      .toList();
}
