import 'package:flutter/material.dart';

class ImageProfile extends StatelessWidget {
  final String nameUser;
  final String adressEmail;
  final ImageProvider imgProfile;

  const ImageProfile({
    Key? key,
    required this.nameUser,
    required this.adressEmail,
    required this.imgProfile,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Padding(
          padding: const EdgeInsets.only(left: 20),
          child: Container(
            width: MediaQuery.of(context).size.width * 0.2,
            height: MediaQuery.of(context).size.width * 0.2,
            decoration: BoxDecoration(
              shape: BoxShape.circle,
              image: DecorationImage(
                fit: BoxFit.cover,
                image: imgProfile,
              ),
            ),
          ),
        ),
        SizedBox(height: MediaQuery.of(context).size.width * 0.02),
        Padding(
          padding: const EdgeInsets.only(left: 20),
          child: Text(
            nameUser.contains(' ')
                ? nameUser.substring(0, nameUser.indexOf(' '))
                : nameUser,
            style: const TextStyle(
              color: Colors.white,
              fontSize: 25,
            ),
          ),
        ),
        Padding(
          padding: const EdgeInsets.only(left: 20),
          child: Text(
            adressEmail,
            style: const TextStyle(
              color: Color.fromARGB(255, 163, 163, 163),
              fontSize: 15,
            ),
          ),
        ),
        Container(
          margin: const EdgeInsets.only(top: 20),
          decoration: const BoxDecoration(
            border: Border(
              bottom: BorderSide(
                color: Colors.white,
                width: 0.2,
              ),
            ),
          ),
        ),
      ],
    );
  }
}
