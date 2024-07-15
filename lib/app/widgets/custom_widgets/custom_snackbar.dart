import 'package:flutter/material.dart';
import 'package:get/get.dart';

import '../../constants/app_text_style.dart';
import '../../constants/themes.dart';

class EBCustomSnackbar {
  static void show(String message,
      {int? milliseconds, int? days, Color? backgroundColor, Widget? icon}) {
    if (!Get.isSnackbarOpen) {
      Get.rawSnackbar(
        backgroundColor: backgroundColor ?? EBTheme.kPrimaryColor,
        messageText: Text(
          message,
          style: EBAppTextStyle.printBtn,
        ),
        icon: icon,
        animationDuration: Duration(milliseconds: milliseconds ?? 300),
        snackPosition: SnackPosition.BOTTOM,
      );
    }
  }

  static void showWithDays(String message,
      {int? milliseconds, int? days, Color? backgroundColor, Widget? icon}) {
    if (!Get.isSnackbarOpen) {
      Get.rawSnackbar(
        backgroundColor: backgroundColor ?? EBTheme.kPrimaryColor,
        messageText: Text(
          message,
          style: EBAppTextStyle.printBtn,
        ),
        icon: icon,
        duration: days != null
            ? Duration(days: days)
            : Duration(milliseconds: milliseconds ?? 300),
        snackPosition: SnackPosition.BOTTOM,
      );
    }
  }
}
