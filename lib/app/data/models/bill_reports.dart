import 'package:easybill_app/app/data/models/response_model.dart';

class Reports extends BaseModel {
  int? shopbillid;
  int? userregistrationid;
  int? credentialsid;
  String? productnameEnglish;
  String? productnameTamil;
  double? quantity;
  double? totalquantityamount;
  String? reporttype;
  String? rateperitem;
  int? shopproductid;
  String? loginusername;
  String? fullname;
  String? toDate;
  String? fromDate;
  String? paymentmode;
  String? billdate;
  String? uniqueshopbillid;

  Reports({
    this.shopbillid,
    this.userregistrationid,
    this.credentialsid,
    this.loginusername,
    this.reporttype,
    this.shopproductid,
    this.productnameEnglish,
    this.productnameTamil,
    this.quantity,
    this.totalquantityamount,
    this.paymentmode,
    this.billdate,
    this.fullname,
    this.uniqueshopbillid,
    this.fromDate,
    this.toDate,
    this.rateperitem,
  });

  Reports.fromJson(Map<String, dynamic> json) {
    shopbillid = json['shopbillid'];
    shopproductid = json['shopproductid'];
    fullname = json['fullname'];
    userregistrationid = json['userregistrationid'];
    loginusername = json['loginusername'];
    credentialsid = json['usercredentialsid'];
    productnameEnglish = json['productname_english'];
    productnameTamil = json['productname_tamil'];
    quantity = double.parse(json['totalquantity'].toString());
    rateperitem = json['rateperitem'];
    totalquantityamount = json['totalamount'] is String
        ? double.parse(json['totalamount'])
        : json['totalamount'];
    paymentmode = json['paymentmode'];
    billdate = json['formatted_createdon'];
    uniqueshopbillid = json['uniqueshopbillid'];
  }
  @override
  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['shopbillid'] = shopbillid;
    data['uniqueshopbillid'] = uniqueshopbillid;
    data['paymentmode'] = paymentmode;
    data['fromDate'] = fromDate;
    data['toDate'] = toDate;
    data['userregistrationid'] = userregistrationid;
    data['credentialsid'] = credentialsid;
    data['reporttype'] = reporttype;
    data['shopproductid'] = shopproductid;
    return data;
  }

  Map<String, dynamic> filteringToJosn() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['userregistrationid'] = userregistrationid;
    data['fromDate'] = fromDate;
    data['toDate'] = toDate;
    data['reporttype'] = reporttype;
    data['shopproductid'] = shopproductid;
    data['usercredentialsid'] = credentialsid;
    data['paymentmode'] = paymentmode;
    return data;
  }

  @override
  List<Object?> get props => [shopbillid];
}
