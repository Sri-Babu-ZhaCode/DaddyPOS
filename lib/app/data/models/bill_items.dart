import 'package:easybill_app/app/data/models/response_model.dart';

class BillItems extends BaseModel {
  String? productNameEnglish;
  String? productnameTamil;
  int? productId;
  int? shopproductid;
  String? taxpercentage;
  String? sgstPercentage;
  String? cgstPercentage;
  String? sgstValueonprice;
  String? cgstValueonprice;
  double? quantity;
  double? price;
  double? totalprice;
  bool? isDecimal;

  BillItems(
      this.productNameEnglish,
      this.productId,
      this.quantity,
      this.price,
      this.totalprice,
      this.shopproductid,
      this.isDecimal,
      this.productnameTamil,
      this.taxpercentage,
      this.sgstPercentage,
      this.cgstPercentage,
      this.sgstValueonprice,
      this.cgstValueonprice);

  @override
  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['shopproductid'] = shopproductid;
    data['quantity'] = quantity;
    data['price'] = price;
    data['totalprice'] = totalprice;
    return data;
  }

  BillItems.fromJson(Map<String, dynamic> json) {
    shopproductid = json['shopproductid'];
    quantity = json['quantity'];
    price = json['price'];
    totalprice = json['totalprice'];
  }

  @override
  List<Object?> get props => [shopproductid];
}
