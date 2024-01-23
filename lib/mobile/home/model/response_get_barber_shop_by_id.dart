import 'package:navalha/shared/model/barber_shop_model.dart';
import 'package:navalha/shared/model/service_model.dart';

import '../../../shared/model/package_model.dart';

class ResponseBarberShopById {
  String? status;
  BarberShop? barbershop;
  List<CustomerPackages>? customerPackages;

  ResponseBarberShopById({this.status, this.barbershop, this.customerPackages});

  ResponseBarberShopById.fromJson(Map<String, dynamic> json) {
    status = json['status'];
    barbershop = json['barbershop'] != null
        ? BarberShop.fromJson(json['barbershop'])
        : null;
    if (json['customer_packages'] != null) {
      customerPackages = <CustomerPackages>[];
      json['customer_packages'].forEach((v) {
        customerPackages!.add(CustomerPackages.fromJson(v));
      });
    }
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['status'] = status;
    if (barbershop != null) {
      data['barbershop'] = barbershop!.toJson();
    }
    if (customerPackages != null) {
      data['customer_packages'] =
          customerPackages!.map((v) => v.toJson()).toList();
    }
    return data;
  }
}

class ProfessionalServices {
  String? description;
  int? duration;
  String? imgProfile;
  String? serviceId;
  String? name;
  String? price;
  bool? activated;
  bool? required;

  ProfessionalServices(
      {this.description,
      this.duration,
      this.imgProfile,
      this.serviceId,
      this.name,
      this.price,
      this.activated,
      this.required});

  ProfessionalServices.fromJson(Map<String, dynamic> json) {
    description = json['description'];
    duration = json['duration'];
    imgProfile = json['img_profile'];
    serviceId = json['service_id'];
    name = json['name'];
    price = json['price'];
    activated = json['activated'];
    required = json['required'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['description'] = description;
    data['duration'] = duration;
    data['img_profile'] = imgProfile;
    data['service_id'] = serviceId;
    data['name'] = name;
    data['price'] = price;
    data['activated'] = activated;
    data['required'] = required;
    return data;
  }
}

class OpeningHourList {
  bool? activated;
  String? startPm;
  String? endPm;
  String? startAm;
  String? endAm;
  String? weekday;

  OpeningHourList(
      {this.activated,
      this.startPm,
      this.endPm,
      this.startAm,
      this.endAm,
      this.weekday});

  OpeningHourList.fromJson(Map<String, dynamic> json) {
    activated = json['activated'];
    startPm = json['start_pm'];
    endPm = json['end_pm'];
    startAm = json['start_am'];
    endAm = json['end_am'];
    weekday = json['weekday'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['activated'] = activated;
    data['start_pm'] = startPm;
    data['end_pm'] = endPm;
    data['start_am'] = startAm;
    data['end_am'] = endAm;
    data['weekday'] = weekday;
    return data;
  }
}

class PackageList {
  String? barbershopPackageId;
  String? barbershopPackageName;
  int? barbershopPackageValidity;
  String? barbershopPackagePrice;
  String? barbershopPackageDescription;
  String? barbershopPackageImgProfile;
  bool? barbershopPackageActivated;
  List<BarbershopPackageServices>? barbershopPackageServices;
  List<BarbershopPackageProducts>? barbershopPackageProducts;

  PackageList(
      {this.barbershopPackageId,
      this.barbershopPackageName,
      this.barbershopPackageValidity,
      this.barbershopPackagePrice,
      this.barbershopPackageDescription,
      this.barbershopPackageImgProfile,
      this.barbershopPackageActivated,
      this.barbershopPackageServices,
      this.barbershopPackageProducts});

  PackageList.fromJson(Map<String, dynamic> json) {
    barbershopPackageId = json['barbershop_package_id'];
    barbershopPackageName = json['barbershop_package_name'];
    barbershopPackageValidity = json['barbershop_package_validity'];
    barbershopPackagePrice = json['barbershop_package_price'];
    barbershopPackageDescription = json['barbershop_package_description'];
    barbershopPackageImgProfile = json['barbershop_package_img_profile'];
    barbershopPackageActivated = json['barbershop_package_activated'];
    if (json['barbershop_package_services'] != null) {
      barbershopPackageServices = <BarbershopPackageServices>[];
      json['barbershop_package_services'].forEach((v) {
        barbershopPackageServices!.add(BarbershopPackageServices.fromJson(v));
      });
    }
    if (json['barbershop_package_products'] != null) {
      barbershopPackageProducts = <BarbershopPackageProducts>[];
      json['barbershop_package_products'].forEach((v) {
        barbershopPackageProducts!.add(BarbershopPackageProducts.fromJson(v));
      });
    }
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
    if (barbershopPackageServices != null) {
      data['barbershop_package_services'] =
          barbershopPackageServices!.map((v) => v.toJson()).toList();
    }
    if (barbershopPackageProducts != null) {
      data['barbershop_package_products'] =
          barbershopPackageProducts!.map((v) => v.toJson()).toList();
    }
    return data;
  }
}

class BarbershopPackageServices {
  String? barbershopPackageServiceId;
  int? barbershopPackageServiceQuantity;
  bool? barbershopPackageServiceRequired;
  String? barbershopPackageServicePrice;
  BarbershopServiceId? barbershopServiceId;

  BarbershopPackageServices(
      {this.barbershopPackageServiceId,
      this.barbershopPackageServiceQuantity,
      this.barbershopPackageServiceRequired,
      this.barbershopPackageServicePrice,
      this.barbershopServiceId});

  BarbershopPackageServices.fromJson(Map<String, dynamic> json) {
    barbershopPackageServiceId = json['barbershop_package_service_id'];
    barbershopPackageServiceQuantity =
        json['barbershop_package_service_quantity'];
    barbershopPackageServiceRequired =
        json['barbershop_package_service_required'];
    barbershopPackageServicePrice = json['barbershop_package_service_price'];
    barbershopServiceId = json['barbershop_service_id'] != null
        ? BarbershopServiceId.fromJson(json['barbershop_service_id'])
        : null;
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['barbershop_package_service_id'] = barbershopPackageServiceId;
    data['barbershop_package_service_quantity'] =
        barbershopPackageServiceQuantity;
    data['barbershop_package_service_required'] =
        barbershopPackageServiceRequired;
    data['barbershop_package_service_price'] = barbershopPackageServicePrice;
    if (barbershopServiceId != null) {
      data['barbershop_service_id'] = barbershopServiceId!.toJson();
    }
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

  Service toService() {
    return Service(
        activated: serviceActivated,
        description: serviceDescription,
        duration: serviceDuration,
        imgProfile: serviceImgProfile,
        name: serviceName,
        price: double.parse(servicePrice!),
        required: serviceRequired,
        serviceId: serviceId);
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

class BarbershopPackageProducts {
  String? barbershopPackageProductId;
  int? barbershopPackageProductQuantity;
  bool? barbershopPackageProductRequired;
  String? barbershopPackageProductPrice;
  BarberShopProductId? barberShopProductId;

  BarbershopPackageProducts({
    this.barbershopPackageProductId,
    this.barbershopPackageProductQuantity,
    this.barbershopPackageProductRequired,
    this.barbershopPackageProductPrice,
    this.barberShopProductId,
  });

  BarbershopPackageProducts.fromJson(Map<String, dynamic> json) {
    barbershopPackageProductId = json['barbershop_package_product_id'];
    barbershopPackageProductQuantity =
        json['barbershop_package_product_quantity'];
    barbershopPackageProductRequired =
        json['barbershop_package_product_required'];
    barbershopPackageProductPrice = json['barbershop_package_product_price'];
    barberShopProductId = json['barbershop_product_id'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['barbershop_package_product_id'] = barbershopPackageProductId;
    data['barbershop_package_product_quantity'] =
        barbershopPackageProductQuantity;
    data['barbershop_package_product_required'] =
        barbershopPackageProductRequired;
    data['barbershop_package_product_price'] = barbershopPackageProductPrice;
    data['barbershop_product_id'] = barberShopProductId;
    return data;
  }
}

class BarberShopProductId {
  String? productId;
  String? productName;
  double? productPrice;
  String? productDescription;
  String? productImgProfile;
  bool? productActivated;

  BarberShopProductId({
    this.productId,
    this.productName,
    this.productPrice,
    this.productDescription,
    this.productImgProfile,
    this.productActivated,
  });

  BarberShopProductId.fromJson(Map<String, dynamic> json) {
    productId = json['product_id'];
    productName = json['product_name'];
    productPrice = double.parse(json['product_price'].toString());
    productDescription = json['product_description'];
    productImgProfile = json['product_img_profile'];
    productActivated = json['package_activated'];
  }
}

class PixPayment {
  String? pixId;
  String? type;
  String? key;

  PixPayment({this.pixId, this.type, this.key});

  PixPayment.fromJson(Map<String, dynamic> json) {
    pixId = json['pix_id'];
    type = json['type'];
    key = json['key'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['pix_id'] = pixId;
    data['type'] = type;
    data['key'] = key;
    return data;
  }
}

class Adress {
  String? barbershopId;
  String? city;
  String? district;
  String? state;
  String? street;
  String? complement;
  String? postalCode;
  int? number;

  Adress(
      {this.barbershopId,
      this.city,
      this.district,
      this.state,
      this.street,
      this.complement,
      this.postalCode,
      this.number});

  Adress.fromJson(Map<String, dynamic> json) {
    barbershopId = json['barbershop_id'];
    city = json['city'];
    district = json['district'];
    state = json['state'];
    street = json['street'];
    complement = json['complement'];
    postalCode = json['postal_code'];
    number = json['number'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['barbershop_id'] = barbershopId;
    data['city'] = city;
    data['district'] = district;
    data['state'] = state;
    data['street'] = street;
    data['complement'] = complement;
    data['postal_code'] = postalCode;
    data['number'] = number;
    return data;
  }
}

class CustomerPackages {
  String? customerPackageBarbershopName;
  String? customerPackageName;
  String? customerPackageId;
  PackageModel? packageModel;
  List<CustomerPackageProducts>? customerPackageProducts;
  List<CustomerPackageServices>? customerPackageServices;

  CustomerPackages({
    this.packageModel,
    this.customerPackageBarbershopName,
    this.customerPackageName,
    this.customerPackageId,
    this.customerPackageProducts,
    this.customerPackageServices,
  });

  CustomerPackages.fromJson(Map<String, dynamic> json) {
    customerPackageBarbershopName = json['customer_package_barbershop_name'];
    customerPackageName = json['customer_package_name'];
    customerPackageId = json['customer_package_id'];

    packageModel =
        PackageModel.fromJson(json['customer_packages_barbershop_package']);
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
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['customer_package_barbershop_name'] = customerPackageBarbershopName;
    data['customer_package_name'] = customerPackageName;
    data['customer_packages_barbershop_package'] = packageModel;
    data['customer_package_id'] = customerPackageId;
    if (customerPackageProducts != null) {
      data['customer_package_products'] =
          customerPackageProducts!.map((v) => v.toJson()).toList();
    }
    if (customerPackageServices != null) {
      data['customer_package_services'] =
          customerPackageServices!.map((v) => v.toJson()).toList();
    }
    return data;
  }
}

class CustomerPackageProducts {
  String? packageProductId;
  String? customerPackageProductId;
  BarbershopProductId? barbershopProductId;
  int? count;

  CustomerPackageProducts(
      {this.packageProductId,
      this.customerPackageProductId,
      this.barbershopProductId,
      this.count});

  CustomerPackageProducts.fromJson(Map<String, dynamic> json) {
    packageProductId = json['package_product_id'];
    customerPackageProductId = json['customer_package_product_id'];
    barbershopProductId = json['barbershop_product_id'] != null
        ? BarbershopProductId.fromJson(json['barbershop_product_id'])
        : null;
    count = json['count'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['package_product_id'] = packageProductId;
    data['customer_package_product_id'] = customerPackageProductId;
    if (barbershopProductId != null) {
      data['barbershop_product_id'] = barbershopProductId!.toJson();
    }
    data['count'] = this.count;
    return data;
  }
}

class BarbershopProductId {
  String? productId;
  String? productName;
  String? productPrice;
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
    productPrice = json['product_price'];
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
