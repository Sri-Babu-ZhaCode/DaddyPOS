import 'package:get/get.dart';

import '../controllers/cashier_settings_controller.dart';

class CashierSettingsBinding extends Bindings {
  @override
  void dependencies() {
    Get.lazyPut<CashierSettingsController>(
      () => CashierSettingsController(),
    );
  }
}
