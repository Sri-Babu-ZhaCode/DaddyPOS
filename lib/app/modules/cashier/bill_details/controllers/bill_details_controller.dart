import 'package:easybill_app/app/data/api/local_storage.dart';
import 'package:easybill_app/app/data/models/bill_items.dart';
import 'package:easybill_app/app/data/repositories/bill_repository.dart';
import 'package:easybill_app/app/modules/cashier/cashier_bills/controllers/cashier_bills_controller.dart';
import 'package:easybill_app/app/routes/app_pages.dart';
import 'package:easybill_app/app/widgets/custom_widgets/custom_toast.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import '../../../../data/models/bill_info.dart';

class BillDetailsController extends GetxController {
  final cashierBillsController = Get.find<CashierBillsController>();
  BillRepo billRepo = BillRepo();

  List<BillItems>? billItems;

  BillDetailsController({this.billItems});

  List<String> paymentMode = ['Cash', 'Card', 'Upi'];

  int currentIndex = 0;



  Future<void> addBillInfo() async {
    try {
      debugPrint(
          "usercredentialsid ------------->> ${LocalStorage.usercredentialsid}");
      BillInfo billInfo = BillInfo(
        usercredentialsid: LocalStorage.usercredentialsid ?? '8',
        paymentmode: paymentMode[currentIndex].toString().toUpperCase(),
        billtype: 'Print',
        billtemplate: 'Template1',
        issuccess: true,
        istoken: cashierBillsController.tabIndex == 2 ? true : false,
        items: cashierBillsController.billItems.map((e) => e).toList(),
      );
      final x = await billRepo.addBillInfo(billInfo);
      debugPrint('Responce for Bill info ---------->>$x');

      ebCustomTtoastMsg(message: 'Bill Items Printed');
      cashierBillsController.billItems.clear();
      cashierBillsController.getTotalPriceOfBill();
      update();
      Get.offNamed(Routes.CASHIER_BILLS);
    } catch (e) {
      debugPrint(e.toString());
    }
  }
}
