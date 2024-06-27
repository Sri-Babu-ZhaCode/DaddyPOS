import 'package:get/get.dart';

import '../controllers/casier_help_controller.dart';

class CasierHelpBinding extends Bindings {
  @override
  void dependencies() {
    Get.lazyPut<CasierHelpController>(
      () => CasierHelpController(),
    );
  }
}
