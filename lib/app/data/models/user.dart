import 'package:easybill_app/app/data/models/response_model.dart';

class User extends BaseModel {
  // mandatory for all
  int? userregistrationid;

  // Registeration
  String? deviceuniqueid;
  String? devicename;
  String? businessname;
  String? businessaddress;
  String? loginmobilenumber;
  String? email;
  bool? gst;
  String? gstnumber;
  bool? isactive;
  bool? isapproved;
  bool? appstatus;
  bool? issubscription;
  String? createdon;
  String? lastloginon;
  String? productlanguage;
  int? decisionkey;

// setting password
  String? userpassword;

  User(
      {this.userregistrationid,
      this.deviceuniqueid,
      this.devicename,
      this.businessname,
      this.businessaddress,
      this.loginmobilenumber,
      this.email,
      this.gst,
      this.userpassword,
      this.gstnumber,
      this.isactive,
      this.isapproved,
      this.appstatus,
      this.issubscription,
      this.createdon,
      this.lastloginon,
      this.productlanguage,
      this.decisionkey});

  User.fromJson(Map<String, dynamic> json) {
    userregistrationid = json['userregistrationid'];
    decisionkey = json['decisionkey'];
    deviceuniqueid = json['deviceuniqueid'];
    devicename = json['devicename'];
    businessname = json['businessname'];
    businessaddress = json['businessaddress'];
    loginmobilenumber = json['loginmobilenumber'];
    email = json['email'];
    gst = json['gst'];
    gstnumber = json['gstnumber'];
    isactive = json['isactive'];
    isapproved = json['isapproved'];
    appstatus = json['appstatus'];
    issubscription = json['issubscription'];
    createdon = json['createdon'];
    lastloginon = json['lastloginon'];
    productlanguage = json['productlanguage'];
    // setting password
    userpassword = json['userpassword'];
  }

  @override
  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['userregistrationid'] = userregistrationid;
    data['deviceuniqueid'] = deviceuniqueid;
    data['devicename'] = devicename;
    data['businessname'] = businessname;
    data['businessaddress'] = businessaddress;
    data['loginmobilenumber'] = loginmobilenumber;
    data['email'] = email;
    data['gst'] = gst;
    data['gstnumber'] = gstnumber;
    return data;
  }

  toSharedPreference() {}
  @override
  List<Object?> get props => [userregistrationid];
}
