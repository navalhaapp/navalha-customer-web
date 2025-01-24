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
  Color _containerColor = const Color.fromARGB(255, 28, 28, 28);
  @override
  Widget build(BuildContext context) {
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
          MouseRegion(
            onEnter: (_) {
              setState(() =>
                  _containerColor = const Color.fromARGB(255, 40, 40, 40));
            },
            onExit: (_) {
              setState(() =>
                  _containerColor = const Color.fromARGB(255, 28, 28, 28));
            },
            child: Container(
              margin: const EdgeInsets.only(top: 10),
              decoration: BoxDecoration(
                color: widget.selected
                    ? const Color.fromARGB(255, 230, 198, 18)
                    : _containerColor,
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
          ),
          widget.dicount != null
              ? Positioned(
                  right: -5,
                  top: -2,
                  child: Container(
                    decoration: BoxDecoration(
                      color: Colors.white,
                      borderRadius: BorderRadius.circular(5),
                    ),
                    child: Center(
                      child: Padding(
                        padding: const EdgeInsets.symmetric(
                            horizontal: 5, vertical: 2),
                        child: Text(
                          '${widget.dicount!.toInt().toString()}%',
                          style: const TextStyle(
                            color: Colors.black,
                            fontSize: 17,
                          ),
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
