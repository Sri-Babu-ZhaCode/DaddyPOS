import 'package:easybill_app/app/data/models/response_model.dart';

class Category extends BaseModel {
  int? categoryid;
  int? userregistrationid;
  String? categoryname;
  bool? isactive;
  String? createdon;
  bool? isdefault;

  Category({
    this.categoryid,
    this.userregistrationid,
    this.categoryname,
    this.isactive,
    this.createdon,
    this.isdefault,
  });

  Category.fromJson(Map<String, dynamic> json) {
    categoryid = json['categoryid'] ?? '-';
    userregistrationid = json['userregistrationid'] ?? '-';
    categoryname = json['categoryname'] ?? '-';
    isactive = json['isactive'] ?? '-';
    createdon = json['createdon'] ?? '-';
    isdefault = json['isdefault'] ?? '-';
  }

  @override
  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['categoryid'] = categoryid;
    data['userregistrationid'] = userregistrationid;
    data['categoryname'] = categoryname;
    data['isactive'] = isactive;
    data['createdon'] = createdon;
    return data;
  }

  @override
  List<Object?> get props => [categoryid];
}
