import 'package:flutter/material.dart';
import 'package:navalha/core/colors.dart';
import 'package:shimmer/shimmer.dart';

class ShimmerFaq extends StatefulWidget {
  const ShimmerFaq({super.key});

  @override
  ShimmerFaqState createState() => ShimmerFaqState();
}

class ShimmerFaqState extends State<ShimmerFaq> {
  final bool _enabled = true;

  @override
  Widget build(BuildContext context) {
    Size size = MediaQuery.of(context).size;
    return Container(
      color: colorBackground181818,
      width: double.infinity,
      padding: const EdgeInsets.symmetric(horizontal: 16.0, vertical: 16.0),
      child: Column(
        mainAxisSize: MainAxisSize.max,
        children: <Widget>[
          Shimmer.fromColors(
            baseColor: const Color.fromARGB(150, 18, 18, 18),
            highlightColor: const Color.fromARGB(150, 58, 58, 58),
            enabled: _enabled,
            child: SafeArea(
              child: SingleChildScrollView(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.center,
                  children: [
                    Container(
                      margin: const EdgeInsets.symmetric(vertical: 10),
                      height: size.height * 0.1,
                      width: size.width * 0.97,
                      decoration: const BoxDecoration(
                        borderRadius: BorderRadius.all(Radius.circular(15)),
                        color: Color.fromARGB(255, 172, 172, 172),
                      ),
                    ),
                    Container(
                      margin: const EdgeInsets.symmetric(vertical: 10),
                      height: size.height * 0.1,
                      width: size.width * 0.97,
                      decoration: const BoxDecoration(
                        borderRadius: BorderRadius.all(Radius.circular(15)),
                        color: Color.fromARGB(255, 172, 172, 172),
                      ),
                    ),
                    Container(
                      margin: const EdgeInsets.symmetric(vertical: 10),
                      height: size.height * 0.1,
                      width: size.width * 0.97,
                      decoration: const BoxDecoration(
                        borderRadius: BorderRadius.all(Radius.circular(15)),
                        color: Color.fromARGB(255, 172, 172, 172),
                      ),
                    ),
                    Container(
                      margin: const EdgeInsets.symmetric(vertical: 10),
                      height: size.height * 0.1,
                      width: size.width * 0.97,
                      decoration: const BoxDecoration(
                        borderRadius: BorderRadius.all(Radius.circular(15)),
                        color: Color.fromARGB(255, 172, 172, 172),
                      ),
                    ),
                    Container(
                      margin: const EdgeInsets.symmetric(vertical: 10),
                      height: size.height * 0.1,
                      width: size.width * 0.97,
                      decoration: const BoxDecoration(
                        borderRadius: BorderRadius.all(Radius.circular(15)),
                        color: Color.fromARGB(255, 172, 172, 172),
                      ),
                    ),
                    Container(
                      margin: const EdgeInsets.symmetric(vertical: 10),
                      height: size.height * 0.1,
                      width: size.width * 0.97,
                      decoration: const BoxDecoration(
                        borderRadius: BorderRadius.all(Radius.circular(15)),
                        color: Color.fromARGB(255, 172, 172, 172),
                      ),
                    ),
                    Container(
                      margin: const EdgeInsets.symmetric(vertical: 10),
                      height: size.height * 0.1,
                      width: size.width * 0.97,
                      decoration: const BoxDecoration(
                        borderRadius: BorderRadius.all(Radius.circular(15)),
                        color: Color.fromARGB(255, 172, 172, 172),
                      ),
                    ),
                  ],
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }
}
