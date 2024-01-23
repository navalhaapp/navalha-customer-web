import 'package:navalha/shared/model/postal_code_coordinates_model.dart';

class Customer {
  List<ServicePendingReview>? servicePendingReview;
  String? customerId;
  String? name;
  String? email;
  String? birthDate;
  String? gener;
  String? phone;
  String? postalCode;
  String? createdOn;
  bool? activated;
  String? imgProfile;
  String? password;
  PostalCodeCoordinates? postalCodeCoordinates;
  bool? externalAccount;

  Customer({
    this.servicePendingReview,
    this.customerId,
    this.name,
    this.email,
    this.birthDate,
    this.gener,
    this.phone,
    this.postalCode,
    this.createdOn,
    this.activated,
    this.imgProfile,
    this.password,
    this.postalCodeCoordinates,
    this.externalAccount,
  });

  Customer.fromJson(Map<String, dynamic> json) {
    customerId = json['customer_id'];
    name = json['name'];
    email = json['email'];
    birthDate = json['birth_date'];
    gener = json['gener'];
    phone = json['phone'];
    postalCode = json['postal_code'];
    createdOn = json['created_on'];
    activated = json['activated'];
    imgProfile = json['img_profile'];
    password = json['password'];
    externalAccount = json['external_account'];
    if (json['service_pending_review'] != null) {
      servicePendingReview = <ServicePendingReview>[];
      json['service_pending_review'].forEach((v) {
        servicePendingReview!.add(ServicePendingReview.fromJson(v));
      });
    }

    postalCodeCoordinates = json['postal_code_coordinates'] != null
        ? PostalCodeCoordinates.fromJson(json['postal_code_coordinates'])
        : null;
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['customer_id'] = customerId;
    data['name'] = name;
    data['email'] = email;
    data['birth_date'] = birthDate;
    data['gener'] = gener;
    data['phone'] = phone;
    data['postal_code'] = postalCode;
    data['created_on'] = createdOn;
    data['activated'] = activated;
    data['img_profile'] = imgProfile;
    data['password'] = password;
    data['external_account'] = externalAccount;
    if (servicePendingReview != null) {
      data['service_pending_review'] =
          servicePendingReview!.map((v) => v.toJson()).toList();
    }
    if (postalCodeCoordinates != null) {
      data['postal_code_coordinates'] = postalCodeCoordinates!.toJson();
    }

    return data;
  }
}

class ServicePendingReview {
  BarbershopPendingReview? barbershop;
  String? date;
  ProfessionalPendingReview? professional;
  ServicePendingRev? service;

  ServicePendingReview(
      {this.barbershop, this.date, this.professional, this.service});

  ServicePendingReview.fromJson(Map<String, dynamic> json) {
    barbershop = json['barbershop'] != null
        ? BarbershopPendingReview.fromJson(json['barbershop'])
        : null;
    date = json['date'];
    professional = json['professional'] != null
        ? ProfessionalPendingReview.fromJson(json['professional'])
        : null;
    service = json['service'] != null
        ? ServicePendingRev.fromJson(json['service'])
        : null;
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    if (barbershop != null) {
      data['barbershop'] = barbershop!.toJson();
    }
    data['date'] = date;
    if (professional != null) {
      data['professional'] = professional!.toJson();
    }
    if (service != null) {
      data['service'] = service!.toJson();
    }
    return data;
  }
}

class BarbershopPendingReview {
  String? barbershopName;

  BarbershopPendingReview({this.barbershopName});

  BarbershopPendingReview.fromJson(Map<String, dynamic> json) {
    barbershopName = json['barbershop_name'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['barbershop_name'] = barbershopName;
    return data;
  }
}

class ProfessionalPendingReview {
  String? imgProfile;
  String? professionalName;

  ProfessionalPendingReview({this.imgProfile, this.professionalName});

  ProfessionalPendingReview.fromJson(Map<String, dynamic> json) {
    imgProfile = json['img_profile'];
    professionalName = json['professional_name'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['img_profile'] = imgProfile;
    data['professional_name'] = professionalName;
    return data;
  }
}

class ServicePendingRev {
  String? serviceId;
  String? serviceName;

  ServicePendingRev({this.serviceId, this.serviceName});

  ServicePendingRev.fromJson(Map<String, dynamic> json) {
    serviceId = json['service_id'];
    serviceName = json['service_name'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['service_id'] = serviceId;
    data['service_name'] = serviceName;
    return data;
  }
}
