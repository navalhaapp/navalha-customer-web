import 'package:auto_size_text/auto_size_text.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:qr_flutter/qr_flutter.dart';
import 'package:navalha/core/assets.dart';
import 'package:navalha/core/colors.dart';
import 'package:navalha/core/images_s3.dart';
import 'package:navalha/mobile/my_packages/my_packages_page.dart';
import 'package:navalha/shared/shimmer/shimmer_top_container.dart';
import 'package:navalha/shared/shows_dialogs/dialog.dart';
import '../../schedule/widgets/orientation_verification_service_dialog.dart';
import '../../../shared/widgets/button_pattern_botton_sheet.dart';
import '../../../shared/widgets/page_transition.dart';
import '../model/response_get_customer_packages.dart';

class ProductsItemMyPackage extends StatelessWidget {
  const ProductsItemMyPackage({
    Key? key,
    required this.i,
    required this.listProducts,
    required this.birthDate,
  }) : super(key: key);

  final int i;
  final List<CustomerPackageProducts> listProducts;
  final String birthDate;

  @override
  Widget build(BuildContext context) {
    Size size = MediaQuery.of(context).size;
    return Column(
      children: [
        Container(
          margin: EdgeInsets.only(
            left: size.height * 0.01,
            right: size.height * 0.01,
            top: i != 0 ? size.height * 0.02 : 0,
          ),
          decoration: BoxDecoration(
            borderRadius: const BorderRadius.vertical(
              top: Radius.circular(15),
              // bottom: Radius.circular(18),
            ),
            color: colorContainers242424,
          ),
          child: Container(
            margin: EdgeInsets.only(
              bottom:
                  listProducts[i].barbershopProductId!.productDescription! == ""
                      ? size.height * 0
                      : size.height * .01,
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
                      margin:
                          const EdgeInsets.only(left: 10, right: 10, top: 10),
                      width: MediaQuery.of(context).size.width * 0.12,
                      height: MediaQuery.of(context).size.width * 0.12,
                      child: ClipOval(
                        child: FadeInImage.assetNetwork(
                          placeholder: imgLoading3,
                          image:
                              '$baseUrlS3bucketProduct${listProducts[i].barbershopProductId!.productImgProfile!}',
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
                                listProducts[i]
                                    .barbershopProductId!
                                    .productName!,
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
                Padding(
                  padding: EdgeInsets.only(
                    top: listProducts[i]
                                .barbershopProductId!
                                .productDescription! ==
                            ""
                        ? size.height * 0
                        : size.height * 0.01,
                    left: size.width * .03,
                  ),
                  child: AutoSizeText(
                    style: TextStyle(
                      color: colorFontUnable116116116,
                      fontSize: size.height * .020,
                    ),
                    maxLines: 6,
                    listProducts[i].barbershopProductId!.productDescription!,
                  ),
                ),
              ],
            ),
          ),
        ),
        _ContainerActive(birthDate: birthDate, qrCode: listProducts[i].qrCode!)
      ],
    );
  }
}

class _ContainerActive extends StatelessWidget {
  const _ContainerActive({
    Key? key,
    required this.qrCode,
    required this.birthDate,
  }) : super(key: key);

  final String qrCode;
  final String birthDate;

  @override
  Widget build(BuildContext context) {
    final size = MediaQuery.of(context).size;

    return Container(
      height: 35,
      width: size.width,
      margin: EdgeInsets.only(
        left: size.height * 0.01,
        right: size.height * 0.01,
      ),
      decoration: BoxDecoration(
        borderRadius: const BorderRadius.vertical(bottom: Radius.circular(18)),
        color: colorContainers353535,
      ),
      child: Row(
        children: [
          Expanded(
            child: TextButton(
              style: TextButton.styleFrom(
                elevation: 0,
                foregroundColor: const Color.fromARGB(255, 36, 36, 36),
              ),
              onPressed: () => {
                showCustomDialog(
                  context,
                  AlertDialog(
                    // title: SizedBox(
                    //   height: size.height * 0.26,
                    //   width: size.width * 0.15,
                    //   child: QrImage(
                    //     backgroundColor: colorBackground181818,
                    //     foregroundColor: Colors.white,
                    //     data: qrCode,
                    //     version: 1,
                    //     gapless: false,
                    //     errorStateBuilder: (cxt, err) {
                    //       return Center(
                    //         child: Column(
                    //           mainAxisAlignment: MainAxisAlignment.spaceAround,
                    //           children: [
                    //             Icon(
                    //               Icons.error,
                    //               size: size.height * 0.15,
                    //               color: colorWhite255255255,
                    //             ),
                    //             Text(
                    //               "Não foi possível gerar o código de check-in",
                    //               textAlign: TextAlign.center,
                    //               style: TextStyle(color: colorWhite255255255),
                    //             ),
                    //           ],
                    //         ),
                    //       );
                    //     },
                    //   ),
                    // ),
                    content: Column(
                      children: [
                        const Text(
                          textAlign: TextAlign.center,
                          'Código alternativo',
                          style: TextStyle(color: Colors.white, fontSize: 24),
                        ),
                        Text(
                          textAlign: TextAlign.center,
                          'Data de nascimento',
                          style: TextStyle(
                              color: colorFontUnable116116116, fontSize: 15),
                        ),
                        Container(
                          margin: const EdgeInsets.only(top: 10),
                          decoration: BoxDecoration(
                            borderRadius: BorderRadius.circular(18),
                            color: colorYellow25020050,
                          ),
                          child: Padding(
                            padding: const EdgeInsets.all(8.0),
                            child: Text(
                              textAlign: TextAlign.center,
                              formatarData(birthDate),
                              style: const TextStyle(
                                color: Colors.black,
                                fontSize: 22,
                                fontWeight: FontWeight.bold,
                              ),
                            ),
                          ),
                        ),
                      ],
                    ),
                    shape: const RoundedRectangleBorder(
                      borderRadius: BorderRadius.all(
                        Radius.circular(32.0),
                      ),
                    ),
                    scrollable: true,
                    actionsAlignment: MainAxisAlignment.center,
                    backgroundColor: colorBackground181818,
                    actions: [
                      ButtonPattern(
                        width: size.width * 0.41,
                        color: colorContainers242424,
                        child: const Text(
                          'Fechar',
                          style: TextStyle(fontSize: 15, color: Colors.white),
                        ),
                        onPressed: () {
                          navigationFadePush(
                              const ShimmerTopContainer(), context);
                          navigationFadePush(const MyPackagesPage(), context);
                        },
                      ),
                    ],
                  ),
                )
              },
              child: Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  const Text(
                    textAlign: TextAlign.center,
                    'Confirmar retirada',
                    style: TextStyle(
                      color: Colors.white,
                    ),
                  ),
                  const SizedBox(width: 10),
                  Icon(
                    CupertinoIcons.qrcode,
                    color: Colors.white,
                    size: size.height * 0.02,
                  )
                ],
              ),
            ),
          )
        ],
      ),
    );
  }
}
