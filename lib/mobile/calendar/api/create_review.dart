import 'package:dio/dio.dart';
import '../../../shared/utils.dart';
import '../model/model_create_review.dart';

class CreateReviewEndPoint {
  final Dio dio = Dio();

  Future createReview(
    String token,
    String? description,
    double rating,
    String serviceId,
    String customerId,
  ) async {
    final headers = {
      'Authorization': token,
    };
    final data = {
      "barbershop_review_description": description,
      "barbershop_review_rating": rating,
      "schedule_service_id": serviceId
    };
    try {
      var response = await dio.post(
        '$baseURLV1/customer/create/review/$customerId',
        data: data,
        options: Options(headers: headers),
      );
      return response.data;
    } catch (e) {
      return e;
    }
  }
}

class CreateReviewRepository {
  final CreateReviewEndPoint createReviewEndPoint;

  CreateReviewRepository({required this.createReviewEndPoint});

  Future<ResponseCreateReview> createReview(
    String token,
    String? description,
    double rating,
    String serviceId,
    String customerId,
  ) async {
    final result = await createReviewEndPoint.createReview(
      token,
      description,
      rating,
      serviceId,
      customerId,
    );
    if (result.runtimeType == DioError) {
      return ResponseCreateReview.fromJson(result.response.data);
    } else {
      return ResponseCreateReview.fromJson(result);
    }
  }
}

class CreateReviewUseCase {
  final CreateReviewRepository repository;

  CreateReviewUseCase({required this.repository});

  Future<ResponseCreateReview> execute(
    String token,
    String? description,
    double rating,
    String serviceId,
    String customerId,
  ) async {
    final response = await repository.createReview(
      token,
      description,
      rating,
      serviceId,
      customerId,
    );
    return response;
  }
}
