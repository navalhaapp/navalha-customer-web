import 'customer_model.dart';

class Review {
  String? reviewId;
  Customer? customer;
  String? description;
  String? answer;
  double? rating;
  String? date;
  double? tip;

  Review({
    this.reviewId,
    this.customer,
    this.description,
    this.answer,
    this.rating,
    this.date,
    this.tip,
  });

  Review.fromJson(Map<String, dynamic> json) {
    reviewId = json['review_id'];
    customer =
        json['customer'] != null ? Customer.fromJson(json['customer']) : null;
    description = json['description'];
    answer = json['answer'];
    rating = double.parse(json['rating'].toString());
    date = json['date'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['review_id'] = reviewId;
    if (customer != null) {
      data['customer'] = customer!.toJson();
    }
    data['description'] = description;
    data['answer'] = answer;
    data['rating'] = rating;
    data['date'] = date;
    data['tip'] = tip;
    return data;
  }
}
