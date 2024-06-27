import 'package:dio/dio.dart';
import 'package:equatable/equatable.dart';

class BtResponse<T extends BaseModel> {
  bool? status;
  String? message;
  int? decisionkey;
  String? requiredFields;
  List<T>? results;

  BtResponse({
    this.status,
    this.message,
    this.decisionkey,
    this.results,
  });

  BtResponse.fromJson(
      Map<String, dynamic> json, ResponseResultDecoder<T> resultsDecoder) {
    status = json['status'];
    message = json['message'];
    decisionkey = json['decisionkey'];
    requiredFields = json['requiredFields'];
    if (json['results'] != null) {
      results = jsonToList<T>(json['results'], resultsDecoder);
    }
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = {};
    data['status'] = this.status;
    data['message'] = this.message;
    data['decisionkey'] = this.decisionkey;
    if (this.results != null) {
      data['results'] = this.results!.map((v) => v.toJson()).toList();
    }
    return data;
  }
}

abstract class BaseModel extends Equatable {
  toJson() {}
}

typedef ResponseResultDecoder<T> = T Function(dynamic json);
typedef ResponseHandler<T> = T Function(Response response);
typedef ResponseAsListHandler<T> = List<T> Function(Response response);

List<T> jsonToList<T>(json, ResponseResultDecoder<T> decoder) {
  return json?.map<T>((e) => decoder(e)).toList();
}
