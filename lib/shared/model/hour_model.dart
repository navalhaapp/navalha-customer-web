class HourModel {
  bool? activated;
  String? startPm;
  String? endPm;
  String? startAm;
  String? endAm;
  String? weekday;

  HourModel({
    this.activated,
    this.startPm,
    this.endPm,
    this.startAm,
    this.endAm,
    this.weekday,
  });

  HourModel.fromJson(Map<String, dynamic> json) {
    activated = json['activated'];
    startPm = json['start_pm'];
    endPm = json['end_pm'];
    startAm = json['start_am'];
    endAm = json['end_am'];
    weekday = json['weekday'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['activated'] = activated;
    data['start_pm'] = startPm;
    data['end_pm'] = endPm;
    data['start_am'] = startAm;
    data['end_am'] = endAm;
    data['weekday'] = weekday;
    return data;
  }
}
