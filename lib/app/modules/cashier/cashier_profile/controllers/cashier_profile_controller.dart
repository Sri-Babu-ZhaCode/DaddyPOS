// ignore_for_file: unnecessary_overrides

import 'package:flutter/material.dart';
import 'package:get/get.dart';

import '../../../../constants/bools.dart';
import '../../../../data/api/local_storage.dart';
import '../../../../data/models/profile.dart';
import '../../../../data/repositories/profile_repo.dart';
import '../../../../widgets/custom_widgets/custom_toast.dart';

class CashierProfileController extends GetxController {
  final _profileRepo = ProfileRepo();
  final passwordController = TextEditingController();
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

  Future<void> onUpdatePass() async {
    try {
      Profile p = Profile(
          usercredentialsid: int.parse(LocalStorage.usercredentialsid!),
          newpassword: passwordController.text);
      EBBools.isLoading = true;
      update();
      final profileList = await _profileRepo.updatePass(p);
      if (profileList != null) {
        EBBools.isLoading = false;
        ebCustomTtoastMsg(message: 'Password updated successfully');
        update();
      }
      Get.back();
    } catch (e) {
      debugPrint(e.toString());
    } finally {
      EBBools.isLoading = false;
      update();
    }
  }
}
