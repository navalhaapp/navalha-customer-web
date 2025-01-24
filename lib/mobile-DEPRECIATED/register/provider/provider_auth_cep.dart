import 'package:dio/dio.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';

import '../../../shared/utils.dart';
import '../api/auth_cep_customer.dart';
import '../model/auth_cep_model.dart';

final authCepCustomerEndpointProvider = Provider((ref) {
  final dio = Dio(BaseOptions(
    baseUrl: baseURLV1,
  ));
  return AuthCepCustomerEndPoint(dio);
});

final authCepCustomerRepositoryProvider = Provider(
  (ref) => AuthCepCustomerRepository(
    authCepCustomerEndPoint: ref.read(authCepCustomerEndpointProvider),
  ),
);

final authCepCustomerUseCase = Provider((ref) {
  return AuthCepCustomerUseCase(
    repository: ref.read(authCepCustomerRepositoryProvider),
  );
});

enum AuthCepState { loggedOut, loading, loggedIn, error }

class AuthCepStateController extends StateNotifier<AuthCepState> {
  AuthCepStateController(
    this._read,
    this._postalCode,
  ) : super(AuthCepState.loggedOut);

  final Reader _read;
  AuthCepModel? _postalCode;

  static final provider =
      StateNotifierProvider<AuthCepStateController, AuthCepState>(
          (ref) => AuthCepStateController(ref.read, null));

  Future<void> authCep(String postalCode) async {
    state = AuthCepState.loading;
    try {
      _postalCode = await _read(authCepCustomerUseCase).execute(postalCode);
      state = AuthCepState.loggedIn;
    } catch (e) {
      _postalCode = null;
      state = AuthCepState.error;
    }
  }

  AuthCepModel? get user => _postalCode;
}
