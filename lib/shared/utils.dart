import 'dart:async';
import 'dart:convert';

import 'package:another_flushbar/flushbar.dart';
import 'package:brasil_fields/brasil_fields.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:intl/intl.dart';
import 'package:navalha/core/assets.dart';
import 'package:navalha/core/colors.dart';
import 'package:navalha/mobile-DEPRECIATED/home/model/response_get_barber_shop_by_id.dart';
import 'package:navalha/shared/enviroment.dart';
import 'package:navalha/shared/widgets/snack_bar_pattern.dart';
import 'package:navalha/web/appointment/widgets/register_social_network_page_web.dart';
import 'package:string_validator/string_validator.dart';
import 'package:url_launcher/url_launcher.dart';

import '../mobile-DEPRECIATED/schedule/model/model_service_cache.dart';
import 'model/professional_model.dart';
import 'model/service_model.dart';

class Errors {
  static String badCredentials = 'bad_credentials';
  static String notFound = 'not_found';
  static String timeout = 'timeout';
}

String simpleDecrypt(String encryptedText) {
  return String.fromCharCodes(
      utf8.decode(base64.decode(encryptedText)).runes.toList().reversed);
}

double getSizeException(
    {double? exceptValue,
    double? exceptSize,
    required double currentValue,
    double? deviceSize}) {
  if (exceptSize != null) {
    if (deviceSize! > exceptSize) {
      return exceptValue!;
    } else {
      return currentValue;
    }
  } else {
    return currentValue;
  }
}

const String urlMail = "navalha_app@outlook.com";
final Uri urlWhats =
    Uri(scheme: 'https', host: 'wa.me', path: '/5547991558228');

String baseURLV1 = Enviroment.apiBaseUrl;


void pushFcm(BuildContext context, String? title, String? message) {
  Flushbar(
    margin: const EdgeInsets.all(8),
    borderRadius: BorderRadius.circular(25),
    icon: Container(
      margin: const EdgeInsets.symmetric(horizontal: 5),
      height: MediaQuery.of(context).size.width * 0.2,
      width: MediaQuery.of(context).size.width * 0.2,
      child: Image.asset(iconLogoApp),
    ),
    duration: const Duration(seconds: 10),
    flushbarPosition: FlushbarPosition.TOP,
    title: title,
    titleColor: Colors.black,
    messageColor: Colors.black,
    message: message,
    backgroundColor: const Color.fromARGB(255, 200, 200, 200),
  ).show(context);
}

class UtilValidator {
  static bool pCampoVazio(String text) {
    if (text.isEmpty) {
      return true;
    } else {
      return false;
    }
  }

  static bool pNomeInvalido(String nome) {
    bool existeNum = false;
    nome = trim(nome.replaceAll(' ', 'e'));
    if (!isAlpha(nome)) {
      existeNum = true;
    } else {
      existeNum = false;
    }
    return existeNum;
  }

  static bool pPossuiNumero(String texto) {
    if (texto.contains(RegExp(r'[1-9]'))) {
      return true;
    }
    return false;
  }

  static String getSalute() {
    int horaAtual = (DateTime.now().hour);

    if (horaAtual >= 6 && horaAtual < 12) {
      return 'Bom dia';
    } else if (horaAtual >= 12 && horaAtual <= 18) {
      return 'Boa tarde';
    }
    return 'Boa noite';
  }

  String putMaskCep(String value) {
    final length = value.length;
    if (length == 8) {
      return value.replaceFirstMapped(RegExp(r'^(\d{2})(\d{3})(\d{3})$'),
          (match) => '${match[1]}.${match[2]}-${match[3]}');
    } else {
      return value; // retorna sem máscara se não for CEP válido
    }
  }

  String formatPhoneNumber(String unformattedPhoneNumber) {
    String formattedPhoneNumber = unformattedPhoneNumber.padLeft(11, "0");
    if (formattedPhoneNumber.length == 11) {
      formattedPhoneNumber =
          "(${formattedPhoneNumber.substring(0, 2)}) ${formattedPhoneNumber.substring(2, 3)} ${formattedPhoneNumber.substring(3, 7)}-${formattedPhoneNumber.substring(7, 11)}";
    } else {
      formattedPhoneNumber =
          "(${formattedPhoneNumber.substring(0, 2)}) ${formattedPhoneNumber.substring(2, 6)}-${formattedPhoneNumber.substring(6, 10)}";
    }
    return formattedPhoneNumber;
  }

  static bool numberFormater(TextInputFormatter? mask) {
    if (mask.runtimeType == TelefoneInputFormatter ||
        mask.runtimeType == CepInputFormatter ||
        mask.runtimeType == CpfInputFormatter ||
        mask.runtimeType == DataInputFormatter) {
      return true;
    }

    return false;
  }
}

String removeNonNumeric(String? input) {
  if (input == null) {
    return '';
  }
  return input.replaceAll(RegExp(r'[^0-9]'), '');
}

class DateInputFormatter extends TextInputFormatter {
  @override
  TextEditingValue formatEditUpdate(
      TextEditingValue oldValue, TextEditingValue newValue) {
    String text = newValue.text;

    // Remove tudo que não seja número
    text = text.replaceAll(RegExp(r'[^0-9]'), '');

    // Limita a 8 dígitos (DDMMYYYY)
    if (text.length > 8) {
      text = text.substring(0, 8);
    }

    // Adiciona as barras (/) nos lugares corretos
    if (text.length >= 3 && text.length <= 4) {
      text = text.substring(0, 2) + '/' + text.substring(2);
    } else if (text.length > 4 && text.length <= 8) {
      text = text.substring(0, 2) +
          '/' +
          text.substring(2, 4) +
          '/' +
          text.substring(4);
    }

    // Retorna o valor formatado com a nova posição do cursor
    return TextEditingValue(
      text: text,
      selection: TextSelection.collapsed(offset: text.length),
    );
  }
}

String formatarDataNew(String data) {
  return data.replaceAll('/', '-');
}

String? getServiceIdByName(String? name, List<Service>? services) {
  if (name == null || services == null) {
    return null;
  }
  for (var service in services) {
    if (service.name == name) {
      return service.serviceId!;
    }
  }
  return '';
}

String getImgByName(String img, List<Service> services) {
  for (var service in services) {
    if (service.imgProfile == img) {
      return service.imgProfile!;
    }
  }
  return '';
}

String formatDate(DateTime data) {
  String mes = data.month.toString().padLeft(
      2, '0'); // Adiciona o zero à esquerda se o mês tiver apenas um dígito
  String dia = data.day.toString().padLeft(
      2, '0'); // Adiciona o zero à esquerda se o dia tiver apenas um dígito
  String ano = data.year.toString();
  return "$mes-$dia-$ano";
}

List<Service> showActivatedServices(List<Service> services) {
  return services.where((service) => service.activated == true).toList();
}

double calcTotalPrice(List<ServiceCache> services) {
  double totalPrice = 0;
  for (var service in services) {
    totalPrice += service.servicePrice!;
  }
  return totalPrice;
}

int calcTotalTime(List<ServiceCache> services) {
  int totalMinutes = 0;

  for (var service in services) {
    final date = DateFormat('MM-dd-yyyy').parse(service.date!);
    final startTime = DateFormat('HH:mm').parse(service.initialHour!);
    final endTime = DateFormat('HH:mm').parse(service.finalHour!);
    final startDateTime = DateTime(
        date.year, date.month, date.day, startTime.hour, startTime.minute);
    final endDateTime =
        DateTime(date.year, date.month, date.day, endTime.hour, endTime.minute);
    final diff = endDateTime.difference(startDateTime);

    totalMinutes += diff.inMinutes;
  }

  return totalMinutes;
}

List<Service> findServicesWithProfessionals(
  List<Professional> professionals,
  List<Service> services,
) {
  List<Service> result = [];

  for (var service in services) {
    for (var professional in professionals) {
      final professionalServices = professional.professionalServices;
      if (professionalServices == null) {
        continue;
      }
      for (var professionalService in professionalServices) {
        if (professionalService.name == service.name &&
            professionalService.activated == true) {
          result.add(service);
          break;
        }
      }
    }
  }

  return result.toSet().toList();
}

List<Service> findPackageServicesWithProfessionals(
  List<Professional>? professionals,
  List<CustomerPackageServices>? services,
) {
  if (professionals == null || services == null) {
    return [];
  }

  Set<String> addedServiceNames =
      {}; // Conjunto para rastrear nomes de serviços já adicionados
  List<Service> result = [];

  for (var service in services) {
    for (var professional in professionals) {
      if (professional.professionalServices == null) {
        continue;
      }
      for (var professionalService in professional.professionalServices!) {
        if (professionalService.name ==
                service.barbershopServiceId?.serviceName &&
            professionalService.activated == true &&
            !addedServiceNames
                .contains(service.barbershopServiceId?.serviceName)) {
          result.add(service.barbershopServiceId!.toService());
          addedServiceNames.add(service.barbershopServiceId?.serviceName ?? "");
          break; // Sair do loop após encontrar um serviço correspondente
        }
      }
    }
  }

  return result;
}

String getDurationRange(List<Service> services, String serviceName) {
  int minDuration = 0;
  int maxDuration = 0;
  bool found = false;
  for (var service in services) {
    if (service.name == serviceName) {
      int duration = service.duration!;
      if (!found) {
        minDuration = duration;
        maxDuration = duration;
        found = true;
      } else {
        minDuration = duration < minDuration ? duration : minDuration;
        maxDuration = duration > maxDuration ? duration : maxDuration;
      }
    }
  }
  if (found) {
    return minDuration == maxDuration
        ? '${minDuration}min'
        : '$minDuration - ${maxDuration}min';
  } else {
    return 'Serviço não encontrado.';
  }
}

String getPriceRange(List<Service> services, String serviceName) {
  double minPrice = double.infinity;
  double maxPrice = 0;
  bool found = false;

  for (var service in services) {
    if (service.name == serviceName && service.activated == true) {
      double price = service.price!;
      if (!found) {
        minPrice = price;
        maxPrice = price;
        found = true;
      } else {
        minPrice = price < minPrice ? price : minPrice;
        maxPrice = price > maxPrice ? price : maxPrice;
      }
    }
  }

  if (found) {
    return minPrice == maxPrice
        ? 'R\$ ${minPrice.toStringAsFixed(2).replaceAll('.', ',')}'
        : 'R\$ ${minPrice.toStringAsFixed(2).replaceAll('.', ',')} - ${maxPrice.toStringAsFixed(2).replaceAll('.', ',')}';
  } else {
    return 'Serviço não encontrado ou não está ativo.';
  }
}

List<Service> getAllServicesProfessional(List<Professional> professionals) {
  return professionals
      .expand((professional) => professional.professionalServices!)
      .toSet()
      .toList();
}

Future<void> launchInBrowser(Uri uri) async {
  if (!await launchUrl(
    uri,
    mode: LaunchMode.externalApplication,
  )) {
    throw Exception('Could not launch $uri');
  }
}

void showSnackBar(BuildContext context, String mensagem) async {
  ScaffoldMessenger.of(context)
    ..clearSnackBars()
    ..showSnackBar(
      snackBarPattern(
        mensagem,
      ),
    );
}

String getFirstName(String fullName) {
  List<String> nameParts = fullName.split(" ");
  return nameParts[0];
}

String formatTime(String time) {
  if (time.trim().isEmpty) {
    return '00:00';
  }
  if (time == 'vazio') {
    return '';
  }
  List<String> parts = time.trim().split(':');
  int hours = int.tryParse(parts[0]) ?? 0;
  int minutes = int.tryParse(parts[1]) ?? 0;

  String formattedHours = hours.toString().padLeft(2, '0');
  String formattedMinutes = minutes.toString().padLeft(2, '0');

  return '$formattedHours:$formattedMinutes';
}

class UtilText {
  static List<String> barberShopBodyTitlesList = [
    'Informações',
    'Profissionais',
    'Serviços',
    'Comentários',
  ];
  static List<String> registerGener = [
    undefined,
    male,
    female,
  ];
  static String formatDate(DateTime date) {
    return '${date.month}-${date.day}-${date.year}'.trim();
  }
}

bool isNullOrEmpty(dynamic variable) {
  if (variable == null) {
    return true;
  } else if (variable is String) {
    return variable.trim().isEmpty;
  } else if (variable is List) {
    return variable.isEmpty;
  } else {
    return false;
  }
}

String getAbbreviatedWeekday(int weekday) {
  switch (weekday) {
    case DateTime.monday:
      return 'mon';
    case DateTime.tuesday:
      return 'tue';
    case DateTime.wednesday:
      return 'wed';
    case DateTime.thursday:
      return 'thu';
    case DateTime.friday:
      return 'fri';
    case DateTime.saturday:
      return 'sat';
    case DateTime.sunday:
      return 'sun';
    default:
      return '';
  }
}

class ImageOnboarding {
  final String url;
  final double height;
  late AssetImage assetImage;
  final String title;
  final String description;

  ImageOnboarding(
      {required this.title,
      required this.description,
      required this.url,
      required this.height}) {
    assetImage = AssetImage(url);
  }
}

String removeMaskCep(String cep) {
  String cepSemMascara = cep.replaceAll(RegExp(r'\D'), '');

  return cepSemMascara;
}

List<ImageOnboarding> onboardingList(context) {
  return [
    ImageOnboarding(
      description:
          'Para encontrar uma barbearia de acordo com sua preferência, você pode ordenar por distância, avaliação e preço.',
      title: 'Encontre a melhor barbearia',
      url: imgHomeOnboarding,
      height: MediaQuery.of(context).size.height * 0.55,
    ),
    ImageOnboarding(
      description:
          'Escolha um serviço, um profissional e uma data que se adequem à sua agenda.',
      title: 'Marque um serviço',
      url: imgScheduleOnboarding,
      height: MediaQuery.of(context).size.height * 0.55,
    ),
    // ImageOnboarding(
    //   title: 'Não se preocupe com pagamentos',
    //   description:
    //       'Oferecemos opções de pagamento rápidas e seguras, incluindo cartão de crédito, PIX e Navalha Cash.',
    //   url: imgPaymentOnBoarding,
    //   height: MediaQuery.of(context).size.height * 0.55,
    // ),
    ImageOnboarding(
      title: 'Não perca seus horários',
      description:
          'Acompanhe os seus agendamentos futuros e compartilhe sua experiência conosco.',
      url: imgCalendarOnboarding,
      height: MediaQuery.of(context).size.height * 0.55,
    ),
  ];
}

String formatDateStr(String? date) {
  if (date == null) {
    return '';
  }
  List<String> dateParts = date.split('-');

  String formattedDate = '${dateParts[1]}/${dateParts[0]}/${dateParts[2]}';

  return formattedDate;
}
