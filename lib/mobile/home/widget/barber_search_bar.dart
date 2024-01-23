// Developer            Data              Descrição
// Vitor Daniel         22/08/2022        search bar home page.

import 'package:flutter/material.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:navalha/mobile/change_location/change_location.dart';
import 'package:navalha/core/colors.dart';
import 'package:navalha/shared/animation/page_trasition.dart';

import '../../../shared/providers.dart';

class BarberSearchBar extends StatefulWidget {
  const BarberSearchBar({
    Key? key,
  }) : super(key: key);

  @override
  State<BarberSearchBar> createState() => _BarberSearchBarState();
}

class _BarberSearchBarState extends State<BarberSearchBar> {
  TextEditingController filterEditController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    Size size = MediaQuery.of(context).size;
    return Consumer(
      builder: (context, ref, child) {
        var textController = ref.watch(filterTextController.state);

        return Container(
          decoration: BoxDecoration(
            // boxShadow: shadow,
            color: colorContainers242424,
            borderRadius: BorderRadius.circular(18),
          ),
          height: 50,
          child: Row(
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              const Padding(
                padding: EdgeInsets.only(left: 15),
                child: Icon(
                  Icons.search,
                  color: Color.fromARGB(210, 133, 133, 133),
                ),
              ),
              SizedBox(
                width: size.width * 0.66,
                child: Padding(
                  padding: const EdgeInsets.only(left: 15),
                  child: TextFormField(
                    controller: filterEditController,
                    onChanged: (filterEditController) {
                      textController.state = filterEditController;
                    },
                    style: TextStyle(
                      fontSize: MediaQuery.of(context).size.width * 0.050,
                      color: Colors.white,
                    ),
                    decoration: const InputDecoration(
                      hintText: 'Procurar',
                      hintStyle: TextStyle(
                        color: Color.fromARGB(255, 119, 119, 119),
                      ),
                      border: InputBorder.none,
                    ),
                  ),
                ),
              ),
            ],
          ),
        );
      },
    );
  }
}

class ButtonChangeLocation extends StatelessWidget {
  const ButtonChangeLocation({
    Key? key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    Size size = MediaQuery.of(context).size;
    return GestureDetector(
      onTap: () =>
          navigationWithFadeAnimation(const ChangeLocations(), context),
      child: Container(
        width: size.width * .15,
        height: 50,
        decoration: BoxDecoration(
          // boxShadow: shadow,
          color: colorContainers242424,
          borderRadius: BorderRadius.circular(18),
        ),
        child: const Icon(
          Icons.edit_location_alt_rounded,
          color: Colors.white,
        ),
      ),
    );
  }
}
