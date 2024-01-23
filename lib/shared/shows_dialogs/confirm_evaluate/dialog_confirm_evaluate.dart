/**
 * 
 * 
 *              Vitor - 09/11/2022
 *          Substituido por dialog com  animação
 * 
 * 
 * 
 */
// Future<void> confirmEvaluateDialog(BuildContext context) {
//   final size = MediaQuery.of(context).size;
//   return showDialog<void>(
//     context: context,
//     builder: (BuildContext context) {
//       return AlertDialog(
//         alignment: Alignment.center,
//         shape: const RoundedRectangleBorder(
//           borderRadius: BorderRadius.all(
//             Radius.circular(32.0),
//           ),
//         ),
//         scrollable: true,
//         backgroundColor: const Color.fromARGB(150, 0, 0, 0),
//         title: SizedBox(
//           width: size.width * 0.6,
//           child: const Text(
//             textAlign: TextAlign.center,
//             'Obrigado pela avaliação!',
//             style: TextStyle(color: Colors.white),
//           ),
//         ),
//         content: const Icon(
//           Icons.check_circle_rounded,
//           color: Colors.white,
//           size: 80,
//         ),
//         actions: <Widget>[
//           Row(
//             mainAxisAlignment: MainAxisAlignment.spaceEvenly,
//             children: [
//               ElevatedButton(
//                 style: ButtonStyle(
//                   backgroundColor: MaterialStateProperty.all<Color>(
//                       const Color.fromARGB(255, 24, 24, 24)),
//                   shape: MaterialStateProperty.all<RoundedRectangleBorder>(
//                     RoundedRectangleBorder(
//                       borderRadius: BorderRadius.circular(15),
//                     ),
//                   ),
//                 ),
//                 child: const Padding(
//                   padding: EdgeInsets.symmetric(horizontal: 30),
//                   child: Text(
//                     'Ok',
//                     style: TextStyle(color: Colors.white),
//                   ),
//                 ),
//                 onPressed: () =>
//                     Navigator.pushNamed(context, CalendarPage.route),
//               ),
//             ],
//           ),
//         ],
//       );
//     },
//   );
// }
