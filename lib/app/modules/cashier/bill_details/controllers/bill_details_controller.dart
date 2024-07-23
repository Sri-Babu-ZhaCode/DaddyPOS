import 'package:easybill_app/app/data/api/local_storage.dart';
import 'package:easybill_app/app/data/models/bill_items.dart';
import 'package:easybill_app/app/data/models/setting.dart';
import 'package:easybill_app/app/data/repositories/bill_repository.dart';
import 'package:easybill_app/app/modules/cashier/cashier_bills/controllers/cashier_bills_controller.dart';
import 'package:easybill_app/app/widgets/custom_widgets/custom_toast.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import '../../../../data/models/bill_info.dart';

class BillDetailsController extends GetxController {
  final cashierCtrl = Get.find<CashierBillsController>();
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
        istoken: cashierCtrl.tabIndex == 2 ? true : false,
        items: cashierCtrl.billItems.map((e) => e).toList(),
      );
      final x = await billRepo.addBillInfo(billInfo);
      debugPrint('Responce for Bill info ---------->>$x');

      if (x == []) {
        printBillInfoInThermalPrinter();
      }

      // ebCustomTtoastMsg(message: 'Bill Items Printed');
      // cashierBillsController.billItems.clear();
      // cashierBillsController.getTotalPriceAndQtyOfBill();
      // update();
      // Get.back();
    } catch (e) {
      debugPrint(e.toString());
    }
  }

  void printBillInfoInThermalPrinter() {

    if (cashierCtrl.billConfig?.printersize == '80MM (3 inch)') {
      build2inchTemplate(cashierCtrl.billConfig!, billItems);
    } else {
      build3inchTemplate(cashierCtrl.billConfig!, billItems);
    }

    ebCustomTtoastMsg(message: 'Bill Items Printed');
    cashierCtrl.billItems.clear();
    cashierCtrl.getTotalPriceAndQtyOfBill();
    update();
    Get.back();
  }

  void build2inchTemplate(Setting billConfig, List<BillItems>? billItems) {
    

  }

  void build3inchTemplate(Setting billConfig, List<BillItems>? billItems) {}
}
