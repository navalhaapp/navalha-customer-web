import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:navalha/core/colors.dart';
import 'package:navalha/mobile/register/provider/register_customer_provider.dart';
import 'package:navalha/shared/animation/page_trasition.dart';
import 'package:navalha/shared/utils.dart';
import 'package:navalha/shared/widgets/cupertino_piker_list.dart';
import 'package:navalha/shared/widgets/floating_next_button.dart';
import 'package:navalha/web/appointment/widgets/cupertino_date_picker_web.dart';
import 'package:navalha/web/appointment/widgets/cupertino_piker_list_web.dart';
import 'package:navalha/web/appointment/widgets/register_web/registration_page_client_third_web.dart';
import 'package:navalha/web/appointment/widgets/register_web/registration_page_client_web.dart';

class RegistrationPageClientSecondWeb extends StatefulWidget {
  const RegistrationPageClientSecondWeb({Key? key}) : super(key: key);

  static const route = '/register-page-two-web';

  @override
  State<RegistrationPageClientSecondWeb> createState() =>
      _RegistrationPageClientSecondWebState();
}

class _RegistrationPageClientSecondWebState
    extends State<RegistrationPageClientSecondWeb> {
  final List<String> _listgener = <String>[
    'Selecione o gênero',
    'Masculino',
    'Feminino'
  ];

  DateTime date = DateTime(2018, 28, 10);
  int selectedItem = 0;

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      top: false,
      child: Scaffold(
        backgroundColor: colorBackground181818,
        body: Center(
          child: Container(
            margin: const EdgeInsets.all(18),
            width: 500,
            height: 500,
            decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(15),
              color: colorContainers242424,
            ),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.end,
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        IconButton(
                          padding: const EdgeInsets.symmetric(
                              horizontal: 20, vertical: 15),
                          onPressed: () {
                            Navigator.pop(context);
                          },
                          icon: const Icon(
                            CupertinoIcons.back,
                            color: Colors.white,
                          ),
                        ),
                        Row(
                          children: [
                            const ContainerStepper(color: Colors.white),
                            const ContainerStepper(color: Colors.white),
                            ContainerStepper(color: Colors.grey.shade800),
                            ContainerStepper(color: Colors.grey.shade800),
                          ],
                        ),
                        IconButton(
                          padding: const EdgeInsets.symmetric(
                              horizontal: 20, vertical: 15),
                          onPressed: () {},
                          icon: const Icon(
                            CupertinoIcons.back,
                            color: Colors.transparent,
                          ),
                        ),
                      ],
                    ),
                    SingleChildScrollView(
                      child: Form(
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.center,
                          children: [
                            CupertinoDataPickerWeb(
                              label: 'Data de nascimento',
                              color: colorContainers353535,
                              marginHorizontal: 0,
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
                            CupertinoPickerListWeb(
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
                                children: List<Widget>.generate(
                                    _listgener.length, (int index) {
                                  return Center(
                                    child: Text(
                                      _listgener[index],
                                      style: TextStyle(
                                        color: colorWhite255255255,
                                        fontStyle: FontStyle.normal,
                                      ),
                                    ),
                                  );
                                }),
                              ),
                              label: 'Gênero',
                              list: _listgener,
                              optional: 'opcional',
                              textEdit: _listgener[selectedItem],
                              color: colorContainers353535,
                              marginHorizontal: 20,
                            ),
                          ],
                        ),
                      ),
                    ),
                  ],
                ),
                Padding(
                  padding: const EdgeInsets.all(25),
                  child: Consumer(
                    builder:
                        (BuildContext context, WidgetRef ref, Widget? child) {
                      final customerRegisterController =
                          ref.watch(customerRegisterProvider.notifier);
                      return FloatingNextButton(
                        onPressed: () {
                          if (verificarDataFutura(UtilText.formatDate(date))) {
                            showSnackBar(context,
                                'Não é possível adicionar datas futuras!');
                          } else {
                            customerRegisterController.verifyValidProp([
                              'birth_date',
                              'gener'
                            ], [
                              UtilText.formatDate(date),
                              UtilText.registerGener[selectedItem] ==
                                      'undefined'
                                  ? null
                                  : UtilText.registerGener[selectedItem]
                            ]);
                            navigationWithFadeAnimation(
                                const RegistrationPageClientThirdWeb(),
                                context);
                          }
                        },
                      );
                    },
                  ),
                ),
              ],
            ),
          ),
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
