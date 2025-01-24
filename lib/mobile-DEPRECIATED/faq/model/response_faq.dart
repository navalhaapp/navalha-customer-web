class ResponseFaqModel {
  List<Faq>? result;
  String? status;

  ResponseFaqModel({this.result, this.status});

  ResponseFaqModel.fromJson(Map<String, dynamic> json) {
    if (json['result'] != null) {
      result = <Faq>[];
      json['result'].forEach((v) {
        result!.add(Faq.fromJson(v));
      });
    }
    status = json['status'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    if (result != null) {
      data['result'] = result!.map((v) => v.toJson()).toList();
    }
    data['status'] = status;
    return data;
  }
}

class Faq {
  String? description;
  String? title;
  String? faqId;

  Faq({this.description, this.title, this.faqId});

  Faq.fromJson(Map<String, dynamic> json) {
    description = json['description'];
    title = json['title'];
    faqId = json['faq_id'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['description'] = description;
    data['title'] = title;
    data['faq_id'] = faqId;
    return data;
  }
}
