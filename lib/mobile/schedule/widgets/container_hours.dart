import 'package:flutter/material.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:navalha/core/colors.dart';
import 'package:navalha/mobile/home/model/response_get_barber_shop_by_id.dart';

class ContainerHours extends StatefulHookConsumerWidget {
  final String hour;
  bool selected;
  final double? dicount;
  final Function onPressed;
  final CustomerPackages? packageSelected;
  ContainerHours({
    this.packageSelected,
    Key? key,
    required this.hour,
    required this.selected,
    this.dicount,
    required this.onPressed,
  }) : super(key: key);

  @override
  ConsumerState<ContainerHours> createState() => _ContainerHoursState();
}

class _ContainerHoursState extends ConsumerState<ContainerHours> {
  @override
  Widget build(BuildContext context) {
    Size size = MediaQuery.of(context).size;
    return GestureDetector(
      onTap: () {
        widget.onPressed();
        setState(() {
          widget.selected = !widget.selected;
        });
      },
      child: Stack(
        clipBehavior: Clip.none,
        children: [
          Container(
            margin: const EdgeInsets.only(top: 10),
            decoration: BoxDecoration(
              color: widget.selected
                  ? const Color.fromARGB(255, 230, 198, 18)
                  : colorContainers242424,
              borderRadius: BorderRadius.circular(10),
            ),
            child: Center(
              child: Text(
                widget.hour,
                style: TextStyle(
                  color: !widget.selected ? Colors.white : Colors.black,
                  fontSize: 17,
                  fontWeight: widget.selected ? FontWeight.bold : null,
                ),
              ),
            ),
          ),
          widget.dicount != null && widget.packageSelected == null
              ? Positioned(
                  left: size.width * 0.13,
                  child: Container(
                    height: size.height * 0.02,
                    width: size.height * 0.045,
                    decoration: BoxDecoration(
                      color: Colors.white,
                      borderRadius: BorderRadius.circular(5),
                    ),
                    child: Center(
                      child: Text(
                        '${widget.dicount!.toInt().toString()}%',
                        style: TextStyle(
                          color: Colors.black,
                          fontSize: size.width * 0.03,
                        ),
                      ),
                    ),
                  ),
                )
              : const SizedBox()
        ],
      ),
    );
  }
}
