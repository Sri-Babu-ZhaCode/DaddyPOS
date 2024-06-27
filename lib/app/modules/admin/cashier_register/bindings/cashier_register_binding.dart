import 'package:get/get.dart';

import '../controllers/cashier_register_controller.dart';

class CashierRegisterBinding extends Bindings {
  @override
  void dependencies() {
    print('---------------- CashierRegisterController binded');
    print(Get.arguments['isEditMode']);
    print(Get.arguments['selectedCashier']);
    Get.lazyPut<CashierRegisterController>(
      () => CashierRegisterController(
          isEditMode: Get.arguments['isEditMode'] ?? false,
          selectedCashier: Get.arguments['selectedCashier']),
    );
  }
}
