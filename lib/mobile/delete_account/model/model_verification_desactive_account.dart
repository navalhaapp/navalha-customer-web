class ResponseVerificationDesactiveAccount {
  String? status;
  bool? result;

  ResponseVerificationDesactiveAccount({this.status, this.result});

  ResponseVerificationDesactiveAccount.fromJson(Map<String, dynamic> json) {
    status = json['status'];
    result = json['result'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['status'] = status;
    data['result'] = result;
    return data;
  }
}
