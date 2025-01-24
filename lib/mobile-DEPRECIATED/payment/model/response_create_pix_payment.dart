class ServiceRequest {
  String? professionalId;
  String? professionalServiceId;
  double? price;
  String? date;
  String? cacheId;
  String? serviceInitialHour;
  String? serviceFinalHour;
  String? observation;
  double? promotionalHourPercent;
  double? promotionalHourDiscount;

  ServiceRequest({
    this.professionalId,
    this.professionalServiceId,
    this.price,
    this.observation,
    this.date,
    this.cacheId,
    this.serviceInitialHour,
    this.serviceFinalHour,
    this.promotionalHourPercent,
    this.promotionalHourDiscount,
  });

  void clear() {
    professionalId = '';
    professionalServiceId = '';
    price = 0;
    observation = '';
    date = '';
    cacheId = '';
    serviceInitialHour = '';
    serviceFinalHour = '';
    promotionalHourPercent = 0;
    promotionalHourDiscount = 0;
  }

  factory ServiceRequest.fromJson(Map<String, dynamic> json) {
    return ServiceRequest(
      cacheId: json['cache_id'],
      observation: json['observation'],
      professionalId: json['professional_id'],
      professionalServiceId: json['professional_service_id'],
      price: json['price'],
      date: json['date_time'],
      serviceInitialHour: json['service_initial_hour'],
      serviceFinalHour: json['service_final_hour'],
      promotionalHourPercent: json['promotional_hour_percent'],
      promotionalHourDiscount: json['promotional_hour_discount'],
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'cache_id': cacheId,
      'observation': observation,
      'professional_id': professionalId,
      'professional_service_id': professionalServiceId,
      'price': price,
      'date_time': date,
      'service_initial_hour': serviceInitialHour,
      'service_final_hour': serviceFinalHour,
      'promotional_hour_percent': promotionalHourPercent,
      'promotional_hour_discount': promotionalHourDiscount,
    };
  }
}

class RequestPaymentPix {
  String? barbershopId;
  double? transactionAmount;
  double? promotionalCodeDiscount;
  double? promotionalCodePercent;
  List<ServiceRequest> services;

  RequestPaymentPix({
    this.barbershopId,
    this.transactionAmount,
    this.promotionalCodeDiscount,
    this.promotionalCodePercent,
    required this.services,
  });

  void clear() {
    barbershopId = '';
    transactionAmount = 0;
    promotionalCodeDiscount = 0;
    promotionalCodePercent = 0;
    services = [];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['barbershopId'] = barbershopId;
    data['transactionAmount'] = transactionAmount;
    data['promotionalCodeDiscount'] = promotionalCodeDiscount;
    data['promotionalCodePercent'] = promotionalCodePercent;
    data['services'] = services.map((service) => service.toJson()).toList();
    return data;
  }

  factory RequestPaymentPix.fromJson(Map<String, dynamic> json) {
    List<ServiceRequest> servicesList = [];
    if (json['services'] != null) {
      json['services'].forEach((service) {
        servicesList.add(ServiceRequest.fromJson(service));
      });
    }
    return RequestPaymentPix(
      barbershopId: json['barbershopId'],
      transactionAmount: json['transactionAmount'],
      promotionalCodeDiscount: json['promotionalCodeDiscount'],
      promotionalCodePercent: json['promotionalCodePercent'],
      services: servicesList,
    );
  }
}
