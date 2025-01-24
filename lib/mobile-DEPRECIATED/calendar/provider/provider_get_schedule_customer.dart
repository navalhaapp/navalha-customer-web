import 'package:hooks_riverpod/hooks_riverpod.dart';

import '../api/get_schedule_customer.dart';
import '../model/model_get_schedule_customer.dart';

final getScheduleCustomerEndpointProvider = Provider((ref) {
  return GetScheduleCustomerEndPoint();
});

final getScheduleCustomerRepositoryProvider = Provider(
  (ref) => GetScheduleCustomerRepository(
    getScheduleCustomerEndPoint: ref.read(getScheduleCustomerEndpointProvider),
  ),
);

final getScheduleCustomerUseCase = Provider((ref) {
  return GetScheduleCustomerUseCase(
    repository: ref.read(getScheduleCustomerRepositoryProvider),
  );
});

final getScheduleCustomerList = FutureProvider.family<
    ResponseGetScheduleCustomer,
    ProviderFamilyGetScheduleModel>((ref, getScheduleModel) async {
  return ref.read(getScheduleCustomerUseCase).execute(getScheduleModel);
});

enum GetScheduleCustomerState { loggedOut, loading, loggedIn, error }

class GetScheduleCustomerStateController
    extends StateNotifier<GetScheduleCustomerState> {
  GetScheduleCustomerStateController(
    this._read,
    this.scheduleItem,
  ) : super(GetScheduleCustomerState.loggedOut);

  final Reader _read;
  var scheduleItem;

  static final provider = StateNotifierProvider<
      GetScheduleCustomerStateController, GetScheduleCustomerState>(
    (ref) => GetScheduleCustomerStateController(ref.read, null),
  );

  Future getScheduleCustomer(
      ProviderFamilyGetScheduleModel getScheduleModel) async {
    scheduleItem =
        await _read(getScheduleCustomerUseCase).execute(getScheduleModel);

    return scheduleItem!;
  }
}
