import 'package:flutter/material.dart';

class PermissionBody extends StatelessWidget {
  const PermissionBody({
    Key? key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    Size size = MediaQuery.of(context).size;
    return Center(
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          SizedBox(
            width: size.width * 0.5,
            child: Image.asset(
              'asset/images/location-page.png',
            ),
          ),
          const SizedBox(height: 20),
          const Center(
            child: Text(
              'Habilitar serviços de localização',
              style: TextStyle(color: Colors.white, fontSize: 20),
            ),
          ),
          const Center(
            child: Padding(
              padding: EdgeInsets.symmetric(horizontal: 20, vertical: 10),
              child: Text(
                textAlign: TextAlign.center,
                'Obtenha as melhores recomendações de barbearias próximas a você!',
                style: TextStyle(color: Colors.white, fontSize: 15),
              ),
            ),
          ),
        ],
      ),
    );
  }
}
