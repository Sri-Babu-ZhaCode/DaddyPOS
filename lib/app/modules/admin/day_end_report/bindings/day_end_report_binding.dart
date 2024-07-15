import 'package:get/get.dart';

import '../controllers/day_end_report_controller.dart';

class DayEndReportBinding extends Bindings {
  @override
  void dependencies() {
    Get.lazyPut<DayEndReportController>(
      () => DayEndReportController(),
    );
  }
}
