import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:navalha/core/assets.dart';
import 'package:navalha/shared/widgets/top_container_star.dart';
import '../../../core/colors.dart';
import '../../../shared/model/barber_shop_model.dart';
import '../../../shared/providers.dart';
import '../tab_details/tab_details.dart';
import '../tab_hours/tab_hours.dart';
import '../tab_professionals/tab_professionals.dart';
import '../tab_reviews/tab_reviews.dart';
import '../tab_services/tab_services.dart';

class BarbershopBody extends HookConsumerWidget {
  final BarberShop barberShop;
  const BarbershopBody({Key? key, required this.barberShop}) : super(key: key);

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final indexBarberShopPage = ref.watch(indexBarberShopPageProvider.state);
    void setIndex(int index) => indexBarberShopPage.state = index;

    return SingleChildScrollView(
      child: Column(
        children: [
          TopContainerPatternStar(
            rating: barberShop.rating!,
            imgProfile: barberShop.imgProfile!,
            imgBackGround: barberShop.imgBackground,
          ),
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceAround,
            children: [
              _BarberShopPage(
                icon: CupertinoIcons.ellipsis,
                onTap: () => setIndex(0),
                buttonName: 'Detalhes',
                focusedOption: indexBarberShopPage.state == 0,
              ),
              _BarberShopPage(
                icon: CupertinoIcons.person_3_fill,
                onTap: () => setIndex(1),
                buttonName: 'Profissionais',
                focusedOption: indexBarberShopPage.state == 1,
              ),
              _BarberShopPage(
                icon: CupertinoIcons.scissors,
                onTap: () => setIndex(2),
                buttonName: 'Serviços',
                focusedOption: indexBarberShopPage.state == 2,
              ),
              _BarberShopPage(
                icon: CupertinoIcons.captions_bubble_fill,
                onTap: () => setIndex(3),
                buttonName: 'Comentários',
                focusedOption: indexBarberShopPage.state == 3,
              ),
              _BarberShopPage(
                icon: CupertinoIcons.clock_fill,
                onTap: () => setIndex(4),
                buttonName: 'Horários',
                focusedOption: indexBarberShopPage.state == 4,
              ),
            ],
          ),
          if (indexBarberShopPage.state == 0)
            TabDetails(barberShop: barberShop)
          else if (indexBarberShopPage.state == 1)
            TabProfessional(barberShop: barberShop)
          else if (indexBarberShopPage.state == 2)
            TabServices(barberShop: barberShop)
          else if (indexBarberShopPage.state == 3)
            TabReviews(barberShop: barberShop)
          else if (indexBarberShopPage.state == 4)
            TabHours(barberShop: barberShop)
          else
            TabDetails(barberShop: barberShop),
          SizedBox(height: MediaQuery.of(context).size.height * 0.2)
        ],
      ),
    );
  }
}

class _BarberShopPage extends StatelessWidget {
  final IconData? icon;
  final Function onTap;
  final bool focusedOption;

  const _BarberShopPage({
    Key? key,
    this.icon,
    required this.onTap,
    required this.focusedOption,
    required this.buttonName,
  }) : super(key: key);

  final String buttonName;
  @override
  Widget build(BuildContext context) {
    Size size = MediaQuery.of(context).size;
    return Column(
      children: [
        GestureDetector(
          onTap: () {
            onTap();
          },
          child: Container(
            height: 50,
            margin: const EdgeInsets.only(bottom: 5),
            decoration: BoxDecoration(
                color: colorContainers242424,
                borderRadius: BorderRadius.circular(18)),
            width: size.width * .15,
            child: Center(
              child: AnimatedContainer(
                curve: Curves.linear,
                duration: const Duration(milliseconds: 130),
                height: focusedOption ? 40 : 35,
                child: Icon(
                  icon,
                  color: focusedOption
                      ? const Color.fromARGB(255, 255, 255, 255)
                      : const Color.fromARGB(255, 125, 125, 125),
                  size: focusedOption ? size.width * 0.07 : size.width * 0.06,
                ),
              ),
            ),
          ),
        ),
        Padding(
          padding: const EdgeInsets.only(bottom: 10),
          child: Text(
            buttonName,
            style: TextStyle(
              shadows: shadow,
              color: focusedOption ? Colors.white : colorFontUnable116116116,
              fontSize: size.width * 0.03,
            ),
          ),
        ),
      ],
    );
  }
}
