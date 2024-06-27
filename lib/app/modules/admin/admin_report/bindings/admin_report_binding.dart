import 'package:easybill_app/app/modules/admin/inventory/controllers/inventory_controller.dart';
import 'package:get/get.dart';

import '../controllers/admin_report_controller.dart';

class AdminReportBinding extends Bindings {
  @override
  void dependencies() {
    Get.lazyPut<InventoryController>(
      () => InventoryController(),
    );
    Get.lazyPut<AdminReportController>(
      () => AdminReportController(
        decitionKeyForReports: Get.arguments['decitionKeyForReports'],
      ),
    );
  }
}
