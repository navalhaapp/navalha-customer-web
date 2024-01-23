/*types to text_form_pattern      -Vitor    */

import 'package:navalha/shared/messages.dart';

abstract class EditType {
  String getErrorMessage();
}

class EmailType implements EditType {
  @override
  String getErrorMessage() {
    return msgValidEmail;
  }
}

class NameType implements EditType {
  @override
  String getErrorMessage() {
    return msgOnylLetter;
  }
}

class NumericType implements EditType {
  @override
  String getErrorMessage() {
    return msgOnlyDigit;
  }
}
