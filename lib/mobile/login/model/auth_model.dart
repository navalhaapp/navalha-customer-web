import '../../../shared/model/customer_model.dart';

class AuthCustomer {
  String? status;
  Customer? customer;
  String? id;
  String? token;

  AuthCustomer({this.status, this.customer, this.token});

  AuthCustomer.fromJson(Map<String, dynamic> json) {
    status = json['status'];
    customer =
        json['customer'] != null ? Customer.fromJson(json['customer']) : null;
    token = json['token'];
    id = json['id'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['status'] = status;
    if (customer != null) {
      data['customer'] = customer!.toJson();
    }
    data['token'] = token;
    data['id'] = id;
    return data;
  }
}
