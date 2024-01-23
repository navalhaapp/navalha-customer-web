import 'package:dio/dio.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';
import '../../../shared/utils.dart';
import '../api/auth_endpoint.dart';

final authEndpointProvider = Provider((ref) {
  final dio = Dio(BaseOptions(
    baseUrl: baseURLV1,
  ));
  return AuthEndPoint(dio);
});

final authRepositoryProvider = Provider(
  (ref) => AuthRepository(
    authEndPoint: ref.read(authEndpointProvider),
  ),
);

final authCustomerUseCase = Provider((ref) {
  return AuthCustomerUseCase(
    repository: ref.read(authRepositoryProvider),
  );
});
