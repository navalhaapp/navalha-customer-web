class AuthCepModel {
  String? status;
  bool? result;

  AuthCepModel({this.status, this.result});

  AuthCepModel.fromJson(Map<String, dynamic> json) {
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
