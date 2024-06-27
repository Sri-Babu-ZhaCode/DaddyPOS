import 'package:easybill_app/app/data/models/response_model.dart';

class TaxType extends BaseModel {
  int? taxtypeid;
  String? taxtypename;
  bool? isactive;
  String? createdon;
  bool? isdefault;

  TaxType(
      {this.taxtypeid,  
      this.taxtypename,
      this.isactive,
      this.createdon,
      this.isdefault});

  TaxType.fromJson(Map<String , dynamic> json) {
    taxtypeid = json['taxtypeid'];
    taxtypename = json['taxtypename'];
    isactive = json['isactive'];
    createdon = json['createdon'];
    isdefault = json['isdefault'];
  }

  @override
  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['taxtypeid'] = taxtypeid;
    data['taxtypename'] = taxtypename;
    data['isactive'] = isactive;
    data['createdon'] = createdon;
    return data;
  }

  @override
  List<Object?> get props => [taxtypeid];
}

class Units extends BaseModel {
  int? unitid;
  String? unitname;
  bool? isactive;
  String? createdon;
  bool? isdefault;

  Units(
      {this.unitid,
      this.unitname,
      this.isactive,
      this.createdon,
      this.isdefault});

  Units.fromJson(Map<String, dynamic> json) {
    unitid = json['unitid'];
    unitname = json['unitname'];
    isactive = json['isactive'];
    createdon = json['createdon'];
    isdefault = json['isdefault'];
  }

  @override
  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['unitid'] = unitid;
    data['unitname'] = unitname;
    data['isactive'] = isactive;
    data['createdon'] = createdon;
    return data;
  }

  @override
  List<Object?> get props => [unitid];
}
