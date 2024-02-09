import 'package:flutter/material.dart';

import 'package:navalha/web/appointment/widgets/drawer_body_web.dart';

class DrawerPageWeb extends StatefulWidget {
  const DrawerPageWeb({
    Key? key,
    required this.barberShopId,
  }) : super(key: key);

  final String barberShopId;

  static const route = '/drawer-page';

  @override
  State<DrawerPageWeb> createState() => _DrawerPageWebState();
}

class _DrawerPageWebState extends State<DrawerPageWeb> {
  @override
  Widget build(BuildContext context) {
    return DrawerBodyWeb(
      barberShopId: widget.barberShopId,
    );
  }
}
