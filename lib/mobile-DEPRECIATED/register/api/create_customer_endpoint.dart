import 'dart:async';
import 'package:dio/dio.dart';

import '../model/req_create_customer.dart';

class CustomerEndPoint {
  final Dio _dio;
  CustomerEndPoint(this._dio);

  Future createCustomer(ReqCreateCustomerModel customer) async {
    try {
      var response = await _dio.post(
        '/customer/',
        data: customer.toJson(),
      );
      return response.data;
    } catch (e) {
      return e;
    }
  }
}
