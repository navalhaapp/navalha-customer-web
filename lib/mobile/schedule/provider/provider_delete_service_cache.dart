import 'package:hooks_riverpod/hooks_riverpod.dart';

import '../api/delete_service_cache.dart';

final deleteCacheServiceEndpointProvider = Provider((ref) {
  return DeleteCacheServiceEndPoint();
});

final deleteCacheServiceRepositoryProvider = Provider(
  (ref) => DeleteCacheServiceRepository(
    deleteCacheServiceEndPoint: ref.read(deleteCacheServiceEndpointProvider),
  ),
);

final deleteCacheServiceUseCase = Provider((ref) {
  return DeleteCacheServiceUseCase(
    repository: ref.read(deleteCacheServiceRepositoryProvider),
  );
});

enum DeleteCacheServiceState { loggedOut, loading, loggedIn, error }

class DeleteCacheServiceStateController
    extends StateNotifier<DeleteCacheServiceState> {
  DeleteCacheServiceStateController(
    this._read,
    this.service,
  ) : super(DeleteCacheServiceState.loggedOut);

  final Reader _read;
  var service;

  static final provider = StateNotifierProvider<
      DeleteCacheServiceStateController, DeleteCacheServiceState>(
    (ref) => DeleteCacheServiceStateController(ref.read, null),
  );

  Future deleteCacheService(String cachedId) async {
    service = await _read(deleteCacheServiceUseCase).execute(cachedId);

    return service!;
  }
}
