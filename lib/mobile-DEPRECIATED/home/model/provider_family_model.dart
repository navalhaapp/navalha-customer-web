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
  String barberShopId;
  String? customerId;

  ParamsBarberShopById({
    required this.barberShopId,
    required this.customerId,
  });
}
