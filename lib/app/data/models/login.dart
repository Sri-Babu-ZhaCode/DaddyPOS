// ignore_for_file: unnecessary_this

import 'package:easybill_app/app/data/models/response_model.dart';

class Login extends BaseModel {
  String? loginmobilenumber;
  String? userpassword;
  String? userrole;
  String? loggedindeviceid;
  String? loggedindevicename;
  int? userregistrationid;
  int? usercredentialsid;
  String? loginusername;
  String? username;
  String? businessname;
  String? email;
  bool? gst;
  String? gstnumber;
  String? productlanguage;
  int? decisionkey;
  String? subscriptionplan;
  List<String>? screenaccess;
  Login(
      {this.userregistrationid,
      this.usercredentialsid,
      this.loginusername,
      this.userrole,
      this.username,
      this.businessname,
      this.email,
      this.gst,
      this.gstnumber,
      this.productlanguage,
      this.loggedindeviceid,
      this.loggedindevicename,
      this.decisionkey,
      this.loginmobilenumber,
      this.userpassword,
      this.subscriptionplan,
      this.screenaccess});
  @override
  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['usercredentialsid'] = usercredentialsid;
    data['loginmobilenumber'] = loginmobilenumber;
    data['userpassword'] = userpassword;
    data['userrole'] = userrole;
    data['loggedindeviceid'] = loggedindeviceid;
    data['loggedindevicename'] = loggedindevicename;
    return data;
  }

  Login.fromJson(Map<String, dynamic> json) {
    userregistrationid = json['userregistrationid'];
    usercredentialsid = json['usercredentialsid'];
    loginusername = json['loginusername'];
    userrole = json['userrole'];
    username = json['username'];
    businessname = json['businessname'];
    email = json['email'];
    gst = json['gst'];
    gstnumber = json['gstnumber'];
    loggedindeviceid = json['loggedindeviceid'];
    loggedindevicename = json['loggedindevicename'];
    productlanguage = json['productlanguage'];
    decisionkey = json['decisionkey'];
    subscriptionplan = json['subscriptionplan'];
    if (json["screenaccess"] != null) {
      screenaccess = List<String>.from(json["screenaccess"].map((x) => x));
    }
  }
  @override
  List<Object?> get props => [userregistrationid];
}
