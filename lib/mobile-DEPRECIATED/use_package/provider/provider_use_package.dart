import 'package:hooks_riverpod/hooks_riverpod.dart';

import '../api/use_package.dart';
import '../model/response_use_package.dart';
import '../model/service_package_request.dart';

final userPackageEndpointProvider = Provider((ref) {
  return UsePackageEndPoint();
});

final usePackageRepositoryProvider = Provider(
  (ref) => UsePackageRepository(
    usePackageEndPoint: ref.read(userPackageEndpointProvider),
  ),
);
final usePackageServiceUseCase = Provider((ref) {
  return UsePackageUseCase(
    repository: ref.read(usePackageRepositoryProvider),
  );
});

class UsePackageStateController extends StateNotifier {
  UsePackageStateController(
    this._read,
    this.payment,
  ) : super(null);

  final Reader _read;
  ResponseUsePackage? payment;

  static final provider = StateNotifierProvider(
    (ref) => UsePackageStateController(ref.read, null),
  );

  Future usePackage(
    String customerId,
    String customerPackageId,
    String token,
    List<UsePackageServiceRequest> listService,
  ) async {
    payment = await _read(usePackageServiceUseCase).execute(
      customerId,
      customerPackageId,
      token,
      listService,
    );

    return payment!;
  }
}
