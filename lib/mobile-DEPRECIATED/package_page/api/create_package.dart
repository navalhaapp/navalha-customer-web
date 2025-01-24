import 'package:dio/dio.dart';
import 'package:navalha/shared/utils.dart';
import '../model/params_create_package.dart';
import '../model/response_create_package.dart';

class CreatePackageEndPoint {
  final Dio dio = Dio();

  Future createPackage(ParamsCreatePackage paramns) async {
    final headers = {
      'Authorization': paramns.token,
    };

    final data = {
      'transaction_amount': paramns.transactionAmount,
      'barbershop_package_id': paramns.barbershopPackageId,
      'barbershop_optional_services': paramns.barbershopOptionalServices,
      'barbershop_optional_products': paramns.barbershopOptionalItems
    };

    try {
      var response = await dio.post(
        '$baseURLV1/customer/package/${paramns.customerId}',
        options: Options(headers: headers),
        data: data,
      );
      return response.data;
    } catch (e) {
      return e;
    }
  }
}

class CreatePackageRepository {
  final CreatePackageEndPoint createPackageEndPoint;

  CreatePackageRepository({required this.createPackageEndPoint});

  Future<ResponseCreatePackage> createPackage(
      ParamsCreatePackage paramns) async {
    final result = await createPackageEndPoint.createPackage(paramns);
    if (result.runtimeType == DioError) {
      return ResponseCreatePackage.fromJson(result.response.data);
    } else {
      return ResponseCreatePackage.fromJson(result);
    }
  }
}

class CreatePackageUseCase {
  final CreatePackageRepository repository;

  CreatePackageUseCase({required this.repository});

  Future<ResponseCreatePackage> execute(ParamsCreatePackage paramns) async {
    final response = await repository.createPackage(paramns);
    return response;
  }
}
