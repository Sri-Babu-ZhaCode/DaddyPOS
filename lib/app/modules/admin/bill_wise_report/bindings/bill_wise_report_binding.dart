import 'package:get/get.dart';

import '../controllers/bill_wise_report_controller.dart';

class BillWiseReportBinding extends Bindings {
  @override
  void dependencies() {
    Get.lazyPut<BillWiseReportController>(
      () => BillWiseReportController(
        billWiseDecisionKey: Get.arguments['billWiseDecisionKey'],
        otherReports: Get.arguments['otherReports'],
      ),
    );
  }
}
