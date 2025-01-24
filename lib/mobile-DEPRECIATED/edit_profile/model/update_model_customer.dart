import '../../../shared/model/customer_model.dart';

abstract class IResponseUpdateCustomer<T> {
  String? status;
  T? result;
}

class CustomerModelResponse implements IResponseUpdateCustomer<Customer> {
  @override
  String? status;
  @override
  Customer? result;

  CustomerModelResponse({this.status, this.result});

  CustomerModelResponse.fromJson(Map<String, dynamic> json) {
    status = json['status'];
    result =
        json['customer'] != null ? Customer.fromJson(json['customer']) : null;
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['status'] = status;
    if (result != null) {
      data['customer'] = result!.toJson();
    }
    return data;
  }
}

class CustomerModelResponseError implements IResponseUpdateCustomer<String> {
  @override
  String? status;
  @override
  String? result;

  CustomerModelResponseError({this.status, this.result});

  CustomerModelResponseError.fromJson(Map<String, dynamic> json) {
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
