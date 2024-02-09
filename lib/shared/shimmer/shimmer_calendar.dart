import 'package:flutter/material.dart';
import 'package:shimmer/shimmer.dart';

class ShimmerCalendar extends StatefulWidget {
  const ShimmerCalendar({super.key});

  @override
  ShimmerCalendarState createState() => ShimmerCalendarState();
}

class ShimmerCalendarState extends State<ShimmerCalendar> {
  final bool _enabled = true;

  @override
  Widget build(BuildContext context) {
    Size size = MediaQuery.of(context).size;
    return Container(
      width: double.infinity,
      padding: const EdgeInsets.symmetric(
        horizontal: 16.0,
      ),
      child: Column(
        mainAxisSize: MainAxisSize.max,
        children: <Widget>[
          Shimmer.fromColors(
              baseColor: const Color.fromARGB(150, 18, 18, 18),
              highlightColor: const Color.fromARGB(150, 58, 58, 58),
              enabled: _enabled,
              child: SingleChildScrollView(
                child: Column(
                  children: [
                    Container(
                      margin: const EdgeInsets.only(bottom: 10, top: 10),
                      height: size.height * 0.16,
                      width: size.width * 0.97,
                      decoration: const BoxDecoration(
                        borderRadius: BorderRadius.all(Radius.circular(15)),
                        color: Color.fromARGB(255, 172, 172, 172),
                      ),
                    ),
                    Container(
                      margin: const EdgeInsets.symmetric(vertical: 10),
                      height: size.height * 0.16,
                      width: size.width * 0.97,
                      decoration: const BoxDecoration(
                        borderRadius: BorderRadius.all(Radius.circular(15)),
                        color: Color.fromARGB(255, 172, 172, 172),
                      ),
                    ),
                    Container(
                      margin: const EdgeInsets.symmetric(vertical: 10),
                      height: size.height * 0.16,
                      width: size.width * 0.97,
                      decoration: const BoxDecoration(
                        borderRadius: BorderRadius.all(Radius.circular(15)),
                        color: Color.fromARGB(255, 172, 172, 172),
                      ),
                    ),
                  ],
                ),
              )),
        ],
      ),
    );
  }
}
