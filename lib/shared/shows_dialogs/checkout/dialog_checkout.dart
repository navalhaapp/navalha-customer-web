/**
 * 
 * 
 *            Vitor - 09/11/2022
 *     Substituido por dialog com animação
 * 
 * 
 * 
 * 
 */
// Future<void> calendarDialog(BuildContext context) {
//   return showDialog<void>(
//     context: context,
//     builder: (BuildContext context) {
//       return _CalendarDialog();
//     },
//   );
// }

// class _CalendarDialog extends StatelessWidget {
//   const _CalendarDialog({
//     Key? key,
//   }) : super(key: key);

//   @override
//   Widget build(BuildContext context) {
//     final size = MediaQuery.of(context).size;

//     return AlertDialog(
//       alignment: Alignment.center,
//       shape: const RoundedRectangleBorder(
//         borderRadius: BorderRadius.all(
//           Radius.circular(32.0),
//         ),
//       ),
//       // scrollable: true,
//       backgroundColor: const Color.fromARGB(150, 0, 0, 0),
//       title: Column(
//         children: [
//           const Text(
//             textAlign: TextAlign.center,
//             'Confirme seu agendamento',
//             style: TextStyle(color: Colors.white),
//           ),
//           SizedBox(height: size.height * 0.01),
//           const Text(
//             textAlign: TextAlign.center,
//             'Dia 17/09/2022 ás 22:22',
//             style: TextStyle(
//               color: Colors.white,
//               fontSize: 17,
//             ),
//           ),
//         ],
//       ),
//       content: Column(
//         children: [
//           SizedBox(
//             height: size.height * 0.2,
//             width: size.width * 0.9,
//             child: ListView(
//               children: [
//                 ContainerCheckoutDialog(
//                   price: 'R\$ 25,00',
//                   service: 'Corte máquina',
//                   imgservice: imgMaquinhaIcon,
//                 ),
//                 ContainerCheckoutDialog(
//                   price: 'R\$ 25,00',
//                   service: 'Corte tesoura',
//                   imgservice: imgNavalhaIcon,
//                 ),
//                 ContainerCheckoutDialog(
//                   price: 'R\$ 30,00',
//                   service: 'Barba',
//                   imgservice: imgTesouraIcon,
//                 ),
//               ],
//             ),
//           ),
//           SizedBox(height: size.height * 0.02),
//           const Text(
//             textAlign: TextAlign.center,
//             'Total: R\$ 55,00',
//             style: TextStyle(
//               color: Colors.white,
//               fontSize: 18,
//               fontWeight: FontWeight.bold,
//             ),
//           ),
//         ],
//       ),
//       actions: <Widget>[
//         Row(
//           mainAxisAlignment: MainAxisAlignment.spaceEvenly,
//           crossAxisAlignment: CrossAxisAlignment.start,
//           children: [
//             ElevatedButton(
//               style: ButtonStyle(
//                 backgroundColor: MaterialStateProperty.all<Color>(
//                     const Color.fromARGB(255, 24, 24, 24)),
//                 shape: MaterialStateProperty.all<RoundedRectangleBorder>(
//                   RoundedRectangleBorder(
//                     borderRadius: BorderRadius.circular(15),
//                   ),
//                 ),
//               ),
//               child: const Padding(
//                 padding: EdgeInsets.symmetric(horizontal: 10),
//                 child: Text(
//                   'Cancelar',
//                   style: TextStyle(color: Colors.white),
//                 ),
//               ),
//               onPressed: () => Navigator.of(context).pop(),
//             ),
//             ElevatedButton(
//               style: ButtonStyle(
//                 backgroundColor: MaterialStateProperty.all<Color>(
//                   const Color.fromARGB(255, 24, 24, 24),
//                 ),
//                 shape: MaterialStateProperty.all<RoundedRectangleBorder>(
//                   RoundedRectangleBorder(
//                     borderRadius: BorderRadius.circular(15),
//                   ),
//                 ),
//               ),
//               child: const Padding(
//                 padding: EdgeInsets.symmetric(horizontal: 10),
//                 child: Text(
//                   'Confirmar',
//                   style: TextStyle(color: Colors.white),
//                 ),
//               ),
//               onPressed: () {
//                 Navigator.pushNamed(context, PaymentPage.route);
//               },
//             ),
//           ],
//         ),
//       ],
//     );
//   }
// }
