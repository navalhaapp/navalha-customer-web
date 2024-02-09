import 'package:flutter/material.dart';
import 'package:navalha/core/colors.dart';
import 'package:shimmer/shimmer.dart';

class ShimmerHomeDefault extends StatefulWidget {
  const ShimmerHomeDefault({super.key});

  @override
  ShimmerHomeDefaultState createState() => ShimmerHomeDefaultState();
}

class ShimmerHomeDefaultState extends State<ShimmerHomeDefault> {
  final bool _enabled = true;

  @override
  Widget build(BuildContext context) {
    Size size = MediaQuery.of(context).size;
    return SafeArea(
      top: false,
      child: Scaffold(
        body: Container(
          decoration: BoxDecoration(color: colorBackground181818),
          width: double.infinity,
          padding: const EdgeInsets.symmetric(horizontal: 16.0, vertical: 16.0),
          child: Column(
            mainAxisSize: MainAxisSize.max,
            children: <Widget>[
              Expanded(
                child: Shimmer.fromColors(
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
                              height: size.height * 0.08,
                              width: size.width * 0.97,
                              decoration: const BoxDecoration(
                                borderRadius:
                                    BorderRadius.all(Radius.circular(15)),
                                color: Color.fromARGB(255, 172, 172, 172),
                              ),
                            ),
                            Container(
                              margin: const EdgeInsets.symmetric(vertical: 10),
                              height: size.height * 0.08,
                              width: size.width * 0.97,
                              decoration: const BoxDecoration(
                                borderRadius:
                                    BorderRadius.all(Radius.circular(15)),
                                color: Color.fromARGB(255, 172, 172, 172),
                              ),
                            ),
                            Container(
                              margin:
                                  const EdgeInsets.only(top: 10, bottom: 30),
                              height: size.height * 0.08,
                              width: size.width * 0.5,
                              decoration: const BoxDecoration(
                                borderRadius:
                                    BorderRadius.all(Radius.circular(15)),
                                color: Color.fromARGB(255, 172, 172, 172),
                              ),
                            ),
                            SizedBox(
                              height: size.height * 0.08,
                              width: size.width * 0.99,
                              child: ListView.builder(
                                scrollDirection: Axis.horizontal,
                                itemCount: 5,
                                itemBuilder: (context, index) => Container(
                                  margin: EdgeInsets.only(
                                    top: size.height * 0.01,
                                    right: size.width * 0.04,
                                  ),
                                  height: size.height * 0.06,
                                  width: size.width * 0.15,
                                  decoration: const BoxDecoration(
                                    borderRadius:
                                        BorderRadius.all(Radius.circular(15)),
                                    color: Color.fromARGB(255, 172, 172, 172),
                                  ),
                                ),
                              ),
                            ),
                            SizedBox(
                              height: size.height * 0.065,
                              width: size.width * 0.99,
                              child: ListView.builder(
                                scrollDirection: Axis.horizontal,
                                itemCount: 5,
                                itemBuilder: (context, index) => Container(
                                  margin: EdgeInsets.only(
                                    top: size.height * 0.01,
                                    bottom: 30,
                                    right: size.width * 0.04,
                                  ),
                                  height: size.height * 0.06,
                                  width: size.width * 0.15,
                                  decoration: const BoxDecoration(
                                    borderRadius:
                                        BorderRadius.all(Radius.circular(15)),
                                    color: Color.fromARGB(255, 172, 172, 172),
                                  ),
                                ),
                              ),
                            ),
                            Container(
                              margin: const EdgeInsets.symmetric(vertical: 10),
                              height: size.height * 0.2,
                              width: size.width * 0.97,
                              decoration: const BoxDecoration(
                                borderRadius:
                                    BorderRadius.all(Radius.circular(15)),
                                color: Color.fromARGB(255, 172, 172, 172),
                              ),
                            ),
                            Container(
                              margin: const EdgeInsets.symmetric(vertical: 10),
                              height: size.height * 0.08,
                              width: size.width * 0.97,
                              decoration: const BoxDecoration(
                                borderRadius:
                                    BorderRadius.all(Radius.circular(15)),
                                color: Color.fromARGB(255, 172, 172, 172),
                              ),
                            ),
                            Container(
                              margin: const EdgeInsets.symmetric(vertical: 10),
                              height: size.height * 0.08,
                              width: size.width * 0.97,
                              decoration: const BoxDecoration(
                                borderRadius:
                                    BorderRadius.all(Radius.circular(15)),
                                color: Color.fromARGB(255, 172, 172, 172),
                              ),
                            ),
                            Container(
                              margin: const EdgeInsets.symmetric(vertical: 10),
                              height: size.height * 0.08,
                              width: size.width * 0.97,
                              decoration: const BoxDecoration(
                                borderRadius:
                                    BorderRadius.all(Radius.circular(15)),
                                color: Color.fromARGB(255, 172, 172, 172),
                              ),
                            ),
                          ],
                        ),
                      ),
                    )),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
