import '../../../shared/model/coupom_discount_model.dart';

class ResponseGetPromotionalCode {
  String? status;
  dynamic result;

  ResponseGetPromotionalCode({this.status, this.result});

  ResponseGetPromotionalCode.fromJson(Map<String, dynamic> json) {
    status = json['status'];
    if (json['result'] is String) {
      result = json['result'];
    } else {
      result = json['result'] != null
          ? CoupomDiscount.fromJson(json['result'])
          : null;
    }
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['status'] = status;
    if (result is CoupomDiscount) {
      data['result'] = result.toJson();
    } else {
      data['result'] = result;
    }
    return data;
  }
}
