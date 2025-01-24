import 'package:flutter/material.dart';
import 'package:navalha/core/colors.dart';

class CardItem extends StatelessWidget {
  final String imgFlagCard;
  final String flag;
  final String type;
  final String number;
  final Widget button;

  const CardItem({
    Key? key,
    required this.imgFlagCard,
    required this.flag,
    required this.type,
    required this.number,
    required this.button,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final size = MediaQuery.of(context).size;
    return Row(
      children: [
        Row(
          mainAxisAlignment: MainAxisAlignment.center,
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            Padding(
              padding: EdgeInsets.symmetric(horizontal: size.width * 0.04),
              child: Image.asset(
                imgFlagCard,
                width: size.width * 0.08,
              ),
            ),
          ],
        ),
        Container(
          alignment: Alignment.centerLeft,
          height: size.height * 0.08,
          width: size.width * 0.835,
          decoration: BoxDecoration(
            border: const Border(
              bottom: BorderSide(
                color: Colors.white,
                width: 0.5,
              ),
            ),
            color: colorBackground181818,
          ),
          child: Padding(
            padding: EdgeInsets.symmetric(horizontal: size.width * 0.0),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.start,
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                buildCard(number),
                SizedBox(
                  width: size.width * 0.51,
                  child: tranlationType(type),
                ),
                button
              ],
            ),
          ),
        ),
      ],
    );
  }
}

Widget buildCard(String cardNumber) {
  String last4Digits = cardNumber.substring(cardNumber.length - 4);

  List<Widget> bullets = List.generate(
    4,
    (index) =>
        const Icon(Icons.fiber_manual_record, size: 6, color: Colors.white),
  );

  return Row(
    children: [
      Row(children: bullets),
      Text(
        ' $last4Digits',
        style: const TextStyle(fontSize: 16, color: Colors.white),
      ),
    ],
  );
}

Widget tranlationType(String transacao) {
  if (transacao.toLowerCase() == "debit") {
    return const Text(
      ' (Débito)',
      style: TextStyle(color: Colors.white, fontSize: 16),
    );
  } else if (transacao.toLowerCase() == "credit") {
    return const Text(' (Crédito)',
        style: TextStyle(color: Colors.white, fontSize: 16));
  } else {
    return const Text('Transação inválida',
        style: TextStyle(color: Colors.white, fontSize: 16));
  }
}
