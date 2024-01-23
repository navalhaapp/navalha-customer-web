class CoupomDiscount {
  String? promotionalCodeId;
  String? code;
  double? discount;

  CoupomDiscount({this.promotionalCodeId, this.code, this.discount});

  CoupomDiscount.fromJson(Map<String, dynamic> json) {
    promotionalCodeId = json['promotional_code_id'];
    code = json['code'];
    discount = double.parse(json['discount'].toString());
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['promotional_code_id'] = promotionalCodeId;
    data['code'] = code;
    data['discount'] = discount;
    return data;
  }
}
