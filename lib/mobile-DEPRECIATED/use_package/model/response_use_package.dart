import 'package:navalha/shared/interface/IResponse.dart';

class ResponseUsePackage implements IResponse<StatusEnum, String> {
  @override
  StatusEnum? status;
  @override
  String? result;

  ResponseUsePackage.fromJson(Map<String, dynamic> json) {
    status = Status.fromJson(json['status']);
    result = json['result'];
  }
  @override
  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['status'] = status;
    data['result'] = result;
    return data;
  }

  @override
  bool hasSucess() {
    return status == StatusEnum.success;
  }
}

enum StatusEnum { error, success }

extension Status on StatusEnum {
  static StatusEnum fromJson(String? json) {
    if (json == 'success') {
      return StatusEnum.success;
    } else {
      return StatusEnum.error; // Default to error if not recognized.
    }
  }
}
