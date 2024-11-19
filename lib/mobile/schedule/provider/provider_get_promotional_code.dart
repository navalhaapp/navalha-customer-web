import 'package:hooks_riverpod/hooks_riverpod.dart';

import '../api/get_promotional_code.dart';

final getPromotionalCodeEndpointProvider = Provider((ref) {
  return GetPromotionalCodeEndPoint();
});

final getPromotionalCodeRepositoryProvider = Provider(
  (ref) => GetPromotionalCodeRepository(
    getPromotionalCodeEndPoint: ref.read(getPromotionalCodeEndpointProvider),
  ),
);

final getPromotionalCodeUseCase = Provider((ref) {
  return GetPromotionalCodeUseCase(
    repository: ref.read(getPromotionalCodeRepositoryProvider),
  );
});

enum GetPromotionalCodeState { loggedOut, loading, loggedIn, error }

class GetPromotionalCodeStateController
    extends StateNotifier<GetPromotionalCodeState> {
  GetPromotionalCodeStateController(
    this._read,
    this.code,
  ) : super(GetPromotionalCodeState.loggedOut);

  final Reader _read;
  var code;

  static final provider = StateNotifierProvider<
      GetPromotionalCodeStateController, GetPromotionalCodeState>(
    (ref) => GetPromotionalCodeStateController(ref.read, null),
  );

  Future getPromotionalCode(
     String promotionalCode, String barberShopId) async {
    code = await _read(getPromotionalCodeUseCase)
        .execute(promotionalCode, barberShopId);

    return code!;
  }
}
