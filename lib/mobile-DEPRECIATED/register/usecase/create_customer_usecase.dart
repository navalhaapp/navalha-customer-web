import 'dart:async';

import 'package:navalha/mobile-DEPRECIATED/register/repository/registration_repository.dart';

import '../model/req_create_customer.dart';

class CreateCustomerUseCase {
  final CustomerRepository repository;

  CreateCustomerUseCase({required this.repository});

  Future<ResponseCreateCustomer> execute(
      ReqCreateCustomerModel customer) async {
    final response = await repository.createCustomer(customer);
    return response;
  }
}
