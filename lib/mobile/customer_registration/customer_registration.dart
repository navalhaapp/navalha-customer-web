import 'package:flutter/material.dart';
import '../../core/colors.dart';
import 'widgets/customer_edit_body.dart';

class CustomerRegistrationPage extends StatelessWidget {
  const CustomerRegistrationPage({Key? key}) : super(key: key);

  static const route = '/customer-registration-page';

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: colorBackground181818,
      body: const CustomerRegistrationBody(),
    );
  }
}
