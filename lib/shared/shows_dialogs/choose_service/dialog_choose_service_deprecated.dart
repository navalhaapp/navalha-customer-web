

/*
 * 
 *         Vitor - 09/11/2022
 *  substituido por dialog com animação
 * 
 * 
 */
// Future<void> chooseServiceDialog(BuildContext context) {
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
//           'Escolha um serviço',
//           style: TextStyle(color: Colors.white),
//         ),
//         content: SizedBox(
//           height: size.height * 0.3,
//           width: size.width * 0.9,
//           child: ListView(
//             children: [
//               ContainerChooseServiceDialog(
//                 onTap: () {
//                   Navigator.pop(context);
//                   chooseBarberDialog(context);
//                 },
//                 imgservice: imgMaquinhaIcon,
//                 price: '20,00',
//                 service: 'Corte máquina',
//                 time: '15',
//               ),
//               ContainerChooseServiceDialog(
//                 onTap: () {
//                   Navigator.pop(context);
//                   chooseBarberDialog(context);
//                 },
//                 imgservice: imgTesouraIcon,
//                 price: '35,00',
//                 service: 'Corte tesoura',
//                 time: '25',
//               ),
//               ContainerChooseServiceDialog(
//                 onTap: () {
//                   Navigator.pop(context);
//                   chooseBarberDialog(context);
//                 },
//                 imgservice: imgNavalhaIcon,
//                 price: '25,00',
//                 service: 'Barba',
//                 time: '20',
//               ),
//               ContainerChooseServiceDialog(
//                 onTap: () {
//                   Navigator.pop(context);
//                   chooseBarberDialog(context);
//                 },
//                 imgservice: imgTesouraIcon,
//                 price: '25,00',
//                 service: 'Barba',
//                 time: '20',
//               ),
//             ],
//           ),
//         ),
//         actions: <Widget>[
//           Row(
//             mainAxisAlignment: MainAxisAlignment.center,
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
