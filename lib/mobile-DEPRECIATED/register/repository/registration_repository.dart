import 'package:dio/dio.dart';
import 'package:navalha/mobile-DEPRECIATED/register/api/create_customer_endpoint.dart';

import '../model/req_create_customer.dart';

class CustomerRepository {
  final CustomerEndPoint customerEndPoint;

  CustomerRepository({required this.customerEndPoint});

  Future<ResponseCreateCustomer> createCustomer(
      ReqCreateCustomerModel customer) async {
    final result = await customerEndPoint.createCustomer(customer);
    if (result.runtimeType == DioError) {
      return ResponseCreateCustomer.fromJson(result.response.data);
    } else {
      return ResponseCreateCustomer.fromJson(result);
    }
  }
}
