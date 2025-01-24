class ResponseGetCustomerPackages {
  String? status;
  List<ResultGetCustomerPackages>? result;

  ResponseGetCustomerPackages({this.status, this.result});

  ResponseGetCustomerPackages.fromJson(Map<String, dynamic> json) {
    status = json['status'];
    if (json['result'] != null) {
      result = <ResultGetCustomerPackages>[];
      json['result'].forEach((v) {
        result!.add(ResultGetCustomerPackages.fromJson(v));
      });
    }
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['status'] = status;
    if (result != null) {
      data['result'] = result!.map((v) => v.toJson()).toList();
    }
    return data;
  }
}

class ResultGetCustomerPackages {
  int? customerPackageExpirationDays;
  String? customerPackageBarbershopName;
  CustomerPackagesBarbershopPackage? customerPackagesBarbershopPackage;
  String? customerPackageName;
  String? customerPackageId;
  List<CustomerPackageProducts>? customerPackageProducts;
  List<CustomerPackageServices>? customerPackageServices;
  String? customerPackagePaymentStatus;
  double? customerPackagePayment;

  ResultGetCustomerPackages({
    this.customerPackageExpirationDays,
    this.customerPackageBarbershopName,
    this.customerPackagesBarbershopPackage,
    this.customerPackageName,
    this.customerPackageId,
    this.customerPackageProducts,
    this.customerPackageServices,
    this.customerPackagePaymentStatus,
    customerPackagePayment,
  });

  ResultGetCustomerPackages.fromJson(Map<String, dynamic> json) {
    customerPackagePayment =
        double.parse(json['customer_package_payment'].toString());
    customerPackageExpirationDays = json['customer_package_expiration_days'];
    customerPackageBarbershopName = json['customer_package_barbershop_name'];
    customerPackagesBarbershopPackage =
        json['customer_packages_barbershop_package'] != null
            ? CustomerPackagesBarbershopPackage.fromJson(
                json['customer_packages_barbershop_package'])
            : null;
    customerPackageName = json['customer_package_name'];
    customerPackageId = json['customer_package_id'];
    if (json['customer_package_products'] != null) {
      customerPackageProducts = <CustomerPackageProducts>[];
      json['customer_package_products'].forEach((v) {
        customerPackageProducts!.add(CustomerPackageProducts.fromJson(v));
      });
    }
    if (json['customer_package_services'] != null) {
      customerPackageServices = <CustomerPackageServices>[];
      json['customer_package_services'].forEach((v) {
        customerPackageServices!.add(CustomerPackageServices.fromJson(v));
      });
    }
    customerPackagePaymentStatus = json['customer_package_payment_status'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['customer_package_payment'] = customerPackagePayment;
    data['customer_package_expiration_days'] = customerPackageExpirationDays;
    data['customer_package_barbershop_name'] = customerPackageBarbershopName;
    if (customerPackagesBarbershopPackage != null) {
      data['customer_packages_barbershop_package'] =
          customerPackagesBarbershopPackage!.toJson();
    }
    data['customer_package_name'] = customerPackageName;
    data['customer_package_id'] = customerPackageId;
    if (customerPackageProducts != null) {
      data['customer_package_products'] =
          customerPackageProducts!.map((v) => v.toJson()).toList();
    }
    if (customerPackageServices != null) {
      data['customer_package_services'] =
          customerPackageServices!.map((v) => v.toJson()).toList();
    }
    data['customer_package_payment_status'] = customerPackagePaymentStatus;
    return data;
  }
}

class CustomerPackagesBarbershopPackage {
  String? barbershopPackageId;
  String? barbershopPackageName;
  int? barbershopPackageValidity;
  double? barbershopPackagePrice;
  String? barbershopPackageDescription;
  String? barbershopPackageImgProfile;
  bool? barbershopPackageActivated;
  BarbershopPackageBarbershopId? barbershopPackageBarbershopId;

  CustomerPackagesBarbershopPackage(
      {this.barbershopPackageId,
      this.barbershopPackageName,
      this.barbershopPackageValidity,
      this.barbershopPackagePrice,
      this.barbershopPackageDescription,
      this.barbershopPackageImgProfile,
      this.barbershopPackageActivated,
      this.barbershopPackageBarbershopId});

  CustomerPackagesBarbershopPackage.fromJson(Map<String, dynamic> json) {
    barbershopPackageId = json['barbershop_package_id'];
    barbershopPackageName = json['barbershop_package_name'];
    barbershopPackageValidity = json['barbershop_package_validity'];
    barbershopPackagePrice = double.parse(json['barbershop_package_price']);
    barbershopPackageDescription = json['barbershop_package_description'];
    barbershopPackageImgProfile = json['barbershop_package_img_profile'];
    barbershopPackageActivated = json['barbershop_package_activated'];
    barbershopPackageBarbershopId =
        json['barbershop_package_barbershop_id'] != null
            ? BarbershopPackageBarbershopId.fromJson(
                json['barbershop_package_barbershop_id'])
            : null;
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['barbershop_package_id'] = barbershopPackageId;
    data['barbershop_package_name'] = barbershopPackageName;
    data['barbershop_package_validity'] = barbershopPackageValidity;
    data['barbershop_package_price'] = barbershopPackagePrice;
    data['barbershop_package_description'] = barbershopPackageDescription;
    data['barbershop_package_img_profile'] = barbershopPackageImgProfile;
    data['barbershop_package_activated'] = barbershopPackageActivated;
    if (barbershopPackageBarbershopId != null) {
      data['barbershop_package_barbershop_id'] =
          barbershopPackageBarbershopId!.toJson();
    }
    return data;
  }
}

class BarbershopPackageBarbershopId {
  String? barbershopId;
  String? barbershopName;
  String? barbershopEmail;
  String? barbershopPhone;
  String? barbershopCnpjDocument;
  String? barbershopImgProfile;
  String? barbershopPassword;
  String? barbershopAboutUs;
  bool? barbershopPhysical;
  double? barbershopRating;
  bool? barbershopAccessibility;
  bool? barbershopPark;
  bool? barbershopStepperCompleted;
  bool? barbershopInternet;
  bool? barbershopValidatedCnpj;
  String? barbershopCreatedOn;
  bool? barbershopActivated;
  bool? barbershopReady;

  BarbershopPackageBarbershopId(
      {this.barbershopId,
      this.barbershopName,
      this.barbershopEmail,
      this.barbershopPhone,
      this.barbershopCnpjDocument,
      this.barbershopImgProfile,
      this.barbershopPassword,
      this.barbershopAboutUs,
      this.barbershopPhysical,
      this.barbershopRating,
      this.barbershopAccessibility,
      this.barbershopPark,
      this.barbershopStepperCompleted,
      this.barbershopInternet,
      this.barbershopValidatedCnpj,
      this.barbershopCreatedOn,
      this.barbershopActivated,
      this.barbershopReady});

  BarbershopPackageBarbershopId.fromJson(Map<String, dynamic> json) {
    barbershopId = json['barbershop_id'];
    barbershopName = json['barbershop_name'];
    barbershopEmail = json['barbershop_email'];
    barbershopPhone = json['barbershop_phone'];
    barbershopCnpjDocument = json['barbershop_cnpj_document'];
    barbershopImgProfile = json['barbershop_img_profile'];
    barbershopPassword = json['barbershop_password'];
    barbershopAboutUs = json['barbershop_about_us'];
    barbershopPhysical = json['barbershop_physical'];
    barbershopRating = double.parse(json['barbershop_rating'].toString());
    barbershopAccessibility = json['barbershop_accessibility'];
    barbershopPark = json['barbershop_park'];
    barbershopStepperCompleted = json['barbershop_stepper_completed'];
    barbershopInternet = json['barbershop_internet'];
    barbershopValidatedCnpj = json['barbershop_validated_cnpj'];
    barbershopCreatedOn = json['barbershop_created_on'];
    barbershopActivated = json['barbershop_activated'];
    barbershopReady = json['barbershop_ready'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['barbershop_id'] = barbershopId;
    data['barbershop_name'] = barbershopName;
    data['barbershop_email'] = barbershopEmail;
    data['barbershop_phone'] = barbershopPhone;
    data['barbershop_cnpj_document'] = barbershopCnpjDocument;
    data['barbershop_img_profile'] = barbershopImgProfile;
    data['barbershop_password'] = barbershopPassword;
    data['barbershop_about_us'] = barbershopAboutUs;
    data['barbershop_physical'] = barbershopPhysical;
    data['barbershop_rating'] = barbershopRating;
    data['barbershop_accessibility'] = barbershopAccessibility;
    data['barbershop_park'] = barbershopPark;
    data['barbershop_stepper_completed'] = barbershopStepperCompleted;
    data['barbershop_internet'] = barbershopInternet;
    data['barbershop_validated_cnpj'] = barbershopValidatedCnpj;
    data['barbershop_created_on'] = barbershopCreatedOn;
    data['barbershop_activated'] = barbershopActivated;
    data['barbershop_ready'] = barbershopReady;
    return data;
  }
}

class CustomerPackageProducts {
  String? qrCode;
  String? packageProductId;
  String? customerPackageProductId;
  BarbershopProductId? barbershopProductId;
  int? count;

  CustomerPackageProducts(this.qrCode,
      {this.packageProductId,
      this.customerPackageProductId,
      this.barbershopProductId,
      this.count});

  CustomerPackageProducts.fromJson(Map<String, dynamic> json) {
    qrCode = json['qr_code'];
    packageProductId = json['package_product_id'];
    customerPackageProductId = json['customer_package_product_id'];
    barbershopProductId = json['barbershop_product_id'] != null
        ? BarbershopProductId.fromJson(json['barbershop_product_id'])
        : null;
    count = json['count'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['qr_code'] = qrCode;
    data['package_product_id'] = packageProductId;
    data['customer_package_product_id'] = customerPackageProductId;
    if (barbershopProductId != null) {
      data['barbershop_product_id'] = barbershopProductId!.toJson();
    }
    data['count'] = count;
    return data;
  }
}

class BarbershopProductId {
  String? productId;
  String? productName;
  double? productPrice;
  String? productDescription;
  String? productImgProfile;
  bool? productActivated;

  BarbershopProductId(
      {this.productId,
      this.productName,
      this.productPrice,
      this.productDescription,
      this.productImgProfile,
      this.productActivated});

  BarbershopProductId.fromJson(Map<String, dynamic> json) {
    productId = json['product_id'];
    productName = json['product_name'];
    productPrice = double.parse(json['product_price'].toString());
    productDescription = json['product_description'];
    productImgProfile = json['product_img_profile'];
    productActivated = json['product_activated'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['product_id'] = productId;
    data['product_name'] = productName;
    data['product_price'] = productPrice;
    data['product_description'] = productDescription;
    data['product_img_profile'] = productImgProfile;
    data['product_activated'] = productActivated;
    return data;
  }
}

class CustomerPackageServices {
  String? customerPackageServiceId;
  BarbershopServiceId? barbershopServiceId;
  int? count;
  String? packageServiceId;

  CustomerPackageServices(
      {this.customerPackageServiceId,
      this.barbershopServiceId,
      this.count,
      this.packageServiceId});

  CustomerPackageServices.fromJson(Map<String, dynamic> json) {
    customerPackageServiceId = json['customer_package_service_id'];
    barbershopServiceId = json['barbershop_service_id'] != null
        ? BarbershopServiceId.fromJson(json['barbershop_service_id'])
        : null;
    count = json['count'];
    packageServiceId = json['package_service_id'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['customer_package_service_id'] = customerPackageServiceId;
    if (barbershopServiceId != null) {
      data['barbershop_service_id'] = barbershopServiceId!.toJson();
    }
    data['count'] = count;
    data['package_service_id'] = packageServiceId;
    return data;
  }
}

class BarbershopServiceId {
  String? serviceId;
  String? serviceName;
  int? serviceDuration;
  String? servicePrice;
  String? serviceDescription;
  String? serviceImgProfile;
  bool? serviceRequired;
  bool? serviceActivated;

  BarbershopServiceId(
      {this.serviceId,
      this.serviceName,
      this.serviceDuration,
      this.servicePrice,
      this.serviceDescription,
      this.serviceImgProfile,
      this.serviceRequired,
      this.serviceActivated});

  BarbershopServiceId.fromJson(Map<String, dynamic> json) {
    serviceId = json['service_id'];
    serviceName = json['service_name'];
    serviceDuration = json['service_duration'];
    servicePrice = json['service_price'];
    serviceDescription = json['service_description'];
    serviceImgProfile = json['service_img_profile'];
    serviceRequired = json['service_required'];
    serviceActivated = json['service_activated'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['service_id'] = serviceId;
    data['service_name'] = serviceName;
    data['service_duration'] = serviceDuration;
    data['service_price'] = servicePrice;
    data['service_description'] = serviceDescription;
    data['service_img_profile'] = serviceImgProfile;
    data['service_required'] = serviceRequired;
    data['service_activated'] = serviceActivated;
    return data;
  }
}
