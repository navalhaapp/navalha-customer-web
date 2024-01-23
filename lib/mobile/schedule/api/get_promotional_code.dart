import 'package:dio/dio.dart';
import '../../../shared/utils.dart';
import '../model/response_get_promotional_code.dart';

class GetPromotionalCodeEndPoint {
  final Dio dio = Dio();

  Future getPromotionalCode(
      String token, String promotionalCode, String barberShopId) async {
    final headers = {
      'Authorization': token,
    };

    try {
      var response = await dio.get(
        '$baseURLV1/barbershop/$barberShopId/get/promotional_code/$promotionalCode',
        options: Options(headers: headers),
      );
      return response.data;
    } catch (e) {
      return e;
    }
  }
}

class GetPromotionalCodeRepository {
  final GetPromotionalCodeEndPoint getPromotionalCodeEndPoint;

  GetPromotionalCodeRepository({required this.getPromotionalCodeEndPoint});

  Future<ResponseGetPromotionalCode> getPromotionalCode(
      String token, String promotionalCode, String barberShopId) async {
    final result = await getPromotionalCodeEndPoint.getPromotionalCode(
        token, promotionalCode, barberShopId);
    if (result.runtimeType == DioError) {
      return ResponseGetPromotionalCode.fromJson(result.response.data);
    } else {
      return ResponseGetPromotionalCode.fromJson(result);
    }
  }
}

class GetPromotionalCodeUseCase {
  final GetPromotionalCodeRepository repository;

  GetPromotionalCodeUseCase({required this.repository});

  Future<ResponseGetPromotionalCode> execute(
      String token, String promotionalCode, String barberShopId) async {
    final response = await repository.getPromotionalCode(
        token, promotionalCode, barberShopId);
    return response;
  }
}
