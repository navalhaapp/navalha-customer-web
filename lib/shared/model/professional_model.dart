import 'package:navalha/shared/model/closed_date_model.dart';
import 'package:navalha/shared/model/review_model.dart';

import 'barber_shop_model.dart';
import 'hour_model.dart';
import 'service_model.dart';

class Professional {
  String? professionalId;
  String? name;
  String? cpfDocument;
  String? email;
  String? birthDate;
  String? phone;
  String? imgProfile;
  String? password;
  bool? activated;
  String? createdOn;
  String? gener;
  double? rating;
  double? comission;
  BarberShop? barbershop;
  List<Service>? professionalServices;
  List<Review>? professionalReviews;
  List<ClosedDate>? closedDateList;
  List<HourModel>? openingHourList;

  Professional({
    this.professionalId,
    this.name,
    this.cpfDocument,
    this.email,
    this.birthDate,
    this.phone,
    this.imgProfile,
    this.password,
    this.activated,
    this.createdOn,
    this.gener,
    this.rating,
    this.comission,
    this.barbershop,
    this.openingHourList,
    this.professionalServices,
    this.professionalReviews,
  });

  Professional.fromJson(Map<String, dynamic> json) {
    if (json['closed_date_list'] != null) {
      closedDateList = <ClosedDate>[];
      json['closed_date_list'].forEach((v) {
        closedDateList!.add(ClosedDate.fromJson(v));
      });
    }
    if (json['professional_services'] != null) {
      professionalServices = <Service>[];
      json['professional_services'].forEach((v) {
        professionalServices!.add(Service.fromJson(v));
      });
    }
    if (json['professional_reviews'] != null) {
      professionalReviews = <Review>[];
      json['professional_reviews'].forEach((v) {
        professionalReviews!.add(Review.fromJson(v));
      });
    }
    professionalId = json['professional_id'];
    name = json['name'];
    cpfDocument = json['cpf_document'];
    email = json['email'];
    birthDate = json['birth_date'];
    phone = json['phone'];
    imgProfile = json['img_profile'];
    password = json['password'];
    activated = json['activated'];
    createdOn = json['created_on'];
    gener = json['gener'];
    if (json['opening_hour_list'] != null) {
      openingHourList = <HourModel>[];
      json['opening_hour_list'].forEach((v) {
        openingHourList!.add(HourModel.fromJson(v));
      });
    }
    rating =
        json['rating'] == null ? 5 : double.parse(json['rating'].toString());
    comission = json['comission'] == null
        ? 0
        : double.parse(json['comission'].toString());
    barbershop = json['barbershop'] != null
        ? BarberShop.fromJson(json['barbershop'])
        : null;
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    if (professionalServices != null) {
      data['professional_services'] =
          professionalServices!.map((v) => v.toJson()).toList();
    }
    if (professionalReviews != null) {
      data['professional_reviews'] =
          professionalReviews!.map((v) => v.toJson()).toList();
    }
    if (closedDateList != null) {
      data['closed_date_list'] =
          closedDateList!.map((v) => v.toJson()).toList();
    }
    data['professional_id'] = professionalId;
    data['name'] = name;
    data['cpf_document'] = cpfDocument;
    data['email'] = email;
    data['birth_date'] = birthDate;
    data['phone'] = phone;
    data['img_profile'] = imgProfile;
    data['password'] = password;
    data['activated'] = activated;
    data['created_on'] = createdOn;
    data['gener'] = gener;
    data['rating'] = rating;
    data['comission'] = comission;
    if (barbershop != null) {
      data['barbershop'] = barbershop!.toJson();
    }
    if (openingHourList != null) {
      data['opening_hour_list'] =
          openingHourList!.map((v) => v.toJson()).toList();
    }
    return data;
  }
}
