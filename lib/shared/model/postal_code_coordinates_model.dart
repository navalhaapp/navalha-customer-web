class PostalCodeCoordinates {
  String? lat;
  String? lng;

  PostalCodeCoordinates({this.lat, this.lng});

  PostalCodeCoordinates.fromJson(Map<String, dynamic> json) {
    lat = json['lat'];
    lng = json['lng'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['lat'] = lat;
    data['lng'] = lng;
    return data;
  }
}
