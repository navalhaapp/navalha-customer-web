import 'package:flutter/material.dart';

import '../../../../../../core/colors.dart';

class AboutUs extends StatelessWidget {
  final String description;
  const AboutUs({
    Key? key,
    required this.description,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    Size size = MediaQuery.of(context).size;
    return Container(
      margin: EdgeInsets.only(
        bottom: size.height * .015,
        left: size.width * .03,
        right: size.width * .03,
      ),
      decoration: BoxDecoration(
        // boxShadow: const [
        //   BoxShadow(
        //     blurRadius: 8,
        //     color: Color.fromARGB(255, 4, 4, 4),
        //     offset: Offset(5, 5),
        //   )
        // ],
        color: colorContainers242424,
        borderRadius: BorderRadius.circular(18),
      ),
      width: double.maxFinite,
      child: Padding(
        padding: const EdgeInsets.all(15.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start, //
          mainAxisSize: MainAxisSize.min,
          children: [
            Text(
              'Sobre nós',
              style:
                  TextStyle(color: Colors.white, fontSize: size.height * 0.025),
            ),
            const SizedBox(height: 5),
            Text(
              description,
              style: TextStyle(
                color: const Color.fromARGB(255, 182, 182, 182),
                fontSize: size.height * 0.02,
              ),
            ),
          ],
        ),
      ),
    );
  }
}
