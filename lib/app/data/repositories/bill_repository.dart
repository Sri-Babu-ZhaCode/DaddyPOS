import 'package:easybill_app/app/data/models/bill_info.dart';
import 'package:easybill_app/app/data/models/bill_reports.dart';
import 'package:easybill_app/app/data/models/day_end_report.dart';
import 'package:easybill_app/app/data/repositories/base_repository.dart';
import '../../core/exceptions.dart';

class BillRepo extends BaseRepo {
  BillRepo._privateConstructor();

  // Static instance variable
  static final BillRepo _instance = BillRepo._privateConstructor();

  // Factory constructor to return the singleton instance
  factory BillRepo() {
    return _instance;
  }

  Future<List<BillInfo>?> addBillInfo(BillInfo b) async {
    try {
      return await post("/billinformation",
          body: b.toJson(), decoder: (json) => BillInfo.fromJson(json));
    } catch (e) {
      throw EbException(e);
    }
  }

  Future<List<Reports>?> getBillInfo(Reports r) async {
    try {
      return await post("/billreport/report",
          body: r.toJson(), decoder: (json) => Reports.fromJson(json));
    } catch (e) {
      throw EbException(e);
    }
  }

  Future<List<Reports>?> getBillDetailed(Reports r) async {
    try {
      return await post("/billreport/report",
          body: r.toJson(), decoder: (json) => Reports.fromJson(json));
    } catch (e) {
      throw EbException(e);
    }
  }

  Future<void> downLoadReports(Reports r) async {
    try {
      return await postWithOutResponse("/download", body: r.toJson());
    } catch (e) {
      throw EbException(e);
    }
  }

  Future<List<Reports>?> deleteReport(Reports r) async {
    try {
      return await post("/cancelbill/cancel",
          body: r.toJson(), decoder: (json) => Reports.fromJson(json));
    } catch (e) {
      throw EbException(e);
    }
  }

  Future<List<DayEndReport>?> getDayEndReport() async {
    try {
      return await get<DayEndReport>("/billreport/",
          decoder: (json) => DayEndReport.fromJson(json));
    } catch (e) {
      throw EbException(e);
    }
  }

  Future<List<Reports>?> updatePaymentMode(Reports r) async {
    try {
      return await post("/billreport/updatepaymentmode",
          body: r.toJson(), decoder: (json) => Reports.fromJson(json));
    } catch (e) {
      throw EbException(e);
    }
  }

  Future<List<Reports>?> filterBills(Reports r) async {
    try {
      return await post("/filterbills",
          body: r.filteringToJosn(), decoder: (json) => Reports.fromJson(json));
    } catch (e) {
      throw EbException(e);
    }
  }
}
