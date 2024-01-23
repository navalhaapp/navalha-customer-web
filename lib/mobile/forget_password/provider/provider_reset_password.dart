import 'package:dio/dio.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';
import '../../../shared/utils.dart';
import '../api/reset_password_customer.dart';
import '../model/reset_password_model.dart';

final resetPasswordCustomerEndpointProvider = Provider((ref) {
  final dio = Dio(BaseOptions(
    baseUrl: baseURLV1,
  ));
  return ResetPasswordCustomerEndPoint(dio);
});

final resetPasswordCustomerRepositoryProvider = Provider(
  (ref) => ResetPasswordCustomerRepository(
    resetPasswordCustomerEndPoint:
        ref.read(resetPasswordCustomerEndpointProvider),
  ),
);

final resetPasswordCustomerUseCase = Provider((ref) {
  return ResetPasswordCustomerUseCase(
    repository: ref.read(resetPasswordCustomerRepositoryProvider),
  );
});

enum ResetPasswordState { loggedOut, loading, loggedIn, error }

class ResetPasswordStateController extends StateNotifier<ResetPasswordState> {
  ResetPasswordStateController(
    this._read,
    this.email,
  ) : super(ResetPasswordState.loggedOut);

  final Reader _read;
  ResetPasswordModel? email;

  static final provider =
      StateNotifierProvider<ResetPasswordStateController, ResetPasswordState>(
    (ref) => ResetPasswordStateController(ref.read, null),
  );

  Future<ResetPasswordModel> resetPassword(String adressEmail) async {
    email = await _read(resetPasswordCustomerUseCase).execute(adressEmail);

    return email!;
  }
}
