import '../../mobile/use_package/model/response_use_package.dart';

class IResponse<S, R> {
  S? status;
  R? result;

  IResponse.fromJson(Map<String, dynamic> json) {
    status = json['status'];
    result = json['result'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['status'] = status;
    data['result'] = result;
    return data;
  }

  bool hasSucess() {
    return status == StatusEnum.success;
  }
}
