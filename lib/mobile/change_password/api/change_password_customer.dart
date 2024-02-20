import 'dart:convert';
import 'package:dio/dio.dart';

import '../model/change_password_model.dart';

class ChangePasswordCustomerEndPoint {
  final Dio _dio;
  ChangePasswordCustomerEndPoint(this._dio);

  Future changePassword(String customerId, String? currentPassword,
      String newPassword, String? token) async {
    String? authorization = token;

    var data = {
      "current_password": currentPassword,
      "new_password": newPassword,
    };
    try {
      return await _dio.put('/customer/change/password/$customerId',
          options: Options(
            headers: {
              "Authorization": authorization,
              "Content-Type": "application/json",
            },
          ),
          data: jsonEncode(data));
    } catch (e) {
      return e;
    }
  }
}

class ChangePasswordCustomerRepository {
  final ChangePasswordCustomerEndPoint changePasswordCustomerEndPoint;

  ChangePasswordCustomerRepository(
      {required this.changePasswordCustomerEndPoint});

  Future<ChangePasswordResponse> changePassword(String customerId,
      String? currentPassword, String newPassword, String? token) async {
    final result = await changePasswordCustomerEndPoint.changePassword(
        customerId, currentPassword, newPassword, token);
    if (result.runtimeType == DioError) {
      return ChangePasswordResponse.fromJson(result.response.data);
    } else {
      return ChangePasswordResponse.fromJson(result.data);
    }
  }
}

class ChangePasswordCustomerUseCase {
  final ChangePasswordCustomerRepository repository;

  ChangePasswordCustomerUseCase({required this.repository});

  Future<ChangePasswordResponse> execute(String customerId,
      String? currentPassword, String newPassword, String? token) async {
    final response = await repository.changePassword(
        customerId, currentPassword, newPassword, token);

    return response;
  }
}
