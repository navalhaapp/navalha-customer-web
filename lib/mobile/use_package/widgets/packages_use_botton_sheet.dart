import 'package:flutter/material.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:navalha/core/colors.dart';
import '../../home/model/response_get_barber_shop_by_id.dart';
import '../../../shared/widgets/header_button_sheet_pattern.dart';
import 'package_use_item.dart';

class PackageUseButtonSheet extends StatelessWidget {
  final List<CustomerPackages>? listPackagesUser;

  const PackageUseButtonSheet({
    Key? key,
    this.listPackagesUser,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    Size size = MediaQuery.of(context).size;

    return SafeArea(
      minimum: EdgeInsets.only(top: size.height * 0.04),
      child: Scaffold(
        bottomSheet: GestureDetector(
          onTap: () {},
          child: Consumer(
            builder: (context, ref, child) {
              return Container(
                color: colorBackground181818,
                child: SingleChildScrollView(
                  child: Column(
                    mainAxisSize: MainAxisSize.min,
                    children: [
                      const HeaderBottonSheetPattern(),
                      Text(
                        'Escolha um pacote',
                        style: TextStyle(
                            color: Colors.white, fontSize: size.width * 0.04),
                      ),
                      const SizedBox(height: 10),
                      ListView.builder(
                        padding: EdgeInsets.zero,
                        shrinkWrap: true,
                        physics: const NeverScrollableScrollPhysics(),
                        itemCount: listPackagesUser!.length,
                        itemBuilder: (context, i) => PackageUseContainerItem(
                          i: i,
                          packageList: listPackagesUser!,
                        ),
                      ),
                      const SizedBox(height: 20)
                    ],
                  ),
                ),
              );
            },
          ),
        ),
      ),
    );
  }
}
