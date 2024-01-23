import 'package:auto_size_text/auto_size_text.dart';
import 'package:flutter/material.dart';
import 'package:navalha/core/colors.dart';

class ExpandedFaq extends StatefulWidget {
  final String title;
  final String description;
  final double sizeNotExpanded;
  final double sizeExpanded;
  const ExpandedFaq({
    Key? key,
    required this.title,
    required this.description,
    required this.sizeNotExpanded,
    required this.sizeExpanded,
  }) : super(key: key);

  @override
  State<ExpandedFaq> createState() => ExpandedFaqState();
}

class ExpandedFaqState extends State<ExpandedFaq> {
  bool isTapped = true;
  bool isExpanded = false;
  @override
  Widget build(BuildContext context) {
    final size = MediaQuery.of(context).size;
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 5),
      child: InkWell(
        highlightColor: Colors.transparent,
        splashColor: Colors.transparent,
        onTap: () {
          setState(() {
            isTapped = !isTapped;
          });
        },
        onHighlightChanged: (value) {
          setState(() {
            isExpanded = value;
          });
        },
        child: AnimatedContainer(
          alignment: Alignment.center,
          duration: const Duration(seconds: 1),
          curve: Curves.fastLinearToSlowEaseIn,
          width: isExpanded ? size.width * 0.95 : size.width * 0.96,
          decoration: BoxDecoration(
            color: colorContainers242424,
            borderRadius: const BorderRadius.all(
              Radius.circular(20),
            ),
          ),
          child: isTapped
              ? Column(
                  mainAxisSize: MainAxisSize.min,
                  mainAxisAlignment: MainAxisAlignment.start,
                  children: [
                    Padding(
                      padding: const EdgeInsets.symmetric(
                          horizontal: 20, vertical: 10),
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          SizedBox(
                            width: size.width * 0.75,
                            child: AutoSizeText(
                              widget.title,
                              style: const TextStyle(
                                color: Colors.white,
                                fontSize: 16,
                                fontWeight: FontWeight.w400,
                              ),
                            ),
                          ),
                          Icon(
                            isTapped
                                ? Icons.keyboard_arrow_down
                                : Icons.keyboard_arrow_up,
                            color: Colors.white,
                            size: 27,
                          ),
                        ],
                      ),
                    ),
                  ],
                )
              : Column(
                  children: [
                    Padding(
                      padding: const EdgeInsets.symmetric(
                        horizontal: 20,
                        vertical: 10,
                      ),
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          SizedBox(
                            width: size.width * 0.75,
                            child: AutoSizeText(
                              widget.title,
                              style: const TextStyle(
                                color: Colors.white,
                                fontSize: 16,
                                fontWeight: FontWeight.w400,
                              ),
                            ),
                          ),
                          Icon(
                            isTapped
                                ? Icons.keyboard_arrow_down
                                : Icons.keyboard_arrow_up,
                            color: Colors.white,
                            size: 27,
                          ),
                        ],
                      ),
                    ),
                    const SizedBox(
                      height: 20,
                    ),
                    Padding(
                      padding: const EdgeInsets.symmetric(
                          horizontal: 20, vertical: 20),
                      child: Text(
                        isTapped ? '' : widget.description,
                        style: TextStyle(
                          color: Colors.white.withOpacity(0.9),
                          fontSize: 17,
                          fontWeight: FontWeight.w400,
                        ),
                      ),
                    ),
                  ],
                ),
        ),
      ),
    );
  }
}
