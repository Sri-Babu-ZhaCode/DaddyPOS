import 'response_model.dart';

class Setting extends BaseModel {
  int? configid;
  String? businessname;
  String? businessaddress;
  String? businessmobile;
  String? businessemail;
  dynamic businesslogo;
  String? footer;
  String? gst;
  bool? nameenable;
  bool? phoneenable;
  bool? addressenable;
  bool? mobileenable;
  bool? logoenable;
  bool? footerenable;
  bool? gstenable;
  bool? whatsappenable;
  String? printername;
  String? printeraddress;
  String? printersize;
  String? language;
  String? templatedesign;
  int? userregistrationid;
  bool? emailenable;
  bool? isactive;

  Setting(
      {this.configid,
      this.businessname,
      this.businessaddress,
      this.businessmobile,
      this.businessemail,
      this.businesslogo,
      this.footer,
      this.gst,
      this.nameenable,
      this.phoneenable,
      this.addressenable,
      this.mobileenable,
      this.logoenable,
      this.footerenable,
      this.gstenable,
      this.whatsappenable,
      this.printername,
      this.printeraddress,
      this.printersize,
      this.language,
      this.templatedesign,
      this.userregistrationid,
      this.emailenable,
      this.isactive});

  Setting.fromJson(Map<String, dynamic> json) {
    configid = json['configid'];
    businessname = json['businessname'];
    businessaddress = json['businessaddress'];
    businessmobile = json['businessmobile'];
    businessemail = json['businessemail'];
    businesslogo = json['businesslogo'];
    footer = json['footer'];
    gst = json['gst'];
    nameenable = json['nameenable'];
    phoneenable = json['phoneenable'];
    addressenable = json['addressenable'];
    mobileenable = json['mobileenable'];
    logoenable = json['logoenable'];
    footerenable = json['footerenable'];
    gstenable = json['gstenable'];
    whatsappenable = json['whatsappenable'];
    printername = json['printername'];
    printeraddress = json['printeraddress'];
    printersize = json['printersize'];
    language = json['language'];
    templatedesign = json['templatedesign'];
    userregistrationid = json['userregistrationid'];
    emailenable = json['emailenable'];
    isactive = json['isactive'];
  }

  @override
  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['userregistrationid'] = userregistrationid;
    data['businessname'] = businessname;
    data['businessaddress'] = businessaddress;
    data['businessmobile'] = businessmobile;
    data['businessemail'] = businessemail;
    data['businesslogo'] = businesslogo;
    data['footerdata'] = footer;
    data['gst'] = gst;
    data['nameenable'] = nameenable;
    data['phoneenable'] = phoneenable;
    data['addressenable'] = addressenable;
    data['mobileenable'] = mobileenable;
    data['logoenable'] = logoenable;
    data['footerenable'] = footerenable;
    data['gstenable'] = gstenable;
    data['whatsappenable'] = whatsappenable;
    data['printername'] = printername;
    data['printeraddress'] = printeraddress;
    data['printersize'] = printersize;
    data['language'] = language;
    data['templatedesign'] = templatedesign;
    data['emailenable'] = emailenable;
    return data;
  }

  @override
  List<Object?> get props => [userregistrationid];
}
