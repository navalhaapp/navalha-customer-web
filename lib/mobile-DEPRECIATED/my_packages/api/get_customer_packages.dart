import 'package:dio/dio.dart';
import '../../calendar/model/model_get_schedule_customer.dart';
import '../../../shared/utils.dart';
import '../model/response_get_customer_packages.dart';

class GetPackagesCustomerEndPoint {
  final Dio dio = Dio();

  Future getPackagesCustomer(
      ProviderFamilyGetScheduleModel getPackagesModel) async {
    final headers = {
      'Authorization': getPackagesModel.token,
    };

    try {
      var response = await dio.get(
        '$baseURLV1/customer/package/${getPackagesModel.customerId}',
        options: Options(headers: headers),
      );
      return response.data;
    } catch (e) {
      return e;
    }
  }
}

class GetPackagesCustomerRepository {
  final GetPackagesCustomerEndPoint getPackagesCustomerEndPoint;

  GetPackagesCustomerRepository({required this.getPackagesCustomerEndPoint});

  Future<ResponseGetCustomerPackages> getPackagesCustomer(
      ProviderFamilyGetScheduleModel getPackagesModel) async {
    final result =
        await getPackagesCustomerEndPoint.getPackagesCustomer(getPackagesModel);
    if (result.runtimeType == DioError) {
      return ResponseGetCustomerPackages.fromJson(result.response.data);
    } else {
      return ResponseGetCustomerPackages.fromJson(result);
    }
  }
}

class GetPackagesCustomerUseCase {
  final GetPackagesCustomerRepository repository;

  GetPackagesCustomerUseCase({required this.repository});

  Future<ResponseGetCustomerPackages> execute(
      ProviderFamilyGetScheduleModel getPackagesModel) async {
    final response = await repository.getPackagesCustomer(getPackagesModel);
    return response;
  }
}
