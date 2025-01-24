import 'package:flutter/material.dart';
import 'package:navalha/core/colors.dart';
import 'package:navalha/shared/model/package_model.dart';
import 'count_item_items.dart';

class AditionalItemItem extends StatelessWidget {
  const AditionalItemItem({
    Key? key,
    required this.i,
    required this.package,
  }) : super(key: key);

  final int i;
  final List<BarbershopPackageItems> package;

  @override
  Widget build(BuildContext context) {
    Size size = MediaQuery.of(context).size;
    return Container(
      margin: EdgeInsets.only(
        bottom: size.height * .015,
        left: size.width * .03,
        right: size.width * .03,
      ),
      decoration: BoxDecoration(
        color: colorContainers242424,
        borderRadius: BorderRadius.circular(14),
      ),
      child: Padding(
        padding: EdgeInsets.symmetric(
          horizontal: size.width * 0.04,
          vertical: size.height * 0.005,
        ),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Column(
              mainAxisAlignment: MainAxisAlignment.start,
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  '${package[i].barberShopProductId!.productName}',
                  style: TextStyle(
                    color: Colors.white,
                    fontSize: size.width * 0.035,
                  ),
                ),
                Text(
                  '+ R\$ ${package[i].barbershopPackageItemPrice!.toStringAsFixed(2).replaceAll('.', ',')}',
                  style: TextStyle(
                    color: colorFontUnable116116116,
                    fontSize: size.width * 0.035,
                  ),
                ),
              ],
            ),
            CountItem(i: i),
          ],
        ),
      ),
    );
  }
}
