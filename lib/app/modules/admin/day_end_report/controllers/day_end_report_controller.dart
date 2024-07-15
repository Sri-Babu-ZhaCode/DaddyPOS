// ignore_for_file: unnecessary_overrides

import 'package:easybill_app/app/data/repositories/bill_repository.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

import '../../../../constants/bools.dart';
import '../../../../data/models/day_end_report.dart';

class DayEndReportController extends GetxController
    with GetSingleTickerProviderStateMixin {
  late TabController tabController;
  List<DayEndReport>? dayReportList;
  List<DayEndReport>? filteredDayReports;

  final _billRepo = BillRepo();
  @override
  void onInit() {
    super.onInit();
    tabController = TabController(
      length: 3,
      vsync: this,
    );
    getDayEndReports();
  }

  Future<void> getDayEndReports() async {
    try {
      EBBools.isLoading = true;
      final x = await _billRepo.getDayEndReport();
      dayReportList = x;
      filteredDayReports = x;
      updateDayEndReport(0);
    } catch (e) {
      debugPrint(e.toString());
    } finally {
      EBBools.isLoading = false;
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

  void updateDayEndReport(int index) {
    EBBools.isLoading = true;
    update();
    debugPrint('updateDayEndReport called -------------->> & tab index : $index');
    String? report;

    if (index == 0) {
      report = 'Product';
    } else if (index == 1) {
      report = 'cashier';
    } else {
      report = 'paymentMode';
    }

    final resultList =
        dayReportList?.where((element) => element.report == report).toList();

    filteredDayReports = resultList;

    debugPrint('fltered list -------->> $filteredDayReports');

    EBBools.isLoading = false;
    update();
  }
}
