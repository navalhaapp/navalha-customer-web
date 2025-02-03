import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:navalha/web/utils/utils.dart';

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
              decoration: const BoxDecoration(
                color: Color.fromARGB(255, 30, 30, 30),
                borderRadius: BorderRadius.all(
                  Radius.circular(15),
                ),
              ),
              height: 216,
              padding: const EdgeInsets.only(top: 6.0),
              margin: NavalhaUtils().calculateDialogPadding(context),
              child: SafeArea(
                top: false,
                child: child,
              ),
            ),
            const SizedBox(height: 5),
            Container(
              margin: NavalhaUtils().calculateDialogPadding(context),
              height: MediaQuery.of(context).size.height * 0.05,
              color: Colors.transparent,
              child: ElevatedButton(
                style: ButtonStyle(
                  overlayColor: WidgetStateProperty.all<Color>(
                    colorBrown626262,
                  ),
                  shadowColor: WidgetStateProperty.all<Color>(Colors.black),
                  elevation: WidgetStateProperty.all<double>(10),
                  backgroundColor:
                      WidgetStateProperty.all<Color>(colorContainers242424),
                  shape: WidgetStateProperty.all<RoundedRectangleBorder>(
                    RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(15),
                    ),
                  ),
                ),
                child: const Padding(
                  padding: EdgeInsets.symmetric(horizontal: 10),
                  child: Center(
                    child: Text(
                      'Confirmar',
                      style: TextStyle(
                        color: Colors.white,
                        fontSize: 16,
                      ),
                    ),
                  ),
                ),
                onPressed: () => Navigator.pop(context),
              ),
            ),
            const SizedBox(height: 5),
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
        padding: const EdgeInsets.only(left: 20),
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
                        style: const TextStyle(
                          color: Colors.white,
                        ),
                        textAlign: TextAlign.left,
                      ),
                      Padding(
                        padding: const EdgeInsets.only(right: 20),
                        child: Text(
                          widget.optional!,
                          style: const TextStyle(
                            color: Colors.white,
                            fontSize: 12,
                          ),
                          textAlign: TextAlign.left,
                        ),
                      ),
                    ],
                  )
                : Text(
                    widget.label,
                    style: const TextStyle(
                      color: Colors.white,
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
                  color: colorFontUnable116116116,
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
