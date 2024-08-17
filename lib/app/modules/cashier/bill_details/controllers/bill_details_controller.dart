// ignore_for_file: unnecessary_overrides

import 'dart:async';
import 'dart:convert';
import 'dart:io';
import 'package:easybill_app/app/constants/bill_template.dart';
import 'package:easybill_app/app/data/api/local_storage.dart';
import 'package:easybill_app/app/data/models/bill_items.dart';
import 'package:easybill_app/app/data/models/setting.dart';
import 'package:easybill_app/app/data/repositories/bill_repository.dart';
import 'package:easybill_app/app/modules/cashier/cashier_bills/controllers/cashier_bills_controller.dart';
import 'package:flutter/material.dart';
import 'package:flutter_blue_plus/flutter_blue_plus.dart';
import 'package:get/get.dart';
import 'package:intl/intl.dart';
import 'package:path_provider/path_provider.dart';
import 'package:thermal_printer_sdk/models/printer_settings.dart';
import 'package:thermal_printer_sdk/models/template_settings.dart';
import 'package:thermal_printer_sdk/models/text_to_image_args.dart';
import 'package:thermal_printer_sdk/thermal_printer_sdk.dart';
import '../../../../constants/app_string.dart';
import '../../../../constants/bools.dart';
import '../../../../data/models/bill_info.dart';
import '../../../../widgets/custom_widgets/custom_toast.dart';

class BillDetailsController extends GetxController {
  final cashierCtrl = Get.find<CashierBillsController>();
  BillRepo billRepo = BillRepo();
  BillTemplate bt = BillTemplate();
  StreamSubscription<List<ScanResult>>? scanSubscription;
  List<BillItems>? billItems;
  List<BillInfo>? addedBilInfo;

  BillDetailsController({this.billItems});
  final FlutterBluePlus flutterBlue = FlutterBluePlus();
  late ThermalPrinterSdk thermalPrinterSdkPlugin;
  bool isBluetoothPaired = false;

  List<String> paymentMode = ['Cash', 'Card', 'Upi'];

  int currentIndex = 0;

  @override
  void onInit() {
    super.onInit();
    PrinterSettings printerSettings;
    if (cashierCtrl.billConfig?.printersize == '80MM (3 inch)') {
      printerSettings = PrinterSettings(
          deviceAddress: cashierCtrl.billConfig!.printeraddress,
          printerDpi: 200,
          printerWidth: 72,
          nbrCharPerLine: 48);
    } else {
      printerSettings = PrinterSettings(
          deviceAddress: cashierCtrl.billConfig!.printeraddress,
          printerDpi: 200,
          printerWidth: 48,
          nbrCharPerLine: 32);
    }

    thermalPrinterSdkPlugin = ThermalPrinterSdk(printerSettings);
  }

  Future<void> addBillInfo() async {
    try {
      debugPrint(
          "usercredentialsid ------------->> ${LocalStorage.usercredentialsid}");
      BillInfo billInfo = BillInfo(
        usercredentialsid: LocalStorage.usercredentialsid,
        paymentmode: paymentMode[currentIndex].toString().toUpperCase(),
        billtype: 'Print',
        tab: EBBools.isTokenPresent &&
                cashierCtrl.tabIndex == EBAppString.screenAccessList.length - 1
            ? 'token'
            : '',
        billtemplate: 'Template1',
        issuccess: true,
        istoken: cashierCtrl.tabIndex == 2 ? true : false,
        items: cashierCtrl.billItems.map((e) => e).toList(),
      );
      final x = await billRepo.addBillInfo(billInfo);
      debugPrint('Responce for Bill info ---------->>$x');

      if (x != null) {
        addedBilInfo = x;
        checkBluetoothDevice();
        // if (isBluetoothPaired == true) {
        configuringBillTemplate();
        //  }
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
      if (addedBilInfo![0].tab == 'token') {
        debugPrint(addedBilInfo?[0].datetime);
        debugPrint(addedBilInfo?[0].tab);
        build3inchTokenTemplate(cashierCtrl.billConfig!, billItems);
      } else {
        build3inchTemplate(cashierCtrl.billConfig!, billItems);
      }
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
    // final file = await convertBase64ToFile(billConfig.businesslogo);
    // bt.logoFile = file;
    //bt.template += billConfig.businesslogo;
    //  await thermalPrinterSdkPlugin.print(TemplateSettings(
    //       template: billConfig.businesslogo));
    int j = 1;
    for (var item in billItems!) {
      print('Item ----->> $j');

      print('product name english : ${item.productNameEnglish}');
      print('product name tamil : ${item.productnameTamil}');
      print('rate : ${item.price}');
      print('quantity : ${item.quantity}');
      print('amount : ${item.totalprice}');
      print('-----------------------------------------');
      j++;
    }

    bt.billData = await printerTextToImg(
        size: 30, txt: billConfig.businessname ?? "", allignment: 'CENTER');
    bt.template += bt.imageTagW1linebreak;
    final dateTimeRecord = dateAndTimeFormatter(addedBilInfo?[0].datetime);

    bt.billData = await printerTextToImg(
        size: 30, txt: billConfig.businessaddress ?? "", allignment: 'CENTER');
    bt.template += bt.imageTagW2linebreak;
    bt.billData = billConfig.businessmobile ?? '-';
    bt.template += bt.billPhone;
    bt.billData = addedBilInfo?[0].billno.toString() ?? "";
    bt.template += bt.billNo;
    bt.date = dateTimeRecord.date;
    bt.time = '${dateTimeRecord.time} ${dateTimeRecord.amPm}';
    bt.template += bt.billDateTime;
    bt.template += bt.inch3divider;
    bt.template += bt.inch3billTopColumn;
    bt.template += bt.inch3divider;

    if (billItems != null) {
      int i = 1;
      for (var item in billItems) {
        debugPrint(item.productNameEnglish);
        //  bt.sno = i.toString();

        bt.billData = await printerTextToImg(
            fontType: 'NORMAL',
            txt: '${i.toString()}    ${item.productNameEnglish ?? ""}');
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
      // if upi enabled in settings
      if (billConfig.upienable == true) {
        bt.template += bt.inch3QR;
      }
      bt.billData = cashierCtrl.billItemsTotalPrice.toStringAsFixed(2);
      bt.template += bt.billDataTotalAmt;
      bt.billData = await printerTextToImg(
          size: 30, txt: billConfig.footer ?? "", allignment: 'CENTER');

      bt.template += bt.billFooter;
    }

    printBillInThermalPrinter();
  }

  Future<String> printerTextToImg(
      {required String txt,
      String? allignment,
      int? size,
      String? fontType}) async {
    final result = await thermalPrinterSdkPlugin.textToImg(TextToImageArgs(
            text: txt,
            textSize: size ?? 24,
            interfaceType: fontType ?? "BOLD",
            alignment: allignment ?? "LEFT")) ??
        "";
    return result;
  }

  void printBillInThermalPrinter() async {
    try {
      await thermalPrinterSdkPlugin.print(TemplateSettings(
          template: "${bt.template}[L][L][L]\n\n\n[L]\n[L]\n\n\n"));
      cashierCtrl.billItems.clear();
      cashierCtrl.getTotalPriceAndQtyOfBill();
      ebCustomTtoastMsg(message: 'Bill Items Printed');
      update();
      Get.back();
    } catch (e) {
      debugPrint(e.toString());
    }
  }

  void checkBluetoothDevice() {
    FlutterBluePlus.scanResults.listen((scanResult) {
      for (ScanResult result in scanResult) {
        String deviceMAC = result.device.id.id; // Get the device's MAC address
        if (deviceMAC == cashierCtrl.billConfig?.printeraddress) {
          // Device found, handle accordingly
          debugPrint(
              'Device with MAC ${cashierCtrl.billConfig?.printeraddress} is connected');
          // Stop scanning if needed
          isBluetoothPaired = true;
          scanSubscription?.cancel();
        }
      }
    });
  }

  Future<File> convertBase64ToFile(String base64String) async {
    List<int> bytes = base64Decode(base64String);
    final directory = await getTemporaryDirectory();
    final filePath = '${directory.path}/output_image.png';

    // Write the file
    File file = File(filePath);
    await file.writeAsBytes(bytes);

    debugPrint('File saved at $filePath');
    return file;
  }

  void build3inchTokenTemplate(
      Setting billConfig, List<BillItems>? billItems) async {
    final dateTimeRecord = dateAndTimeFormatter(addedBilInfo?[0].datetime);
    bt.billData = addedBilInfo?[0].billno.toString() ?? "";
    bt.template += bt.tokenNo;
    bt.billData =
        '${dateTimeRecord.date}  ${dateTimeRecord.time}  ${dateTimeRecord.amPm}';
    bt.template += bt.tokenBillDateTime;
    for (var items in billItems!) {
      bt.billData = await printerTextToImg(
          size: 30,
          txt:
              '${items.quantity ?? ""}        ${items.productNameEnglish ?? ""}            ${items.price ?? ""}');
      bt.template += bt.billProduct;
    }
    bt.billData = await printerTextToImg(
        txt: billConfig.businessname ?? "", fontType: 'NORMAL');
    bt.template += bt.billProduct;

    printBillInThermalPrinter();
  }

  ({String date, String time, String amPm}) dateAndTimeFormatter(
      String? datetime) {
    String date = '';
    String time = '';
    String amPm = '';
    if (datetime != null) {
      String timestamp = datetime;

      DateTime dateTime = DateTime.parse(timestamp);
      date = DateFormat('dd-MMM-yyyy').format(dateTime);
      time = DateFormat('hh:mm').format(dateTime);
      amPm = DateFormat('a').format(dateTime);
    }
    return (date: date, time: time, amPm: amPm);
  }
}

  // ThermalPrinterSdk().print(PrinterTemplateSettings(
  //     deviceAddress: "DC:0D:30:23:0E:00",
  //     template: "template",
  //     printerDpi: 200,
  //     printerWidth: 72,
  //     nbrCharPerLine: 48));

