import 'package:hooks_riverpod/hooks_riverpod.dart';
import '../api/create_schedule.dart';

final createScheduleEndpointProvider = Provider((ref) {
  return CreateScheduleEndPoint();
});

final createScheduleRepositoryProvider = Provider(
  (ref) => CreateScheduleRepository(
    createScheduleEndPoint: ref.read(createScheduleEndpointProvider),
  ),
);

final createScheduleUseCase = Provider((ref) {
  return CreateScheduleUseCase(
    repository: ref.read(createScheduleRepositoryProvider),
  );
});

class CreateScheduleStateController extends StateNotifier {
  CreateScheduleStateController(
    this._read,
    this.schedule,
  ) : super(null);

  final Reader _read;
  var schedule;

  static final provider = StateNotifierProvider(
    (ref) => CreateScheduleStateController(ref.read, null),
  );

  Future createSchedule(
    String customerId,
    String barberShopId,
    String token,
    double amount,
    double codeDiscount,
    double codePercent,
    List<dynamic> listService,
  ) async {
    schedule = await _read(createScheduleUseCase).execute(
      customerId,
      barberShopId,
      token,
      amount,
      codeDiscount,
      codePercent,
      listService,
    );

    return schedule!;
  }
}