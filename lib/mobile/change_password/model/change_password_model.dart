import '../../../shared/model/customer_model.dart';

class ChangePasswordResponse {
  String? status;
  Customer? customer;

  ChangePasswordResponse({this.status, this.customer});

  ChangePasswordResponse.fromJson(Map<String, dynamic> json) {
    status = json['status'];
    customer =
        json['customer'] != null ? Customer.fromJson(json['customer']) : null;
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['status'] = status;
    if (customer != null) {
      data['customer'] = customer!.toJson();
    }
    return data;
  }
}
