// ignore_for_file: unnecessary_overrides

import 'package:easybill_app/app/constants/utils.dart';
import 'package:easybill_app/app/widgets/custom_widgets/custom_toast.dart';
import 'package:flutter/widgets.dart';
import 'package:get/get.dart';
import '../../../../constants/bools.dart';
import '../../../../data/api/local_storage.dart';
import '../../../../data/models/profile.dart';
import '../../../../data/repositories/profile_repo.dart';

class AdminProfileController extends GetxController {
  final formKey = GlobalKey<FormState>();

  final _profileRepo = ProfileRepo();

  TextEditingController gstController = TextEditingController();
  TextEditingController businessController = TextEditingController();
  TextEditingController addressController = TextEditingController();
  TextEditingController mobilController = TextEditingController();
  TextEditingController emailController = TextEditingController();
  TextEditingController passwordController = TextEditingController();

  bool isGstApplicable = false;

  bool readOnly = true, gstFlag = false;

  @override
  void onInit() {
    super.onInit();
    getProfile();
  }

  @override
  void onReady() {
    super.onReady();
  }

  @override
  void onClose() {
    super.onClose();
  }

  Future<void> getProfile() async {
    try {
      Profile p = Profile(
        usercredentialsid: int.parse(LocalStorage.usercredentialsid!),
      );
      debugPrint(
          "user credentials id --->> : ${LocalStorage.usercredentialsid}");
      EBBools.isLoading = true;
      final profile = await _profileRepo.getProfile(p);
      storeProfileDate(profile);
    } catch (e) {
      debugPrint(e.toString());
    } finally {
      EBBools.isLoading = false;
      readOnly = true;
      update();
    }
  }

  Future<void> updateProfile() async {
    try {
      Profile p = Profile(
          usercredentialsid: int.parse(LocalStorage.usercredentialsid!),
          businessaddress: addressController.text,
          businessname: businessController.text,
          loginmobilenumber: mobilController.text,
          gstnumber: gstController.text,
          email: emailController.text,
          loggedindeviceid: deviceID,
          loggedindevicename: deviceName);
      EBBools.isLoading = true;
      update();
      final profile = await _profileRepo.editProfile(p);
      storeProfileDate(profile);
    } catch (e) {
      debugPrint(e.toString());
      EBBools.isLoading = false;
      readOnly = true;
      update();
    } finally {
      EBBools.isLoading = false;
      readOnly = true;
      update();
    }
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

  void storeProfileDate(List<Profile>? profile) {
    if (profile != null) {
      for (var data in profile) {
        businessController.text = data.businessname ?? "";
        addressController.text = data.businessaddress ?? "";
        mobilController.text = data.loginmobilenumber ?? "";
        emailController.text = data.email ?? "";
        if (data.gst == true) {
          gstFlag = true;
          gstController.text = data.gstnumber!;
          EBBools.isTaxNeeded = true;
        }
      }
    }
  }

  void onEditProfile() {
    updateProfile();
  }
}
