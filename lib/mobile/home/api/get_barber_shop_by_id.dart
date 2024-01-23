import 'package:dio/dio.dart';
import '../../../shared/enviroment.dart';
import '../../../shared/utils.dart';
import '../model/provider_family_model.dart';
import '../model/response_get_barber_shop_by_id.dart';

class GetBarberShopByIdEndPoint {
  final Dio dio = Dio();

  Future getAllBarberShopById(ParamsBarberShopById params) async {
    final headers = {
      'Authorization': Enviroment.publicHash,
    };
    final data = {"customer_id": params.customerId};
    try {
      var response = await dio.post(
        '$baseURLV1/customer/barbershop/getById/${params.barberShopId}',
        data: data,
        options: Options(headers: headers),
      );
      return response.data;
    } catch (e) {
      return e;
    }
  }
}

class GetBarberShopByIdRepository {
  final GetBarberShopByIdEndPoint getAllBarberShopByIdEndPoint;

  GetBarberShopByIdRepository({required this.getAllBarberShopByIdEndPoint});

  Future<ResponseBarberShopById> getAllBarberShopById(
      ParamsBarberShopById params) async {
    final result =
        await getAllBarberShopByIdEndPoint.getAllBarberShopById(params);
    if (result.runtimeType == DioError) {
      return ResponseBarberShopById.fromJson(result.response.data);
    } else {
      return ResponseBarberShopById.fromJson(result);
    }
  }
}

class GetBarberShopByIdUseCase {
  final GetBarberShopByIdRepository repository;

  GetBarberShopByIdUseCase({required this.repository});

  Future<ResponseBarberShopById> execute(ParamsBarberShopById params) async {
    final response = await repository.getAllBarberShopById(params);
    return response;
  }
}
