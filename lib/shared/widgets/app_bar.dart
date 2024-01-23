// Developer            Data              Decription
// Rovigo               22/08/2022        Circular progress creation

import 'package:auto_size_text/auto_size_text.dart';
import 'package:flutter/material.dart';

class AppBarPattern extends StatelessWidget implements PreferredSizeWidget {
  final bool backButton;
  final Size size;

  const AppBarPattern({
    Key? key,
    required this.backButton,
    required this.size,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return AppBar(
      leading: backButton
          ? IconButton(
              onPressed: () {
                Navigator.pop(context);
              },
              icon: const Icon(Icons.arrow_back_ios_new))
          : const SizedBox(),
      backgroundColor: Colors.transparent,
      title: Padding(
        padding: EdgeInsets.symmetric(
            horizontal: MediaQuery.of(context).size.width * 0.1),
        child: Center(
          child: AutoSizeText(
            'parametrizar',
            maxLines: 1,
            style: TextStyle(
              fontSize: MediaQuery.of(context).size.width * 0.06,
              shadows: const [
                Shadow(
                  blurRadius: 10,
                  offset: Offset(1, 1),
                  color: Color.fromARGB(255, 0, 0, 0),
                )
              ],
            ),
          ),
        ),
      ),
      elevation: 0,
    );
  }

  @override
  Size get preferredSize => Size(size.width, size.height * .08);
}
