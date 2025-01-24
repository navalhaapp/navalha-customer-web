import 'package:dio/dio.dart';
import '../../../shared/utils.dart';
import '../model/model_desactivate_account.dart';

class DesactiveAccountEndPoint {
  final Dio dio = Dio();

  Future desactiveAccount(
    String token,
    String customerId,
    String description,
  ) async {
    final headers = {
      'Authorization': token,
    };
    final data = {
      "description": description,
      "user": "customer",
    };
    try {
      var response = await dio.post(
        '$baseURLV1/customer/desactive/account/$customerId',
        data: data,
        options: Options(headers: headers),
      );
      return response.data;
    } catch (e) {
      return e;
    }
  }
}

class DesactiveAccountRepository {
  final DesactiveAccountEndPoint desactiveAccountEndPoint;

  DesactiveAccountRepository({required this.desactiveAccountEndPoint});

  Future<ResponseDesactiveAccount> desactiveAccount(
    String token,
    String customerId,
    String description,
  ) async {
    final result = await desactiveAccountEndPoint.desactiveAccount(
      token,
      customerId,
      description,
    );
    if (result.runtimeType == DioError) {
      return ResponseDesactiveAccount.fromJson(result.response.data);
    } else {
      return ResponseDesactiveAccount.fromJson(result);
    }
  }
}

class DesactiveAccountUseCase {
  final DesactiveAccountRepository repository;

  DesactiveAccountUseCase({required this.repository});

  Future<ResponseDesactiveAccount> execute(
    String token,
    String customerId,
    String description,
  ) async {
    final response = await repository.desactiveAccount(
      token,
      customerId,
      description,
    );
    return response;
  }
}
