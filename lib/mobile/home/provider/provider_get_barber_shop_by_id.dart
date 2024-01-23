import 'package:hooks_riverpod/hooks_riverpod.dart';

import '../api/get_barber_shop_by_id.dart';
import '../model/provider_family_model.dart';
import '../model/response_get_barber_shop_by_id.dart';

final getAllBarberShopByIdEndpointProvider = Provider((ref) {
  return GetBarberShopByIdEndPoint();
});

final getAllBarberShopByIdRepositoryProvider = Provider(
  (ref) => GetBarberShopByIdRepository(
    getAllBarberShopByIdEndPoint:
        ref.read(getAllBarberShopByIdEndpointProvider),
  ),
);

final getAllBarberShopByIdUseCase = Provider((ref) {
  return GetBarberShopByIdUseCase(
    repository: ref.read(getAllBarberShopByIdRepositoryProvider),
  );
});

final getAllBarberShopById =
    FutureProvider.family<ResponseBarberShopById, ParamsBarberShopById>(
        (ref, getBarberShop) async {
  return ref.read(getAllBarberShopByIdUseCase).execute(getBarberShop);
});

enum GetBarberShopByIdState { loggedOut, loading, loggedIn, error }

class GetBarberShopByIdStateController
    extends StateNotifier<GetBarberShopByIdState> {
  GetBarberShopByIdStateController(
    this._read,
    this.barberShop,
  ) : super(GetBarberShopByIdState.loggedOut);

  final Reader _read;
  var barberShop;

  static final provider = StateNotifierProvider<
      GetBarberShopByIdStateController, GetBarberShopByIdState>(
    (ref) => GetBarberShopByIdStateController(ref.read, null),
  );

  Future getAllBarberShopById(ParamsBarberShopById params) async {
    barberShop = await _read(getAllBarberShopByIdUseCase).execute(params);

    return barberShop!;
  }
}
