import 'package:auto_size_text/auto_size_text.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';

import '../../../../../../../core/assets.dart';
import '../../../../../../../core/colors.dart';
import '../../../login/controller/login_controller.dart';
import '../../../schedule/schedule_page.dart';
import '../../../../shared/widgets/page_transition.dart';

class ServiceItem extends StatelessWidget {
  const ServiceItem({
    Key? key,
    required this.img,
    required this.name,
    required this.duration,
    required this.price,
    required this.description,
  }) : super(key: key);

  final String img;
  final String name;
  final int duration;
  final double price;
  final String description;

  @override
  Widget build(BuildContext context) {
    Size size = MediaQuery.of(context).size;
    return Consumer(
      builder: (BuildContext context, WidgetRef ref, Widget? child) {
        return GestureDetector(
            onTap: () {
              final loginController =
                  ref.read(LoginStateController.provider.notifier);

              if (loginController.user != null) {
                navigationFadePushReplacement(const SchedulePage(), context);
              }
            },
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
                        margin:
                            const EdgeInsets.only(left: 10, right: 10, top: 10),
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
                                    size: 12,
                                  ),
                                  Text(
                                    ' $duration min',
                                    style: const TextStyle(
                                      color: Colors.white,
                                      fontSize: 14,
                                    ),
                                  ),
                                ],
                              ),
                              SizedBox(width: size.width * 0.05),
                              Row(
                                children: [
                                  const Text(
                                    'R\$ ',
                                    style: TextStyle(
                                      color: Colors.white,
                                      fontSize: 14,
                                    ),
                                  ),
                                  Text(
                                    price
                                        .toStringAsFixed(2)
                                        .replaceAll('.', ','),
                                    style: const TextStyle(
                                      color: Colors.white,
                                      fontSize: 14,
                                    ),
                                  ),
                                ],
                              ),
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
            ));
      },
    );
  }
}
