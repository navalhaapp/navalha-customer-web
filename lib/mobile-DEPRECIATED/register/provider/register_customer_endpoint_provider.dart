import 'package:dio/dio.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:navalha/mobile-DEPRECIATED/register/api/create_customer_endpoint.dart';
import 'package:navalha/shared/utils.dart';

final customerEndpointProvider = Provider((ref) {
  final dio = Dio(BaseOptions(
    baseUrl: baseURLV1,
  ));
  return CustomerEndPoint(dio);
});
