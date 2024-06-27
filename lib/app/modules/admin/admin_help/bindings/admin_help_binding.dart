import 'package:get/get.dart';

import '../controllers/admin_help_controller.dart';

class AdminHelpBinding extends Bindings {
  @override
  void dependencies() {
    Get.lazyPut<AdminHelpController>(
      () => AdminHelpController(),
    );
  }
}
