import '../../mobile-DEPRECIATED/home/model/response_get_barber_shop_by_id.dart';

class PackageModel {
  String? barbershopPackageId;
  String? barbershopPackageName;
  int? barbershopPackageValidity;
  double? barbershopPackagePrice;
  String? barbershopPackageDescription;
  String? barbershopPackageImgProfile;
  bool? barbershopPackageActivated;
  List<BarbershopPackageServices>? barbershopPackageServices;
  List<BarbershopPackageItems>? barbershopPackageItems;

  PackageModel(
      {this.barbershopPackageId,
      this.barbershopPackageName,
      this.barbershopPackageValidity,
      this.barbershopPackagePrice,
      this.barbershopPackageDescription,
      this.barbershopPackageImgProfile,
      this.barbershopPackageActivated,
      this.barbershopPackageServices,
      this.barbershopPackageItems});

  void clear() {
    barbershopPackageId = null;
    barbershopPackageName = null;
    barbershopPackageValidity = null;
    barbershopPackagePrice = null;
    barbershopPackageDescription = null;
    barbershopPackageImgProfile = null;
    barbershopPackageActivated = null;
    barbershopPackageServices = null;
    barbershopPackageItems = null;
  }

  PackageModel.fromJson(Map<String, dynamic> json) {
    barbershopPackageId = json['barbershop_package_id'];
    barbershopPackageName = json['barbershop_package_name'];
    barbershopPackageValidity = json['barbershop_package_validity'];
    barbershopPackagePrice =
        double.parse(json['barbershop_package_price'].toString());
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
      barbershopPackageItems = <BarbershopPackageItems>[];
      json['barbershop_package_products'].forEach((v) {
        barbershopPackageItems!.add(BarbershopPackageItems.fromJson(v));
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
    if (barbershopPackageItems != null) {
      data['barbershop_package_products'] =
          barbershopPackageItems!.map((v) => v.toJson()).toList();
    }
    return data;
  }
}

class BarbershopPackageServices {
  String? barbershopPackageServiceId;
  int? barbershopPackageServiceQuantity;
  bool? barbershopPackageServiceRequired;
  double? barbershopPackageServicePrice;
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
    barbershopPackageServicePrice =
        double.parse(json['barbershop_package_service_price'].toString());
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
  double? servicePrice;
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
    servicePrice = double.parse(json['service_price'].toString());
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

class BarbershopPackageItems {
  String? barbershopPackageItemId;
  int? barbershopPackageItemQuantity;
  bool? barbershopPackageItemRequired;
  double? barbershopPackageItemPrice;
  BarberShopProductId? barberShopProductId;

  BarbershopPackageItems({
    this.barbershopPackageItemId,
    this.barbershopPackageItemQuantity,
    this.barbershopPackageItemRequired,
    this.barbershopPackageItemPrice,
    this.barberShopProductId,
  });

  BarbershopPackageItems.fromJson(Map<String, dynamic> json) {
    barbershopPackageItemId = json['barbershop_package_product_id'];
    barbershopPackageItemQuantity = json['barbershop_package_product_quantity'];
    barbershopPackageItemRequired = json['barbershop_package_product_required'];
    barbershopPackageItemPrice =
        double.parse(json['barbershop_package_product_price'].toString());
    barberShopProductId = json['barbershop_product_id'] != null
        ? BarberShopProductId.fromJson(json['barbershop_product_id'])
        : null;
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['barbershop_package_product_id'] = barbershopPackageItemId;
    data['barbershop_package_product_quantity'] = barbershopPackageItemQuantity;
    data['barbershop_package_product_required'] = barbershopPackageItemRequired;
    data['barbershop_package_product_price'] = barbershopPackageItemPrice;
    data['barbershop_product_id'] = barberShopProductId;
    return data;
  }
}
