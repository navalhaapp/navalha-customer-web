// Developer            Data              Decription
// Rovigo               22/08/2022        Extracting backgroundLoginTop

import 'package:flutter/material.dart';
import 'package:navalha/shared/utils.dart';

import '../../../core/assets.dart';

class BackgroundLoginTop extends StatelessWidget {
  const BackgroundLoginTop({
    Key? key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      height: getSizeException(
          currentValue: MediaQuery.of(context).size.height * .33,
          exceptSize: 900,
          exceptValue: MediaQuery.of(context).size.height * .38,
          deviceSize: MediaQuery.of(context).size.height),
      width: MediaQuery.of(context).size.width,
      child: Opacity(
        opacity: 0.4,
        child: Image.asset(
          imgBackgroundBarberLogin,
          fit: BoxFit.cover,
        ),
      ),
    );
  }
}
