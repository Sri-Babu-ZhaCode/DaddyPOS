import 'package:easybill_app/app/data/models/response_model.dart';

class DayEndReport extends BaseModel {
  String? report;
  String? reportname;
  int? bills;
  String? amount;
  String? totalamount;

  DayEndReport(
      {this.report,
      this.reportname,
      this.bills,
      this.amount,
      this.totalamount});

  DayEndReport.fromJson(Map<String, dynamic> json) {
    report = json['report'];
    reportname = json['reportname'];
    bills = json['bills'];
    amount = json['amount'];
    totalamount = json['totalamount'];
  }

  @override
  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['report'] = report;
    data['reportname'] = reportname;
    data['bills'] = bills;
    data['amount'] = amount;
    data['totalamount'] = totalamount;
    return data;
  }

  @override
  // TODO: implement props
  List<Object?> get props => [report];
}
