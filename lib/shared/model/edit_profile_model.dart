class EditProfileCacheController {
  String? name;
  String? phone;
  String? postalCode;
  String? birthDate;

  EditProfileCacheController({
    this.name,
    this.phone,
    this.postalCode,
    this.birthDate,
  });

  void clear() {
    name = '';
    phone = '';
    postalCode = '';
    birthDate = '';
  }
}
