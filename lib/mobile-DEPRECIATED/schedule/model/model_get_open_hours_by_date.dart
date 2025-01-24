import '../../../shared/model/open_hour_model.dart';

class ResponseGetOpenHoursByDate {
  String? status;
  dynamic result;

  ResponseGetOpenHoursByDate({this.status, this.result});

  ResponseGetOpenHoursByDate.fromJson(Map<String, dynamic> json) {
    status = json['status'];
    if (json['result'] != null) {
      if (json['result'] is List) {
        result = <OpenHour>[];
        json['result'].forEach((v) {
          result!.add(OpenHour.fromJson(v));
        });
      } else if (json['result'] is String) {
        result = json['result'];
      }
    }
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['status'] = status;
    if (result != null) {
      if (result is List<OpenHour>) {
        data['result'] = result!.map((v) => v.toJson()).toList();
      } else if (result is String) {
        data['result'] = result;
      }
    }
    return data;
  }
}
