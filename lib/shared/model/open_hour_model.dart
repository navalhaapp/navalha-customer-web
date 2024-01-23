class OpenHour {
  String? hour;
  double? discount;

  OpenHour({this.hour, this.discount});

  OpenHour.fromJson(Map<String, dynamic> json) {
    hour = json['hour'];
    discount = json['discount'] != null
        ? double.parse(json['discount'].toString())
        : null;
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['hour'] = hour;
    data['discount'] = discount;
    return data;
  }
}
