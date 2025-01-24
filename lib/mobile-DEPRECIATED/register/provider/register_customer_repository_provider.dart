import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:navalha/mobile-DEPRECIATED/register/repository/registration_repository.dart';

import 'register_customer_endpoint_provider.dart';

final customerRepositoryProvider = Provider((ref) =>
    CustomerRepository(customerEndPoint: ref.read(customerEndpointProvider)));
