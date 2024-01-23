import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:navalha/mobile/home/model/response_get_barber_shop_by_id.dart';

import 'package:navalha/shared/model/barber_shop_model.dart';

import '../mobile/my_packages/widgets/cupertino_sliding.dart';
import '../mobile/payment/model/response_create_pix_payment.dart';
import '../mobile/schedule/model/model_reserved_time.dart';
import '../mobile/schedule/model/model_service_cache.dart';
import '../mobile/schedule/model/model_total_price.dart';
import '../mobile/use_package/model/service_package_request.dart';
import 'model/edit_profile_model.dart';
import 'model/location_model.dart';
import 'model/package_model.dart';
import 'model/package_optional_selected_model.dart';

final loginValidator = StateProvider<bool>(((ref) => true));

final snackUp = StateProvider<bool>(((ref) => false));

final msgErrorInput = StateProvider<String>(((ref) => 'Campo inválido'));

final indexBarberShopPageProvider = StateProvider<int>(((ref) => 0));

final lastPageCheckoutProvider = StateProvider<bool>(((ref) => false));

final editProfilePageCache = StateProvider<EditProfileCacheController>(
  ((ref) => EditProfileCacheController()),
);

final locationProvider = StateProvider<LocationModel>(
  ((ref) => LocationModel(latitude: '', longitude: '')),
);

final reservedTimeProvider = StateProvider<ReservedTime>(
  ((ref) => ReservedTime()),
);

final listServicesCacheProvider = StateProvider<List<ServiceCache>>(
  ((ref) => []),
);

final totalPriceServiceProvider = StateProvider<TotalPriceService>(
  ((ref) => TotalPriceService()),
);

final barberShopSelectedProvider = StateProvider<BarberShop>(
  ((ref) => BarberShop()),
);

final barberShopSelectedIdProvider = StateProvider<String>(
  ((ref) => ''),
);

final filterIndexProvider = StateProvider<int>(
  ((ref) => 0),
);

final filterTextController = StateProvider<String>(
  ((ref) => ''),
);

final resumePaymentProvider = StateProvider<ServiceRequest>(
  ((ref) => ServiceRequest()),
);

final listResumePaymentProvider = StateProvider<RequestPaymentPix>(
  ((ref) => RequestPaymentPix(services: [])),
);
final servicesUsePackageList = StateProvider<List<UsePackageServiceRequest>>(
  ((ref) => []),
);

final navalhaCashActiveProvider = StateProvider<bool>(((ref) => false));

final fBTokenProvider = StateProvider<String>(((ref) => ''));

final daySelectedProvider = StateProvider<DateTime>(((ref) => DateTime.now()));

final packageSelectedProvider = StateProvider<PackageModel>(
  ((ref) => PackageModel()),
);
final packageSelectedToUseProvider = StateProvider<CustomerPackages>(
  ((ref) => CustomerPackages()),
);
final servicePackageSelectedProvider = StateProvider<CustomerPackageServices>(
  ((ref) => CustomerPackageServices()),
);

final packageOptionalSelectedProvider =
    StateProvider<PackageOptionalSelectedModel>(
  ((ref) => PackageOptionalSelectedModel()),
);

final packageAmountPriceProvider = StateProvider<double>(((ref) => 0.0));

final tabServicePackageProvider =
    StateProvider<EnumPackageService>(((ref) => EnumPackageService.products));
