import 'dart:io';
import 'package:dio/dio.dart';
import '../../../shared/model/customer_model.dart';
import '../model/update_model_customer.dart';

class UpdateCustomerEndPoint {
  UpdateCustomerEndPoint(this._dio);
  final Dio _dio;
  updateCustomer(String token, Customer customer, File? image) async {
    _dio.options.headers["authorization"] = token;
    _dio.options.contentType = ContentType.parse("application/json").toString();

    FormData formData = FormData.fromMap({
      'image': image != null
          ? await MultipartFile.fromFile(image.path, filename: image.path)
          : null,
      'customer': {
        'customer_id': customer.customerId,
        'name': customer.name,
        'postal_code': customer.postalCode,
        'phone': customer.phone,
        'birth_date': customer.birthDate,
      }
    });
    try {
      Response response = await _dio.put("/customer/", data: formData);
      return response;
    } catch (e) {
      return e;
    }
  }
}

class UpdateCustomerRepository {
  final UpdateCustomerEndPoint updateCustomerEndPoint;

  UpdateCustomerRepository({required this.updateCustomerEndPoint});

  Future updateCustomer(String token, Customer customer, File? image) async {
    final result =
        await updateCustomerEndPoint.updateCustomer(token, customer, image);
    if (result.runtimeType == DioError) {
      return CustomerModelResponseError.fromJson(result.response.data);
    } else {
      return CustomerModelResponse.fromJson(result.data);
    }
  }
}

class UpdateCustomerUseCase {
  final UpdateCustomerRepository repository;

  UpdateCustomerUseCase({required this.repository});

  Future execute(String token, Customer customer, File? image) async {
    final response = await repository.updateCustomer(token, customer, image);

    return response;
  }
}
