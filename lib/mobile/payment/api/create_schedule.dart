import 'package:dio/dio.dart';
import 'package:navalha/shared/utils.dart';
import '../model/response_schedule.dart';

class CreateScheduleEndPoint {
  final Dio dio = Dio();

  Future createSchedule(
    String customerId,
    String barberShopId,
    String token,
    double amount,
    double codeDiscount,
    double codePercent,
    List<dynamic> listService,
  ) async {
    final headers = {
      'Authorization': token,
    };
    final data = {
      "promotional_code_discount": codeDiscount,
      "promotional_code_percent": codePercent,
      "barbershop_id": barberShopId,
      "transaction_amount": amount,
      "schedule_services": listService,
      "customer_name": null
    };
    try {
      var response = await dio.post(
        '$baseURLV1/customer/schedule/$customerId',
        data: data,
        options: Options(headers: headers),
      );
      return response;
    } catch (e) {
      return e;
    }
  }
}

class CreateScheduleRepository {
  final CreateScheduleEndPoint createScheduleEndPoint;

  CreateScheduleRepository({required this.createScheduleEndPoint});

  Future<ResponseCreateSchedule> createSchedule(
    String customerId,
    String barberShopId,
    String token,
    double amount,
    double codeDiscount,
    double codePercent,
    List<dynamic> listService,
  ) async {
    final result = await createScheduleEndPoint.createSchedule(
      customerId,
      barberShopId,
      token,
      amount,
      codeDiscount,
      codePercent,
      listService,
    );
    if (result.runtimeType == DioError) {
      return ResponseCreateSchedule.fromJson(result.response.data);
    } else {
      return ResponseCreateSchedule.fromJson(result.data);
    }
  }
}

class CreateScheduleUseCase {
  final CreateScheduleRepository repository;

  CreateScheduleUseCase({required this.repository});

  Future<ResponseCreateSchedule> execute(
    String customerId,
    String barberShopId,
    String token,
    double amount,
    double codeDiscount,
    double codePercent,
    List<dynamic> listService,
  ) async {
    final response = await repository.createSchedule(
      customerId,
      barberShopId,
      token,
      amount,
      codeDiscount,
      codePercent,
      listService,
    );
    return response;
  }
}
