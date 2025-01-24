class UsePackageServiceRequest {
  String? professionalId;
  String? professionalServiceId;
  String? date;
  String? cacheId;
  String? serviceInitialHour;
  String? serviceFinalHour;
  String? observation;
  String? customerPackageServiceId;

  UsePackageServiceRequest(
      {this.professionalId,
      this.professionalServiceId,
      this.observation,
      this.date,
      this.cacheId,
      this.serviceInitialHour,
      this.serviceFinalHour,
      this.customerPackageServiceId});

  void clear() {
    professionalId = '';
    professionalServiceId = '';
    observation = '';
    date = '';
    cacheId = '';
    serviceInitialHour = '';
    serviceFinalHour = '';
    customerPackageServiceId = '';
  }

  factory UsePackageServiceRequest.fromJson(Map<String, dynamic> json) {
    return UsePackageServiceRequest(
      customerPackageServiceId: json['customer_package_service_id'],
      cacheId: json['cache_id'],
      observation: json['observation'],
      professionalId: json['professional_id'],
      professionalServiceId: json['professional_service_id'],
      date: json['date_time'],
      serviceInitialHour: json['service_initial_hour'],
      serviceFinalHour: json['service_final_hour'],
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'customer_package_service_id': customerPackageServiceId,
      'cache_id': cacheId,
      'observation': observation,
      'professional_id': professionalId,
      'professional_service_id': professionalServiceId,
      'date_time': date,
      'service_initial_hour': serviceInitialHour,
      'service_final_hour': serviceFinalHour,
    };
  }
}
