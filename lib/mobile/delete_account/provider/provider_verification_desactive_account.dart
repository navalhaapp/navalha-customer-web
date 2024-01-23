import 'package:hooks_riverpod/hooks_riverpod.dart';

import '../api/verification_desactive_account.dart';

final verificationDesactiveAccountEndpointProvider = Provider((ref) {
  return VerificationDesactiveAccountEndPoint();
});

final verificationDesactiveAccountRepositoryProvider = Provider(
  (ref) => VerificationDesactiveAccountRepository(
    verificationDesactiveAccountEndPoint:
        ref.read(verificationDesactiveAccountEndpointProvider),
  ),
);

final verificationDesactiveAccountUseCase = Provider((ref) {
  return VerificationDesactiveAccountUseCase(
    repository: ref.read(verificationDesactiveAccountRepositoryProvider),
  );
});

enum VerificationDesactiveAccountState { loggedOut, loading, loggedIn, error }

class VerificationDesactiveAccountStateController
    extends StateNotifier<VerificationDesactiveAccountState> {
  VerificationDesactiveAccountStateController(
    this._read,
    this.account,
  ) : super(VerificationDesactiveAccountState.loggedOut);

  final Reader _read;
  var account;

  static final provider = StateNotifierProvider<
      VerificationDesactiveAccountStateController,
      VerificationDesactiveAccountState>(
    (ref) => VerificationDesactiveAccountStateController(ref.read, null),
  );

  Future verificationDesactiveAccount(
    String token,
    String customerId,
  ) async {
    account = await _read(verificationDesactiveAccountUseCase).execute(
      token,
      customerId,
    );

    return account!;
  }
}
