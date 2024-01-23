import 'package:flutter/material.dart';

import '../model/req_create_customer.dart';

abstract class IController<T> {
  late T entity;
  bool verifyValidProp(List<String> propNames, List<String> propValues);
  void addProp(List<String> propNames, List<String> propValues);
  T generateFinalObject();
}

class CustomerRegisterController extends ChangeNotifier
    implements IController<ReqCreateCustomerModel> {
  @override
  ReqCreateCustomerModel entity;
  late Map<String, dynamic> customerMiddleMap = {};
  @override
  CustomerRegisterController(this.entity);

  @override
  bool verifyValidProp(List<String> propNames, List<dynamic> propValues) {
    late bool hasCustomerPropName;
    for (var element in propNames) {
      hasCustomerPropName = entity.toJson().containsKey(element);
      if (!hasCustomerPropName) return false;
    }
    addProp(propNames, propValues);
    return hasCustomerPropName;
  }

  @override
  void addProp(List<String> propName, List<dynamic> propValue) {
    for (var i = 0; i < propName.length; i++) {
      customerMiddleMap[propName[i]] = propValue[i];
    }
  }

  @override
  ReqCreateCustomerModel generateFinalObject() {
    return ReqCreateCustomerModel.fromJson(customerMiddleMap);
  }
}
