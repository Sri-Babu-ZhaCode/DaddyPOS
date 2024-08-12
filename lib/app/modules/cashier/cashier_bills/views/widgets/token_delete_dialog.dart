import 'package:easybill_app/app/constants/themes.dart';
import 'package:easybill_app/app/modules/cashier/cashier_bills/controllers/cashier_bills_controller.dart';
import 'package:get/get.dart';
import '../../../../../constants/app_string.dart';
import '../../../../../data/models/product.dart';
import '../../../../../routes/app_pages.dart';
import '../../../../../widgets/custom_widgets/custom_alert_dialog.dart';

Future deteteBillItemsIfTokenAdded(Product p) {
  return const CustomAlertDialog().alertDialog(
    dialogTitle: 'Delete Bill Items',
    isformChildrenNeeded: true,
    dialogContent: 'If you add token item other bill items will be deleted',
    confirmButtonText: EBAppString.delete,
    confimBtnColor: EBTheme.redColor,
    confirmOnPressed: () {
      Get.back();
      Get.find<CashierBillsController>().billItems.clear();
      Get.find<CashierBillsController>().addBillItem(p);
      Get.toNamed(Routes.BILL_DETAILS, arguments: {
        'billItems': Get.find<CashierBillsController>().billItems
      });
    },
    cancelButtonText: EBAppString.cancel,
    cancelOnPressed: () {
      Get.back();
    },
  );
}
