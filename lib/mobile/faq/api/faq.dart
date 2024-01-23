import 'package:dio/dio.dart';
import 'package:navalha/shared/utils.dart';

import '../../../shared/enviroment.dart';
import '../model/response_faq.dart';

class FaqEndPoint {
  final Dio dio = Dio();

  Future faqList(String token) async {
    final headers = {
      // 'Authorization': token,
      'Authorization': Enviroment.publicHash,
    };
    try {
      var response = await dio.get('$baseURLV1/customer/frequently-asked/',
          options: Options(headers: headers));
      print(response.data);
      return response.data;
    } catch (e) {
      return e;
    }
  }
}

class FaqRepository {
  final FaqEndPoint faqEndPoint;

  FaqRepository({required this.faqEndPoint});

  Future<ResponseFaqModel> faqList(String token) async {
    final result = await faqEndPoint.faqList(token);
    if (result.runtimeType == DioError) {
      return ResponseFaqModel.fromJson(result.response.data);
    } else {
      return ResponseFaqModel.fromJson(result);
    }
  }
}

class FaqUseCase {
  final FaqRepository repository;

  FaqUseCase({required this.repository});

  Future<ResponseFaqModel> execute(String token) async {
    final response = await repository.faqList(token);
    return response;
  }
}
