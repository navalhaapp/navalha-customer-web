import 'package:hooks_riverpod/hooks_riverpod.dart';

import '../api/get_all_barber_shop_by_distance.dart';
import '../model/provider_family_model.dart';
import '../model/response_get_all_barber_shop_by_distance.dart';

final getAllBarberShopByDistanceEndpointProvider = Provider((ref) {
  return GetAllBarberShopByDistanceEndPoint();
});

final getAllBarberShopByDistanceRepositoryProvider = Provider(
  (ref) => GetAllBarberShopByDistanceRepository(
    getAllBarberShopByDistanceEndPoint:
        ref.read(getAllBarberShopByDistanceEndpointProvider),
  ),
);

final getAllBarberShopByDistanceUseCase = Provider((ref) {
  return GetAllBarberShopByDistanceUseCase(
    repository: ref.read(getAllBarberShopByDistanceRepositoryProvider),
  );
});

final getAllBarberShopByDistanceList = FutureProvider.family<
    ResponseGetAllBarberShopByDistance,
    ProviderFamilyGetAllBarberShopModel>((ref, getAllBarberShopModel) async {
  return ref
      .read(getAllBarberShopByDistanceUseCase)
      .execute(getAllBarberShopModel);
});

enum GetAllBarberShopByDistanceState { loggedOut, loading, loggedIn, error }

class GetAllBarberShopByDistanceStateController
    extends StateNotifier<GetAllBarberShopByDistanceState> {
  GetAllBarberShopByDistanceStateController(
    this._read,
    this.barberShops,
  ) : super(GetAllBarberShopByDistanceState.loggedOut);

  final Reader _read;
  var barberShops;

  static final provider = StateNotifierProvider<
      GetAllBarberShopByDistanceStateController,
      GetAllBarberShopByDistanceState>(
    (ref) => GetAllBarberShopByDistanceStateController(ref.read, null),
  );

  Future getAllBarberShopByDistance(
      ProviderFamilyGetAllBarberShopModel getAllBarberShopModel) async {
    barberShops = await _read(getAllBarberShopByDistanceUseCase)
        .execute(getAllBarberShopModel);

    return barberShops!;
  }
}
