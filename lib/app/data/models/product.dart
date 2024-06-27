import 'package:easybill_app/app/data/models/response_model.dart';

class Product extends BaseModel {
  int? productid;
  int? shopproductid;
  int? userregistrationid;
  String? productnameEnglish;
  String? productnameTamil;
  int? categoryid;
  bool? istoken;
  String? price;
  int? unitid;
  int? taxtypeid;
  String? taxpercentage;
  String? cgstPercentage;
  String? cgstValueonprice;
  String? sgstPercentage;
  String? sgstValueonprice;
  bool? isactive;
  String? createdon;
  String? pricewithtax;
  String? pricewithouttax;
  String? qrbarcode;
  bool? showQuantityPopup;
  bool? isDecimalAllowed;

  Product({
    this.productid,
    this.shopproductid,
    this.userregistrationid,
    this.productnameEnglish,
    this.productnameTamil,
    this.categoryid,
    this.istoken,
    this.price,
    this.unitid,
    this.taxtypeid,
    this.taxpercentage,
    this.cgstPercentage,
    this.cgstValueonprice,
    this.sgstPercentage,
    this.sgstValueonprice,
    this.isactive,
    this.createdon,
    this.pricewithtax,
    this.pricewithouttax,
    this.qrbarcode,
    this.showQuantityPopup,
    this.isDecimalAllowed,
  });

  Product.fromJson(Map<String, dynamic> json) {
    productid = json['productid'];
    shopproductid = json['shopproductid'];
    userregistrationid = json['userregistrationid'];
    productnameEnglish = json['productname_english'];
    productnameTamil = json['productname_tamil'];
    categoryid = json['categoryid'];
    istoken = json['istoken'];
    price = json['price'];
    unitid = json['unitid'];
    taxtypeid = json['taxtypeid'];
    taxpercentage = json['taxpercentage'];
    cgstPercentage = json['cgst_percentage'];
    cgstValueonprice = json['cgst_valueonprice'];
    sgstPercentage = json['sgst_percentage'];
    sgstValueonprice = json['sgst_valueonprice'];
    isactive = json['isactive'];
    createdon = json['createdon'];
    pricewithtax = json['pricewithtax'];
    pricewithouttax = json['pricewithouttax'];
    qrbarcode = json['qrbarcode'];
    showQuantityPopup = json['show_quantity_popup'];
    isDecimalAllowed = json['is_decimal_allowed'];
  }

  @override
  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['productid'] = productid;
    data['shopproductid'] = shopproductid;
    data['userregistrationid'] = userregistrationid;
    data['productname_english'] = productnameEnglish;
    data['productname_tamil'] = productnameTamil;
    data['categoryid'] = categoryid;
    data['istoken'] = istoken;
    data['price'] = price;
    data['unitid'] = unitid;
    data['taxtypeid'] = taxtypeid;
    data['taxpercentage'] = taxpercentage;
    data['cgst_percentage'] = cgstPercentage;
    data['cgst_valueonprice'] = cgstValueonprice;
    data['sgst_percentage'] = sgstPercentage;
    data['sgst_valueonprice'] = sgstValueonprice;
    data['isactive'] = isactive;
    data['createdon'] = createdon;
    data['pricewithtax'] = pricewithtax;
    data['pricewithouttax'] = pricewithouttax;
    data['qrbarcode'] = qrbarcode;  
    return data;
  }

  @override
  List<Object?> get props => [productid];
}
