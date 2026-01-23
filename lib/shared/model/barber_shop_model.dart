import 'package:navalha/shared/model/professional_model.dart';
import 'package:navalha/shared/model/review_model.dart';
import 'package:navalha/shared/model/service_model.dart';
import 'adress_model.dart';
import 'closed_date_model.dart';
import 'hour_model.dart';
import 'package_model.dart';

class BarberShop {
  List<Professional>? professionals;
  List<Service>? services;
  String? barbershopId;
  String? name;
  String? email;
  String? phone;
  String? cnpjDocument;
  String? imgProfile;
  String? imgBackground;
  String? password;
  double? rating;
  bool? accessibility;
  bool? park;
  bool? internet;
  bool? activated;
  String? createdOn;
  Adress? adress;
  bool? validatedCnpj;
  bool? physical;
  String? aboutUs;
  List<HourModel>? openingHourList;
  List<ClosedDate>? closedDateList;
  List<Review>? barberShopReviews;
  List<PackageModel>? packageList;
  List<GalleryImages>? galleryImages;
  int? scheduleAdvanceDays;

  BarberShop({
    this.professionals,
    this.services,
    this.barbershopId,
    this.name,
    this.email,
    this.phone,
    this.cnpjDocument,
    this.imgProfile,
    this.imgBackground,
    this.password,
    this.rating,
    this.accessibility,
    this.park,
    this.internet,
    this.closedDateList,
    this.activated,
    this.createdOn,
    this.adress,
    this.validatedCnpj,
    this.physical,
    this.aboutUs,
    this.galleryImages,
    this.openingHourList,
    this.barberShopReviews,
    this.packageList,
    this.scheduleAdvanceDays,
  });

  BarberShop.fromJson(Map<String, dynamic> json) {
    if (json['professionals'] != null) {
      professionals = <Professional>[];
      json['professionals'].forEach((v) {
        professionals!.add(Professional.fromJson(v));
      });
    }
    if (json['review_list'] != null) {
      barberShopReviews = <Review>[];
      json['review_list'].forEach((v) {
        barberShopReviews!.add(Review.fromJson(v));
      });
    }
    if (json['gallery_images'] != null) {
      galleryImages = <GalleryImages>[];
      json['gallery_images'].forEach((v) {
        galleryImages!.add(GalleryImages.fromJson(v));
      });
    }
    if (json['services'] != null) {
      services = <Service>[];
      json['services'].forEach((v) {
        services!.add(Service.fromJson(v));
      });
    }
    barbershopId = json['barbershop_id'];
    name = json['name'];
    email = json['email'];
    phone = json['phone'];
    cnpjDocument = json['cnpj_document'];
    imgProfile = json['img_profile'];
    imgBackground = json['img_background'];
    password = json['password'];
    if (json['rating'] != null) {
      rating = double.parse(json['rating'].toString());
    }
    if (json['closed_date_list'] != null) {
      closedDateList = <ClosedDate>[];
      json['closed_date_list'].forEach((v) {
        closedDateList!.add(ClosedDate.fromJson(v));
      });
    }
    accessibility = json['accessibility'].toString().toLowerCase() == "true";
    park = json['park'].toString().toLowerCase() == "true";
    internet = json['internet'].toString().toLowerCase() == "true";
    activated = json['activated'];
    createdOn = json['created_on'];

    adress = json['adress'] != null ? Adress.fromJson(json['adress']) : null;
    validatedCnpj = json['validated_cnpj'];
    physical = json['physical'].toString().toLowerCase() == "true";
    aboutUs = json['about_us'];
    if (json['opening_hour_list'] != null) {
      openingHourList = <HourModel>[];
      json['opening_hour_list'].forEach((v) {
        openingHourList!.add(HourModel.fromJson(v));
      });
    }
    if (json['package_list'] != null) {
      packageList = <PackageModel>[];
      json['package_list'].forEach((v) {
        packageList!.add(PackageModel.fromJson(v));
      });
    }
    scheduleAdvanceDays = json['schedule_advance_days'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    if (professionals != null) {
      data['professionals'] = professionals!.map((v) => v.toJson()).toList();
    }
    if (barberShopReviews != null) {
      data['review'] = barberShopReviews!.map((v) => v.toJson()).toList();
    }

    if (services != null) {
      data['services'] = services!.map((v) => v.toJson()).toList();
    }
    if (closedDateList != null) {
      data['closed_date_list'] =
          closedDateList!.map((v) => v.toJson()).toList();
    }
    if (galleryImages != null) {
      data['gallery_images'] = galleryImages!.map((v) => v.toJson()).toList();
    }
    data['barbershop_id'] = barbershopId;
    data['name'] = name;
    data['email'] = email;
    data['phone'] = phone;
    data['cnpj_document'] = cnpjDocument;
    data['img_profile'] = imgProfile;
    data['img_background'] = imgBackground;
    data['password'] = password;
    data['rating'] = rating;
    data['accessibility'] = accessibility;
    data['park'] = park;
    data['internet'] = internet;
    data['activated'] = activated;
    data['created_on'] = createdOn;
    if (adress != null) {
      data['adress'] = adress!.toJson();
    }
    data['validated_cnpj'] = validatedCnpj;
    data['physical'] = physical;
    data['about_us'] = aboutUs;
    if (openingHourList != null) {
      data['opening_hour_list'] =
          openingHourList!.map((v) => v.toJson()).toList();
    }
    if (packageList != null) {
      data['package_list'] = packageList!.map((v) => v.toJson()).toList();
    }
    data['schedule_advance_days'] = scheduleAdvanceDays;
    return data;
  }
}

class GalleryImages {
  String? barbershopImageId;
  String? barbershopImage;
  int? barbershopImageIndex;
  String? barbershopImageCreateAt;

  GalleryImages(
      {this.barbershopImageId,
      this.barbershopImage,
      this.barbershopImageIndex,
      this.barbershopImageCreateAt});

  GalleryImages.fromJson(Map<String, dynamic> json) {
    barbershopImageId = json['barbershop_image_id'];
    barbershopImage = json['barbershop_image'];
    barbershopImageIndex = json['barbershop_image_index'];
    barbershopImageCreateAt = json['barbershop_image_create_at'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['barbershop_image_id'] = barbershopImageId;
    data['barbershop_image'] = barbershopImage;
    data['barbershop_image_index'] = barbershopImageIndex;
    data['barbershop_image_create_at'] = barbershopImageCreateAt;
    return data;
  }
}
