import 'dart:io';

import 'package:hooks_riverpod/hooks_riverpod.dart';
import '../../../shared/model/customer_model.dart';
import '../provider/provider_update_customer.dart';

enum UpdateState { loggedOut, loading, loggedIn, error }

class UpdateStateController extends StateNotifier<UpdateState> {
  UpdateStateController(
    this._read,
    this.user,
  ) : super(UpdateState.loggedOut);

  final Reader _read;
  var user;

  static final provider =
      StateNotifierProvider<UpdateStateController, UpdateState>(
    (ref) => UpdateStateController(ref.read, null),
  );

  Future updatecustomer(String token, Customer customer, File? image) async {
    try {
      user = await _read(updateCustomerUseCase).execute(token, customer, image);
    } catch (e) {
      return e;
    }
    return user;
  }
}
