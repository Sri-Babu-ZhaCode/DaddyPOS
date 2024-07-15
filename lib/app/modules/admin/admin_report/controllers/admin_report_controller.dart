// ignore_for_file: unnecessary_overrides

import 'package:easybill_app/app/constants/app_string.dart';
import 'package:easybill_app/app/constants/bools.dart';
import 'package:easybill_app/app/data/api/local_storage.dart';
import 'package:easybill_app/app/data/models/bill_reports.dart';
import 'package:easybill_app/app/modules/admin/inventory/controllers/inventory_controller.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:intl/intl.dart';
import '../../../../data/models/product.dart';
import '../../../../data/repositories/bill_repository.dart';
import '../../../../routes/app_pages.dart';
import '../../../../widgets/custom_widgets/custom_toast.dart';

class AdminReportController extends GetxController {
  AdminReportController({this.otherReportsDecisionKey});
  int? otherReportsDecisionKey;
  Reports? reports;
  final _billRepo = BillRepo();
  List<Reports>? billReports;
  List<Reports>? filterableBillReports;
  List<Reports>? cancelillDetailedReports;
  String? strDate, endDate;
  final scannerController = TextEditingController();
  List<String> paymentMode = ['CASH', 'CARD', 'UPI'];
  String? currentPaymentMode;

  String getProductName(String shopproductid) {
    Product? p = Get.find<InventoryController>().productList?.firstWhereOrNull(
        (element) => element.shopproductid.toString() == shopproductid);
    return p?.productnameEnglish ?? "-";
  }

  @override
  void onInit() {
    super.onInit();
    debugPrint('onint AdminReportController called------------->>  ');
    currentPaymentMode = paymentMode[0];
    getOtherBillReports();
  }

  Future<void> getOtherBillReports() async {
    try {
      EBBools.isLoading = true;
      Reports reports = Reports(
        reporttype: '',
        credentialsid: 0,
        shopbillid: 0,
        shopproductid: 0,
      );
      switch (otherReportsDecisionKey) {
        case 1:
          reports.reporttype = 'product';
          break;
        case 2:
          reports.reporttype = 'staff';
          break;
        case 3:
          if (EBAppString.userRole == 'Staff') {
            reports.reporttype = 'cancelbillstaff';
            reports.credentialsid = int.parse(LocalStorage.usercredentialsid!);
          } else {
            reports.reporttype = 'cancel';
          }
          break;
        default:
          debugPrint('some this went wrong  ----------->> ');
      }
      final x = await _billRepo.getBillInfo(reports);
      billReports = x;
      filterableBillReports = x;
    } catch (e) {
      debugPrint(e.toString());
    } finally {
      EBBools.isLoading = false;
      update();
    }
  }

  void onReportsPressed(Reports reports) {
    Get.toNamed(Routes.BILL_WISE_REPORT, arguments: {
      "billWiseDecisionKey": otherReportsDecisionKey,
      'otherReports': reports
    });
  }

  @override
  void onReady() {
    super.onReady();
  }

  @override
  void onClose() {
    super.onClose();
  }

  void formtDates(DateTime start, DateTime end) {
    strDate = DateFormat('yyyy-MM-dd').format(start);
    endDate = DateFormat('yyyy-MM-dd').format(end);
  }

  void cancelBillPressed(Reports reports) {
    getBillDetailedOfCancel(reports);
  }

  Future<void> getBillDetailedOfCancel(Reports cancelBill) async {
    try {
      EBBools.isLoading = true;
      update();
      Reports reports = Reports(
        reporttype: 'detailcancelbill',
        credentialsid: cancelBill.credentialsid ??
            int.parse(LocalStorage.usercredentialsid!),
        shopbillid: 0,
        shopproductid: 0,
      );
      reports.uniqueshopbillid = cancelBill.uniqueshopbillid;
      final x = await _billRepo.getBillDetailed(reports);
      cancelillDetailedReports = x;
    } catch (e) {
      debugPrint(e.toString());
    } finally {
      EBBools.isLoading = false;
      update();
    }
  }
  //  Future<void> filterByDateOrPaymentmode() async {
  //   try {
  //     debugPrint('filterByDateOrPaymentmode called ------------------------>.');
  //     EBBools.isLoading = true;

  //     update();
  //     reports!.paymentmode = currentPaymentMode;
  //     final profileList = await _billRepo.updatePaymentMode(reports);
  //     if (profileList != null) {
  //       ebCustomTtoastMsg(message: 'Paymentmode updated successfully');
  //       update();
  //     }
  //     Get.back();
  //   } catch (e) {
  //     debugPrint(e.toString());
  //   } finally {
  //     EBBools.isLoading = false;
  //     update();
  //   }
  // }

  void searchForProduct(String value) {
    List<Reports>? resultList;
    if (value.isEmpty) {
      resultList = billReports;
    } else {
      resultList = billReports!
          .where((product) => EBAppString.productlanguage == 'English'
              ? product.productnameEnglish!
                  .toLowerCase()
                  .contains(value.toLowerCase())
              : product.productnameTamil!
                  .toLowerCase()
                  .contains(value.toLowerCase()))
          .toList();
    }
    filterableBillReports = resultList;
    update();
  }

  void searchForStaff(String value) {
    List<Reports>? resultList;
    if (value.isEmpty) {
      resultList = billReports;
    } else {
      resultList = billReports!
          .where((report) =>
              report.fullname!.toLowerCase().contains(value.toLowerCase()))
          .toList();
    }
    filterableBillReports = resultList;
    update();
  }

  Future<void> filterByDateOrPaymentmode(
      {String? fromDate, String? toDate}) async {
    try {
      debugPrint('filterByDateOrPaymentmode called ------------------------>.');
      EBBools.isLoading = true;
      update();
      Reports reports = Reports(
        reporttype: '',
        fromDate: fromDate,
        toDate: toDate,
        credentialsid: 0,
        shopproductid: 0,
      );
      if (fromDate != null && toDate != null) {
        reports.reporttype = otherReportsDecisionKey == 1
            ? 'filterProductByDate'
            : otherReportsDecisionKey == 2
                ? 'filterStaffByDate'
                : otherReportsDecisionKey == 3
                    ? "filtercancelbillsbydate"
                    : 'filterBillsbyDate';
        reports.fromDate = fromDate;
        reports.toDate = toDate;
      } else {
        reports.reporttype = otherReportsDecisionKey == 1
            ? 'filterProductByPayment'
            : otherReportsDecisionKey == 2
                ? 'filterStaffByPayment'
                : otherReportsDecisionKey == 3
                    ? 'filterCancelBillsByPayment'
                    : 'filterBillsByPayment';
        reports.paymentmode = currentPaymentMode;
        reports.fromDate = '';
        reports.toDate = '';
      }

      final resultList = await _billRepo.filterBills(reports);
      if (resultList != null) {
        filterableBillReports = resultList;
      } else {
        ebCustomTtoastMsg(message: 'No bills in Found');
      }
    } catch (e) {
      debugPrint(e.toString());
    } finally {
      EBBools.isLoading = false;
      update();
    }
  }
}
