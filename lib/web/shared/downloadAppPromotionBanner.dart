import 'package:flutter/material.dart';
import 'package:navalha/core/assets.dart';

class DownloadAppPromotion extends StatelessWidget {
  const DownloadAppPromotion({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    Size size = MediaQuery.of(context).size;
    return Container(
      height: 100,
      decoration: BoxDecoration(
        boxShadow: const [
          BoxShadow(color: Colors.white10, spreadRadius: 2),
        ],
        borderRadius: const BorderRadius.only(
          topLeft: Radius.circular(15),
          topRight: Radius.circular(15),
        ),
        image: DecorationImage(
          image: AssetImage(imgBackgroundBarberLogin),
          fit: BoxFit.cover,
        ),
      ),
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.end,
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Container(
                width: size.width > 500 ? 350 : 200,
                decoration: const BoxDecoration(
                    borderRadius: BorderRadius.only(
                      topRight: Radius.circular(18),
                      bottomRight: Radius.circular(18),
                    ),
                    color: Colors.black),
                child: const Center(
                  child: Padding(
                    padding: EdgeInsets.only(
                        left: 10, right: 10, top: 10, bottom: 10),
                    child: Text(
                      textAlign: TextAlign.center,
                      'Para uma experiência completa, baixe nosso aplicativo.',
                      style:
                          TextStyle(color: Color.fromARGB(255, 212, 212, 212)),
                    ),
                  ),
                ),
              ),
              Visibility(
                visible: size.width < 920,
                child: SizedBox(
                    height: size.width < 500 ? 28 : 40,
                    child: Image.asset(imgStore2)),
              ),
            ],
          ),
          Padding(
            padding: const EdgeInsets.only(top: 10),
            child: SizedBox(
              child: Image.asset(width: 180, imgMockup1),
            ),
          ),
          Visibility(
            visible: size.width > 720,
            child: Padding(
              padding: const EdgeInsets.only(top: 10),
              child: SizedBox(width: 180, child: Image.asset(imgMockup2)),
            ),
          ),
          Visibility(
            visible: size.width > 920,
            child: Padding(
              padding: const EdgeInsets.only(right: 50),
              child: SizedBox(height: 70, child: Image.asset(imgStore)),
            ),
          ),
        ],
      ),
    );
  }
}
