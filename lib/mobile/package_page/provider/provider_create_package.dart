import 'package:hooks_riverpod/hooks_riverpod.dart';
import '../api/create_package.dart';
import '../model/params_create_package.dart';

final buyPackageEndpointProvider = Provider((ref) {
  return CreatePackageEndPoint();
});

final buyPackageRepositoryProvider = Provider(
  (ref) => CreatePackageRepository(
    createPackageEndPoint: ref.read(buyPackageEndpointProvider),
  ),
);

final buyPackageUseCase = Provider((ref) {
  return CreatePackageUseCase(
    repository: ref.read(buyPackageRepositoryProvider),
  );
});

enum CreatePackageState { loggedOut, loading, loggedIn, error }

class CreatePackageController extends StateNotifier<CreatePackageState> {
  CreatePackageController(
    this._read,
    this.package,
  ) : super(CreatePackageState.loggedOut);

  final Reader _read;
  var package;

  static final provider =
      StateNotifierProvider<CreatePackageController, CreatePackageState>(
    (ref) => CreatePackageController(ref.read, null),
  );

  Future createPackage(ParamsCreatePackage paramns) async {
    package = await _read(buyPackageUseCase).execute(paramns);

    return package!;
  }
}
