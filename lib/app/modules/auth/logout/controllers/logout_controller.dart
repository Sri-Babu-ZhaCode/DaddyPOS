// ignore_for_file: unnecessary_overrides, annotate_overrides

import 'package:easybill_app/app/modules/auth/login/controllers/login_controller.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import '../../../../constants/app_string.dart';
import '../../../../data/models/login.dart';
import '../../../../data/repositories/auth_repository.dart';
import '../../../../routes/app_pages.dart';
import '../../../../widgets/custom_widgets/custom_snackbar.dart';

class LogoutController extends GetxController {
  final authRepo = AuthRepo();
  @override
  void onInit() {
    super.onInit();
  }

  @override
  void onReady() {
    super.onReady();
  }

  @override
  void onClose() {
    super.onClose();
  }

  Future<void> onLogoutPressed() async {
    Login? login = Get.find<LoginController>().loginList![0];

    try {
      await authRepo.logOut(login);
      Get.back();
      EBCustomSnackbar.show('${EBAppString.responseMsg}');
      Get.toNamed(Routes.LOGIN);
    } catch (e) {
      debugPrint(e.toString());
    }
  }
}
