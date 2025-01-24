import 'package:flutter/material.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:navalha/core/colors.dart';
import '../../../shared/model/package_model.dart';
import '../../../shared/providers.dart';
import '../../../shared/widgets/header_button_sheet_pattern.dart';
import '../../barbershop_page/widget/package_buy_item.dart';

class PackageBuyItemButtonSheet extends StatelessWidget {
  const PackageBuyItemButtonSheet({Key? key}) : super(key: key);

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
              var barberShopProvider =
                  ref.watch(barberShopSelectedProvider.state);
              final List<PackageModel> listPackages =
                  barberShopProvider.state.packageList!;
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
                        itemCount: listPackages.length,
                        itemBuilder: (context, i) => PackageContainerItem(
                          i: i,
                          packageList: listPackages,
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
