import 'package:flutter/material.dart';

import 'widgets/drawer_web_body.dart';

class DrawerWebPage extends StatefulWidget {
  const DrawerWebPage({Key? key}) : super(key: key);

  static const route = '/drawer-page';

  @override
  State<DrawerWebPage> createState() => _DrawerWebPageState();
}

class _DrawerWebPageState extends State<DrawerWebPage> {
  @override
  Widget build(BuildContext context) {
    return const DrawerWebBody();
  }
}
