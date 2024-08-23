import 'package:get/get.dart';
import '../controllers/bill_details_controller.dart';

class BillDetailsBinding extends Bindings {
  @override
  void dependencies() {
    Get.lazyPut<BillDetailsController>(
      () => BillDetailsController(
        billItems: Get.arguments['billItems']
      ),
    );
  }
}
