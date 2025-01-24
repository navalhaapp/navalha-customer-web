import 'package:dio/dio.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';

import '../../../shared/utils.dart';
import '../api/change_password_customer.dart';
import '../model/change_password_model.dart';

final changePasswordCustomerEndPointProvider = Provider((ref) {
  final dio = Dio(BaseOptions(
    baseUrl: baseURLV1,
  ));
  return ChangePasswordCustomerEndPoint(dio);
});

final changePasswordCustomerProvider = Provider(
  (ref) => ChangePasswordCustomerRepository(
    changePasswordCustomerEndPoint:
        ref.read(changePasswordCustomerEndPointProvider),
  ),
);

final changePasswordCustomerUseCase = Provider((ref) {
  return ChangePasswordCustomerUseCase(
    repository: ref.read(changePasswordCustomerProvider),
  );
});

enum ChangePasswordState { loggedOut, loading, loggedIn, error }

class ChangePasswordStateController extends StateNotifier<ChangePasswordState> {
  ChangePasswordStateController(
    this._read,
    this.userChangePassword,
  ) : super(ChangePasswordState.loggedOut);

  final Reader _read;
  ChangePasswordResponse? userChangePassword;

  static final provider =
      StateNotifierProvider<ChangePasswordStateController, ChangePasswordState>(
          (ref) => ChangePasswordStateController(ref.read, null));

  Future<ChangePasswordResponse> changePassword(String customerId,
      String? currentPassword, String newPassword, String? token) async {
    state = ChangePasswordState.loading;

    userChangePassword = await _read(changePasswordCustomerUseCase)
        .execute(customerId, currentPassword, newPassword, token);
    state = ChangePasswordState.loggedIn;
    return userChangePassword!;
  }
}
