import 'package:dio/dio.dart';
import 'package:navalha/shared/utils.dart';
import '../model/model_get_open_hours_by_date.dart';

class GetOpenHoursByDateEndPoint {
  final Dio dio = Dio();

  Future getOpenHoursByDate(
    String weekday,
    String professionalId,
    String serviceId,
    String date, {
    String? token,
  }) async {
    final headers = {
      'Authorization': token,
    };
    final data = {
      "service_detail": {
        "weekday": weekday,
        "professional_id": professionalId,
        "service_id": serviceId
      }
    };
    try {
      var response = await dio.put(
        '$baseURLV1/professional/open/hours/date/$date',
        data: data,
        options: Options(headers: headers),
      );
      return response.data;
    } catch (e) {
      return e;
    }
  }
}

class GetOpenHoursByDateRepository {
  final GetOpenHoursByDateEndPoint getOpenHoursByDateEndPoint;

  GetOpenHoursByDateRepository({required this.getOpenHoursByDateEndPoint});

  Future<ResponseGetOpenHoursByDate> getOpenHoursByDate(
    String weekday,
    String professionalId,
    String serviceId,
    String date, {
    String? token,
  }) async {
    final result = await getOpenHoursByDateEndPoint.getOpenHoursByDate(
      weekday,
      professionalId,
      serviceId,
      date,
      token: token,
    );
    if (result.runtimeType == DioError) {
      return ResponseGetOpenHoursByDate.fromJson(result.response.data);
    } else {
      return ResponseGetOpenHoursByDate.fromJson(result);
    }
  }
}

class GetOpenHoursByDateUseCase {
  final GetOpenHoursByDateRepository repository;

  GetOpenHoursByDateUseCase({required this.repository});

  Future<ResponseGetOpenHoursByDate> execute(
    String weekday,
    String professionalId,
    String serviceId,
    String date, {
    String? token,
  }) async {
    final response = await repository.getOpenHoursByDate(
      weekday,
      professionalId,
      serviceId,
      date,
      token: token,
    );
    return response;
  }
}
