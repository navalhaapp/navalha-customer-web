import 'package:flutter/material.dart';

import 'package:navalha/approved_schedule/widgets/approved_schedule_body.dart';
import 'package:navalha/core/colors.dart';

class ApprovedSchedulePage extends StatelessWidget {

  const ApprovedSchedulePage({
    Key? key,
    required this.page,
    this.title,
    this.subTitle,
    required this.arguments,
  }) : super(key: key);
  final String page;
  final String? title;
  final String? subTitle;
  final Map<String, dynamic> arguments;

  @override
  Widget build(BuildContext context) {
    return WillPopScope(
      onWillPop: () async {
        return false;
      },
      child: Scaffold(
        backgroundColor: colorBackground181818,
        body: Center(
          child: SlideFadeTransition(
            page: page,
            curve: Curves.elasticOut,
            delayStart: const Duration(milliseconds: 500),
            animationDuration: const Duration(milliseconds: 3000),
            offset: -3.0,
            direction: Direction.vertical,
            args: arguments,
            child: SizedBox(
              height: 150,
              child: ApprovedScheduleBody(
                page: page,
                title: title,
                subTitle: subTitle,
              ),
            ),
          ),
        ),
      ),
    );
  }
}
