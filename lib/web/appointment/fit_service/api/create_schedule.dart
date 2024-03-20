import 'package:dio/dio.dart';
import 'package:navalha/mobile/payment/model/response_schedule.dart';
import 'package:navalha/shared/utils.dart';

class CreateScheduleEndPoint {
  final Dio dio = Dio();

  Future createSchedule(
    String customerName,
    String barberShopId,
    double amount,
    double codeDiscount,
    double codePercent,
    List<dynamic> listService,
  ) async {
    final data = {
      "promotional_code_discount": codeDiscount,
      "promotional_code_percent": codePercent,
      "barbershop_id": barberShopId,
      "transaction_amount": amount,
      "schedule_services": listService,
      "customer_name": customerName
    };
    try {
      var response = await dio.post(
        '$baseURLV1/customer/schedule/ ',
        data: data,
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
    String customerName,
    String barberShopId,
    double amount,
    double codeDiscount,
    double codePercent,
    List<dynamic> listService,
  ) async {
    final result = await createScheduleEndPoint.createSchedule(
      customerName,
      barberShopId,
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
    String customerName,
    String barberShopId,
    double amount,
    double codeDiscount,
    double codePercent,
    List<dynamic> listService,
  ) async {
    final response = await repository.createSchedule(
      customerName,
      barberShopId,
      amount,
      codeDiscount,
      codePercent,
      listService,
    );
    return response;
  }
}
