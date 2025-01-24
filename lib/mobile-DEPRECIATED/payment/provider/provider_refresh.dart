import 'package:hooks_riverpod/hooks_riverpod.dart';
import '../api/refesh.dart';

final refreshEndpointProvider = Provider((ref) {
  return RefreshEndPoint();
});

final refreshRepositoryProvider = Provider(
  (ref) => RefreshRepository(
    refreshEndPoint: ref.read(refreshEndpointProvider),
  ),
);

final refreshUseCase = Provider((ref) {
  return RefreshUseCase(
    repository: ref.read(refreshRepositoryProvider),
  );
});

enum RefreshState { loggedOut, loading, loggedIn, error }

class RefreshStateController extends StateNotifier<RefreshState> {
  RefreshStateController(
    this._read,
    this.user,
  ) : super(RefreshState.loggedOut);

  final Reader _read;
  var user;

  static final provider =
      StateNotifierProvider<RefreshStateController, RefreshState>(
    (ref) => RefreshStateController(ref.read, null),
  );

  Future refresh(
    String customerId,
    String token,
  ) async {
    user = await _read(refreshUseCase).execute(
      customerId,
      token,
    );

    return user!;
  }
}
