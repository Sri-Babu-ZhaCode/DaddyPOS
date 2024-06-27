import 'package:get/get.dart';

import '../controllers/cashier_management_controller.dart';

class CashierManagementBinding extends Bindings {
  @override
  void dependencies() {
    Get.lazyPut<CashierManagementController>(
      () => CashierManagementController(),
    );
  }
}
