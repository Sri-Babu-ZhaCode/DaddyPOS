import 'package:easybill_app/app/data/models/response_model.dart';

class Reports extends BaseModel {
  int? shopbillid;
  int? productId;
  int? cancelbillid;
  String? billDate;
  int? staffid;
  int? sumquantity;
  int? sumtotalquantityamount;
  String? billtype;

  Reports({
    this.shopbillid,
    this.sumquantity,
    this.sumtotalquantityamount,
    this.billtype,
    this.productId,
    this.staffid,
    this.billDate,
    this.cancelbillid,
  });

  Reports.fromJson(Map<String, dynamic> json) {
    shopbillid = json['shopbillid'];
    productId = json['productId'];
    staffid = json['staffid'];
    cancelbillid = json['cancelbillid'];
    billDate = json['billDate'];
    sumquantity = json['sumquantity'];
    sumtotalquantityamount = json['sumtotalquantityamount'];
  }

  @override
  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['billtype'] = billtype;
    data['shopbillid'] = shopbillid;
    return data;
  }

  @override
  List<Object?> get props => [shopbillid];
}
