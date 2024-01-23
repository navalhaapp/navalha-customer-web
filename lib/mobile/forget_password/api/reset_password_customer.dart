import 'package:dio/dio.dart';

import '../model/reset_password_model.dart';

class ResetPasswordCustomerEndPoint {
  final Dio _dio;
  ResetPasswordCustomerEndPoint(this._dio);

  Future resetPasswordCustomer(String email) async {
    try {
      return await _dio.get('/customer/reset/password/$email');
    } catch (e) {
      return e;
    }
  }
}

class ResetPasswordCustomerRepository {
  final ResetPasswordCustomerEndPoint resetPasswordCustomerEndPoint;

  ResetPasswordCustomerRepository(
      {required this.resetPasswordCustomerEndPoint});

  Future<ResetPasswordModel> resetPasswordCustomer(String email) async {
    final result =
        await resetPasswordCustomerEndPoint.resetPasswordCustomer(email);
    if (result.runtimeType == DioError) {
      return ResetPasswordModel.fromJson(result.response.data);
    } else {
      return ResetPasswordModel.fromJson(result.data);
    }
  }
}

class ResetPasswordCustomerUseCase {
  final ResetPasswordCustomerRepository repository;

  ResetPasswordCustomerUseCase({required this.repository});

  Future<ResetPasswordModel> execute(String email) async {
    final response = await repository.resetPasswordCustomer(email);

    return response;
  }
}
