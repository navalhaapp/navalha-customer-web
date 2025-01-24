import 'package:navalha/shared/model/customer_model.dart';

class ReqCreateCustomerModel {
  String? name;
  String? email;
  String? birthDate;
  String? postalCode;
  String? gener;
  String? phone;
  String? password;
  bool? externalAccount;

  ReqCreateCustomerModel({
    this.name,
    this.email,
    this.birthDate,
    this.postalCode,
    this.gener,
    this.phone,
    this.password,
    this.externalAccount,
  });

  ReqCreateCustomerModel.fromJson(Map<String, dynamic> json) {
    name = json['name'];
    email = json['email'];
    birthDate = json['birth_date'];
    postalCode = json['postal_code'];
    gener = json['gener'];
    phone = json['phone'];
    password = json['password'];
    externalAccount = json['external_account'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['name'] = name;
    data['email'] = email;
    data['birth_date'] = birthDate;
    data['postal_code'] = postalCode;
    data['gener'] = gener;
    data['phone'] = phone;
    data['password'] = password;
    data['external_account'] = externalAccount;
    return data;
  }
}

class ResponseCreateCustomer {
  String? status;
  dynamic customer;
  String? token;

  ResponseCreateCustomer({this.status, this.customer, this.token});

  ResponseCreateCustomer.fromJson(Map<String, dynamic> json) {
    status = json['status'];
    if (json['customer'] is String) {
      customer = json['customer'];
    } else if (json['customer'] != null) {
      customer = Customer.fromJson(json['customer']);
    }
    token = json['token'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['status'] = status;
    if (customer != null) {
      if (customer is Customer) {
        data['customer'] = (customer as Customer).toJson();
      } else {
        data['customer'] = customer;
      }
    }
    data['token'] = token;
    return data;
  }
}
