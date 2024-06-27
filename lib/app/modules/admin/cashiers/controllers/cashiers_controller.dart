import 'package:easybill_app/app/data/repositories/cashier_repository.dart';
import 'package:get/get.dart';

import '../../../../data/models/cashier.dart';

class CashiersController extends GetxController {
  CashierRepo cashierRepo = CashierRepo();
  List<Cashier>? cashierList;

  @override
  void onInit() {
    print('CashiersController intit method called ');
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
    print('getCashier method called ------------------->>  ');

    try {
      print('before try method called ------------------->>  ');  
      final categoryLists = await cashierRepo.getCashier();
      update();
      print('after try method called ------------------->>  ');

      for (var category in categoryLists!) {
        print(category.loginusername);
      }
      cashierList = categoryLists;
    } catch (e) {
      print(e);
    }
  }

  void updateCashiers(List<Cashier> updatedList) {
    cashierList = updatedList;
    update();
  }



}
