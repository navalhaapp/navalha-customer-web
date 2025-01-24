import 'package:hooks_riverpod/hooks_riverpod.dart';
import '../../calendar/model/model_get_schedule_customer.dart';
import '../api/get_customer_packages.dart';
import '../model/response_get_customer_packages.dart';

final getPackagesCustomerEndpointProvider = Provider((ref) {
  return GetPackagesCustomerEndPoint();
});

final getPackagesCustomerRepositoryProvider = Provider(
  (ref) => GetPackagesCustomerRepository(
    getPackagesCustomerEndPoint: ref.read(getPackagesCustomerEndpointProvider),
  ),
);

final getPackagesCustomerUseCase = Provider((ref) {
  return GetPackagesCustomerUseCase(
    repository: ref.read(getPackagesCustomerRepositoryProvider),
  );
});

final getPackagesCustomerList = FutureProvider.family<
    ResponseGetCustomerPackages,
    ProviderFamilyGetScheduleModel>((ref, getPackagesModel) async {
  return ref.read(getPackagesCustomerUseCase).execute(getPackagesModel);
});

enum GetPackagesCustomerState { loggedOut, loading, loggedIn, error }

class GetPackagesCustomerStateController
    extends StateNotifier<GetPackagesCustomerState> {
  GetPackagesCustomerStateController(
    this._read,
    this.packageItem,
  ) : super(GetPackagesCustomerState.loggedOut);

  final Reader _read;
  var packageItem;

  static final provider = StateNotifierProvider<
      GetPackagesCustomerStateController, GetPackagesCustomerState>(
    (ref) => GetPackagesCustomerStateController(ref.read, null),
  );

  Future getPackagesCustomer(
      ProviderFamilyGetScheduleModel getPackagesModel) async {
    packageItem =
        await _read(getPackagesCustomerUseCase).execute(getPackagesModel);

    return packageItem!;
  }
}
