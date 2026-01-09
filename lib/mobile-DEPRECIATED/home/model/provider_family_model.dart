class ProviderFamilyGetAllBarberShopModel {
  String deviceLat;
  String deviceLng;
  String maxDistance;

  ProviderFamilyGetAllBarberShopModel({
    required this.deviceLat,
    required this.deviceLng,
    required this.maxDistance,
  });
}

class ParamsBarberShopById {
  String barberShopName;
  String? customerId;

  ParamsBarberShopById({
    required this.barberShopName,
    required this.customerId,
  });
}
