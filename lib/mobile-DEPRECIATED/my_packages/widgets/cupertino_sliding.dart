import 'package:flutter/cupertino.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:navalha/core/colors.dart';
import '../../../../../../shared/providers.dart';

enum EnumPackageService { services, products }

class SlidingServicePackage extends StatefulWidget {
  const SlidingServicePackage({super.key, required this.onSegmentChanged});

  final void Function(EnumPackageService) onSegmentChanged;

  @override
  State<SlidingServicePackage> createState() => _SlidingServicePackageState();
}

class _SlidingServicePackageState extends State<SlidingServicePackage> {
  @override
  Widget build(BuildContext context) {
    Size size = MediaQuery.of(context).size;
    return Consumer(
      builder: (context, ref, child) {
        final tabServicePackageController =
            ref.watch(tabServicePackageProvider.state);
        return Padding(
          padding: EdgeInsets.symmetric(
            horizontal: size.width * .03,
          ),
          child: CupertinoSlidingSegmentedControl<EnumPackageService>(
            backgroundColor: colorContainers242424,
            thumbColor: colorYellow25020050,
            // This represents the currently selected segmented control.
            groupValue: tabServicePackageController.state,
            // Callback that sets the selected segmented control.
            onValueChanged: (EnumPackageService? value) {
              if (value != null) {
                setState(() {
                  widget.onSegmentChanged(value);
                  tabServicePackageController.state = value;
                });
              }
            },

            children: <EnumPackageService, Widget>{
              EnumPackageService.products: Padding(
                padding: const EdgeInsets.symmetric(horizontal: 20),
                child: SizedBox(
                  width: double.maxFinite,
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Icon(
                        CupertinoIcons.cube_box_fill,
                        size: size.width * 0.037,
                        color: tabServicePackageController.state ==
                                EnumPackageService.products
                            ? CupertinoColors.black
                            : CupertinoColors.white,
                      ),
                      const SizedBox(width: 10),
                      Text(
                        textAlign: TextAlign.center,
                        'Produtos',
                        style: TextStyle(
                          fontSize: size.width * 0.033,
                          color: tabServicePackageController.state ==
                                  EnumPackageService.products
                              ? CupertinoColors.black
                              : CupertinoColors.white,
                        ),
                      ),
                    ],
                  ),
                ),
              ),
              EnumPackageService.services: Padding(
                padding: const EdgeInsets.symmetric(horizontal: 20),
                child: SizedBox(
                  width: double.maxFinite,
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Icon(
                        CupertinoIcons.scissors,
                        size: size.width * 0.037,
                        color: tabServicePackageController.state ==
                                EnumPackageService.services
                            ? CupertinoColors.black
                            : CupertinoColors.white,
                      ),
                      const SizedBox(width: 10),
                      Text(
                        textAlign: TextAlign.center,
                        'Serviços',
                        style: TextStyle(
                          fontSize: size.width * 0.033,
                          color: tabServicePackageController.state ==
                                  EnumPackageService.services
                              ? CupertinoColors.black
                              : CupertinoColors.white,
                        ),
                      ),
                    ],
                  ),
                ),
              ),
            },
          ),
        );
      },
    );
  }
}
