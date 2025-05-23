import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import '../../core/colors.dart';

class CupertinoDataPicker extends StatefulWidget {
  const CupertinoDataPicker({
    Key? key,
    required this.label,
    required this.color,
    required this.marginHorizontal,
    required this.date,
    required this.picker,
  }) : super(key: key);

  final String label;
  final Color color;
  final double marginHorizontal;
  final CupertinoDatePicker picker;
  final DateTime? date;

  @override
  State<CupertinoDataPicker> createState() => _CupertinoDataPickerState();
}

class _CupertinoDataPickerState extends State<CupertinoDataPicker> {
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
              padding: const EdgeInsets.all(10),
              child: SafeArea(
                top: false,
                child: child,
              ),
            ),
            Container(
              margin: const EdgeInsets.symmetric(horizontal: 10, vertical: 10),
              width: 500,
              height: MediaQuery.of(context).size.height * 0.05,
              color: Colors.transparent,
              child: ElevatedButton(
                style: ButtonStyle(
                  overlayColor: MaterialStateProperty.all<Color>(
                    colorContainers353535,
                  ),
                  shadowColor: MaterialStateProperty.all<Color>(Colors.black),
                  elevation: MaterialStateProperty.all<double>(1),
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
                    style: TextStyle(color: Colors.white, fontSize: 16),
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
      ),
      decoration: BoxDecoration(
        color: widget.color,
        borderRadius: BorderRadius.circular(15),
      ),
      height: MediaQuery.of(context).size.height * 0.11,
      width: MediaQuery.of(context).size.width,
      child: Padding(
        padding: const EdgeInsets.only(left: 20),
        child: Column(
          mainAxisSize: MainAxisSize.min,
          mainAxisAlignment: MainAxisAlignment.center,
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              widget.label,
              style: const TextStyle(
                color: Colors.white,
              ),
              textAlign: TextAlign.left,
            ),
            CupertinoButton(
              onPressed: () => _showDialog(
                SizedBox(
                  child: CupertinoTheme(
                    data: const CupertinoThemeData(
                      textTheme: CupertinoTextThemeData(
                        dateTimePickerTextStyle: TextStyle(
                          color: Colors.white,
                          wordSpacing: 10,
                        ),
                        primaryColor: Colors.white,
                      ),
                    ),
                    child: widget.picker,
                  ),
                ),
              ),
              padding: EdgeInsets.zero,
              child: Text(
                widget.date == null
                    ? 'Selecione uma data'
                    : '${widget.date!.day} / ${widget.date!.month} / ${widget.date!.year}',
                style: TextStyle(
                  color: widget.date == null
                      ? colorFontUnable116116116
                      : colorWhite255255255,
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
