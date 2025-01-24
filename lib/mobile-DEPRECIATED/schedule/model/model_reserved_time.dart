import 'package:navalha/shared/model/open_hour_model.dart';

class ReservedTime {
  String? weekday;
  String? professionalId;
  String? serviceId;
  String? date;
  String? initialHour;
  double? discount;
  String? observation;
  List<OpenHour>? listOpenHours;

  ReservedTime({
    this.weekday,
    this.professionalId,
    this.serviceId,
    this.date,
    this.initialHour,
    this.discount,
    this.observation,
    this.listOpenHours,
  });

  void clear() {
    weekday = '';
    professionalId = '';
    serviceId = '';
    date = '';
    initialHour = '';
    discount = 0;
    observation = '';
    listOpenHours = [];
  }
}
