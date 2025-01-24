import 'package:flutter/material.dart';

class AddCardContainer extends StatelessWidget {
  const AddCardContainer({
    Key? key,
    required this.title,
    required this.ontap,
    required this.icon,
  }) : super(key: key);

  final String title;
  final Function ontap;
  final IconData icon;
  @override
  Widget build(BuildContext context) {
    final size = MediaQuery.of(context).size;

    return InkWell(
      onTap: () {
        ontap();
      },
      child: Row(
        children: [
          CircleAvatar(
            backgroundColor: const Color.fromARGB(255, 66, 66, 66),
            radius: 25,
            child: Icon(icon, color: Colors.grey),
          ),
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 15),
            child: Text(
              title,
              style: TextStyle(
                color: Colors.white,
                fontSize: size.height * 0.02,
              ),
            ),
          )
        ],
      ),
    );
  }
}
