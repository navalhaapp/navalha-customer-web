
/*
 * 
 *         Vitor - 09/11/2022
 *  substituido por dialog com animação
 * 
 * 
 */

// Future<void> chooseBarberDialog(BuildContext context) {
//   final size = MediaQuery.of(context).size;
//   return showDialog<void>(
//     context: context,
//     builder: (BuildContext context) {
//       return _DialogChooseBarber(size: size);
//     },
//   );
// }

// class _DialogChooseBarber extends StatelessWidget {
//   const _DialogChooseBarber({
//     Key? key,
//     required this.size,
//   }) : super(key: key);

//   final Size size;

//   @override
//   Widget build(BuildContext context) {
//     return AlertDialog(
//       alignment: Alignment.center,
//       shape: const RoundedRectangleBorder(
//         borderRadius: BorderRadius.all(
//           Radius.circular(32.0),
//         ),
//       ),
//       scrollable: true,
//       backgroundColor: const Color.fromARGB(150, 0, 0, 0),
//       title: const Text(
//         textAlign: TextAlign.center,
//         'Escolha um profissional',
//         style: TextStyle(color: Colors.white),
//       ),
//       content: SizedBox(
//         height: size.height * 0.3,
//         width: size.width * 0.9,
//         child: ListView(
//           children: [
//             ContainerChooseBarberDialog(
//               onTap: () => Navigator.pushNamed(context, SchedulePage.route),
//               barberName: 'Andressa Queiroz',
//               imgservice: imgProfile1,
//             ),
//             ContainerChooseBarberDialog(
//               onTap: () => Navigator.pushNamed(context, SchedulePage.route),
//               barberName: 'Ronaldo Adriano',
//               imgservice: imgProfile2,
//             ),
//             ContainerChooseBarberDialog(
//               onTap: () => Navigator.pushNamed(context, SchedulePage.route),
//               barberName: 'Alessandro Jobs',
//               imgservice: imgProfile3,
//             ),
//             ContainerChooseBarberDialog(
//               onTap: () => Navigator.pushNamed(context, SchedulePage.route),
//               barberName: 'Ana Da Silva',
//               imgservice: imgProfile6,
//             ),
//           ],
//         ),
//       ),
//       actions: <Widget>[
//         Row(
//           mainAxisAlignment: MainAxisAlignment.spaceEvenly,
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
//           ],
//         ),
//       ],
//     );
//   }
// }
