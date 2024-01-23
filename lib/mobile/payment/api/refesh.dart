import 'package:dio/dio.dart';
import '../../login/model/auth_model.dart';
import '../../../shared/utils.dart';

class RefreshEndPoint {
  final Dio dio = Dio();

  Future refresh(
    String customerId,
    String token,
  ) async {
    final headers = {
      'Authorization': token,
    };

    try {
      var response = await dio.get(
        '$baseURLV1/customer/refresh/$customerId',
        options: Options(headers: headers),
      );
      return response.data;
    } catch (e) {
      return e;
    }
  }
}

class RefreshRepository {
  final RefreshEndPoint refreshEndPoint;

  RefreshRepository({required this.refreshEndPoint});

  Future<AuthCustomer> refresh(
    String customerId,
    String token,
  ) async {
    final result = await refreshEndPoint.refresh(
      customerId,
      token,
    );
    if (result.runtimeType == DioError) {
      return AuthCustomer.fromJson(result.response.data);
    } else {
      return AuthCustomer.fromJson(result);
    }
  }
}

class RefreshUseCase {
  final RefreshRepository repository;

  RefreshUseCase({required this.repository});

  Future<AuthCustomer> execute(
    String customerId,
    String token,
  ) async {
    final response = await repository.refresh(
      customerId,
      token,
    );
    return response;
  }
}
