import 'package:dio/dio.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:navalha/mobile-DEPRECIATED/register/api/auth_email_customer.dart';
import 'package:navalha/mobile-DEPRECIATED/register/model/auth_email_model.dart';
import '../../../shared/utils.dart';

final authEmailCustomerEndpointProvider = Provider((ref) {
  final dio = Dio(BaseOptions(
    baseUrl: baseURLV1,
  ));
  return AuthEmailCustomerEndPoint(dio);
});

final authEmailCustomerRepositoryProvider = Provider(
  (ref) => AuthEmailCustomerRepository(
    authEmailCustomerEndPoint: ref.read(authEmailCustomerEndpointProvider),
  ),
);

final authEmailCustomerUseCase = Provider((ref) {
  return AuthEmailCustomerUseCase(
    repository: ref.read(authEmailCustomerRepositoryProvider),
  );
});

enum AuthEmailState { loggedOut, loading, loggedIn, error }

class AuthEmailStateController extends StateNotifier<AuthEmailState> {
  AuthEmailStateController(
    this._read,
    this.Email,
  ) : super(AuthEmailState.loggedOut);

  final Reader _read;
  AuthEmailModel? Email;

  static final provider =
      StateNotifierProvider<AuthEmailStateController, AuthEmailState>(
    (ref) => AuthEmailStateController(ref.read, null),
  );

  Future<AuthEmailModel> authEmail(String andressEmail) async {
    Email = await _read(authEmailCustomerUseCase).execute(andressEmail);

    return Email!;
  }
}
