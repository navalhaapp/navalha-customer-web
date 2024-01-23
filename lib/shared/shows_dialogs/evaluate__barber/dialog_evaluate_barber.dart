/**
 * 
 * 
 *            Vitor - 09/11/2022
 *    Substituido por dialog com animação
 * 
 * 
 */
// Future<void> evaluateDialog(BuildContext context) {
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
//         title: const Text(
//           textAlign: TextAlign.center,
//           'Avalie o atendimento',
//           style: TextStyle(color: Colors.white),
//         ),
//         content: Column(
//           mainAxisSize: MainAxisSize.min,
//           children: [
//             Container(
//               width: MediaQuery.of(context).size.width * 0.2,
//               height: MediaQuery.of(context).size.width * 0.2,
//               decoration: BoxDecoration(
//                 shape: BoxShape.circle,
//                 image: DecorationImage(
//                   fit: BoxFit.fill,
//                   image: AssetImage(imgProfileBarber2),
//                 ),
//               ),
//             ),
//             SizedBox(height: MediaQuery.of(context).size.width * 0.02),
//             Row(
//               mainAxisAlignment: MainAxisAlignment.center,
//               children: const [
//                 Icon(Icons.star_border, color: Colors.grey),
//                 Icon(Icons.star_border, color: Colors.grey),
//                 Icon(Icons.star_border, color: Colors.grey),
//                 Icon(Icons.star_border, color: Colors.grey),
//                 Icon(Icons.star_border, color: Colors.grey),
//               ],
//             ),
//             SizedBox(height: MediaQuery.of(context).size.width * 0.02),
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
//                   'Fazer um elogio',
//                   style: TextStyle(color: Colors.white),
//                 ),
//               ),
//               onPressed: () {
//                 showModalBottomSheet<void>(
//                   backgroundColor: Colors.black,
//                   isScrollControlled: true,
//                   shape: RoundedRectangleBorder(
//                       borderRadius: BorderRadius.circular(20)),
//                   context: context,
//                   builder: (BuildContext context) {
//                     return const CommentBarberBottomSheet();
//                   },
//                 );
//               },
//             ),
//             SizedBox(height: MediaQuery.of(context).size.width * 0.06),
//             SizedBox(
//               height: size.height * 0.04,
//               width: size.width * 0.8,
//               child: const AutoSizeText(
//                 'Adicione um valor extra para Ronaldo',
//                 style: TextStyle(color: Colors.white, fontSize: 15),
//                 textAlign: TextAlign.center,
//               ),
//             ),
//             Row(
//               mainAxisAlignment: MainAxisAlignment.spaceEvenly,
//               children: [
//                 ButtonPriceEvaluate(
//                   able: false,
//                   value: 1,
//                 ),
//                 ButtonPriceEvaluate(
//                   able: false,
//                   value: 3,
//                 ),
//                 ButtonPriceEvaluate(
//                   able: false,
//                   value: 5,
//                 ),
//               ],
//             ),
//             SizedBox(height: MediaQuery.of(context).size.width * 0.03),
//             GestureDetector(
//               onTap: () {
//                 showModalBottomSheet<void>(
//                   backgroundColor: Colors.black,
//                   isScrollControlled: true,
//                   shape: RoundedRectangleBorder(
//                       borderRadius: BorderRadius.circular(20)),
//                   context: context,
//                   builder: (BuildContext context) {
//                     return const ExtraValueBottomSheet();
//                   },
//                 );
//               },
//               child: SizedBox(
//                 height: size.height * 0.04,
//                 width: size.width * 0.8,
//                 child: const AutoSizeText(
//                   'Outro valor',
//                   style: TextStyle(color: Colors.white, fontSize: 15),
//                   textAlign: TextAlign.center,
//                 ),
//               ),
//             ),
//           ],
//         ),
//         actions: <Widget>[
//           Row(
//             mainAxisAlignment: MainAxisAlignment.spaceEvenly,
//             children: [
//               ElevatedButton(
//                   style: ButtonStyle(
//                     backgroundColor: MaterialStateProperty.all<Color>(
//                         const Color.fromARGB(255, 24, 24, 24)),
//                     shape: MaterialStateProperty.all<RoundedRectangleBorder>(
//                       RoundedRectangleBorder(
//                         borderRadius: BorderRadius.circular(15),
//                       ),
//                     ),
//                   ),
//                   child: const Padding(
//                     padding: EdgeInsets.symmetric(horizontal: 10),
//                     child: Text(
//                       'Confirmar',
//                       style: TextStyle(color: Colors.white),
//                     ),
//                   ),
//                   onPressed: () {
//                     Navigator.pop(context);
//                     confirmEvaluateDialog(context);
//                   }),
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
//                   padding: EdgeInsets.symmetric(horizontal: 10),
//                   child: Text(
//                     'Cancelar',
//                     style: TextStyle(color: Colors.white),
//                   ),
//                 ),
//                 onPressed: () => Navigator.of(context).pop(),
//               ),
//             ],
//           ),
//         ],
//       );
//     },
//   );
// }
