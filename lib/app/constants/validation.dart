import 'package:flutter/widgets.dart';
import 'package:get/get.dart';

abstract class EBValidation {
  static bool isFormValidated(GlobalKey<FormState> formKey) {
    final currentState = formKey.currentState;
    return currentState != null && currentState.validate();
  }

  static String? validateMobile(String value) {
    if (value.trim().length != 10) {
      return 'Mobile number must be of 10 digit';
    }
    return null;
  }

  static String? validateGst(String value) {
    if (value.trim().length != 15) {
      return 'Gst must be of 15 digit';
    }
    return null;
  }

  static String? validateIsEmpty(String value) {
    if (value.trim().isEmpty) {
      return 'This field is required';
    }
    return null;
  }

  static String? validateEmail(String value) {
    if (!value.isEmail) {
      return 'Please enter valid email';
    }
    return null;
  }

  static String? validatePrice(String value) {
    if (value.trim().length != 15) {
      return 'price must be of 15 digit';
    }
    return null;
  }

}
