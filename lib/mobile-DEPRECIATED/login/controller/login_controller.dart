import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:navalha/mobile-DEPRECIATED/login/model/auth_model.dart';
import '../provider/provider.dart';

enum LoginState { loggedOut, loading, loggedIn, error }

class LoginStateController extends StateNotifier<LoginState> {
  LoginStateController(
    this._read,
    this._user,
  ) : super(LoginState.loggedOut);

  final Reader _read;
  AuthCustomer? _user;

  static final provider =
      StateNotifierProvider<LoginStateController, LoginState>(
    (ref) => LoginStateController(ref.read, null),
  );

  Future login(String email, String password, String fBToken) async {
    _user = await _read(authCustomerUseCase).execute(email, password, fBToken);
    return _user;
  }

  get user => _user;
  set user(u) {
    _user = u;
  }
}
