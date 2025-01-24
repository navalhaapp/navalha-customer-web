// import 'package:flutter/material.dart';
// import 'package:flutter_pw_validator/Resource/Strings.dart';
// import 'package:flutter_pw_validator/flutter_pw_validator.dart';
// import 'package:navalha/core/colors.dart';
// import '../../shared/widgets/text_edit.dart';

// class ChangePasswordBody extends StatefulWidget {
//   ChangePasswordBody({
//     Key? key,
//   }) : super(key: key);
//   bool passedTest = false;

//   @override
//   State<ChangePasswordBody> createState() => _ChangePasswordBodyState();
// }

// class _ChangePasswordBodyState extends State<ChangePasswordBody> {
//   final TextEditingController oldPasswordController = TextEditingController();
//   final TextEditingController newPasswordController = TextEditingController();
//   final TextEditingController confirmPasswordController =
//       TextEditingController();
//   final GlobalKey<FlutterPwValidatorState> validatorKey =
//       GlobalKey<FlutterPwValidatorState>();

//   @override
//   Widget build(BuildContext context) {
//     return SizedBox(
//       height: MediaQuery.of(context).size.height,
//       child: ListView(
//         children: [
//           TextEditPattern(
//             controller: oldPasswordController,
//             label: 'Senha Atual',
//             hint: 'Informe sua senha atual',
//             keyboardType: TextInputType.visiblePassword,
//             color: colorContainers363636,
//           ),
//           TextEditPattern(
//             controller: newPasswordController,
//             label: 'Nova senha',
//             hint: 'Informe a nova senha',
//             keyboardType: TextInputType.visiblePassword,
//             color: colorContainers363636,
//           ),
//           TextEditPattern(
//             controller: confirmPasswordController,
//             label: 'Confirme sua senha',
//             hint: 'Confirme a nova senha',
//             keyboardType: TextInputType.visiblePassword,
//             color: colorContainers363636,
//           ),
//           Padding(
//             padding: EdgeInsets.symmetric(
//               horizontal: MediaQuery.of(context).size.width * 0.08,
//             ),
//             child: SizedBox(
//               width: MediaQuery.of(context).size.width,
//               child: FlutterPwValidator(
//                 key: validatorKey,
//                 controller: newPasswordController,
//                 minLength: 8,
//                 uppercaseCharCount: 1,
//                 numericCharCount: 1,
//                 failureColor: const Color.fromARGB(255, 227, 90, 80),
//                 width: MediaQuery.of(context).size.width * 0.8,
//                 height: MediaQuery.of(context).size.height * 0.17,
//                 onSuccess: () {
//                   widget.passedTest = true;
//                 },
//                 onFail: () {},
//               ),
//             ),
//           ),
//         ],
//       ),
//     );
//   }
// }

// class FlutterPwValidatorNavalha implements FlutterPwValidatorStrings {
//   @override
//   final String atLeast = "Ao menos - caracteres";
//   @override
//   final String normalLetters = "- Letter";
//   @override
//   final String uppercaseLetters = "- Letra maiúscula";
//   @override
//   final String numericCharacters = "- Caractere numérico";
//   @override
//   final String specialCharacters = "- Caractere especial";
// }
