import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

import '../../core/colors.dart';

class CupertinoPickerList extends StatefulWidget {
  const CupertinoPickerList({
    Key? key,
    required this.list,
    required this.label,
    required this.color,
    required this.marginHorizontal,
    required this.picker,
    required this.textEdit,
    this.optional,
  }) : super(key: key);

  final List<String> list;
  final String label;
  final Color color;
  final double marginHorizontal;
  final CupertinoPicker picker;
  final String textEdit;
  final String? optional;

  @override
  State<CupertinoPickerList> createState() => _CupertinoPickerListState();
}

class _CupertinoPickerListState extends State<CupertinoPickerList> {
  void _showDialog(Widget child) {
    showCupertinoModalPopup<void>(
      context: context,
      builder: (BuildContext context) => SafeArea(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.end,
          children: [
            Container(
              decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(15),
                color: colorBackground181818,
              ),
              height: 216,
              padding: const EdgeInsets.only(top: 6.0),
              margin: EdgeInsets.only(
                left: 10,
                right: 10,
                bottom: MediaQuery.of(context).viewInsets.bottom,
              ),
              child: SafeArea(
                top: false,
                child: child,
              ),
            ),
            Container(
              margin: const EdgeInsets.symmetric(horizontal: 10, vertical: 10),
              width: MediaQuery.of(context).size.width * 0.98,
              height: MediaQuery.of(context).size.height * 0.05,
              color: Colors.transparent,
              child: ElevatedButton(
                style: ButtonStyle(
                  overlayColor: MaterialStateProperty.all<Color>(
                    colorContainers353535,
                  ),
                  shadowColor: MaterialStateProperty.all<Color>(Colors.black),
                  elevation: MaterialStateProperty.all<double>(10),
                  backgroundColor:
                      MaterialStateProperty.all<Color>(colorBackground181818),
                  shape: MaterialStateProperty.all<RoundedRectangleBorder>(
                    RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(15),
                    ),
                  ),
                ),
                child: const Padding(
                  padding: EdgeInsets.symmetric(horizontal: 10),
                  child: Text(
                    'Confirmar',
                    style: TextStyle(
                      color: Colors.white,
                      fontSize: 16,
                    ),
                  ),
                ),
                onPressed: () => Navigator.pop(context),
              ),
            )
          ],
        ),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: EdgeInsets.symmetric(
        horizontal: widget.marginHorizontal,
        vertical: MediaQuery.of(context).size.height * 0.01,
      ),
      decoration: BoxDecoration(
        color: widget.color,
        borderRadius: const BorderRadius.all(
          Radius.circular(20),
        ),
      ),
      height: MediaQuery.of(context).size.height * 0.11,
      width: MediaQuery.of(context).size.width,
      child: Padding(
        padding: EdgeInsets.only(
          left: MediaQuery.of(context).size.width * 0.05,
        ),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            widget.optional != null
                ? Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Text(
                        widget.label,
                        style: TextStyle(
                          color: Colors.white,
                          fontSize: MediaQuery.of(context).size.width * 0.045,
                        ),
                        textAlign: TextAlign.left,
                      ),
                      Padding(
                        padding: EdgeInsets.only(
                            right: MediaQuery.of(context).size.width * 0.05),
                        child: Text(
                          widget.optional!,
                          style: TextStyle(
                            color: Colors.white,
                            fontSize: MediaQuery.of(context).size.width * 0.035,
                          ),
                          textAlign: TextAlign.left,
                        ),
                      ),
                    ],
                  )
                : Text(
                    widget.label,
                    style: TextStyle(
                      color: Colors.white,
                      fontSize: MediaQuery.of(context).size.width * 0.045,
                    ),
                    textAlign: TextAlign.left,
                  ),
            CupertinoButton(
              onPressed: () => _showDialog(widget.picker),
              padding: EdgeInsets.only(
                right: MediaQuery.of(context).size.width * 0.0,
              ),
              child: Text(
                widget.textEdit,
                style: TextStyle(
                  fontSize: MediaQuery.of(context).size.width * 0.045,
                  color: colorWhite255255255,
                  fontStyle: FontStyle.normal,
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
