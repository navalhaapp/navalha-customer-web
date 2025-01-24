import 'package:hooks_riverpod/hooks_riverpod.dart';

import '../controller/register_customer_controller.dart';
import '../model/req_create_customer.dart';

final customerRegisterProvider =
    ChangeNotifierProvider<CustomerRegisterController>(
  (ref) => CustomerRegisterController(ref.read(newCustomer)),
);

final newCustomer =
    StateProvider<ReqCreateCustomerModel>((ref) => ReqCreateCustomerModel());
