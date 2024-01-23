class ParamsCreatePackage {
  String? token;
  String? customerId;
  double? transactionAmount;
  String? barbershopPackageId;
  List<ParamsBuyPackageService>? barbershopOptionalServices;
  List<ParamsBuyPackageServiceItem>? barbershopOptionalItems;

  ParamsCreatePackage({
    required this.token,
    required this.customerId,
    required this.transactionAmount,
    required this.barbershopPackageId,
    required this.barbershopOptionalServices,
    required this.barbershopOptionalItems,
  });
}

class ParamsBuyPackageServiceItem {
  String? barbershopPackageServiceId;
  int? quantity;

  ParamsBuyPackageServiceItem({
    this.barbershopPackageServiceId,
    this.quantity,
  });

  factory ParamsBuyPackageServiceItem.fromJson(Map<String, dynamic> json) {
    return ParamsBuyPackageServiceItem(
      barbershopPackageServiceId: json['barbershop_package_product_id'],
      quantity: json['quantity'],
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'barbershop_package_product_id': barbershopPackageServiceId,
      'quantity': quantity,
    };
  }
}

class ParamsBuyPackageService {
  String? barbershopPackageServiceId;
  int? quantity;

  ParamsBuyPackageService({
    this.barbershopPackageServiceId,
    this.quantity,
  });

  factory ParamsBuyPackageService.fromJson(Map<String, dynamic> json) {
    return ParamsBuyPackageService(
      barbershopPackageServiceId: json['barbershop_package_service_id'],
      quantity: json['quantity'],
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'barbershop_package_service_id': barbershopPackageServiceId,
      'quantity': quantity,
    };
  }
}
