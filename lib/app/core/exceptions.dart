import 'dart:io';

import 'package:dio/dio.dart';
import 'package:easybill_app/app/constants/app_string.dart';
import 'package:easybill_app/app/constants/app_text_style.dart';
import 'package:easybill_app/app/constants/bools.dart';
import 'package:easybill_app/app/constants/themes.dart';
import 'package:easybill_app/app/internet/controller/network_controller.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class EbException {
  int? statusCode;
  String? message;
  EbException(error) {
    if (error is DioError) {
      EBBools.isLoading = false;
      statusCode = error.response?.statusCode;
      message = error.response?.data["message"];
      EBAppString.responseMsg = message;
      debugPrint('status code --------->> : $statusCode');
      debugPrint('message --------->> : $message');
      if (!Get.isSnackbarOpen) {
        Get.rawSnackbar(
            backgroundColor: EBTheme.kPrimaryColor,
            messageText: Text(
              message!,
              style: EBAppTextStyle.printBtn,
            ),
            animationDuration: const Duration(milliseconds: 300),
            snackPosition: SnackPosition.BOTTOM);
      }
      print('message ----------------->>  ${message}');
    }
    if (error is SocketException) {
       debugPrint(
            '<<---------------------------------------------- Error in Internet --------------------------------------------------------------->>');
      NetworkController.logoutFromApp();      
    }
  }
}
