import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:navalha/core/colors.dart';
import '../../../mobile-DEPRECIATED/home/model/response_get_barber_shop_by_id.dart';

class ChooseServicePackage extends StatefulWidget {
  const ChooseServicePackage({
    Key? key,
    required this.data,
  }) : super(key: key);

  final ResponseBarberShopById data;

  @override
  State<ChooseServicePackage> createState() => _ChooseServicePackageState();
}

class _ChooseServicePackageState extends State<ChooseServicePackage> {
  bool loading = false;
  @override
  Widget build(BuildContext context) {
    return Container(
      alignment: Alignment.center,
      child: Column(
        mainAxisSize: MainAxisSize.min,
        children: [
          SizedBox(height: MediaQuery.of(context).size.width * 0.02),
          ContainerPackageServiceBuyWeb(
            icon: CupertinoIcons.scissors,
            label: 'Agendar serviço',
            description: 'Agende serviços de forma independente.',
            onPressed: () {
              Navigator.pop(context);
              Navigator.of(context).pushNamed(
                '/',
                arguments: {
                  'barbershop_id': widget.data.barbershop!.barbershopId!
                },
              );
            },
          ),
          Visibility(
            visible: true,
            child: ContainerPackageServiceBuyWeb(
              icon: CupertinoIcons.cube_box,
              label: 'Comprar pacote',
              description: 'Compre um pacote e tenha mais economia.',
              onPressed: () {},
            ),
          ),
          Visibility(
            visible: true,
            child: ContainerPackageServiceBuyWeb(
              icon: CupertinoIcons.cube_box_fill,
              label: 'Usar pacote',
              description: 'Use os serviços que já estão pagos.',
              onPressed: () {},
            ),
          ),
          const SizedBox(height: 15)
        ],
      ),
    );
  }
}

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
