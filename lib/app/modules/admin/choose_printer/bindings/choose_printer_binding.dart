import 'package:get/get.dart';

import '../controllers/choose_printer_controller.dart';

class ChoosePrinterBinding extends Bindings {
  @override
  void dependencies() {
    Get.lazyPut<ChoosePrinterController>(
      () => ChoosePrinterController(),
    );
  }
}
