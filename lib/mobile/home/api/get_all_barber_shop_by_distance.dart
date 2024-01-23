import 'package:dio/dio.dart';
import '../../../shared/enviroment.dart';
import '../../../shared/utils.dart';
import '../model/provider_family_model.dart';
import '../model/response_get_all_barber_shop_by_distance.dart';

class GetAllBarberShopByDistanceEndPoint {
  final Dio dio = Dio();

  Future getAllBarberShopByDistance(
      ProviderFamilyGetAllBarberShopModel getAllBarberShopModel) async {
    final headers = {
      'Authorization': Enviroment.publicHash,
    };
    final data = {
      "device_coordinates": {
        "deviceLat": getAllBarberShopModel.deviceLat,
        "deviceLng": getAllBarberShopModel.deviceLng,
        "maxDistance": getAllBarberShopModel.maxDistance
      }
    };
    try {
      var response = await dio.post(
        '$baseURLV1/barbershop/by_distance',
        data: data,
        options: Options(headers: headers),
      );
      return response.data;
    } catch (e) {
      return e;
    }
  }
}

class GetAllBarberShopByDistanceRepository {
  final GetAllBarberShopByDistanceEndPoint getAllBarberShopByDistanceEndPoint;

  GetAllBarberShopByDistanceRepository(
      {required this.getAllBarberShopByDistanceEndPoint});

  Future<ResponseGetAllBarberShopByDistance> getAllBarberShopByDistance(
      ProviderFamilyGetAllBarberShopModel getAllBarberShopModel) async {
    final result = await getAllBarberShopByDistanceEndPoint
        .getAllBarberShopByDistance(getAllBarberShopModel);
    if (result.runtimeType == DioError) {
      return ResponseGetAllBarberShopByDistance.fromJson(result.response.data);
    } else {
      return ResponseGetAllBarberShopByDistance.fromJson(result);
    }
  }
}

class GetAllBarberShopByDistanceUseCase {
  final GetAllBarberShopByDistanceRepository repository;

  GetAllBarberShopByDistanceUseCase({required this.repository});

  Future<ResponseGetAllBarberShopByDistance> execute(
      ProviderFamilyGetAllBarberShopModel getAllBarberShopModel) async {
    final response =
        await repository.getAllBarberShopByDistance(getAllBarberShopModel);
    return response;
  }
}
