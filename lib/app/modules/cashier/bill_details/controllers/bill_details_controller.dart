import 'package:easybill_app/app/constants/bill_template.dart';
import 'package:easybill_app/app/data/api/local_storage.dart';
import 'package:easybill_app/app/data/models/bill_items.dart';
import 'package:easybill_app/app/data/models/setting.dart';
import 'package:easybill_app/app/data/repositories/bill_repository.dart';
import 'package:easybill_app/app/modules/cashier/cashier_bills/controllers/cashier_bills_controller.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:thermal_printer_sdk/models/printer_template_settings.dart';
import 'package:thermal_printer_sdk/models/text_to_image_args.dart';
import 'package:thermal_printer_sdk/thermal_printer_sdk.dart';

import '../../../../data/models/bill_info.dart';
import '../../../../widgets/custom_widgets/custom_toast.dart';

class BillDetailsController extends GetxController {
  final cashierCtrl = Get.find<CashierBillsController>();
  final thermalPrinter = ThermalPrinterSdk();
  BillRepo billRepo = BillRepo();

  BillTemplate bt = BillTemplate();

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

      if (x!.isEmpty) {
        configuringBillTemplate();
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

  void configuringBillTemplate() {
    debugPrint('configuringBillTemplate called -------------------->>');
    if (cashierCtrl.billConfig?.printersize == '80MM (3 inch)') {
      build3inchTemplate(cashierCtrl.billConfig!, billItems);
    } else {
      build2inchTemplate(cashierCtrl.billConfig!, billItems);
    }

    // ebCustomTtoastMsg(message: 'Bill Items Printed');
    // cashierCtrl.billItems.clear();
    // cashierCtrl.getTotalPriceAndQtyOfBill();
    // update();
    // Get.back();
  }

  void build2inchTemplate(Setting billConfig, List<BillItems>? billItems) {}

  void build3inchTemplate(
      Setting billConfig, List<BillItems>? billItems) async {
    bt.billData = await printerTextToImg(billConfig.businessname ?? "");
    bt.template += bt.imageTagW1linebreak;
    bt.billData = await printerTextToImg(billConfig.businessaddress ?? "");
    bt.template += bt.imageTagW2linebreak;
    bt.billData = billConfig.businessmobile ?? '-';
    bt.template += bt.billPhone;

    bt.template += bt.inch3divider;
    bt.template += bt.inch3billTopColumn;
    bt.template += bt.inch3divider;

    if (billItems != null) {
      int i =1;
      for (var item in billItems) {
        debugPrint(item.productNameEnglish);
      //  bt.sno = i.toString();
        
        bt.billData = await printerTextToImg('${i.toString()}      ${item.productNameEnglish ?? ""}');
        i++;

        bt.template += bt.billProduct;

        bt.rate = item.price?.toStringAsFixed(1) ?? "";
        bt.qty = item.quantity?.toStringAsFixed(2) ?? "";
        bt.amt = item.totalprice?.toStringAsFixed(1) ?? "";

        bt.template += bt.inch3billPriceQtyAmt;
      }
      bt.billData = billItems.length.toString();
      bt.totlaQty = cashierCtrl.billItemsTotalQty.toStringAsFixed(2);
      bt.totlaAmt = cashierCtrl.billItemsTotalPrice.toStringAsFixed(2);
      bt.template += bt.inch3divider;
      bt.template += bt.billBottomColumn;
      bt.template += bt.inch3divider;
      bt.billData = cashierCtrl.billItemsTotalPrice.toStringAsFixed(2);
      bt.template += bt.billDataTotalAmt;
      bt.billData = billConfig.footer ?? "";

      bt.template += bt.billFooter;
    }

    printBillInThermalPrinter(billConfig);
  }

  void printBillInThermalPrinter(Setting billConfig) async {
    // final result = await printerTextToImg(billConfig.businessname ?? "");
    final printerSettings = PrinterTemplateSettings(
        deviceAddress: billConfig.printeraddress,
        template: "${bt.template}+[L][L][L]\n\n\n[L]\n\n\n[L]\n\n\n",
        printerDpi: 200,
        printerWidth: 72,
        nbrCharPerLine: 48);

    try {
      thermalPrinter.print(printerSettings);
      cashierCtrl.billItems.clear();
      cashierCtrl.getTotalPriceAndQtyOfBill();
      ebCustomTtoastMsg(message: 'Bill Items Printed');
      update();
      Get.back();
    } catch (e) {
      debugPrint(e.toString());
    }
  }

  Future<String> printerTextToImg(String str) async {
    final result = await thermalPrinter.textToImg(TextToImageArgs(
            text: str,
            textSize: 136,
            interfaceType: "NORMAL",
            alignment: "CENTER")) ??
        "";
    return result;
  }

  // ThermalPrinterSdk().print(PrinterTemplateSettings(
  //     deviceAddress: "DC:0D:30:23:0E:00",
  //     template: "template",
  //     printerDpi: 200,
  //     printerWidth: 72,
  //     nbrCharPerLine: 48));
}
