import 'dart:async';
import 'package:dio/dio.dart';
import '../model/auth_model.dart';

class AuthEndPoint {
  final Dio _dio;
  AuthEndPoint(this._dio);

  Future authCustomer(String login, String password, String fBToken) async {
    final data = {
      "fb_token": fBToken,
    };
    const int timeoutMilliseconds = 10000;
    try {
      var response = await _dio.post(
        '/customer/auth/${login.trim()}/${password.trim()}',
        data: data,
        options: Options(
          receiveTimeout: timeoutMilliseconds,
          sendTimeout: timeoutMilliseconds,
        ),
      );
      return response.data;
    } catch (e) {
      return e;
    }
  }
}

class AuthRepository {
  final AuthEndPoint authEndPoint;

  AuthRepository({required this.authEndPoint});

  Future authCustomer(String login, String password, String fBToken) async {
    final result = await authEndPoint.authCustomer(login, password, fBToken);
    if (result.runtimeType == DioError) {
      if (result.type == DioErrorType.connectTimeout ||
          result.type == DioErrorType.receiveTimeout ||
          result.type == DioErrorType.sendTimeout) {
        return result;
      } else {
        return AuthCustomer.fromJson(result.response.data);
      }
    } else {
      return AuthCustomer.fromJson(result);
    }
  }
}

class AuthCustomerUseCase {
  final AuthRepository repository;

  AuthCustomerUseCase({required this.repository});

  Future execute(String login, String password, String fBToken) async {
    final response = await repository.authCustomer(login, password, fBToken);

    return response;
  }
}
