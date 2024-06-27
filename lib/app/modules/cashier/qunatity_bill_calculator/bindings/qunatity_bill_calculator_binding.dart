import 'package:get/get.dart';

import '../controllers/qunatity_bill_calculator_controller.dart';

class QunatityBillCalculatorBinding extends Bindings {
  @override
  void dependencies() {
    Get.lazyPut<QunatityBillCalculatorController>(
      () => QunatityBillCalculatorController(
        selectedProduct: Get.arguments['selectedProduct'],
      ),
    );
  }
}
