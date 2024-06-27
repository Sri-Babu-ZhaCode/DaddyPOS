import 'package:get/get.dart';

import '../controllers/cashier_profile_controller.dart';

class CashierProfileBinding extends Bindings {
  @override
  void dependencies() {
    Get.lazyPut<CashierProfileController>(
      () => CashierProfileController(),
    );
  }
}
