// ignore_for_file: unnecessary_overrides

import 'package:easybill_app/app/constants/bools.dart';
import 'package:easybill_app/app/data/repositories/cashier_repository.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

import '../../../../data/models/cashier.dart';

class CashiersController extends GetxController {
  CashierRepo cashierRepo = CashierRepo();
  List<Cashier>? cashierList;

  @override
  void onInit() {
    debugPrint('CashiersController intit method called ');
    super.onInit();
    getCashier();
  }

  @override
  void onReady() {
    super.onReady();
  }

  @override
  void onClose() {
    super.onClose();
  }

  Future<void> getCashier() async {
    EBBools.isLoading = true;
    update();
    debugPrint('getCashier method called ------------------->>  ');

    try {
      debugPrint('before try method called ------------------->>  ');
      final categoryLists = await cashierRepo.getCashier();
      update();
      debugPrint('after try method called ------------------->>  ');

      for (var category in categoryLists!) {
        debugPrint(category.loginusername);
      }
      cashierList = categoryLists;
    } catch (e) {
      debugPrint(e.toString());
    } finally {
      EBBools.isLoading = false;
      update();
    }
  }

  void updateCashiers(List<Cashier> updatedList) {
    EBBools.isLoading = true;
    update();
    cashierList = updatedList;
     EBBools.isLoading = false;
    update();
  }
}
