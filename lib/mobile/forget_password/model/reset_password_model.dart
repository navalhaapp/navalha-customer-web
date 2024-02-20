class ResetPasswordModel {
  String? status;
  dynamic result;

  ResetPasswordModel({this.status, this.result});

  ResetPasswordModel.fromJson(Map<String, dynamic> json) {
    status = json['status'];
    result = json['result'] is String
        ? json['result']
        : ResultPassword.fromJson(json['result']);
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['status'] = status;
    if (result != null) {
      data['result'] = result!.toJson();
    }
    return data;
  }
}

class ResultPassword {
  String? verificationCode;
  String? customerId;

  ResultPassword({this.verificationCode, this.customerId});

  ResultPassword.fromJson(Map<String, dynamic> json) {
    verificationCode = json['verification_code'];
    customerId = json['customer_id'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['verification_code'] = verificationCode;
    data['customer_id'] = customerId;
    return data;
  }
}
