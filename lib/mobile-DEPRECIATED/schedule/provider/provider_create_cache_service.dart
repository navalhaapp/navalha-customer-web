import 'package:hooks_riverpod/hooks_riverpod.dart';

import '../api/create_cache_service.dart';

final createCacheServiceEndpointProvider = Provider((ref) {
  return CreateCacheServiceEndPoint();
});

final createCacheServiceRepositoryProvider = Provider(
  (ref) => CreateCacheServiceRepository(
    createCacheServiceEndPoint: ref.read(createCacheServiceEndpointProvider),
  ),
);

final createCacheServiceUseCase = Provider((ref) {
  return CreateCacheServiceUseCase(
    repository: ref.read(createCacheServiceRepositoryProvider),
  );
});

enum CreateCacheServiceState { loggedOut, loading, loggedIn, error }

class CreateCacheServiceStateController
    extends StateNotifier<CreateCacheServiceState> {
  CreateCacheServiceStateController(
    this._read,
    this.service,
  ) : super(CreateCacheServiceState.loggedOut);

  final Reader _read;
  var service;

  static final provider = StateNotifierProvider<
      CreateCacheServiceStateController, CreateCacheServiceState>(
    (ref) => CreateCacheServiceStateController(ref.read, null),
  );

  Future createCacheService(
    String barbershopId,
    String professionalId,
    String serviceId,
    String date,
    String initialHour,
    double discount,
  ) async {
    service = await _read(createCacheServiceUseCase).execute(
      barbershopId,
      professionalId,
      serviceId,
      date,
      initialHour,
      discount,
    );

    return service!;
  }
}
