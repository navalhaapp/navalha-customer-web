class Service {
  String? description;
  int? duration;
  String? imgProfile;
  String? serviceId;
  String? name;
  double? price;
  bool? activated;
  bool? required;

  Service(
      {this.description,
      this.duration,
      this.imgProfile,
      this.serviceId,
      this.name,
      this.price,
      this.activated,
      this.required});

  Service.fromJson(Map<String, dynamic> json) {
    description = json['description'];
    duration = json['duration'];
    imgProfile = json['img_profile'];
    serviceId = json['service_id'];
    name = json['name'];
    price = double.parse(json['price'].toString());
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
