import 'package:navalha/shared/model/professional_model.dart';
import '../../../shared/model/service_model.dart';

class ServiceCache {
  String? serviceName;
  double? servicePrice;
  double? serviceOriginalPrice;
  String? cachedId;
  Service? service;
  Professional? professional;
  String? date;
  String? initialHour;
  String? finalHour;
  String? observation;

  ServiceCache({
    this.serviceName,
    this.serviceOriginalPrice,
    this.servicePrice,
    this.cachedId,
    this.service,
    this.professional,
    this.date,
    this.initialHour,
    this.finalHour,
    this.observation,
  });

  void clear() {
    serviceName = '';
    servicePrice = 0;
    serviceOriginalPrice = 0;
    cachedId = '';
    service = null;
    professional = null;
    date = '';
    initialHour = '';
    finalHour = '';
    observation = '';
  }

  ServiceCache.fromJson(Map<String, dynamic> json) {
    cachedId = json['cached_id'];
    service =
        json['service'] != null ? Service.fromJson(json['service']) : null;
    professional = json['professional'] != null
        ? Professional.fromJson(json['professional'])
        : null;
    servicePrice = double.parse(json['price'].toString());
    date = json['date'];
    initialHour = json['initial_hour'];
    finalHour = json['final_hour'];
    observation = json['observation'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['cached_id'] = cachedId;
    if (service != null) {
      data['service'] = service!.toJson();
    }
    if (professional != null) {
      data['professional'] = professional!.toJson();
    }
    data['price'] = servicePrice;
    data['date'] = date;
    data['initial_hour'] = initialHour;
    data['final_hour'] = finalHour;
    data['observation'] = observation;
    return data;
  }
}
