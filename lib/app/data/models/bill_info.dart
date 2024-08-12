import 'package:easybill_app/app/data/models/bill_items.dart';
import 'package:easybill_app/app/data/models/response_model.dart';

class BillInfo extends BaseModel {
  int? billno;
  String? userregistrationid;
  String? usercredentialsid;
  String? paymentmode;
  String? billtype;
  String? billtemplate;
  bool? issuccess;
  bool? istoken;
  List<BillItems>? items;
  String? datetime;
  String? tab;

  BillInfo(
      {this.userregistrationid,
      this.usercredentialsid,
      this.paymentmode,
      this.billtype,
      this.billtemplate,
      this.issuccess,
      this.istoken,
      this.items,
      this.datetime,
      this.billno,
      this.tab
      });

  BillInfo.fromJson(Map<String, dynamic> json) {
    userregistrationid = json['userregistrationid'];
    usercredentialsid = json['usercredentialsid'];
    paymentmode = json['paymentmode'];
    billtype = json['billtype'];
    billtemplate = json['billtemplate'];
    issuccess = json['issuccess'];
    istoken = json['istoken'];
    datetime = json['billdate'];
    billno = json['billno'];
    tab = json['tab'];
    if (json['items'] != null) {
      items = <BillItems>[];
      json['items'].forEach((v) {
        items!.add( BillItems.fromJson(v));
      });
    }
  }

  @override
  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['userregistrationid'] = userregistrationid;
    data['usercredentialsid'] = usercredentialsid;
    data['paymentmode'] = paymentmode;
    data['billtype'] = billtype;
    data['billtemplate'] = billtemplate;
    data['issuccess'] = issuccess;
    data['istoken'] = istoken;
    data['datetime'] = datetime;
    data['tab'] = tab;
    if (items != null) {
      data['items'] = items!.map((v) => v.toJson()).toList();
    }
    return data;
  }
  @override
  List<Object?> get props => [userregistrationid];
}






class Items extends BaseModel {
  int? shopproductid;
  int? quantity;
  int? price;
  int? totalprice;

  Items({this.shopproductid, this.quantity, this.price, this.totalprice});

  Items.fromJson(Map<String, dynamic> json) {
    shopproductid = json['shopproductid'];
    quantity = json['quantity'];
    price = json['price'];
    totalprice = json['totalprice'];
  }

  @override
  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['shopproductid'] = shopproductid;
    data['quantity'] = quantity;
    data['price'] = price;
    data['totalprice'] = totalprice;
    return data;
  }
  
  @override
  List<Object?> get props =>  [shopproductid];
}