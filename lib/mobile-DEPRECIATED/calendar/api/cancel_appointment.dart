import 'package:dio/dio.dart';
import '../../../shared/utils.dart';
import '../model/model_cancel_appointment.dart';

class CancelAppointmentEndPoint {
  final Dio dio = Dio();

  Future cancelAppointment(
    String token,
    String scheduleServiceId,
    String customerId,
  ) async {
    final headers = {
      'Authorization': token,
    };
    final data = {
      "customer_id": customerId,
    };
    try {
      var response = await dio.post(
        '$baseURLV1/shared/cancel/schedule/service/$scheduleServiceId',
        data: data,
        options: Options(headers: headers),
      );
      return response.data;
    } catch (e) {
      return e;
    }
  }
}

class CancelAppointmentRepository {
  final CancelAppointmentEndPoint cancelAppointmentEndPoint;

  CancelAppointmentRepository({required this.cancelAppointmentEndPoint});

  Future<ResponseCancelAppointment> cancelAppointment(
    String token,
    String scheduleServiceId,
    String customerId,
  ) async {
    final result = await cancelAppointmentEndPoint.cancelAppointment(
      token,
      scheduleServiceId,
      customerId,
    );
    if (result.runtimeType == DioError) {
      return ResponseCancelAppointment.fromJson(result.response.data);
    } else {
      return ResponseCancelAppointment.fromJson(result);
    }
  }
}

class CancelAppointmentUseCase {
  final CancelAppointmentRepository repository;

  CancelAppointmentUseCase({required this.repository});

  Future<ResponseCancelAppointment> execute(
    String token,
    String scheduleServiceId,
    String customerId,
  ) async {
    final response = await repository.cancelAppointment(
      token,
      scheduleServiceId,
      customerId,
    );
    return response;
  }
}
