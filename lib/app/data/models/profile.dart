import 'package:easybill_app/app/data/models/response_model.dart';

class Profile extends BaseModel {
  int? userregistrationid;
  int? usercredentialsid;
  String? businessname;
  String? businessaddress;
  String? gstnumber;
  String? loginmobilenumber;
  String? email;
  String? loggedindeviceid;
  String? loggedindevicename;
  String? newpassword;
  String? userrole;
  bool? gst;
  String? productlanguage;
  int? decisionkey;

  Profile(
      {this.userregistrationid,
      this.usercredentialsid,
      this.businessname,
      this.businessaddress,
      this.gstnumber,
      this.loginmobilenumber,
      this.email,
      this.loggedindeviceid,
      this.loggedindevicename,
      this.newpassword,
      this.userrole,
      this.gst,
      this.productlanguage,
      this.decisionkey});

  Profile.fromJson(Map<String, dynamic> json) {
    userregistrationid = json['userregistrationid'];
    usercredentialsid = json['usercredentialsid'];
    loginmobilenumber = json['loginmobilenumber'];
    userrole = json['userrole'];
    businessname = json['businessname'];
    businessaddress = json['businessaddress'];
    email = json['email'];
    gst = json['gst'];
    gstnumber = json['gstnumber'];
    productlanguage = json['productlanguage'];
    loggedindeviceid = json['loggedindeviceid'];
    loggedindevicename = json['loggedindevicename'];
    decisionkey = json['decisionkey'];
  }

  @override
  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['userregistrationid'] = userregistrationid;
    data['usercredentialsid'] = usercredentialsid;
    data['businessname'] = businessname;
    data['businessaddress'] = businessaddress;
    data['businessmobile'] = loginmobilenumber;
    data['gstnumber'] = gstnumber;
    data['businessemail'] = email;
    data['loggedindeviceid'] = loggedindeviceid;
    data['loggedindevicename'] = loggedindevicename;
    data['newpassword'] = newpassword;
    return data;
  }

  @override
  List<Object?> get props => [userregistrationid];
}
