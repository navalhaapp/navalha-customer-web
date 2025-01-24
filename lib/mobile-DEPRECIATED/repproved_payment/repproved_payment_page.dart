import 'package:flutter/material.dart';
import 'package:navalha/mobile-DEPRECIATED/repproved_payment/widgets/repproved_payment_body.dart';
import '../../core/colors.dart';

class RepprovedPaymentPage extends StatelessWidget {
  static const route = '/repproved-payment-page';

  const RepprovedPaymentPage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return WillPopScope(
      onWillPop: () async {
        return false;
      },
      child: Scaffold(
        backgroundColor: colorBackground181818,
        body: const Center(
          child: SlideFadeTransition(
            curve: Curves.elasticOut,
            delayStart: Duration(milliseconds: 500),
            animationDuration: Duration(milliseconds: 2000),
            offset: -3.0,
            direction: Direction.vertical,
            child: SizedBox(
              height: 150,
              child: RepprovedPaymentBody(),
            ),
          ),
        ),
      ),
    );
  }
}
