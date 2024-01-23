class PaymentCards {
  String? paymentId;
  String? customerId;
  String? document;
  String? nickname;
  String? number;
  String? type;
  String? validDate;
  String? ownerName;
  String? paymentFlag;

  PaymentCards(
      {this.paymentId,
      this.customerId,
      this.document,
      this.nickname,
      this.number,
      this.type,
      this.validDate,
      this.ownerName,
      this.paymentFlag});

  PaymentCards.fromJson(Map<String, dynamic> json) {
    paymentId = json['payment_id'];
    customerId = json['customer_id'];
    document = json['document'];
    nickname = json['nickname'];
    number = json['number'];
    type = json['type'];
    validDate = json['valid_date'];
    ownerName = json['owner_name'];
    paymentFlag = json['payment_flag'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['payment_id'] = paymentId;
    data['customer_id'] = customerId;
    data['document'] = document;
    data['nickname'] = nickname;
    data['number'] = number;
    data['type'] = type;
    data['valid_date'] = validDate;
    data['owner_name'] = ownerName;
    data['payment_flag'] = paymentFlag;
    return data;
  }
}
