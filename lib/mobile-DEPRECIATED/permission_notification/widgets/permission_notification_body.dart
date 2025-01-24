import 'package:flutter/material.dart';
import 'package:navalha/core/assets.dart';

class PermissionNotificationBody extends StatelessWidget {
  const PermissionNotificationBody({
    Key? key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    Size size = MediaQuery.of(context).size;
    return Center(
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Column(
            children: [
              SizedBox(
                width: size.width * 0.7,
                child: Image.asset(
                  iconNotification,
                ),
              ),
              const SizedBox(height: 20),
              const Text(
                'Habilitar notificações',
                style: TextStyle(color: Colors.white, fontSize: 20),
              ),
              Padding(
                padding: EdgeInsets.symmetric(
                    horizontal: size.width * 0.05, vertical: 10),
                child: const Text(
                  textAlign: TextAlign.center,
                  'Eleve a experiência com o navalha ao máximo ao ativar as notificações e receber lembretes de agendamentos, cancelamentos e diversas outras informações.',
                  style: TextStyle(color: Colors.white, fontSize: 15),
                ),
              ),
            ],
          ),
        ],
      ),
    );
  }
}
