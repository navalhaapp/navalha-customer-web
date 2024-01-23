import 'package:dio/dio.dart';

import '../../../shared/utils.dart';
import '../model/model_get_schedule_customer.dart';

class GetScheduleCustomerEndPoint {
  final Dio dio = Dio();

  Future getScheduleCustomer(
      ProviderFamilyGetScheduleModel getScheduleModel) async {
    final headers = {
      'Authorization': getScheduleModel.token,
    };

    try {
      var response = await dio.get(
        '$baseURLV1/customer/schedule/${getScheduleModel.customerId}',
        options: Options(headers: headers),
      );
      return response.data;
    } catch (e) {
      return e;
    }
  }
}

class GetScheduleCustomerRepository {
  final GetScheduleCustomerEndPoint getScheduleCustomerEndPoint;

  GetScheduleCustomerRepository({required this.getScheduleCustomerEndPoint});

  Future<ResponseGetScheduleCustomer> getScheduleCustomer(
      ProviderFamilyGetScheduleModel getScheduleModel) async {
    final result =
        await getScheduleCustomerEndPoint.getScheduleCustomer(getScheduleModel);
    if (result.runtimeType == DioError) {
      return ResponseGetScheduleCustomer.fromJson(result.response.data);
    } else {
      return ResponseGetScheduleCustomer.fromJson(result);
    }
  }
}

class GetScheduleCustomerUseCase {
  final GetScheduleCustomerRepository repository;

  GetScheduleCustomerUseCase({required this.repository});

  Future<ResponseGetScheduleCustomer> execute(
      ProviderFamilyGetScheduleModel getScheduleModel) async {
    final response = await repository.getScheduleCustomer(getScheduleModel);
    return response;
  }
}
