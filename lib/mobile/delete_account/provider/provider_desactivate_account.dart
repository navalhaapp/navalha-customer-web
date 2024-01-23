import 'package:hooks_riverpod/hooks_riverpod.dart';

import '../api/desactivate_account.dart';

final desactiveAccountEndpointProvider = Provider((ref) {
  return DesactiveAccountEndPoint();
});

final desactiveAccountRepositoryProvider = Provider(
  (ref) => DesactiveAccountRepository(
    desactiveAccountEndPoint: ref.read(desactiveAccountEndpointProvider),
  ),
);

final desactiveAccountUseCase = Provider((ref) {
  return DesactiveAccountUseCase(
    repository: ref.read(desactiveAccountRepositoryProvider),
  );
});

enum DesactiveAccountState { loggedOut, loading, loggedIn, error }

class DesactiveAccountStateController
    extends StateNotifier<DesactiveAccountState> {
  DesactiveAccountStateController(
    this._read,
    this.account,
  ) : super(DesactiveAccountState.loggedOut);

  final Reader _read;
  var account;

  static final provider = StateNotifierProvider<DesactiveAccountStateController,
      DesactiveAccountState>(
    (ref) => DesactiveAccountStateController(ref.read, null),
  );

  Future desactiveAccount(
    String token,
    String customerId,
    description,
  ) async {
    account = await _read(desactiveAccountUseCase).execute(
      token,
      customerId,
      description,
    );

    return account!;
  }
}
