import 'package:auto_size_text/auto_size_text.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:navalha/core/assets.dart';
import 'package:navalha/core/colors.dart';
import 'package:navalha/core/images_s3.dart';
import 'package:navalha/shared/utils.dart';
import '../model/response_get_customer_packages.dart';
import 'detail_package_customer_botton_sheet.dart';

class MyPackagesItem extends StatefulWidget {
  const MyPackagesItem(
      {Key? key, required this.listScheduleItem, required this.i})
      : super(key: key);

  final List<ResultGetCustomerPackages> listScheduleItem;
  final int i;

  @override
  State<MyPackagesItem> createState() => _MyPackagesItemState();
}

class _MyPackagesItemState extends State<MyPackagesItem> {
  @override
  Widget build(BuildContext context) {
    bool packageExpired =
        widget.listScheduleItem[widget.i].customerPackageExpirationDays! < 0;

    late String validityText;
    if (packageExpired) {
      validityText = ' Expirado';
    } else if (widget
            .listScheduleItem[widget.i].customerPackageExpirationDays! ==
        0) {
      validityText = ' Expira hoje';
    } else if (widget
            .listScheduleItem[widget.i].customerPackageExpirationDays! ==
        1) {
      validityText =
          ' ${widget.listScheduleItem[widget.i].customerPackageExpirationDays!.toString()} dia';
    } else {
      validityText =
          ' ${widget.listScheduleItem[widget.i].customerPackageExpirationDays!.toString()} dias';
    }
    Size size = MediaQuery.of(context).size;
    return GestureDetector(
      onTap: () {
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
              child: DetailPackageCustomerBottonSheet(
                listScheduleItem: widget.listScheduleItem,
                i: widget.i,
              ),
            );
          },
        );
      },
      child: Consumer(
        builder: (context, ref, child) {
          return Stack(
            children: [
              Container(
                margin: EdgeInsets.only(
                  top: size.height * .015,
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
                          height: MediaQuery.of(context).size.height * 0.1,
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
                                  borderRadius: BorderRadius.circular(1000),
                                  child: FadeInImage.assetNetwork(
                                    placeholder: imgLoading3,
                                    image:
                                        '$baseUrlS3bucketProduct${widget.listScheduleItem[widget.i].customerPackagesBarbershopPackage!.barbershopPackageImgProfile!}',
                                    fadeInDuration:
                                        const Duration(milliseconds: 500),
                                    fadeInCurve: Curves.easeIn,
                                  ),
                                ),
                              ),
                            ],
                          ),
                        ),
                        Column(
                          mainAxisAlignment: MainAxisAlignment.center,
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Row(
                              mainAxisAlignment: MainAxisAlignment.spaceBetween,
                              children: [
                                SizedBox(
                                  width: size.width * 0.5,
                                  child: Text(
                                    widget.listScheduleItem[widget.i]
                                        .customerPackageBarbershopName!,
                                    overflow: TextOverflow.ellipsis,
                                    style: TextStyle(
                                      color: !packageExpired
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
                                      color: !packageExpired
                                          ? Colors.white
                                          : colorFontUnable116116116,
                                      size: size.width * 0.04,
                                    ),
                                    Text(
                                      validityText,
                                      style: TextStyle(
                                        color: !packageExpired
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
                                        color: !packageExpired
                                            ? Colors.white
                                            : colorFontUnable116116116,
                                        fontSize: 14,
                                      ),
                                    ),
                                    Text(
                                      widget.listScheduleItem[widget.i]
                                          .customerPackagePayment!
                                          .toStringAsFixed(2)
                                          .replaceAll('.', ','),
                                      style: TextStyle(
                                        color: !packageExpired
                                            ? Colors.white
                                            : colorFontUnable116116116,
                                        fontSize: 14,
                                      ),
                                    ),
                                  ],
                                ),
                              ],
                            ),
                            const SizedBox(height: 5),
                            Row(
                              children: [
                                Icon(
                                  CupertinoIcons.cube_box_fill,
                                  color: !packageExpired
                                      ? Colors.white
                                      : colorFontUnable116116116,
                                  size: size.width * 0.04,
                                ),
                                const SizedBox(width: 5),
                                Text(
                                  widget.listScheduleItem[widget.i]
                                      .customerPackageName!
                                      .replaceAll('.', ','),
                                  style: TextStyle(
                                    color: !packageExpired
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
                    Padding(
                      padding: EdgeInsets.only(
                        top: size.height * 0.005,
                        left: size.width * .03,
                        bottom: size.height * 0.03,
                      ),
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Visibility(
                            visible: !isNullOrEmpty(widget
                                .listScheduleItem[widget.i]
                                .customerPackageServices!),
                            child: Text(
                              'Serviços',
                              style: TextStyle(
                                color: !packageExpired
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
                            itemCount: widget.listScheduleItem[widget.i]
                                .customerPackageServices!.length,
                            itemBuilder: (context, i) => Row(
                              children: [
                                Text(
                                  '${widget.listScheduleItem[widget.i].customerPackageServices![i].count!}x ',
                                  style: TextStyle(
                                      color: colorFontUnable116116116,
                                      fontSize: size.height * .017),
                                  maxLines: 2,
                                ),
                                Text(
                                  widget
                                      .listScheduleItem[widget.i]
                                      .customerPackageServices![i]
                                      .barbershopServiceId!
                                      .serviceName!,
                                  style: TextStyle(
                                      color: colorFontUnable116116116,
                                      fontSize: size.height * .017),
                                  maxLines: 2,
                                ),
                              ],
                            ),
                          ),
                          const SizedBox(height: 10),
                          Visibility(
                            visible: !isNullOrEmpty(widget
                                .listScheduleItem[widget.i]
                                .customerPackageProducts!),
                            child: Text(
                              'Produtos:',
                              style: TextStyle(
                                color: !packageExpired
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
                            itemCount: widget.listScheduleItem[widget.i]
                                .customerPackageProducts!.length,
                            itemBuilder: (context, i) => Row(
                              children: [
                                Text(
                                  '${widget.listScheduleItem[widget.i].customerPackageProducts![i].count!}x ',
                                  style: TextStyle(
                                      color: colorFontUnable116116116,
                                      fontSize: size.height * .017),
                                  maxLines: 2,
                                ),
                                Text(
                                  widget
                                      .listScheduleItem[widget.i]
                                      .customerPackageProducts![i]
                                      .barbershopProductId!
                                      .productName!,
                                  style: TextStyle(
                                      color: colorFontUnable116116116,
                                      fontSize: size.height * .017),
                                  maxLines: 2,
                                ),
                              ],
                            ),
                          ),
                          const SizedBox(height: 15),
                          Text(
                            'Descrição',
                            style: TextStyle(
                              color: !packageExpired
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
                                color: Colors.grey,
                                fontSize: size.height * .020,
                              ),
                              maxLines: 6,
                              widget
                                  .listScheduleItem[widget.i]
                                  .customerPackagesBarbershopPackage!
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
          );
        },
      ),
    );
  }
}
