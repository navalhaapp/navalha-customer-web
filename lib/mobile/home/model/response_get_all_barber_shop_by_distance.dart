class ResponseGetAllBarberShopByDistance {
  String? status;
  Result? result;

  ResponseGetAllBarberShopByDistance({this.status, this.result});

  ResponseGetAllBarberShopByDistance.fromJson(Map<String, dynamic> json) {
    status = json['status'];
    result = json['result'] != null ? Result.fromJson(json['result']) : null;
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['status'] = status;
    if (result != null) {
      data['result'] = result!.toJson();
    }
    return data;
  }
}

class Result {
  List<Barbershops>? barbershops;

  Result({this.barbershops});

  Result.fromJson(Map<String, dynamic> json) {
    if (json['barbershops'] != null) {
      barbershops = <Barbershops>[];
      json['barbershops'].forEach((v) {
        barbershops!.add(Barbershops.fromJson(v));
      });
    }
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    if (barbershops != null) {
      data['barbershops'] = barbershops!.map((v) => v.toJson()).toList();
    }
    return data;
  }
}

class Barbershops {
  String? barbershopId;
  String? name;
  String? distance;
  String? imgProfile;
  double? rating;
  CheapServices? cheapServices;

  Barbershops(
      {this.barbershopId,
      this.name,
      this.distance,
      this.imgProfile,
      this.rating,
      this.cheapServices});

  Barbershops.fromJson(Map<String, dynamic> json) {
    barbershopId = json['barbershop_id'];
    name = json['name'];
    distance = json['distance'];
    imgProfile = json['img_profile'];
    rating = double.parse(json['rating'].toString());
    cheapServices = json['cheap_services'] != null
        ? CheapServices.fromJson(json['cheap_services'])
        : null;
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['barbershop_id'] = barbershopId;
    data['name'] = name;
    data['distance'] = distance;
    data['img_profile'] = imgProfile;
    data['rating'] = rating;
    if (cheapServices != null) {
      data['cheap_services'] = cheapServices!.toJson();
    }
    return data;
  }
}

class CheapServices {
  RequiredService? barba;
  RequiredService? corteTesoura;
  RequiredService? corteMaquina;

  CheapServices({this.barba, this.corteTesoura, this.corteMaquina});

  CheapServices.fromJson(Map<String, dynamic> json) {
    barba =
        json['Barba'] != null ? RequiredService.fromJson(json['Barba']) : null;
    corteTesoura = json['Corte tesoura'] != null
        ? RequiredService.fromJson(json['Corte tesoura'])
        : null;
    corteMaquina = json['Corte maquina'] != null
        ? RequiredService.fromJson(json['Corte maquina'])
        : null;
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    if (barba != null) {
      data['Barba'] = barba!.toJson();
    }
    if (corteTesoura != null) {
      data['Corte tesoura'] = corteTesoura!.toJson();
    }
    if (corteMaquina != null) {
      data['Corte maquina'] = corteMaquina!.toJson();
    }
    return data;
  }
}

class RequiredService {
  double? servicePrice;

  RequiredService({this.servicePrice});

  RequiredService.fromJson(Map<String, dynamic> json) {
    servicePrice = json['service_price'] != null
        ? double.parse(json['service_price'])
        : null;
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['service_price'] = servicePrice;
    return data;
  }
}
