import 'package:dio/dio.dart';
import 'package:navalha/mobile-DEPRECIATED/register/model/auth_email_model.dart';

class AuthEmailCustomerEndPoint {
  final Dio _dio;
  AuthEmailCustomerEndPoint(this._dio);

  Future authEmailCustomer(String email) async {
    try {
      return await _dio.get('/customer/auth_email/$email/');
    } catch (e) {
      return e;
    }
  }
}

class AuthEmailCustomerRepository {
  final AuthEmailCustomerEndPoint authEmailCustomerEndPoint;

  AuthEmailCustomerRepository({required this.authEmailCustomerEndPoint});

  Future<AuthEmailModel> authEmailCustomer(String email) async {
    final result = await authEmailCustomerEndPoint.authEmailCustomer(email);
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

  Future<AuthEmailModel> execute(String email) async {
    final response = await repository.authEmailCustomer(email);

    return response;
  }
}
