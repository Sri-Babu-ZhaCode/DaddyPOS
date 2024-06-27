import 'package:flutter/material.dart';
import 'package:get/get.dart';

import '../../constants/app_text_style.dart';
import '../../constants/themes.dart';

class EBCustomSnackbar {
  static void show(String message, {int? milliseconds}) {
    if (!Get.isSnackbarOpen) {
      Get.rawSnackbar(
        backgroundColor: EBTheme.kPrimaryColor,
        messageText: Text(
          message,
          
          style: EBAppTextStyle.printBtn,
        ),
        animationDuration: Duration(milliseconds: milliseconds ?? 300),
        snackPosition: SnackPosition.BOTTOM,
      );
    }
  }
}
