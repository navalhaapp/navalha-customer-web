import 'package:flutter/cupertino.dart';

class CupertinoSwitchPattern extends StatefulWidget {
  const CupertinoSwitchPattern({super.key});

  @override
  State<CupertinoSwitchPattern> createState() => _CupertinoSwitchPatternState();
}

class _CupertinoSwitchPatternState extends State<CupertinoSwitchPattern> {
  bool switchValue = false;

  @override
  Widget build(BuildContext context) {
    return CupertinoSwitch(
      value: switchValue,
      activeColor: CupertinoColors.activeBlue,
      onChanged: (bool? value) {
        setState(() {
          switchValue = value ?? false;
        });
      },
    );
  }
}
