import 'package:flutter/material.dart';
import 'package:navalha/core/colors.dart';
import 'package:navalha/mobile/delete_account/widgets/delete_account_body.dart';

import '../drawer/drawer_page.dart';

class DeleteAccountPage extends StatelessWidget {
  const DeleteAccountPage({super.key});

  static const route = '/delete-account-page';

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      top: false,
      child: Scaffold(
        backgroundColor: colorBackground181818,
        appBar: AppBar(
          centerTitle: true,
          leading: GestureDetector(
            onTap: () => Navigator.pop(context),
            child: const Icon(
              Icons.arrow_back_ios_rounded,
              size: 17,
            ),
          ),
          title: const Text(
            'Excluir Conta',
            style: TextStyle(color: Colors.white),
          ),
          elevation: 0,
          backgroundColor: Colors.transparent,
        ),
        body: const DeleteAccountBody(),
        endDrawer: const DrawerPage(),
      ),
    );
  }
}
