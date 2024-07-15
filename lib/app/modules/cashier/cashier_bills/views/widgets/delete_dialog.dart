import 'package:easybill_app/app/constants/themes.dart';
import 'package:easybill_app/app/modules/cashier/cashier_bills/controllers/cashier_bills_controller.dart';
import 'package:get/get.dart';
import '../../../../../constants/app_string.dart';
import '../../../../../widgets/custom_widgets/custom_alert_dialog.dart';

Future deleteAlertDialog() {
  return const CustomAlertDialog().alertDialog(
    confimBtnColor: EBTheme.redColor,
    dialogTitle: 'Delete Bill',
    isformChildrenNeeded: true,
    dialogContent: 'Are you sure you want delete this Bill items',
    confirmButtonText: EBAppString.allClear,
    confirmOnPressed: () {
      Get.find<CashierBillsController>().cancelOrderPressed();
      Get.back();
    },
    cancelButtonText: EBAppString.cancel,
    cancelOnPressed: () {
      Get.back();
    },
  );
}
