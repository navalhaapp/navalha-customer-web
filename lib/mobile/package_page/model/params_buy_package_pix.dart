import 'params_create_package.dart';

class ParamnsBuyPackage {
  String? token;
  String? customerId;
  double? transactionAmount;
  String? barbershopPackageId;
  List<ParamsBuyPackageService>? barbershopOptionalServices;
  List<ParamsBuyPackageServiceItem>? barbershopOptionalItems;

  ParamnsBuyPackage({
    required this.token,
    required this.customerId,
    required this.transactionAmount,
    required this.barbershopPackageId,
    required this.barbershopOptionalServices,
    required this.barbershopOptionalItems,
  });
}
