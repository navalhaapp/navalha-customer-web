import 'package:dio/dio.dart';
import '../../../shared/utils.dart';
import '../model/model_verification_desactive_account.dart';

class VerificationDesactiveAccountEndPoint {
  final Dio dio = Dio();

  Future verificationDesactiveAccount(
    String token,
    String customerId,
  ) async {
    final headers = {
      'Authorization': token,
    };

    try {
      var response = await dio.get(
        '$baseURLV1/customer/desactive/account/verification/$customerId',
        options: Options(headers: headers),
      );
      return response.data;
    } catch (e) {
      return e;
    }
  }
}

class VerificationDesactiveAccountRepository {
  final VerificationDesactiveAccountEndPoint
      verificationDesactiveAccountEndPoint;

  VerificationDesactiveAccountRepository(
      {required this.verificationDesactiveAccountEndPoint});

  Future<ResponseVerificationDesactiveAccount> verificationDesactiveAccount(
    String token,
    String customerId,
  ) async {
    final result =
        await verificationDesactiveAccountEndPoint.verificationDesactiveAccount(
      token,
      customerId,
    );
    if (result.runtimeType == DioError) {
      return ResponseVerificationDesactiveAccount.fromJson(
          result.response.data);
    } else {
      return ResponseVerificationDesactiveAccount.fromJson(result);
    }
  }
}

class VerificationDesactiveAccountUseCase {
  final VerificationDesactiveAccountRepository repository;

  VerificationDesactiveAccountUseCase({required this.repository});

  Future<ResponseVerificationDesactiveAccount> execute(
    String token,
    String customerId,
  ) async {
    final response = await repository.verificationDesactiveAccount(
      token,
      customerId,
    );
    return response;
  }
}
