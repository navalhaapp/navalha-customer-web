import 'package:dio/dio.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';

import '../../../shared/utils.dart';
import '../api/update_customer.dart';

final updateCustomerEndpointProvider = Provider((ref) {
  final dio = Dio(BaseOptions(
    baseUrl: baseURLV1,
  ));
  return UpdateCustomerEndPoint(dio);
});

final updateCustomerRepositoryProvider = Provider(
  (ref) => UpdateCustomerRepository(
    updateCustomerEndPoint: ref.read(updateCustomerEndpointProvider),
  ),
);

final updateCustomerUseCase = Provider((ref) {
  return UpdateCustomerUseCase(
    repository: ref.read(updateCustomerRepositoryProvider),
  );
});
