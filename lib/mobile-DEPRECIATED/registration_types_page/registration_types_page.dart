// ignore_for_file: use_build_context_synchronously

import 'package:flutter/material.dart';
import 'package:navalha/mobile-DEPRECIATED/registration_types_page/widgets/registration_types_body.dart';
import '../../../core/colors.dart';

class RegistrationTypesPage extends StatelessWidget {
  static const route = '/permission-page';

  const RegistrationTypesPage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: colorBackground181818,
      body: const RegistrationTypesBody(),
    );
  }
}
