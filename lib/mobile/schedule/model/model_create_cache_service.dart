import 'package:navalha/mobile/schedule/model/model_service_cache.dart';

class ResponseCreateCacheService {
  String? status;
  dynamic result;

  ResponseCreateCacheService({this.status, this.result});

  ResponseCreateCacheService.fromJson(Map<String, dynamic> json) {
    status = json['status'];
    if (json['result'] != null) {
      if (json['result'] is String) {
        result = json['result'];
      } else {
        result = ServiceCache.fromJson(json['result']);
      }
    } else {
      result = null;
    }
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
