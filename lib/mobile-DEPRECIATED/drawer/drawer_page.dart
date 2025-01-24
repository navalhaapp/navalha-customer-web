import 'package:flutter/material.dart';

import 'widgets/drawer_body.dart';

class DrawerPage extends StatefulWidget {
  const DrawerPage({Key? key}) : super(key: key);

  static const route = '/drawer-page';

  @override
  State<DrawerPage> createState() => _DrawerPageState();
}

class _DrawerPageState extends State<DrawerPage> {
  @override
  Widget build(BuildContext context) {
    return const DrawerBody();
  }
}
