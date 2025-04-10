// ignore_for_file: use_build_context_synchronously, prefer_const_constructors

import 'package:brasil_fields/brasil_fields.dart';
import 'package:dio/dio.dart';
import 'package:easy_debounce/easy_debounce.dart';
import 'package:email_validator/email_validator.dart';
import 'package:firebase_analytics_web/firebase_analytics_web.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_pw_validator/flutter_pw_validator.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';

import 'package:navalha/mobile-DEPRECIATED/change_password/change_password_page.dart';
import 'package:navalha/mobile-DEPRECIATED/login/controller/login_controller.dart';
import 'package:navalha/mobile-DEPRECIATED/payment/model/response_schedule.dart';
import 'package:navalha/mobile-DEPRECIATED/payment/provider/provider_create_schedule.dart';
import 'package:navalha/mobile-DEPRECIATED/register/api/create_customer_endpoint.dart';
import 'package:navalha/mobile-DEPRECIATED/register/model/req_create_customer.dart';
import 'package:navalha/mobile-DEPRECIATED/register/provider/provider_auth_email.dart';
import 'package:navalha/mobile-DEPRECIATED/register/provider/register_customer_provider.dart';
import 'package:navalha/mobile-DEPRECIATED/register/repository/registration_repository.dart';
import 'package:navalha/mobile-DEPRECIATED/register/usecase/create_customer_usecase.dart';
import 'package:navalha/mobile-DEPRECIATED/schedule/schedule_page.dart';
import 'package:navalha/mobile-DEPRECIATED/schedule/widgets/add_coupon_botton_sheet.dart';
import 'package:navalha/shared/shows_dialogs/dialog.dart';
import 'package:navalha/shared/utils.dart';
import 'package:navalha/shared/widgets/button_pattern_dialog.dart';
import 'package:navalha/web/appointment/text_edit_web.dart';
import 'package:navalha/web/appointment/widgets/register_web/registration_password_web.dart';
import 'package:navalha/web/db/db_customer_shared.dart';

import '../../../core/colors.dart';
import '../../../shared/model/barber_shop_model.dart';
import '../../../shared/providers.dart';

class FooterTotalPriceWeb extends StatefulWidget {
  const FooterTotalPriceWeb({
    Key? key,
    required this.totalPrice,
    required this.totalPriceWithDiscount,
    required this.totalTime,
    required this.haveDiscount,
    required this.barberShop,
    required this.onChangedCoupon,
  }) : super(key: key);

  final double totalPrice;
  final double totalPriceWithDiscount;
  final String totalTime;
  final bool haveDiscount;
  final BarberShop barberShop;
  final Function() onChangedCoupon;

  @override
  State<FooterTotalPriceWeb> createState() => _FooterTotalPriceWebState();
}

class _FooterTotalPriceWebState extends State<FooterTotalPriceWeb> {
  FirebaseAnalyticsWeb analytics = FirebaseAnalyticsWeb();
  String? couponName;

  void _trackFinalizeEvent(String customerId) {
    analytics.logEvent(
      name: 'finalize_service',
      parameters: <String, dynamic>{
        'customer_id': customerId,
      },
    );
  }

  bool loading = false;
  @override
  Widget build(BuildContext context) {
    return Consumer(
      builder: (context, ref, child) {
        CustomerDB? retrievedCustomer = LocalStorageManager.getCustomer();
        var serviceCache = ref.watch(listServicesCacheProvider.state);
        final listResumePayment = ref.watch(listResumePaymentProvider.notifier);

        final createSchedule =
            ref.watch(CreateScheduleStateController.provider.notifier);
        var barberShopProvider = ref.watch(barberShopSelectedProvider.state);
        listResumePayment.state.barbershopId =
            barberShopProvider.state.barbershopId;
        var totalPriceProvider = ref.watch(totalPriceServiceProvider.state);
        listResumePayment.state.transactionAmount = calcPriceWithDiscount(
          totalPriceProvider.state.totalPriceWithoutDicount!,
          totalPriceProvider.state.discount ?? 0,
        );
        listResumePayment.state.promotionalCodeDiscount = calcDiscount(
            totalPriceProvider.state.totalPriceWithoutDicount!,
            totalPriceProvider.state.discount ?? 0);
        listResumePayment.state.promotionalCodePercent =
            totalPriceProvider.state.discount;
        return Container(
          decoration: BoxDecoration(
            color: colorContainers242424,
            borderRadius: BorderRadius.circular(15),
          ),
          margin: EdgeInsets.only(bottom: 15, left: 30),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.center,
            mainAxisAlignment: MainAxisAlignment.start,
            children: [
              GestureDetector(
                onTap: () async {
                  showModalBottomSheet<void>(
                    backgroundColor: Colors.transparent,
                    isScrollControlled: false,
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(20),
                    ),
                    context: context,
                    builder: (BuildContext context) {
                      return GestureDetector(
                        onTap: () {
                          Navigator.of(context).pop();
                        },
                        child: AddCouponHourBottonSheet(
                          barberShop: barberShopProvider.state,
                          onChanged: (value) {
                            setState(() {
                              couponName = value;
                            });
                            widget.onChangedCoupon();
                          },
                        ),
                      );
                    },
                  );
                },
                child: Visibility(
                  visible: serviceCache.state.isNotEmpty,
                  child: Padding(
                    padding: const EdgeInsets.only(left: 10, bottom: 5),
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.start,
                      children: [
                        Text(
                          couponName == null
                              ? 'Adicionar cupom de desconto'
                              : 'Trocar cupom de desconto: ',
                          style: const TextStyle(
                            color: Colors.white,
                          ),
                        ),
                        Visibility(
                          visible: couponName != null,
                          child: Text(
                            couponName ?? '',
                            style: TextStyle(
                              color: colorFontUnable116116116,
                            ),
                          ),
                        ),
                      ],
                    ),
                  ),
                ),
              ),
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Padding(
                    padding: const EdgeInsets.symmetric(horizontal: 8),
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.center,
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Column(
                          mainAxisAlignment: MainAxisAlignment.start,
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Text(
                              'R\$ ${widget.totalPrice.toStringAsFixed(2).replaceAll('.', ',')}',
                              style: widget.haveDiscount
                                  ? TextStyle(
                                      color: colorFontUnable116116116,
                                      fontWeight: FontWeight.w600,
                                      fontSize: 15,
                                      decoration: TextDecoration.lineThrough,
                                    )
                                  : const TextStyle(
                                      color: Colors.white,
                                      fontWeight: FontWeight.w600,
                                      fontSize: 20,
                                    ),
                            ),
                            Visibility(
                              visible: widget.haveDiscount,
                              child: Text(
                                'R\$ ${widget.totalPriceWithDiscount.toStringAsFixed(2).replaceAll('.', ',')}',
                                style: const TextStyle(
                                  color: Colors.white,
                                  fontWeight: FontWeight.w600,
                                  fontSize: 20,
                                ),
                              ),
                            ),
                          ],
                        ),
                        Text(
                          '${widget.totalTime}min',
                          style: TextStyle(
                            color: colorFontUnable116116116,
                            fontWeight: FontWeight.w600,
                          ),
                        ),
                      ],
                    ),
                  ),
                  Visibility(
                    visible: serviceCache.state.isNotEmpty,
                    child: Container(
                      margin: EdgeInsets.symmetric(horizontal: 8),
                      width: 150,
                      height: 50,
                      decoration: BoxDecoration(
                        color: colorContainers242424,
                        borderRadius: const BorderRadius.all(
                          Radius.circular(18),
                        ),
                      ),
                      child: ElevatedButton(
                        style: ButtonStyle(
                          elevation: MaterialStateProperty.all(0),
                          backgroundColor: MaterialStateProperty.all<Color>(
                            Color.fromARGB(255, 28, 28, 28),
                          ),
                          overlayColor: MaterialStateProperty.all<Color>(
                            colorContainers353535,
                          ),
                          shape:
                              MaterialStateProperty.all<RoundedRectangleBorder>(
                            RoundedRectangleBorder(
                              borderRadius: BorderRadius.circular(14),
                            ),
                          ),
                        ),
                        child: !loading
                            ? const Text(
                                'Finalizar',
                                style: TextStyle(
                                  fontSize: 17,
                                  color: Colors.white,
                                ),
                              )
                            : const SizedBox(
                                width: 20,
                                height: 20,
                                child: CircularProgressIndicator(
                                  color: Colors.white,
                                  strokeWidth: 2,
                                ),
                              ),
                        onPressed: () {
                          if (retrievedCustomer != null) {
                            EasyDebounce.debounce('finalized-buy-service-web',
                                const Duration(milliseconds: 500), () async {
                              setState(() => loading = true);

                              ResponseCreateSchedule response =
                                  await createSchedule.createSchedule(
                                retrievedCustomer.customerId,
                                widget.barberShop.barbershopId!,
                                retrievedCustomer.token,
                                listResumePayment.state.transactionAmount!,
                                listResumePayment
                                        .state.promotionalCodeDiscount ??
                                    0,
                                listResumePayment
                                        .state.promotionalCodePercent ??
                                    0,
                                listResumePayment.state.services,
                              );
                              if (response.status == 'success') {
                                _trackFinalizeEvent(
                                    retrievedCustomer.customerId);
                                totalPriceProvider
                                    .state.totalPriceWithoutDicount = null;
                                totalPriceProvider.state.discount = null;
                                totalPriceProvider
                                    .state.totalPriceWithoutDicount = null;
                                Navigator.of(context)
                                    .pushNamed('/approved', arguments: {
                                  'services': List.generate(
                                      listResumePayment.state.services.length,
                                      (index) {
                                    final service =
                                        listResumePayment.state.services[index];
                                    final cachedService =
                                        serviceCache.state.isNotEmpty
                                            ? serviceCache.state[index]
                                            : null;

                                    return {
                                      'service_observation':
                                          cachedService?.observation ?? '',
                                      'barbershop_phone': removeNonNumeric(
                                          cachedService?.professional
                                                  ?.barbershop?.phone ??
                                              ''),
                                      'professional_name':
                                          cachedService?.professional?.name ??
                                              '',
                                      'service_name':
                                          cachedService?.service?.name ?? '',
                                      'service_date':
                                          formatDateStr(service.date),
                                      'service_hour':
                                          service.serviceInitialHour,
                                    };
                                  }),
                                });

                                serviceCache.state.clear();
                                listResumePayment.state.clear();
                              } else {
                                showSnackBar(context, 'Erro ao marcar serviço');
                              }
                            });
                          } else {
                            showCustomDialog(
                              context,
                              FittingServiceDialog(
                                barberShop: widget.barberShop,
                              ),
                            );
                          }
                        },
                      ),
                    ),
                  )
                ],
              ),
            ],
          ),
        );
      },
    );
  }
}

class FittingServiceDialog extends StatefulWidget {
  FittingServiceDialog({
    Key? key,
    required this.barberShop,
  }) : super(key: key);
  bool passedTest = false;
  final BarberShop barberShop;

  @override
  State<FittingServiceDialog> createState() => _FittingServiceDialogState();
}

class _FittingServiceDialogState extends State<FittingServiceDialog> {
  final dio = Dio(BaseOptions(
    baseUrl: baseURLV1,
  ));
  var loading = false;
  int _state = 0;
  static final RegExp nameRegExp =
      RegExp(r'^[A-Za-záàâãéèêíïóôõöúçñÁÀÂÃÉÈÍÏÓÔÕÖÚÇÑ ]+$');
  int selectedItem = 0;
  String birthdate = '2000-07-06';
  final TextEditingController phoneController = TextEditingController();
  final TextEditingController passwordController = TextEditingController();
  TextEditingController nameController = TextEditingController();
  TextEditingController birthDateController = TextEditingController();
  TextEditingController emailEditController = TextEditingController();
  DateTime date = DateTime(2018, 28, 10);
  final GlobalKey<FlutterPwValidatorState> validatorKey =
      GlobalKey<FlutterPwValidatorState>();

  final List<String> _listgener = <String>[
    'Selecione o gênero',
    'Masculino',
    'Feminino'
  ];

  @override
  Widget build(BuildContext context) {
    ReqCreateCustomerModel customer;
    return Consumer(
      builder: (context, ref, child) {
        CustomerDB? retrievedCustomer = LocalStorageManager.getCustomer();
        final authEmailController =
            ref.read(AuthEmailStateController.provider.notifier);
        final customerRegisterController =
            ref.watch(customerRegisterProvider.notifier);
        final loginController =
            ref.read(LoginStateController.provider.notifier);
        var fBTokenController = ref.watch(fBTokenProvider.state);
        final createSchedule =
            ref.watch(CreateScheduleStateController.provider.notifier);
        var serviceCache = ref.watch(listServicesCacheProvider.state);
        final listResumePayment = ref.watch(listResumePaymentProvider.notifier);
        return Dialog(
          insetPadding: EdgeInsets.zero,
          backgroundColor: Colors.transparent,
          child: SingleChildScrollView(
            child: SizedBox(
              width: 500,
              child: SingleChildScrollView(
                child: AlertDialog(
                  titlePadding: EdgeInsets.zero,
                  contentPadding: EdgeInsets.zero,
                  alignment: Alignment.center,
                  shape: const RoundedRectangleBorder(
                    borderRadius: BorderRadius.all(
                      Radius.circular(32.0),
                    ),
                  ),
                  scrollable: true,
                  backgroundColor: colorBackground181818,
                  title: Padding(
                    padding: const EdgeInsets.only(top: 20),
                    child: SizedBox(
                      width: 22,
                      child: const Text(
                        textAlign: TextAlign.center,
                        'Falta pouco...',
                        style: TextStyle(color: Colors.white),
                      ),
                    ),
                  ),
                  content: SingleChildScrollView(
                    child: Column(
                      children: [
                        Padding(
                          padding: const EdgeInsets.only(top: 20, bottom: 10),
                          child: TextEditPatternWeb(
                            label: 'Nome completo',
                            obscure: false,
                            maxLength: 100,
                            controller: nameController,
                            hint: 'Digite o seu nome completo',
                            keyboardType: TextInputType.name,
                          ),
                        ),
                        Padding(
                          padding: const EdgeInsets.only(bottom: 10),
                          child: TextEditPatternWeb(
                            label: 'E-mail',
                            obscure: false,
                            maxLength: 100,
                            controller: emailEditController,
                            hint: 'Digite seu e-mail',
                            keyboardType: TextInputType.emailAddress,
                          ),
                        ),
                        Padding(
                          padding: const EdgeInsets.only(bottom: 10),
                          child: TextEditPatternWeb(
                            label: 'Data de nascimento',
                            obscure: false,
                            maxLength: 10,
                            controller: birthDateController,
                            hint: 'DD/MM/AAAA',
                            keyboardType: TextInputType.number,
                            inputFormatters: [
                              FilteringTextInputFormatter
                                  .digitsOnly, // Aceita apenas números
                              LengthLimitingTextInputFormatter(
                                  10), // Limita a 10 caracteres
                              DateInputFormatter(),
                            ],
                          ),
                        ),
                        Padding(
                          padding: const EdgeInsets.only(bottom: 10),
                          child: TextEditPatternWeb(
                            mask: TelefoneInputFormatter(),
                            maxLength: 30,
                            controller: phoneController,
                            label: 'Telefone / WhatsApp',
                            hint: 'Digite o telefone',
                            obscure: false,
                            keyboardType: TextInputType.number,
                          ),
                        ),
                        Padding(
                          padding: const EdgeInsets.only(bottom: 5),
                          child: TextEditPatternWeb(
                            label: 'Senha',
                            obscure: false,
                            maxLength: 50,
                            controller: passwordController,
                            hint: 'Digite uma senha',
                            keyboardType: TextInputType.emailAddress,
                          ),
                        ),
                        Padding(
                          padding: EdgeInsets.symmetric(
                            horizontal: 20,
                            vertical: 10,
                          ),
                          child: SizedBox(
                            width: MediaQuery.of(context).size.width,
                            child: FlutterPwValidator(
                              key: validatorKey,
                              controller: passwordController,
                              strings: FlutterPwValidatorNavalha(),
                              minLength: 8,
                              uppercaseCharCount: 1,
                              numericCharCount: 1,
                              failureColor:
                                  const Color.fromARGB(255, 227, 90, 80),
                              width: 300,
                              height: 80,
                              onSuccess: () {
                                widget.passedTest = true;
                              },
                              onFail: () {},
                            ),
                          ),
                        ),
                        Padding(
                          padding: const EdgeInsets.symmetric(
                              horizontal: 20, vertical: 20),
                          child: ElevatedButton(
                            style: ButtonStyle(
                              overlayColor: MaterialStateProperty.all<Color>(
                                colorContainers353535,
                              ),
                              elevation: MaterialStateProperty.all(0),
                              backgroundColor: MaterialStateProperty.all<Color>(
                                  const Color.fromARGB(255, 28, 28, 28)),
                              shape: MaterialStateProperty.all<
                                  RoundedRectangleBorder>(
                                RoundedRectangleBorder(
                                  borderRadius: BorderRadius.circular(12),
                                ),
                              ),
                            ),
                            onPressed: () async {
                              if (nameController.text.trim().isEmpty) {
                                showErrorDialog(context, 'Digite seu nome');
                              } else if (nameController.text.length < 4) {
                                showErrorDialog(context, 'Nome muito curto');
                              } else if (!nameRegExp
                                  .hasMatch(nameController.text)) {
                                showErrorDialog(context, 'Nome inválido');
                              } else if (!nameController.text.contains(' ')) {
                                showErrorDialog(
                                  context,
                                  'Digite o nome completo',
                                );
                              } else if (!EmailValidator.validate(
                                  emailEditController.text)) {
                                showErrorDialog(
                                    context, 'Digite um email válido');
                              } else if (!verificarDataValida(
                                  birthDateController.text)) {
                                showErrorDialog(context,
                                    'Digite uma data de nascimento válida');
                              } else if (phoneController.text.length < 14) {
                                showErrorDialog(context, 'Telefone inválido');
                              } else if (passwordController.text.isEmpty) {
                                showErrorDialog(context, 'Digite uma senha');
                              } else if (!widget.passedTest) {
                                showErrorDialog(context, 'Senha não segura');
                              } else if (!possuiLetraMaiuscula(
                                  passwordController.text.trim())) {
                                showErrorDialog(context,
                                    'A senha deve conter alguma letra maiúscula!');
                              } else {
                                setState(() => loading = true);
                                final adressEmail =
                                    await authEmailController.authEmail(
                                        emailEditController.text.trim(), false);
                                if (adressEmail.result == 'already_exists') {
                                  showCustomDialog(context,
                                      const AlreadyExistsEmailDialog());
                                  setState(() {
                                    loading = false;
                                    emailEditController.text = '';
                                  });
                                } else if (adressEmail.result !=
                                    'already_exists') {
                                  customer = ReqCreateCustomerModel(
                                    birthDate: UtilText.formatDate(date),
                                    email: emailEditController.text.trim(),
                                    externalAccount: false,
                                    gener: null,
                                    name: nameController.text.trim(),
                                    password: passwordController.text.trim(),
                                    phone: phoneController.text.trim(),
                                    postalCode: '89041080',
                                  );
                                  final createCustomerResponse =
                                      await CreateCustomerUseCase(
                                    repository: CustomerRepository(
                                      customerEndPoint: CustomerEndPoint(dio),
                                    ),
                                  ).execute(customer);
                                  if (createCustomerResponse.status ==
                                      'success') {
                                    var response = await loginController.login(
                                      customer.email!,
                                      customer.password!,
                                      fBTokenController.state,
                                    );
                                    if (response.runtimeType == DioError) {
                                      setState(() {
                                        _state = 0;
                                      });

                                      loginController.user = null;
                                      Navigator.of(context).pushNamed('/login');
                                    } else if (response.status == 'success') {
                                      LocalStorageManager.saveCustomer(
                                        CustomerDB(
                                          name: response.customer.name,
                                          image: response.customer.imgProfile,
                                          customerId:
                                              response.customer.customerId,
                                          token: response.token,
                                          email: response.customer.email,
                                          birthDate:
                                              response.customer.birthDate,
                                          userID: '',
                                          password: customer.password!,
                                        ),
                                      );
                                      //marcando serviço
                                      ResponseCreateSchedule
                                          responseCreateAppointment =
                                          await createSchedule.createSchedule(
                                        response.customer.customerId,
                                        widget.barberShop.barbershopId!,
                                        response.token,
                                        listResumePayment
                                            .state.transactionAmount!,
                                        listResumePayment.state
                                                .promotionalCodeDiscount ??
                                            0,
                                        listResumePayment
                                                .state.promotionalCodePercent ??
                                            0,
                                        listResumePayment.state.services,
                                      );
                                      if (responseCreateAppointment.status ==
                                          'success') {
                                        Navigator.of(context)
                                            .pushNamed('/approved', arguments: {
                                          'service_observation': serviceCache
                                              .state.first.observation,
                                          'barbershop_phone': removeNonNumeric(
                                              serviceCache
                                                  .state
                                                  .first
                                                  .professional
                                                  ?.barbershop
                                                  ?.phone),
                                          'professional_name': serviceCache
                                                  .state
                                                  .first
                                                  .professional
                                                  ?.name ??
                                              '',
                                          'service_name': serviceCache
                                                  .state.first.service?.name ??
                                              '',
                                          'service_date': formatDateStr(
                                              listResumePayment
                                                  .state.services.first.date),
                                          'service_hour': listResumePayment
                                              .state
                                              .services
                                              .first
                                              .serviceInitialHour,
                                        });
                                        serviceCache.state.clear();
                                        listResumePayment.state.clear();
                                      } else {
                                        showSnackBar(
                                            context, 'Erro ao marcar serviço');
                                      }
                                      setState(() {
                                        _state = 2;
                                      });
                                    }
                                  } else {
                                    setState(() => loading = false);
                                    showSnackBar(
                                      context,
                                      'Desculpe, ocorreu um problema. Por favor, entre em contato com o suporte pelo site para que possamos resolver o seu problema de cadastro.',
                                    );
                                  }
                                }
                              }
                            },
                            child: Padding(
                              padding: const EdgeInsets.symmetric(
                                  vertical: 10, horizontal: 5),
                              child: Center(
                                child: Row(
                                  mainAxisAlignment: MainAxisAlignment.center,
                                  children: [
                                    loading
                                        ? const SizedBox(
                                            width: 20,
                                            height: 20,
                                            child: CircularProgressIndicator(
                                              color: Colors.white,
                                              strokeWidth: 2,
                                            ),
                                          )
                                        : Row(
                                            children: const [
                                              Icon(
                                                Icons.check_circle_sharp,
                                                color: Colors.white,
                                              ),
                                              SizedBox(width: 15),
                                              Text(
                                                'Agendar',
                                                style: TextStyle(
                                                  color: Colors.white,
                                                ),
                                              ),
                                            ],
                                          ),
                                  ],
                                ),
                              ),
                            ),
                          ),
                        ),
                      ],
                    ),
                  ),
                ),
              ),
            ),
          ),
        );
      },
    );
  }
}

class AlreadyExistsEmailDialog extends StatefulWidget {
  const AlreadyExistsEmailDialog({Key? key}) : super(key: key);

  @override
  State<AlreadyExistsEmailDialog> createState() =>
      _AlreadyExistsEmailDialogState();
}

class _AlreadyExistsEmailDialogState extends State<AlreadyExistsEmailDialog> {
  @override
  Widget build(BuildContext context) {
    final size = MediaQuery.of(context).size;
    return Consumer(
      builder: (context, ref, child) {
        return Dialog(
          backgroundColor: Colors.transparent,
          child: SizedBox(
            width: 500,
            child: AlertDialog(
              alignment: Alignment.center,
              shape: const RoundedRectangleBorder(
                borderRadius: BorderRadius.all(
                  Radius.circular(32.0),
                ),
              ),
              scrollable: true,
              backgroundColor: colorBackground181818,
              title: const Center(
                // Centraliza o título
                child: Text(
                  'Você já possui conta!',
                  textAlign: TextAlign.center,
                  style: TextStyle(color: Colors.white),
                ),
              ),
              content: Text(
                'O que você deseja fazer?',
                textAlign: TextAlign.center,
                style:
                    TextStyle(color: const Color.fromARGB(255, 188, 188, 188)),
              ),
              actionsAlignment: MainAxisAlignment.center, // Centraliza as ações
              actions: [
                Center(
                  child: Column(
                    // Coluna para centralizar os botões
                    mainAxisSize: MainAxisSize.min,
                    children: [
                      ButtonPatternDialog(
                        width: size.width * 0.35,
                        onPressed: () {
                          Navigator.of(context).pushNamed('/login');
                        },
                        color: colorContainers242424,
                        child: const Text(
                          'Fazer login',
                          style: TextStyle(
                            fontSize: 15,
                            color: Colors.white,
                          ),
                        ),
                      ),
                      const SizedBox(height: 10), // Espaçamento entre os botões
                      ButtonPatternDialog(
                        width: size.width * 0.35,
                        onPressed: () {
                          Navigator.pop(context);
                        },
                        color: colorContainers242424,
                        child: const Text(
                          'Cadastrar com outro e-mail',
                          style: TextStyle(
                            fontSize: 15,
                            color: Colors.white,
                          ),
                        ),
                      ),
                    ],
                  ),
                ),
              ],
            ),
          ),
        );
      },
    );
  }
}

bool verificarDataValida(String data) {
  // Verifica se a string está no formato correto
  RegExp regex = RegExp(r'^(\d{2})\/(\d{2})\/(\d{4})$');
  if (!regex.hasMatch(data)) {
    return false;
  }

  // Divide a string em dia, mês e ano
  List<String> partes = data.split('/');
  int dia = int.parse(partes[0]);
  int mes = int.parse(partes[1]);
  int ano = int.parse(partes[2]);

  // Verifica se o mês está entre 1 e 12
  if (mes < 1 || mes > 12) {
    return false;
  }

  // Verifica o número de dias em cada mês
  List<int> diasPorMes = [31, 28, 31, 30, 31, 30, 31, 31, 30, 31, 30, 31];

  // Verifica se é um ano bissexto e ajusta fevereiro
  if ((ano % 4 == 0 && ano % 100 != 0) || ano % 400 == 0) {
    diasPorMes[1] = 29;
  }

  // Verifica se o dia é válido para o mês
  if (dia < 1 || dia > diasPorMes[mes - 1]) {
    return false;
  }

  // Verifica se a data é futura
  DateTime dataAtual = DateTime.now();
  DateTime dataFornecida = DateTime(ano, mes, dia);

  if (dataFornecida.isAfter(dataAtual)) {
    return false; // Data futura
  }

  return true;
}

void showErrorDialog(BuildContext context, String message) {
  showDialog(
    context: context,
    builder: (BuildContext context) {
      return AlertDialog(
        alignment: Alignment.center,
        shape: const RoundedRectangleBorder(
          borderRadius: BorderRadius.all(
            Radius.circular(32.0),
          ),
        ),
        scrollable: true,
        backgroundColor: colorBackground181818,
        title: const Text('Erro'),
        content: Text(message),
        actions: <Widget>[
          Container(
            margin: const EdgeInsets.only(left: 10, right: 5),
            height: 35,
            decoration: BoxDecoration(
              color: colorContainers242424,
              borderRadius: const BorderRadius.all(
                Radius.circular(14),
              ),
            ),
            child: ElevatedButton(
              style: ButtonStyle(
                overlayColor: MaterialStateProperty.all<Color>(
                  colorContainers353535,
                ),
                elevation: MaterialStateProperty.all(0),
                backgroundColor: MaterialStateProperty.all<Color>(
                  colorContainers242424,
                ),
                shape: MaterialStateProperty.all<RoundedRectangleBorder>(
                  RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(14),
                  ),
                ),
              ),
              child: const Text(
                'Ok',
                style: TextStyle(fontSize: 15, color: Colors.white),
              ),
              onPressed: () {
                Navigator.pop(context);
              },
            ),
          ),
        ],
      );
    },
  );
}
