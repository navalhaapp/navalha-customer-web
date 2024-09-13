// ignore_for_file: use_build_context_synchronously

import 'dart:io';
import 'package:brasil_fields/brasil_fields.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:image_picker/image_picker.dart';
import 'package:navalha/core/assets.dart';
import 'package:navalha/core/colors.dart';
import 'package:navalha/mobile/customer_registration/customer_registration.dart';
import 'package:navalha/mobile/drawer/drawer_page.dart';
import 'package:navalha/mobile/edit_profile/model/update_model_customer.dart';
import 'package:navalha/mobile/edit_profile/widget/image_picker_botton_sheet.dart';
import 'package:navalha/mobile/edit_profile/widget/name_user.dart';
import 'package:navalha/mobile/home/home_page.dart';
import 'package:navalha/mobile/registration_types_page/registration_types_page.dart';
import 'package:navalha/shared/model/edit_profile_model.dart';
import 'package:navalha/shared/widgets/cupertino_date_picker.dart';
import '../../core/images_s3.dart';
import '../login/controller/login_controller.dart';
import '../../shared/animation/page_trasition.dart';
import '../../shared/model/customer_model.dart';
import '../../shared/providers.dart';
import '../../shared/utils.dart';
import '../../shared/widgets/text_edit.dart';
import '../../shared/widgets/widget_empty.dart';
import 'controller/update_controller_customer.dart';
import 'dart:core';

class EditProfilePage extends StatefulHookConsumerWidget {
  const EditProfilePage({Key? key}) : super(key: key);

  @override
  ConsumerState<EditProfilePage> createState() => _EditProfilePageState();
  static const route = '/edit-profile-page';
}

class _EditProfilePageState extends ConsumerState<EditProfilePage> {
  static final RegExp nameRegExp =
      RegExp(r'^[A-Za-záàâãéèêíïóôõöúçñÁÀÂÃÉÈÍÏÓÔÕÖÚÇÑ ]+$');
  final TextEditingController nameController = TextEditingController();
  final TextEditingController emailController = TextEditingController();
  final TextEditingController phoneController = TextEditingController();
  final TextEditingController birthDateController = TextEditingController();
  final TextEditingController passwordController = TextEditingController();
  final TextEditingController postalCodeController = TextEditingController();
  late StateController<EditProfileCacheController> editProfileCache;
  var loginController;
  bool isLoading = false;
  bool isSuccess = false;
  String birthdate = '2000-07-06';
  ImagePicker imagePicker = ImagePicker();
  bool firstTime = true;
  File? imageSelected;
  int _state = 0;

  getImageGallery() async {
    final XFile? imageTemporary = await imagePicker.pickImage(
      source: ImageSource.gallery,
      maxHeight: 300,
      maxWidth: 300,
    );
    if (imageTemporary != null) {
      setState(() {
        imageSelected = File(imageTemporary.path);
      });
    }
  }

  getImageCamera() async {
    final XFile? imageTemporary = await imagePicker.pickImage(
      source: ImageSource.camera,
      maxHeight: 300,
      maxWidth: 300,
    );
    if (imageTemporary != null) {
      setState(() {
        imageSelected = File(imageTemporary.path);
      });
    }
  }

  String putMaskCep(String value) {
    final length = value.length;
    if (length == 8) {
      return value.replaceFirstMapped(RegExp(r'^(\d{2})(\d{3})(\d{3})$'),
          (match) => '${match[1]}.${match[2]}-${match[3]}');
    } else {
      return value;
    }
  }

  String formatPhoneNumber(String unformattedPhoneNumber) {
    String formattedPhoneNumber = unformattedPhoneNumber.padLeft(11, '0');
    if (!RegExp(r'\(\d{2}\) \d{1} \d{4}-\d{4}|\(\d{2}\) \d{4}-\d{4}')
        .hasMatch(formattedPhoneNumber)) {
      if (formattedPhoneNumber.length == 11) {
        formattedPhoneNumber =
            '(${formattedPhoneNumber.substring(0, 2)}) ${formattedPhoneNumber.substring(2, 3)} ${formattedPhoneNumber.substring(3, 7)}-${formattedPhoneNumber.substring(7, 11)}';
      } else {
        formattedPhoneNumber =
            '(${formattedPhoneNumber.substring(0, 2)}) ${formattedPhoneNumber.substring(2, 6)}-${formattedPhoneNumber.substring(6, 10)}';
      }
    }
    return formattedPhoneNumber;
  }

  getCustomerInfo() {
    loginController = ref.read(LoginStateController.provider.notifier);

    if (loginController.user != null) {
      nameController.text = loginController.user!.customer!.name!;
      postalCodeController.text =
          putMaskCep(loginController.user!.customer!.postalCode!);
      phoneController.text = loginController.user!.customer!.phone!;
      birthdate = loginController.user!.customer!.birthDate!;
    }

    editProfileCache = ref.watch(editProfilePageCache.state);
    if (editProfileCache.state.name != '') {
      nameController.text = editProfileCache.state.name!;
    }
    if (editProfileCache.state.phone != '') {
      phoneController.text = formatPhoneNumber(editProfileCache.state.phone!);
    }
    if (editProfileCache.state.birthDate != '') {
      birthdate = editProfileCache.state.birthDate!;
    }
    firstTime = false;
  }

  @override
  Widget build(BuildContext context) {
    if (firstTime) getCustomerInfo();
    Size size = MediaQuery.of(context).size;
    return WillPopScope(
      onWillPop: () async {
        Navigator.pushNamed(context, HomePage.route);
        return true;
      },
      child: SafeArea(
        top: false,
        child: Consumer(
          builder: (context, ref, child) {
            final loginController =
                ref.read(LoginStateController.provider.notifier);
            return Scaffold(
              extendBodyBehindAppBar: true,
              extendBody: true,
              backgroundColor: colorBackground181818,
              appBar: AppBar(
                centerTitle: true,
                title: const Text(
                  style: TextStyle(fontSize: 17),
                  'Editar perfil',
                ),
                backgroundColor: Colors.transparent,
                elevation: 0,
                leading: IconButton(
                  icon: const Icon(Icons.arrow_back_ios_new, size: 17),
                  onPressed: () {
                    Navigator.pushNamed(context, HomePage.route);
                  },
                ),
              ),
              endDrawer: const DrawerPage(),
              body: loginController.user == null
                  ? Center(
                      child: WidgetEmpty(
                        title: 'Você não possui conta!',
                        subTitle:
                            'Crie uma conta para começar a aproveitar o navalha',
                        text: 'Registrar-se',
                        onPressed: () {
                          navigationWithFadeAnimation(
                              const RegistrationTypesPage(), context);
                        },
                      ),
                    )
                  : SingleChildScrollView(
                      child: Consumer(
                        builder: (context, ref, child) {
                          return Center(
                            child: Visibility(
                              visible: loginController.user == null,
                              replacement: Column(
                                children: [
                                  SizedBox(
                                    height: MediaQuery.of(context).size.height *
                                        0.12,
                                  ),
                                  Padding(
                                    padding: const EdgeInsets.only(bottom: 5),
                                    child: Stack(
                                      alignment: AlignmentDirectional.center,
                                      children: [
                                        imageSelected == null
                                            ? Container(
                                                margin:
                                                    const EdgeInsets.symmetric(
                                                        horizontal: 10),
                                                width: MediaQuery.of(context)
                                                        .size
                                                        .width *
                                                    0.3,
                                                height: MediaQuery.of(context)
                                                        .size
                                                        .width *
                                                    0.3,
                                                child: ClipOval(
                                                  child:
                                                      FadeInImage.assetNetwork(
                                                    placeholder: imgLoading3,
                                                    image: loginController
                                                            .user
                                                            ?.customer
                                                            ?.imgProfile ??
                                                        '',
                                                    fit: BoxFit.cover,
                                                  ),
                                                ),
                                              )
                                            : Container(
                                                margin:
                                                    const EdgeInsets.symmetric(
                                                        horizontal: 10),
                                                width: MediaQuery.of(context)
                                                        .size
                                                        .width *
                                                    0.3,
                                                height: MediaQuery.of(context)
                                                        .size
                                                        .width *
                                                    0.3,
                                                decoration: BoxDecoration(
                                                  shape: BoxShape.circle,
                                                  image: DecorationImage(
                                                    image: FileImage(
                                                        imageSelected!),
                                                    fit: BoxFit.cover,
                                                  ),
                                                ),
                                              ),
                                        CircleAvatar(
                                          radius: size.width * 0.15,
                                          backgroundColor: const Color.fromARGB(
                                              150, 0, 0, 0),
                                        ),
                                        Positioned(
                                          left: size.width * 0.24,
                                          top: size.height * 0.092,
                                          child: CircleAvatar(
                                            radius: size.width * 0.05,
                                            backgroundColor: Colors.black,
                                            child: IconButton(
                                              onPressed: () {
                                                showModalBottomSheet<void>(
                                                  backgroundColor: Colors.black,
                                                  shape: RoundedRectangleBorder(
                                                    borderRadius:
                                                        BorderRadius.circular(
                                                            20),
                                                  ),
                                                  context: context,
                                                  builder:
                                                      (BuildContext context) {
                                                    return ImagePickerBottonSheet(
                                                      onTapTakeGallery: () {
                                                        Navigator.pop(context);
                                                        getImageGallery();
                                                      },
                                                      onTapTakePhoto: () {
                                                        Navigator.pop(context);
                                                        getImageCamera();
                                                      },
                                                    );
                                                  },
                                                );
                                              },
                                              icon: Icon(
                                                size: MediaQuery.of(context)
                                                        .size
                                                        .width *
                                                    0.06,
                                                Icons.edit,
                                                color: const Color.fromARGB(
                                                    162, 255, 255, 255),
                                              ),
                                              splashColor: Colors.transparent,
                                              highlightColor:
                                                  Colors.transparent,
                                            ),
                                          ),
                                        ),
                                      ],
                                    ),
                                  ),
                                  NameUser(
                                    name:
                                        loginController.user?.customer?.name ??
                                            'Usuário',
                                  ),
                                  SizedBox(
                                      height:
                                          MediaQuery.of(context).size.height *
                                              0.05),
                                  TextEditPattern(
                                    onChange: () {
                                      editProfileCache.state.name =
                                          nameController.text;
                                    },
                                    margin: EdgeInsets.symmetric(
                                      horizontal:
                                          MediaQuery.of(context).size.width *
                                              0.03,
                                      vertical:
                                          MediaQuery.of(context).size.height *
                                              0.01,
                                    ),
                                    maxLength: 50,
                                    controller: nameController,
                                    label: 'Nome completo',
                                    hint: 'Digite o nome',
                                    obscure: false,
                                    keyboardType: TextInputType.name,
                                    color: colorContainers242424,
                                  ),
                                  TextEditPattern(
                                    margin: EdgeInsets.symmetric(
                                      horizontal:
                                          MediaQuery.of(context).size.width *
                                              0.03,
                                      vertical:
                                          MediaQuery.of(context).size.height *
                                              0.01,
                                    ),
                                    mask: CepInputFormatter(),
                                    maxLength: 30,
                                    controller: postalCodeController,
                                    label: 'CEP',
                                    hint: 'Digite o CEP',
                                    obscure: false,
                                    keyboardType: TextInputType.name,
                                    color: colorContainers242424,
                                  ),
                                  TextEditPattern(
                                    margin: EdgeInsets.symmetric(
                                      horizontal:
                                          MediaQuery.of(context).size.width *
                                              0.03,
                                      vertical:
                                          MediaQuery.of(context).size.height *
                                              0.01,
                                    ),
                                    mask: TelefoneInputFormatter(),
                                    maxLength: 30,
                                    controller: phoneController,
                                    label: 'Telefone',
                                    hint: 'Digite o telefone',
                                    obscure: false,
                                    keyboardType: TextInputType.name,
                                    color: colorContainers242424,
                                  ),
                                  CupertinoDataPicker(
                                    label: 'Data de nascimento',
                                    color: colorContainers242424,
                                    marginHorizontal:
                                        MediaQuery.of(context).size.width *
                                            0.05,
                                    date: parseStringYYYYmmDDtoDateTime(
                                        birthdate),
                                    picker: CupertinoDatePicker(
                                      dateOrder: DatePickerDateOrder.dmy,
                                      initialDateTime:
                                          parseStringYYYYmmDDtoDateTime(
                                              birthdate),
                                      mode: CupertinoDatePickerMode.date,
                                      use24hFormat: true,
                                      maximumYear: DateTime.now().year,
                                      onDateTimeChanged: (DateTime newDate) {
                                        setState(() {
                                          birthdate =
                                              parseDateTimeToStringYYYYmmDD(
                                                  newDate);
                                        });
                                      },
                                    ),
                                  ),
                                  SizedBox(height: size.height * 0.2)
                                ],
                              ),
                              child: WidgetEmpty(
                                title: 'Você não possui conta!',
                                subTitle:
                                    'Crie uma conta para começar a aproveitar o navalha',
                                text: 'Registrar-se',
                                onPressed: () {
                                  navigationWithFadeAnimation(
                                      const CustomerRegistrationPage(),
                                      context);
                                },
                              ),
                            ),
                          );
                        },
                      ),
                    ),
              floatingActionButton: loginController.user?.customer == null
                  ? const SizedBox()
                  : Consumer(
                      builder: (context, ref, child) {
                        final updateController =
                            ref.watch(UpdateStateController.provider.notifier);
                        final loginController =
                            ref.read(LoginStateController.provider.notifier);
                        final String token1 = loginController.user!.token!;
                        return GestureDetector(
                          onTap: () async {
                            if (nameController.text.trim().isEmpty) {
                              showSnackBar(context, 'Digite seu nome');
                            } else if (nameController.text.length < 4) {
                              showSnackBar(context, 'Nome muito curto');
                            } else if (!nameRegExp
                                .hasMatch(nameController.text)) {
                              showSnackBar(context, 'Nome inválido');
                            } else if (!nameController.text.contains(' ')) {
                              showSnackBar(
                                context,
                                'Digite o nome completo',
                              );
                            } else if (postalCodeController.text.length < 10) {
                              showSnackBar(context,
                                  'Não conseguimos encontrar seu cep!');
                            } else if (phoneController.text.isEmpty) {
                              showSnackBar(context, 'Telefone inválido');
                            } else if (phoneController.text.trim().length <
                                14) {
                              showSnackBar(
                                context,
                                'Telefone inválido',
                              );
                            } else {
                              setState(() {
                                isLoading = true;
                              });

                              editProfileCache.state.name =
                                  nameController.text.trim();
                              editProfileCache.state.postalCode =
                                  postalCodeController.text.trim();
                              editProfileCache.state.phone =
                                  phoneController.text.trim();
                              editProfileCache.state.birthDate = birthdate;

                              nameController.text =
                                  editProfileCache.state.name!;
                              postalCodeController.text =
                                  editProfileCache.state.postalCode!;
                              phoneController.text =
                                  editProfileCache.state.phone!;
                              birthdate = editProfileCache.state.birthDate!;

                              Map<String, dynamic> customerMap = {
                                "customer_id":
                                    loginController.user!.customer!.customerId,
                                "name": nameController.text.trim(),
                                "postal_code": removerMascaraCEP(
                                    postalCodeController.text.trim()),
                                "phone": phoneController.text.trim(),
                                "birth_date": formatDateMMddYYYY(birthdate),
                              };
                              IResponseUpdateCustomer response =
                                  await updateController.updatecustomer(
                                      token1,
                                      Customer.fromJson(customerMap),
                                      imageSelected);
                              if (response.status == 'error') {
                                response as CustomerModelResponseError;
                                if (response.result == 'invalid_postal_code') {
                                  showSnackBar(
                                    context,
                                    'Não conseguimos encontrar seu cep!',
                                  );
                                  setState(() {
                                    isLoading = false;
                                  });
                                } else {
                                  showSnackBar(
                                    context,
                                    'Ops, algo aconteceu',
                                  );
                                  setState(() {
                                    isLoading = false;
                                  });
                                }
                              } else {
                                response as CustomerModelResponse;
                                setState(() {
                                  isLoading = false;
                                  isSuccess = true;
                                  Future.delayed(const Duration(seconds: 1))
                                      .then((_) {
                                    setState(() {
                                      isSuccess = false;
                                    });
                                  });
                                  Future.delayed(
                                          const Duration(milliseconds: 1100))
                                      .then((_) {
                                    setState(() {
                                      Navigator.pop(context);
                                    });
                                  });
                                });
                                Customer customer =
                                    loginController.user!.customer!;
                                Customer updateCustomer = response.result!;
                                loginController
                                        .user?.customer?.postalCodeCoordinates =
                                    response.result!.postalCodeCoordinates!;
                                if (imageSelected == null) {
                                  customer.name = updateCustomer.name;
                                  customer.postalCode =
                                      updateCustomer.postalCode;
                                  customer.phone = updateCustomer.phone;
                                  customer.birthDate = updateCustomer.birthDate;
                                } else {
                                  loginController.user!.customer!.imgProfile =
                                      updateController.user!.result.imgProfile;
                                }
                                setState(() {
                                  _state = 3;
                                });

                                showSnackBar(
                                  context,
                                  'Dados atualizados!',
                                );
                                Future.delayed(
                                        const Duration(milliseconds: 1200))
                                    .then((value) {
                                  navigationWithFadeAnimation(
                                      const HomePage(), context);
                                });
                              }
                            }
                          },
                          child: AnimatedContainer(
                            duration: const Duration(milliseconds: 200),
                            width: isSuccess
                                ? MediaQuery.of(context).size.height * 0.09
                                : MediaQuery.of(context).size.height * 0.085,
                            height: isSuccess
                                ? MediaQuery.of(context).size.height * 0.09
                                : MediaQuery.of(context).size.height * 0.085,
                            decoration: BoxDecoration(
                              boxShadow: shadow,
                              borderRadius: BorderRadius.circular(100),
                              color: isSuccess
                                  ? Colors.green
                                  : colorBackground181818,
                            ),
                            child: Center(
                              child: isLoading
                                  ? const SizedBox(
                                      width: 20,
                                      height: 20,
                                      child: CircularProgressIndicator(
                                        strokeWidth: 2,
                                        valueColor:
                                            AlwaysStoppedAnimation<Color>(
                                                Colors.white),
                                      ),
                                    )
                                  : isSuccess
                                      ? const Icon(
                                          Icons.check,
                                          color: Colors.white,
                                          size: 30,
                                        )
                                      : Text(
                                          'Salvar',
                                          style: TextStyle(
                                            fontFamily: "Mansny regular",
                                            color: Colors.white,
                                            fontSize: MediaQuery.of(context)
                                                    .size
                                                    .height *
                                                0.018,
                                          ),
                                        ),
                            ),
                          ),
                        );
                      },
                    ),
            );
          },
        ),
      ),
    );
  }

  String removerMascaraCEP(String cep) {
    String cepSemMascara = cep.replaceAll(RegExp(r'[^\d]'), '');

    return cepSemMascara;
  }

  Widget setUpButtonChild() {
    if (_state == 0) {
      return const Icon(Icons.check, color: Colors.white, size: 35);
    } else if (_state == 1) {
      return const CircularProgressIndicator(
        valueColor: AlwaysStoppedAnimation<Color>(Colors.white),
      );
    } else {
      return const Icon(Icons.check, color: Colors.white, size: 35);
    }
  }
}

class _IconPattern extends StatelessWidget {
  const _IconPattern({
    Key? key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Icon(
      Icons.arrow_forward_ios_rounded,
      color: colorWhite255255255,
      size: 15,
    );
  }
}

class _ButtonChangePassword extends StatelessWidget {
  const _ButtonChangePassword({
    Key? key,
    required this.label,
    required this.value,
    required this.onT,
  }) : super(key: key);

  final Text label;
  final Widget value;
  final Function onT;

  @override
  Widget build(BuildContext context) {
    final size = MediaQuery.of(context).size;
    return Column(
      children: [
        const SizedBox(height: 10),
        Container(
          decoration: BoxDecoration(
            color: colorContainers242424,
            borderRadius: const BorderRadius.all(
              Radius.circular(10),
            ),
          ),
          margin: EdgeInsets.symmetric(
            horizontal: MediaQuery.of(context).size.width * 0.05,
            vertical: MediaQuery.of(context).size.height * 0.002,
          ),
          child: MaterialButton(
            onPressed: () => onT(),
            color: colorContainers242424,
            minWidth: size.width * 0.94,
            height: size.height * 0.065,
            elevation: 0,
            shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(20),
            ),
            child: Padding(
              padding: const EdgeInsets.symmetric(horizontal: 5),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [label, value],
              ),
            ),
          ),
        ),
      ],
    );
  }
}

class _CupertinoDataPicker extends StatefulWidget {
  _CupertinoDataPicker({
    Key? key,
    required this.label,
    required this.color,
    required this.marginHorizontal,
    required this.date,
  }) : super(key: key);

  final String label;
  final Color color;
  final double marginHorizontal;
  DateTime date;

  @override
  State<_CupertinoDataPicker> createState() => __CupertinoDataPickerState();
}

class __CupertinoDataPickerState extends State<_CupertinoDataPicker> {
  void _showDialog(Widget child) {
    showCupertinoModalPopup<void>(
      context: context,
      builder: (BuildContext context) => Container(
        color: colorBackground181818,
        height: 216,
        padding: const EdgeInsets.only(top: 6.0),
        margin: EdgeInsets.only(
          bottom: MediaQuery.of(context).viewInsets.bottom,
        ),
        child: SafeArea(
          top: false,
          child: child,
        ),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: EdgeInsets.symmetric(
        horizontal: widget.marginHorizontal,
        vertical: MediaQuery.of(context).size.height * 0.01,
      ),
      decoration: BoxDecoration(
        boxShadow: shadow,
        color: widget.color,
        borderRadius: const BorderRadius.all(
          Radius.circular(20),
        ),
      ),
      height: MediaQuery.of(context).size.height * 0.06,
      width: MediaQuery.of(context).size.width,
      child: Padding(
        padding: EdgeInsets.only(
          left: MediaQuery.of(context).size.width * 0.05,
        ),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            CupertinoButton(
              onPressed: () => _showDialog(
                CupertinoTheme(
                  data: const CupertinoThemeData(
                      textTheme: CupertinoTextThemeData(
                    dateTimePickerTextStyle: TextStyle(
                      color: Colors.white,
                      fontSize: 20,
                      wordSpacing: 10,
                    ),
                    primaryColor: Colors.white,
                  )),
                  child: CupertinoDatePicker(
                    dateOrder: DatePickerDateOrder.dmy,
                    initialDateTime: widget.date,
                    mode: CupertinoDatePickerMode.date,
                    use24hFormat: true,
                    backgroundColor: colorBackground181818,
                    maximumYear: DateTime.now().year,
                    onDateTimeChanged: (DateTime newDate) {
                      setState(() => widget.date = newDate);
                    },
                  ),
                ),
              ),
              padding: EdgeInsets.zero,
              child: Text(
                '${widget.date.day}/${widget.date.month}/${widget.date.year}',
                style: TextStyle(
                  fontSize: MediaQuery.of(context).size.width * 0.044,
                  color: colorFontUnable116116116,
                  fontStyle: FontStyle.normal,
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}

DateTime parseStringYYYYmmDDtoDateTime(String dateString) {
  List<String> dateParts = dateString.split('-');
  int year = int.parse(dateParts[0]);
  int month = int.parse(dateParts[1]);
  int day = int.parse(dateParts[2]);

  return DateTime(year, month, day);
}

String parseDateTimeToStringYYYYmmDD(DateTime date) {
  String year = date.year.toString().padLeft(4, '0');
  String month = date.month.toString().padLeft(2, '0');
  String day = date.day.toString().padLeft(2, '0');

  return '$year-$month-$day';
}

String formatDateMMddYYYY(String inputDate) {
  List<String> parts = inputDate.split('-');
  String year = parts[0];
  String month = parts[1];
  String day = parts[2];
  return '$month-$day-$year';
}
