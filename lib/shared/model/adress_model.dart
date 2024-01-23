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
