import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:navalha/core/colors.dart';
import 'package:navalha/mobile/register/provider/register_customer_provider.dart';
import 'package:navalha/shared/animation/page_trasition.dart';
import '../../shared/utils.dart';
import '../../shared/widgets/cupertino_date_picker.dart';
import '../../shared/widgets/cupertino_piker_list.dart';
import 'registration_page_client_third.dart';
import '../../shared/widgets/floating_next_button.dart';

class RegistrationPageClientSecond extends StatefulWidget {
  const RegistrationPageClientSecond({Key? key}) : super(key: key);

  static const route = '/register-page-two';

  @override
  State<RegistrationPageClientSecond> createState() =>
      _RegistrationPageClientSecondState();
}

class _RegistrationPageClientSecondState
    extends State<RegistrationPageClientSecond> {
  final List<String> _listgener = <String>[
    'Selecione o gênero',
    'Masculino',
    'Feminino'
  ];

  DateTime? date;
  int selectedItem = 0;

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      top: false,
      child: Scaffold(
        extendBodyBehindAppBar: true,
        appBar: AppBar(
          backgroundColor: Colors.transparent,
          elevation: 0,
        ),
        backgroundColor: colorBackground181818,
        body: SingleChildScrollView(
          child: Form(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                SizedBox(
                  height: MediaQuery.of(context).size.height * 0.1,
                ),
                CupertinoDataPicker(
                  label: 'Data de nascimento',
                  color: colorContainers242424,
                  marginHorizontal: MediaQuery.of(context).size.width * 0.03,
                  date: date,
                  picker: CupertinoDatePicker(
                    dateOrder: DatePickerDateOrder.dmy,
                    initialDateTime: date,
                    mode: CupertinoDatePickerMode.date,
                    use24hFormat: true,
                    maximumYear: DateTime.now().year,
                    onDateTimeChanged: (DateTime newDate) {
                      setState(() => date = newDate);
                    },
                  ),
                ),
                CupertinoPickerList(
                  picker: CupertinoPicker(
                    magnification: 1.22,
                    squeeze: 1.2,
                    useMagnifier: true,
                    itemExtent: 32,
                    onSelectedItemChanged: (int selected) {
                      setState(() {
                        selectedItem = selected;
                      });
                    },
                    children:
                        List<Widget>.generate(_listgener.length, (int index) {
                      return Center(
                        child: Text(
                          _listgener[index],
                          style: TextStyle(
                            fontSize: MediaQuery.of(context).size.width * 0.050,
                            color: colorWhite255255255,
                            fontStyle: FontStyle.normal,
                          ),
                        ),
                      );
                    }),
                  ),
                  label: 'Gênero',
                  list: _listgener,
                  optional: '*Opcional',
                  textEdit: _listgener[selectedItem],
                  color: colorContainers242424,
                  marginHorizontal: MediaQuery.of(context).size.width * 0.03,
                ),
              ],
            ),
          ),
        ),
        floatingActionButton: Consumer(
          builder: (BuildContext context, WidgetRef ref, Widget? child) {
            final customerRegisterController =
                ref.watch(customerRegisterProvider.notifier);
            return FloatingNextButton(
              onPressed: () {
                if (date == null) {
                  showSnackBar(context, 'Preencha a sua data de nascimento!');
                } else if (verificarDataFutura(UtilText.formatDate(date!))) {
                  showSnackBar(
                      context, 'Não é possível adicionar datas futuras!');
                } else {
                  customerRegisterController.verifyValidProp([
                    'birth_date',
                    'gener'
                  ], [
                    UtilText.formatDate(date!),
                    UtilText.registerGener[selectedItem] == 'undefined'
                        ? null
                        : UtilText.registerGener[selectedItem]
                  ]);
                  navigationWithFadeAnimation(
                      const RegistrationPageClientThird(), context);
                }
              },
            );
          },
        ),
      ),
    );
  }
}

bool verificarDataFutura(String data) {
  DateTime dataAtual = DateTime.now();

  List<String> partesData = data.split('-');
  int dia = int.parse(partesData[1]);
  int mes = int.parse(partesData[0]);
  int ano = int.parse(partesData[2]);

  DateTime dataFornecida = DateTime(ano, mes, dia);

  return dataFornecida.isAfter(dataAtual);
}
