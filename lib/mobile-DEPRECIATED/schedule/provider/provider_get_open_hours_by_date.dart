import 'package:hooks_riverpod/hooks_riverpod.dart';
import '../api/get_open_hours_by_date.dart';
import '../model/model_get_open_hours_by_date.dart';

final getOpenHoursByDateEndpointProvider = Provider((ref) {
  return GetOpenHoursByDateEndPoint();
});

final getOpenHoursByDateRepositoryProvider = Provider(
  (ref) => GetOpenHoursByDateRepository(
    getOpenHoursByDateEndPoint: ref.read(getOpenHoursByDateEndpointProvider),
  ),
);

final getOpenHoursByDateUseCase = Provider((ref) {
  return GetOpenHoursByDateUseCase(
    repository: ref.read(getOpenHoursByDateRepositoryProvider),
  );
});

enum GetOpenHoursByDateState { loggedOut, loading, loggedIn, error }

class GetOpenHoursByDateStateController
    extends StateNotifier<GetOpenHoursByDateState> {
  GetOpenHoursByDateStateController(
    this._read,
    this.hours,
  ) : super(GetOpenHoursByDateState.loggedOut);

  final Reader _read;
  var hours;

  static final provider = StateNotifierProvider<
      GetOpenHoursByDateStateController, GetOpenHoursByDateState>(
    (ref) => GetOpenHoursByDateStateController(ref.read, null),
  );

  Future<ResponseGetOpenHoursByDate> getOpenHoursByDate(
    String weekday,
    String professionalId,
    String serviceId,
    String date, {
    String? token,
  }) async {
    hours = await _read(getOpenHoursByDateUseCase).execute(
      weekday,
      professionalId,
      serviceId,
      date,
      token: token,
    );

    return hours!;
  }
}
