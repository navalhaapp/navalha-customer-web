import 'package:dio/dio.dart';
import 'package:navalha/shared/enviroment.dart';
import '../../../shared/utils.dart';
import '../model/model_delete_service_cache.dart';

class DeleteCacheServiceEndPoint {
  final Dio dio = Dio();

  Future deleteCacheService(
    String cachedId,
  ) async {
    final headers = {
      'Authorization': Enviroment.publicHash,
    };

    try {
      var response = await dio.delete(
        '$baseURLV1/customer/delete/cache/$cachedId',
        options: Options(headers: headers),
      );
      return response.data;
    } catch (e) {
      return e;
    }
  }
}

class DeleteCacheServiceRepository {
  final DeleteCacheServiceEndPoint deleteCacheServiceEndPoint;

  DeleteCacheServiceRepository({required this.deleteCacheServiceEndPoint});

  Future<ResponseDeleteServiceCache> deleteCacheService(String cachedId) async {
    final result =
        await deleteCacheServiceEndPoint.deleteCacheService(cachedId);
    if (result.runtimeType == DioError) {
      return ResponseDeleteServiceCache.fromJson(result.response.data);
    } else {
      return ResponseDeleteServiceCache.fromJson(result);
    }
  }
}

class DeleteCacheServiceUseCase {
  final DeleteCacheServiceRepository repository;

  DeleteCacheServiceUseCase({required this.repository});

  Future<ResponseDeleteServiceCache> execute(String cachedId) async {
    final response = await repository.deleteCacheService(cachedId);
    return response;
  }
}
