import 'package:get/get.dart';

import '../controllers/cashier_reports_controller.dart';

class CashierReportsBinding extends Bindings {
  @override
  void dependencies() {
    Get.lazyPut<CashierReportsController>(
      () => CashierReportsController(),
    );
  }
}
