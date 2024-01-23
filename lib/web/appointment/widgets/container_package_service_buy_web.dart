import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:navalha/core/colors.dart';

class ContainerPackageServiceBuyWeb extends StatelessWidget {
  const ContainerPackageServiceBuyWeb({
    Key? key,
    required this.label,
    required this.description,
    required this.icon,
    required this.onPressed,
  }) : super(key: key);

  final String label;
  final String description;
  final IconData icon;
  final Function onPressed;

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 5),
      child: ElevatedButton(
        style: ButtonStyle(
          overlayColor: MaterialStateProperty.all<Color>(
            colorContainers353535,
          ),
          elevation: MaterialStateProperty.all(0),
          backgroundColor: MaterialStateProperty.all<Color>(
              const Color.fromARGB(255, 28, 28, 28)),
          shape: MaterialStateProperty.all<RoundedRectangleBorder>(
            RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(12),
            ),
          ),
        ),
        onPressed: () => onPressed(),
        child: Padding(
          padding: const EdgeInsets.symmetric(vertical: 10, horizontal: 5),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Row(
                    children: [
                      Icon(
                        icon,
                        color: Colors.white,
                        size: 25,
                      ),
                      const SizedBox(width: 15),
                      Text(
                        label,
                        style: const TextStyle(
                          color: Colors.white,
                          fontSize: 25,
                        ),
                      ),
                    ],
                  ),
                  const SizedBox(height: 5),
                  SizedBox(
                    width: 500,
                    child: Text(
                      description,
                      style: TextStyle(
                        color: colorFontUnable116116116,
                        fontSize: 25,
                      ),
                    ),
                  ),
                ],
              ),
              const Icon(
                CupertinoIcons.chevron_forward,
                color: Colors.white,
                size: 25,
              ),
            ],
          ),
        ),
      ),
    );
  }
}
