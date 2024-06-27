import 'package:easybill_app/app/data/models/bill_reports.dart';
import 'package:easybill_app/app/modules/admin/inventory/controllers/inventory_controller.dart';
import 'package:easybill_app/app/widgets/custom_widgets/custom_toast.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:intl/intl.dart';
import '../../../../data/models/product.dart';
import '../../../../data/repositories/bill_repository.dart';

class AdminReportController extends GetxController {
  AdminReportController({this.decitionKeyForReports});
  int? decitionKeyForReports;

  final _billRepo = BillRepo();
  List<Reports>? billReports;
  List<Reports>? filterableBillReports;
  String? strDate, endDate;

  void filterBillsByDateRange(DateTime startDate, DateTime endDate) {
    List<Reports> resultList = billReports!.where((bill) {
      if (bill.billDate == null) {
        return false;
      }
      DateTime? billDate;
      try {
        // parsing date for formatting it
        billDate = DateTime.parse(bill.billDate!);
        // formatting the date
        String formatedDate = DateFormat('yyyy-MM-dd').format(billDate);
        // again parsing the date to get it in datetime formate so it canbe filtered
        billDate = DateTime.parse(formatedDate);
        debugPrint('bill date ------------->>  $billDate');
      } catch (e) {
        return false; // Skip bills with invalid date format
      }
      return (billDate.isAfter(startDate) ||
              billDate.isAtSameMomentAs(startDate)) &&
          (billDate.isBefore(endDate) || billDate.isAtSameMomentAs(endDate));
    }).toList();

    filterableBillReports = resultList;
    update();
  }

  String getProductName(String shopproductid) {
    Product? p = Get.find<InventoryController>().productList?.firstWhereOrNull(
        (element) => element.shopproductid.toString() == shopproductid);
    return p?.productnameEnglish ?? "-";
  }

  @override
  void onInit() {
    super.onInit();
    debugPrint('onint AdminReportController called------------->>  ');
    getBillReports();
  }

  Future<void> getBillReports() async {
    try {
      Reports reports = Reports(billtype: '');
      switch (decitionKeyForReports) {
        case 1:
          reports.billtype = 'bill';
          break;
        case 2:
          reports.billtype = 'product';
          break;
        case 3:
          reports.billtype = 'staff';
          break;
        case 4:
          reports.billtype = 'cancel';
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
      update();
    }
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
    filterBillsByDateRange(DateTime.parse(strDate!), DateTime.parse(endDate!));
  }

  onDeleteBillPressed(Reports r) async {
    final reports = await _billRepo.deleteReport(r);
    if (reports != null) {
      decitionKeyForReports = 1;
      getBillReports();
      ebCustomTtoastMsg(message: 'Bill deleted successfully');
      update();
      Get.back();
    }
  }
}
