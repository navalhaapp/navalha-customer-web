import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:navalha/mobile/register/provider/register_customer_repository_provider.dart';
import 'package:navalha/mobile/register/usecase/create_customer_usecase.dart';

final createCustomerUseCase = Provider((ref) {
  return CreateCustomerUseCase(
      repository: ref.read(customerRepositoryProvider));
});