import 'package:easybill_app/app/data/models/response_model.dart';

class Cashier extends BaseModel {
  int? usercredentialsid;
  int? userregistrationid;
  String? loginusername;
  String? userpassword;
  String? userrole;
  bool? isactive;
  String? createdon;
  int? decisionkey;
  List<String>? screenaccess;

  Cashier(
      {this.usercredentialsid,
      this.userregistrationid,
      this.loginusername,
      this.userpassword,
      this.userrole,
      this.isactive,
      this.createdon});

  Cashier.fromJson(Map<String, dynamic> json) {
    usercredentialsid = json['usercredentialsid'];
    userregistrationid = json['userregistrationid'];
    loginusername = json['loginusername'];
    userpassword = json['userpassword'];
    userrole = json['userrole'];
    isactive = json['isactive'];
    createdon = json['createdon'];
  }

  @override
  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['usercredentialsid'] = usercredentialsid;
    data['userregistrationid'] = userregistrationid;
    data['loginusername'] = loginusername;
    data['userpassword'] = userpassword;
    return data;
  }

  @override
  List<Object?> get props => [usercredentialsid];
}
