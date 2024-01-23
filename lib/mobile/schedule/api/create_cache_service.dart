import 'package:dio/dio.dart';
import 'package:navalha/shared/enviroment.dart';
import '../../../shared/utils.dart';
import '../model/model_create_cache_service.dart';

class CreateCacheServiceEndPoint {
  final Dio dio = Dio();

  Future createCacheService(
    String barbershopId,
    String professionalId,
    String serviceId,
    String date,
    String initialHour,
    double discount,
  ) async {
    final headers = {
      'Authorization': Enviroment.publicHash,
    };
    final data = {
      "service": {
        "barbershop_id": barbershopId,
        "professional_id": professionalId,
        "professional_service_id": serviceId,
        "initial_hour": initialHour,
        "discount": discount
      }
    };
    try {
      var response = await dio.post(
        '$baseURLV1/customer/create/cache/service/$date',
        data: data,
        options: Options(headers: headers),
      );
      return response.data;
    } catch (e) {
      return e;
    }
  }
}

class CreateCacheServiceRepository {
  final CreateCacheServiceEndPoint createCacheServiceEndPoint;

  CreateCacheServiceRepository({required this.createCacheServiceEndPoint});

  Future<ResponseCreateCacheService> createCacheService(
    String barbershopId,
    String professionalId,
    String serviceId,
    String date,
    String initialHour,
    double discount,
  ) async {
    final result = await createCacheServiceEndPoint.createCacheService(
      barbershopId,
      professionalId,
      serviceId,
      date,
      initialHour,
      discount,
    );
    if (result.runtimeType == DioError) {
      return ResponseCreateCacheService.fromJson(result.response.data);
    } else {
      return ResponseCreateCacheService.fromJson(result);
    }
  }
}

class CreateCacheServiceUseCase {
  final CreateCacheServiceRepository repository;

  CreateCacheServiceUseCase({required this.repository});

  Future<ResponseCreateCacheService> execute(
    String barbershopId,
    String professionalId,
    String serviceId,
    String date,
    String initialHour,
    double discount,
  ) async {
    final response = await repository.createCacheService(
      barbershopId,
      professionalId,
      serviceId,
      date,
      initialHour,
      discount,
    );
    return response;
  }
}
