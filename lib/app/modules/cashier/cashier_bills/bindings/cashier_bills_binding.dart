import 'package:get/get.dart';

import '../../../admin/inventory/controllers/inventory_controller.dart';
import '../controllers/cashier_bills_controller.dart';

class CashierBillsBinding extends Bindings {
  @override
  void dependencies() {
    Get.lazyPut<InventoryController>(
      () => InventoryController(),
    );
    Get.lazyPut<CashierBillsController>(
      () => CashierBillsController(),
    );
  }
}
