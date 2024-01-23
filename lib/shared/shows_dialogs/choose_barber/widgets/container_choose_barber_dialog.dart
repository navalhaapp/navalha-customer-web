import 'package:auto_size_text/auto_size_text.dart';
import 'package:flutter/material.dart';

class ContainerChooseBarberDialog extends StatelessWidget {
  final String barberName;
  final String imgservice;
  final Function onTap;

  const ContainerChooseBarberDialog({
    Key? key,
    required this.barberName,
    required this.imgservice,
    required this.onTap,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final size = MediaQuery.of(context).size;
    return Column(
      children: [
        GestureDetector(
          onTap: () => onTap(),
          child: Container(
            alignment: Alignment.center,
            height: size.height * 0.08,
            width: double.maxFinite,
            decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(15),
              color: const Color.fromARGB(255, 24, 24, 24),
            ),
            child: Row(
              children: [
                SizedBox(width: size.width * 0.01),
                Container(
                  width: MediaQuery.of(context).size.width * 0.15,
                  height: MediaQuery.of(context).size.width * 0.15,
                  decoration: BoxDecoration(
                    shape: BoxShape.circle,
                    image: DecorationImage(
                      fit: BoxFit.fill,
                      image: AssetImage(imgservice),
                    ),
                  ),
                ),
                SizedBox(width: size.width * 0.04),
                Column(
                  mainAxisSize: MainAxisSize.min,
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    AutoSizeText(
                      barberName,
                      style: const TextStyle(
                        color: Colors.white,
                      ),
                    ),
                    const SizedBox(height: 3),
                    const Row(
                      children: [
                        Icon(Icons.star, color: Colors.white, size: 15),
                        Icon(Icons.star, color: Colors.white, size: 15),
                        Icon(Icons.star, color: Colors.white, size: 15),
                        Icon(Icons.star_border, color: Colors.white, size: 15),
                        Icon(Icons.star_border, color: Colors.white, size: 15),
                      ],
                    )
                  ],
                ),
              ],
            ),
          ),
        ),
        SizedBox(
          height: size.height * 0.01,
        ),
      ],
    );
  }
}
