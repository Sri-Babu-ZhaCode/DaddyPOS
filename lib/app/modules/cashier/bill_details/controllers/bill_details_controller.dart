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
  List<BillItems> gstBillItems = [];
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
    if (cashierCtrl.billConfig?.printeraddress != null) {
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
    if (billItems != null) {
      List<BillItems> copyOfBillItems = List.from(billItems!);
      //consolidatebillitems = groupBillItemsByTaxPercentage(copyOfBillItems);
      calculateGSTByBillItmes(copyOfBillItems);
    }
  }

  Future<void> addBillInfo() async {
    try {
      if (cashierCtrl.billConfig?.printeraddress != null) {
        debugPrint(
            "usercredentialsid ------------->> ${LocalStorage.usercredentialsid}");
        BillInfo billInfo = BillInfo(
          usercredentialsid: LocalStorage.usercredentialsid,
          paymentmode: paymentMode[currentIndex].toString().toUpperCase(),
          billtype: 'Print',
          tab: EBBools.isTokenPresent &&
                  cashierCtrl.tabIndex ==
                      EBAppString.screenAccessList.length - 1
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
          // if (isBluetoothPaired) {
          configuringBillTemplate();

          // } else {
          //   ebCustomTtoastMsg(message: 'Bluetooth printer is not connected');
          // }
        }
      } else {
        ebCustomTtoastMsg(message: 'Choose printer from setting');
      }

      //
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
            txt:
                '${i.toString()}    ${EBAppString.productlanguage == 'English' ? item.productNameEnglish ?? "" : item.productnameTamil ?? ""}');
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
        bt.billData =
            'upi://pay?pa=${billConfig.upi}&pn=${billConfig.businessname}&tr=&am=${cashierCtrl.billItemsTotalPrice.toStringAsFixed(2)}&cu=INR&mc=0000&mode=02&purpose=00&tn=&tr=';
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
              '${items.quantity ?? ""}        ${EBAppString.productlanguage == 'English' ? items.productNameEnglish ?? "" : items.productnameTamil ?? ""}            ${items.price ?? ""}');
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

  // sortGstFromBillItems() {
  //   if (billItems != null) {

  //     billItems.where( (element) => element.taxpercentage == )
  //   }

  //   //  billItems.where((element) => element.)
  //   // billItems.sort((a, b) => ,)
  // }

  // List<BillItems> consolidateBillItems(List<BillItems> billItems) {
  //   Map<String, BillItems> consolidatedMap = {};

  //   // list of bill items order by taxpercentage
  //   //

  //   for (var i = 0; i < billItems.length; i++) {
  //     int repetedTaxIndex = 0;
  //     for (var j = i + 1; j < billItems.length; i++) {
  //       if (billItems[i].taxpercentage == billItems[j].taxpercentage) {
  //         double totalPrice =
  //             (billItems[i].totalprice ?? 0) + (billItems[j].totalprice ?? 0);
  //       }
  //     }
  //   }

  //   for (var item in billItems!) {
  //     if (item.taxpercentage != null &&
  //         consolidatedMap.containsKey(item.taxpercentage)) {
  //       var existingItem = consolidatedMap[item.taxpercentage];
  //       if (existingItem != null) {
  //         existingItem.price = (existingItem.price ?? 0) + (item.price ?? 0);
  //         existingItem.totalprice =
  //             (existingItem.totalprice ?? 0) + (item.totalprice ?? 0);
  //       }
  //     } else {
  //       consolidatedMap[item.taxpercentage ?? ''] = item;
  //     }
  //   }

  //   for (var item in consolidatedMap.values.toList()) {
  //     debugPrint('tax persentage -------------->> ${item.taxpercentage}');
  //     debugPrint('cgst persentage -------------->> ${item.cgstPercentage}');
  //     debugPrint('stax persentage -------------->> ${item.sgstPercentage}');
  //     debugPrint(
  //         'total price of percentage  -------------->> ${item.totalprice}');
  //     // debugPrint('cgstValueonprice -------------->> ${item.cgstValueonprice}');
  //   }
  //   return consolidatedMap.values.toList();
  // }

  List<BillItems> groupBillItemsByTaxPercentage(
      List<BillItems> copiedBillItems) {
    Map<String, List<BillItems>> groupedBillItems = {};
    for (BillItems item in copiedBillItems) {
      String taxPercentage = item.taxpercentage ?? '';
      if (!groupedBillItems.containsKey(taxPercentage)) {
        groupedBillItems[taxPercentage] = [];
      }
      groupedBillItems[taxPercentage]!.add(item);
    }

    List<BillItems> result = [];
    for (String taxPercentage in groupedBillItems.keys) {
      List<BillItems> itemsWithSameTax = groupedBillItems[taxPercentage]!;
      if (itemsWithSameTax.length > 1) {
        // Combine items with the same tax percentage
        double totalPrice =
            itemsWithSameTax.fold(0, (sum, item) => sum + item.totalprice!);
        BillItems combinedItem = itemsWithSameTax.first;
        combinedItem.totalprice = totalPrice;
        result.add(combinedItem);
      } else {
        // Keep single items unchanged
        result.add(itemsWithSameTax.first);
      }
    }

    return result;
  }

  double calculateGSTAmount(double totalAmount, double gstPercentage) {
    /*
Add GST
GST Amount = ( Original Cost * GST% ) / 100
Net Price = Original Cost + GST Amount

In order to remove GST from base amount,

Remove GST
GST Amount = Original Cost – (Original Cost * (100 / (100 + GST% ) ) )
Net Price = Original Cost – GST Amount

*/

debugPrint('total price --------------------------->> $totalAmount');
    return totalAmount * gstPercentage / 100;
    // return (gstPercentage / (100 + gstPercentage)) * totalAmount;
  }

  void calculateGSTByBillItmes(List<BillItems> copiedBillItems) {
    gstBillItems.clear();
    for (var i = 0; i < copiedBillItems.length; i++) {
      for (var j = i + 1; j < copiedBillItems.length; j++) {
        if (copiedBillItems[i].taxpercentage != '' &&
            copiedBillItems[i].taxpercentage ==
                copiedBillItems[j].taxpercentage) {
          debugPrint(copiedBillItems[i].taxpercentage);
          copiedBillItems[i].totalprice = (copiedBillItems[i].totalprice ?? 0) +
              (copiedBillItems[j].totalprice ?? 0);
          debugPrint(copiedBillItems[i].totalprice.toString());

          copiedBillItems[j].taxpercentage = '';
        }
      }
      if (copiedBillItems[i].taxpercentage != '') {
        gstBillItems.add(copiedBillItems[i]);
      }
      update();
    }

    for (var item in gstBillItems) {
      debugPrint('tax persentage -------------->> ${item.taxpercentage}');
      debugPrint('cgst persentage -------------->> ${item.cgstPercentage}');
      debugPrint('stax persentage -------------->> ${item.sgstPercentage}');
      debugPrint(
          'total price of percentage  -------------->> ${item.totalprice}');
      // debugPrint('cgstVa
    }
  }
}


// ThermalPrinterSdk().print(PrinterTemplateSettings(
//     deviceAddress: "DC:0D:30:23:0E:00",
//     template: "template",
//     printerDpi: 200,
//     printerWidth: 72,
//     nbrCharPerLine: 48));
