class ProviderFamilyGetScheduleModel {
  String customerId;
  String token;

  ProviderFamilyGetScheduleModel({
    required this.token,
    required this.customerId,
  });
}

class ResponseGetScheduleCustomer {
  String? status;
  List<ScheduleItemModel>? result;

  ResponseGetScheduleCustomer({this.status, this.result});

  ResponseGetScheduleCustomer.fromJson(Map<String, dynamic> json) {
    status = json['status'];
    if (json['result'] != null) {
      result = <ScheduleItemModel>[];
      json['result'].forEach((v) {
        result!.add(ScheduleItemModel.fromJson(v));
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

class ScheduleItemModel {
  String? scheduleId;
  BarbershopScheduleModel? barbershop;
  String? scheduleServiceId;
  String? initialHour;
  String? date;
  ProfessionalScheduleModel? professional;
  ServiceScheduleModel? service;
  bool? finalized;
  bool? canceled;
  bool? reviewed;

  ScheduleItemModel({
    this.scheduleId,
    this.barbershop,
    this.scheduleServiceId,
    this.initialHour,
    this.date,
    this.professional,
    this.service,
    this.finalized,
    this.canceled,
    this.reviewed,
  });

  ScheduleItemModel.fromJson(Map<String, dynamic> json) {
    scheduleId = json['schedule_id'];
    barbershop = json['barbershop'] != null
        ? BarbershopScheduleModel.fromJson(json['barbershop'])
        : null;
    scheduleServiceId = json['schedule_service_id'];
    initialHour = json['initial_hour'];
    date = json['date'];
    professional = json['professional'] != null
        ? ProfessionalScheduleModel.fromJson(json['professional'])
        : null;
    service = json['service'] != null
        ? ServiceScheduleModel.fromJson(json['service'])
        : null;
    finalized = json['finalized'];
    canceled = json['canceled'];
    reviewed = json['reviewed'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['schedule_id'] = scheduleId;
    if (barbershop != null) {
      data['barbershop'] = barbershop!.toJson();
    }
    data['schedule_service_id'] = scheduleServiceId;
    data['initial_hour'] = initialHour;
    data['date'] = date;
    if (professional != null) {
      data['professional'] = professional!.toJson();
    }
    if (service != null) {
      data['service'] = service!.toJson();
    }
    data['finalized'] = finalized;
    data['canceled'] = canceled;
    data['reviewed'] = reviewed;
    return data;
  }
}

class BarbershopScheduleModel {
  String? barbershopName;
  String? imgProfile;

  BarbershopScheduleModel({this.barbershopName, this.imgProfile});

  BarbershopScheduleModel.fromJson(Map<String, dynamic> json) {
    barbershopName = json['barbershop_name'];
    imgProfile = json['img_profile'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['barbershop_name'] = barbershopName;
    data['img_profile'] = imgProfile;
    return data;
  }
}

class ProfessionalScheduleModel {
  String? name;
  String? imgProfile;
  String? professionalId;

  ProfessionalScheduleModel({this.name, this.imgProfile});

  ProfessionalScheduleModel.fromJson(Map<String, dynamic> json) {
    name = json['name'];
    imgProfile = json['img_profile'];
    professionalId = json['professional_id'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['name'] = name;
    data['img_profile'] = imgProfile;
    data['professional_id'] = professionalId;
    return data;
  }
}

class ServiceScheduleModel {
  String? name;
  double? price;

  ServiceScheduleModel({this.name, this.price});

  ServiceScheduleModel.fromJson(Map<String, dynamic> json) {
    name = json['name'];
    if (json['price'] != null) {
      price = double.parse(json['price'].toString());
    }
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['name'] = name;
    data['price'] = price;
    return data;
  }
}
