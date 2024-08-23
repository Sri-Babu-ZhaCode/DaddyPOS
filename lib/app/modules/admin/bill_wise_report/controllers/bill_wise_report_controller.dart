import 'package:easybill_app/app/constants/bools.dart';
import 'package:easybill_app/app/data/api/local_storage.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:intl/intl.dart';
import '../../../../constants/app_string.dart';
import '../../../../data/models/bill_reports.dart';
import '../../../../data/models/setting.dart';
import '../../../../data/repositories/bill_repository.dart';
import '../../../../data/repositories/setting_repo.dart';
import '../../../../widgets/custom_widgets/custom_toast.dart';

class BillWiseReportController extends GetxController {
  BillWiseReportController({this.billWiseDecisionKey, this.otherReports});
  int? billWiseDecisionKey;
  Reports? otherReports;
  final _billRepo = BillRepo();
  final _settingsRepo = SettingsRepo();
  List<Setting>? settingsList;
  List<String> paymentMode = ['CASH', 'CARD', 'UPI'];
  String? currentPaymentMode;
  List<Reports>? billReports;
  List<Reports>? billDetailedReports;
  List<Reports>? filterableBillReports;
  String? strDate, endDate;
  String? formattedTime;
  double totalBillAmt = 0;
  double totalQty = 0;
  bool? triggeredFromChangePaymentMode;

  void filterBillsByDateRange(DateTime startDate, DateTime endDate) {
    List<Reports> resultList = billReports!.where((bill) {
      if (bill.billdate == null) {
        return false;
      }
      DateTime? billdate;
      try {
        // parsing date for formatting it
        billdate = DateTime.parse(bill.billdate!);
        // formatting the date
        String formatedDate = DateFormat('yyyy-MM-dd').format(billdate);
        // again parsing the date to get it in datetime formate so it canbe filtered
        billdate = DateTime.parse(formatedDate);
        debugPrint('bill date ------------->>  $billdate');
      } catch (e) {
        return false; // Skip bills with invalid date format
      }
      return (billdate.isAfter(startDate) ||
              billdate.isAtSameMomentAs(startDate)) &&
          (billdate.isBefore(endDate) || billdate.isAtSameMomentAs(endDate));
    }).toList();

    filterableBillReports = resultList;
    for (var element in resultList) {
      debugPrint(element.billdate);
      debugPrint(element.shopbillid.toString());
    }
    update();
  }

  String formateBillDate(String date) {
    try {
      DateTime dateTime = DateTime.parse(date);

      formattedTime = DateFormat('hh:mm').format(dateTime);

      formattedTime = '$formattedTime ${DateFormat('a').format(dateTime)}';
      return DateFormat('dd-MMM-yyyy').format(dateTime);
    } catch (e) {
      debugPrint(e.toString());
      debugPrint('invalid date format');
      return "";
    }
  }

  @override
  void onInit() {
    super.onInit();
    debugPrint('onint BillWiseReportController called------------->>  ');
    currentPaymentMode = paymentMode[0];
    getSetting();
    getBillWiseFromReportType();

    if (otherReports != null) {
      debugPrint(otherReports!.quantity.toString());
      debugPrint(otherReports!.totalquantityamount.toString());
      debugPrint(otherReports!.productnameEnglish);
      debugPrint(otherReports!.shopbillid.toString());
    }
  }

  Future<void> getSetting() async {
    try {
      EBBools.isLoading = true;
      final result = await _settingsRepo.getSettings();
      if (result != null) {
        settingsList = result;
        for (var element in settingsList!) {
          debugPrint('----------------------- ------------>> getSettings ');

          debugPrint(element.businessaddress);
          debugPrint(element.mobileenable.toString());
          debugPrint(element.emailenable.toString());
          debugPrint(element.businessname);
          debugPrint(element.settimeinterval);
        }
      }
    } catch (e) {
      debugPrint(e.toString());
    } finally {
      //  EBBools.isLoading = false;
      // update();
    }
  }

  Future<void> getBillWiseFromReportType([Reports? detailedReport]) async {
    try {
      EBBools.isLoading = true;
      update();
      Reports reports = Reports(
        reporttype: '',
        credentialsid: 0,
        shopbillid: 0,
        shopproductid: 0,
      );

      if (detailedReport != null) {
        debugPrint(detailedReport.quantity.toString());
        debugPrint(detailedReport.totalquantityamount.toString());
        debugPrint(detailedReport.productnameEnglish);
        debugPrint(detailedReport.shopbillid.toString());
        reports.uniqueshopbillid = detailedReport.uniqueshopbillid;
        reports.reporttype =
            billWiseDecisionKey == 4 ? 'detailcancelbill' : 'billbyid';
        final x = await _billRepo.getBillDetailed(reports);
        billDetailedReports = x;
        if (billDetailedReports != null) {
          totalBillAmt = billDetailedReports!.fold(
              0,
              (previousValue, element) =>
                  element.totalquantityamount! + previousValue);
          totalQty = billDetailedReports!.fold(
              0, (previousValue, element) => element.quantity! + previousValue);
        }

        debugPrint(
            'billDetailedReports =====================>> $billDetailedReports ');
      }

      if (otherReports == null) {
        if (billWiseDecisionKey == 4) {
          if (EBAppString.userRole == 'Staff') {
            reports.reporttype = 'cancelbillstaff';
            reports.credentialsid = int.parse(LocalStorage.usercredentialsid!);
          } else {
            reports.reporttype = 'cancel';
          }
        } else {
          if (EBAppString.userRole == 'Staff') {
            reports.credentialsid = int.parse(LocalStorage.usercredentialsid!);
            reports.reporttype = 'billsunderstaff';
          } else {
            reports.reporttype = 'bill';
          }
        }
      } else {
        switch (billWiseDecisionKey) {
          case 1:
            // product bill detailed
            reports.shopproductid = otherReports!.shopproductid;
            reports.reporttype = 'productdetailedbill';
            break;
          case 2:
            // staff bill detailed
            reports.credentialsid = otherReports?.credentialsid ??
                int.parse(LocalStorage.usercredentialsid!);
            reports.reporttype = 'staffdetailedbill';
            break;
          case 3:
            // cancel bill detailed
            reports.shopbillid = otherReports!.shopbillid;
          // case 4:

          //  // reports.credentialsid = int.parse(LocalStorage.usercredentialsid!);
          //   break;
          default:
            debugPrint('some this went wrong  ----------->> ');
        }
      }

      if (detailedReport == null) {
        final x = await _billRepo.getBillInfo(reports);
        billReports = x;
        filterableBillReports = x;
      }
    } catch (e) {
      debugPrint(e.toString());
    } finally {
      EBBools.isLoading = false;
      update();
    }
  }

  onReportsPressed(Reports reports) {}

  onDeleteBillPressed(Reports r) async {
    final reports = await _billRepo.deleteReport(r);
    if (reports != null) {
      getBillWiseFromReportType();
      ebCustomTtoastMsg(message: 'Bill deleted successfully');
      update();
      Get.back();
    }
  }

  Future<void> downLoadReports() async {
    try {
      EBBools.isLoading = true;
      update();
      Reports reports = Reports(
        reporttype: 'bill',
        credentialsid: 0,
        shopbillid: 0,
        shopproductid: 0,
      );

      await _billRepo.downLoadReports(reports);
    } catch (e) {
      debugPrint(e.toString());
    } finally {
      EBBools.isLoading = false;
      update();
    }
  }

  Future<void> onChagingPaymentMode(Reports? reports) async {
    try {
      debugPrint('onChagingPaymentMode called ------------------------>.');
      EBBools.isLoading = true;

      update();
      reports!.paymentmode = currentPaymentMode;
      final profileList = await _billRepo.updatePaymentMode(reports);
      if (profileList != null) {
        ebCustomTtoastMsg(message: 'Paymentmode updated successfully');
        update();
      }
      Get.back();
    } catch (e) {
      debugPrint(e.toString());
    } finally {
      EBBools.isLoading = false;
      update();
    }
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
        reports.reporttype = 'filterBillsbyDate';
        reports.fromDate = fromDate;
        reports.toDate = toDate;
      } else {
        reports.reporttype = 'filterBillsByPayment';
        reports.paymentmode = currentPaymentMode;
        reports.fromDate = '';
        reports.toDate = '';
      }

      final resultList = await _billRepo.filterBills(reports);
      if (resultList != null) {
        filterableBillReports = resultList;
        //   ebCustomTtoastMsg(message: 'Bills filtered by dates');
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

  Future<void> showDateCalender(context) async {
    final result = await showDateRangePicker(
      context: context,
      firstDate: DateTime(2024),
      lastDate: DateTime.now().add(
        const Duration(days: 365),
      ),
    );
    if (result != null) {
      String startDate = formateBillDate(result.start.toString());
      String endDate = formateBillDate(result.end.toString());
      filterByDateOrPaymentmode(fromDate: startDate, toDate: endDate);
      debugPrint('start date ------------------>>  $startDate');
    }
  }
}
