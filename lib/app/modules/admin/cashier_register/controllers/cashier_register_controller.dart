// ignore_for_file: unnecessary_overrides

import 'package:flutter/widgets.dart';
import 'package:get/get.dart';
import '../../../../data/models/cashier.dart';
import '../../../../data/repositories/cashier_repository.dart';
import '../../cashiers/controllers/cashiers_controller.dart';

class CashierRegisterController extends GetxController {
  CashierRegisterController(
      {required this.isEditMode, required this.selectedCashier});
  CashierRepo cashierRepo = CashierRepo();
  Cashier? selectedCashier;

  final count = 0.obs;

  bool isEditMode;

  TextEditingController mobileController = TextEditingController();

  TextEditingController userPasswordController = TextEditingController();
  TextEditingController staffUsernameController = TextEditingController();
  final formKey = GlobalKey<FormState>();
  @override
  void onInit() {
    super.onInit();
    if (selectedCashier != null) initCashier();
  }

  @override
  void onReady() {
    super.onReady();
  }

  @override
  void onClose() {
    super.onClose();
  }

  Future<void> addCashier() async {
    try {
      debugPrint(mobileController.text);
      debugPrint(userPasswordController.text);
      Cashier cashier = Cashier(
        loginusername: mobileController.text.trim(),
        userpassword: userPasswordController.text.trim(),
        staffname: staffUsernameController.text.trim(),
      );
      final cashierList = await cashierRepo.addCashier(cashier);
      Get.find<CashiersController>().updateCashiers(cashierList!);
      debugPrint(cashierList.toString());
      Get.back();
    } catch (e) {
      debugPrint(e.toString());
    }
  }

  void addCashierPressed() {
    if (formKey.currentState?.validate() == true) {
      addCashier();
      update();
    }
  }

  void editCashierPressed() {
    if (formKey.currentState?.validate() == true) {
      updateCashier();
      update();
    }
  }

  Future<void> updateCashier() async {
    debugPrint('update cashier called -------------->>   ');
    try {
      Cashier cashier = Cashier(
        usercredentialsid: selectedCashier!.usercredentialsid,
        loginusername: mobileController.text.trim(),
        staffname: staffUsernameController.text.trim(),
        userpassword: userPasswordController.text.trim(),
      );
      final cashierList = await cashierRepo.updateCashier(cashier);
      Get.find<CashiersController>().updateCashiers(cashierList!);
      debugPrint(cashierList.toString());
      Get.back();
    } catch (e) {
      debugPrint(e.toString());
    }
  }

  void initCashier() {
    mobileController.text = selectedCashier!.loginusername ?? '';
    userPasswordController.text = selectedCashier!.userpassword ?? '';
    staffUsernameController.text = selectedCashier!.staffname ?? '';
  }

  Future<void> deleteCashier(Cashier c) async {
    try {
      final x = await cashierRepo.deleteCashier(c);
      Get.find<CashiersController>().updateCashiers(x!);
      // update();
      Get.back();
      Get.back();
    } catch (e) {
      debugPrint(e.toString());
    }
  }
}
