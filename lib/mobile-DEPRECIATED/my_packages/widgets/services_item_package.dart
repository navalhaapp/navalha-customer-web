import 'package:auto_size_text/auto_size_text.dart';
import 'package:flutter/material.dart';
import 'package:navalha/core/colors.dart';
import 'package:navalha/mobile-DEPRECIATED/my_packages/model/response_get_customer_packages.dart';
import '../../../core/assets.dart';
import '../../../core/images_s3.dart';

class ServicesItemMyPackage extends StatelessWidget {
  const ServicesItemMyPackage({
    Key? key,
    required this.i,
    required this.listProducts,
  }) : super(key: key);

  final int i;
  final List<CustomerPackageServices> listProducts;

  @override
  Widget build(BuildContext context) {
    Size size = MediaQuery.of(context).size;
    return Container(
      margin: EdgeInsets.only(
        left: size.height * 0.01,
        right: size.height * 0.01,
        top: i != 0 ? size.height * 0.02 : 0,
      ),
      decoration: BoxDecoration(
        borderRadius: const BorderRadius.vertical(
          top: Radius.circular(18),
          bottom: Radius.circular(18),
        ),
        color: colorContainers242424,
      ),
      child: Container(
        margin: EdgeInsets.only(
          bottom: size.height * .015,
          left: size.width * .03,
          right: size.width * .03,
        ),
        decoration: BoxDecoration(
          borderRadius: const BorderRadius.all(Radius.circular(18)),
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
                  margin: const EdgeInsets.only(left: 10, right: 10, top: 10),
                  width: MediaQuery.of(context).size.width * 0.12,
                  height: MediaQuery.of(context).size.width * 0.12,
                  child: ClipOval(
                    child: FadeInImage.assetNetwork(
                      placeholder: imgLoading3,
                      image:
                          '$baseUrlS3bucket${listProducts[i].barbershopServiceId!.serviceImgProfile!}',
                      fit: BoxFit.fill,
                    ),
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
                          width: size.width * 0.58,
                          child: AutoSizeText(
                            listProducts[i].barbershopServiceId!.serviceName!,
                            style: TextStyle(
                              color: Colors.white,
                              fontSize: size.height * .025,
                            ),
                          ),
                        ),
                      ],
                    ),
                    Text(
                      'Quantidade disponível: ${listProducts[i].count}',
                      style: const TextStyle(
                        color: Colors.white,
                        fontSize: 14,
                      ),
                    ),
                  ],
                )
              ],
            ),
            SizedBox(
              width: size.width * 0.90,
              child: Padding(
                padding: EdgeInsets.only(
                  top: size.height * 0.01,
                  left: size.width * .03,
                  bottom: size.height * 0.03,
                ),
                child: AutoSizeText(
                  style: TextStyle(
                    color: colorFontUnable116116116,
                    fontSize: size.height * .020,
                  ),
                  maxLines: 6,
                  listProducts[i].barbershopServiceId!.serviceDescription!,
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
