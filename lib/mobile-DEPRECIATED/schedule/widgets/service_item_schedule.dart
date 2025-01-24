import 'package:auto_size_text/auto_size_text.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

import '../../../../../../../core/assets.dart';
import '../../../../../../../core/colors.dart';
import '../../home/model/response_get_barber_shop_by_id.dart';

class ServiceItemSchedule extends StatelessWidget {
  const ServiceItemSchedule({
    Key? key,
    required this.img,
    required this.name,
    required this.duration,
    required this.price,
    required this.description,
    this.packageSelected,
    this.havePrice,
  }) : super(key: key);

  final String img;
  final String name;
  final String duration;
  final String price;
  final String description;
  final CustomerPackages? packageSelected;
  final bool? havePrice;

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
        // boxShadow: const [
        //   BoxShadow(
        //     blurRadius: 8,
        //     color: Color.fromARGB(255, 4, 4, 4),
        //     offset: Offset(5, 5),
        //   )
        // ],
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
                margin: const EdgeInsets.only(left: 10, right: 10, top: 10),
                width: MediaQuery.of(context).size.height * 0.09,
                height: MediaQuery.of(context).size.height * 0.09,
                child: ClipOval(
                  child: FadeInImage.assetNetwork(
                    placeholder: imgLoading3,
                    image: img,
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
                          name,
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
                          const Icon(
                            CupertinoIcons.clock_fill,
                            color: Colors.white,
                            size: 14,
                          ),
                          Text(
                            ' $duration',
                            style: const TextStyle(
                              color: Colors.white,
                              fontSize: 14,
                            ),
                          ),
                        ],
                      ),
                      SizedBox(width: size.width * 0.05),
                      havePrice == null
                          ? Text(
                              price,
                              style: const TextStyle(
                                color: Colors.white,
                                fontSize: 14,
                              ),
                            )
                          : const SizedBox()
                    ],
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
                description,
              ),
            ),
          ),
        ],
      ),
    );
  }
}
