import 'package_model.dart';

class PackageOptionalSelectedModel {
  List<BarbershopPackageServices>? barbershopPackageServices;
  List<BarbershopPackageItems>? barbershopPackageItems;

  PackageOptionalSelectedModel({
    this.barbershopPackageServices,
    this.barbershopPackageItems,
  });

  void clear() {
    barbershopPackageServices = [];
    barbershopPackageItems = [];
  }
}
