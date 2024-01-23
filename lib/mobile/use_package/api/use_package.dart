import 'package:dio/dio.dart';

import '../../../shared/utils.dart';
import '../model/response_use_package.dart';

class UsePackageEndPoint {
  final Dio dio = Dio();

  Future usePackage(
    String customerId,
    String customerPackageId,
    String token,
    List<dynamic> listService,
  ) async {
    final headers = {
      'Authorization': token,
    };
    final data = {
      "customer_package_id": customerPackageId,
      "schedule_services": listService
    };
    try {
      var response = await dio.post(
        '$baseURLV1/customer/create/payment/package/service/$customerId',
        data: data,
        options: Options(headers: headers),
      );
      return response.data;
    } catch (e) {
      return e;
    }
  }
}

class UsePackageRepository {
  final UsePackageEndPoint usePackageEndPoint;

  UsePackageRepository({required this.usePackageEndPoint});

  Future<ResponseUsePackage> usePackage(
    String customerId,
    String customerPackageId,
    String token,
    List<dynamic> listService,
  ) async {
    final result = await usePackageEndPoint.usePackage(
      customerId,
      customerPackageId,
      token,
      listService,
    );
    if (result.runtimeType == DioError) {
      return ResponseUsePackage.fromJson(result.response.data);
    } else {
      return ResponseUsePackage.fromJson(result);
    }
  }
}

class UsePackageUseCase {
  final UsePackageRepository repository;

  UsePackageUseCase({required this.repository});

  Future<ResponseUsePackage> execute(
    String customerId,
    String customerPackageId,
    String token,
    List<dynamic> listService,
  ) async {
    final response = await repository.usePackage(
      customerId,
      customerPackageId,
      token,
      listService,
    );
    return response;
  }
}
