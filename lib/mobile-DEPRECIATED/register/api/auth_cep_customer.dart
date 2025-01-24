import 'package:dio/dio.dart';

import '../model/auth_cep_model.dart';

class AuthCepCustomerEndPoint {
  final Dio _dio;
  AuthCepCustomerEndPoint(this._dio);

  Future<Response> authCepCustomer(String postalCode) async {
    return await _dio.get(
      '/customer/auth_cep/$postalCode',
    );
  }
}

class AuthCepCustomerRepository {
  final AuthCepCustomerEndPoint authCepCustomerEndPoint;

  AuthCepCustomerRepository({required this.authCepCustomerEndPoint});

  Future<AuthCepModel> authCepCustomer(String postalCode) async {
    final result = await authCepCustomerEndPoint.authCepCustomer(postalCode);
    return AuthCepModel.fromJson(result.data);
  }
}

class AuthCepCustomerUseCase {
  final AuthCepCustomerRepository repository;

  AuthCepCustomerUseCase({required this.repository});

  Future<AuthCepModel> execute(String postalCode) async {
    final response = await repository.authCepCustomer(postalCode);

    return response;
  }
}
