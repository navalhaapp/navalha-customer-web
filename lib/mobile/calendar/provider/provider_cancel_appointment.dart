import 'package:hooks_riverpod/hooks_riverpod.dart';

import '../api/cancel_appointment.dart';

final cancelAppointmentEndpointProvider = Provider((ref) {
  return CancelAppointmentEndPoint();
});

final cancelAppointmentRepositoryProvider = Provider(
  (ref) => CancelAppointmentRepository(
    cancelAppointmentEndPoint: ref.read(cancelAppointmentEndpointProvider),
  ),
);

final cancelAppointmentUseCase = Provider((ref) {
  return CancelAppointmentUseCase(
    repository: ref.read(cancelAppointmentRepositoryProvider),
  );
});

enum CancelAppointmentState { loggedOut, loading, loggedIn, error }

class CancelAppointmentStateController
    extends StateNotifier<CancelAppointmentState> {
  CancelAppointmentStateController(
    this._read,
    this.appointment,
  ) : super(CancelAppointmentState.loggedOut);

  final Reader _read;
  var appointment;

  static final provider = StateNotifierProvider<
      CancelAppointmentStateController, CancelAppointmentState>(
    (ref) => CancelAppointmentStateController(ref.read, null),
  );

  Future cancelAppointment(
    String token,
    String scheduleServiceId,
    String customerId,
  ) async {
    appointment = await _read(cancelAppointmentUseCase).execute(
      token,
      scheduleServiceId,
      customerId,
    );
    return appointment!;
  }
}
