class ClosedDate {
  String? closedDateId;
  String? closedDate;

  ClosedDate({this.closedDateId, this.closedDate});

  ClosedDate.fromJson(Map<String, dynamic> json) {
    closedDateId = json['closed_date_id'];
    closedDate = json['closed_date'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['closed_date_id'] = closedDateId;
    data['closed_date'] = closedDate;
    return data;
  }
}
