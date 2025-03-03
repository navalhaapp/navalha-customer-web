import 'package:dio/dio.dart';
import 'package:navalha/mobile-DEPRECIATED/register/model/auth_email_model.dart';

class AuthEmailCustomerEndPoint {
  final Dio _dio;
  AuthEmailCustomerEndPoint(this._dio);

  Future authEmailCustomer(String email, bool sendCode) async {
    var url = sendCode
        ? '/customer/auth_email/$email/'
        : '/web/customer/auth_email/$email/';
    try {
      return await _dio.get(url);
    } catch (e) {
      return e;
    }
  }
}

class AuthEmailCustomerRepository {
  final AuthEmailCustomerEndPoint authEmailCustomerEndPoint;

  AuthEmailCustomerRepository({required this.authEmailCustomerEndPoint});

  Future<AuthEmailModel> authEmailCustomer(String email, bool sendCode) async {
    final result =
        await authEmailCustomerEndPoint.authEmailCustomer(email, sendCode);
    if (result.runtimeType == DioError) {
      return AuthEmailModel.fromJson(result.response.data);
    } else {
      return AuthEmailModel.fromJson(result.data);
    }
  }
}

class AuthEmailCustomerUseCase {
  final AuthEmailCustomerRepository repository;

  AuthEmailCustomerUseCase({required this.repository});

  Future<AuthEmailModel> execute(String email, bool sendCode) async {
    final response = await repository.authEmailCustomer(email, sendCode);

    return response;
  }
}
