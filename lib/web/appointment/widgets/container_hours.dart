import 'package:flutter/material.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';

class ContainerHoursWeb extends StatefulHookConsumerWidget {
  final String hour;
  bool selected;
  final double? dicount;
  final Function onPressed;

  ContainerHoursWeb({
    Key? key,
    required this.hour,
    required this.selected,
    this.dicount,
    required this.onPressed,
  }) : super(key: key);

  @override
  ConsumerState<ContainerHoursWeb> createState() => _ContainerHoursWebState();
}

class _ContainerHoursWebState extends ConsumerState<ContainerHoursWeb> {
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
                  : const Color.fromARGB(255, 20, 20, 20),
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
          widget.dicount != null
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
