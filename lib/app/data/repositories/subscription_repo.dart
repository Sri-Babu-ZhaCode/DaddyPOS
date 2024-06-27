import 'dart:convert';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'package:easybill_app/secrets.dart';
import '../../core/exceptions.dart';
import '../models/razer_pay.dart';
import '../models/subscription.dart';
import 'base_repository.dart';

class SubscriptionRepo extends BaseRepo {
  SubscriptionRepo._privateConstructor();

  // Static instance variable
  static final SubscriptionRepo _instance =
      SubscriptionRepo._privateConstructor();

  // Factory constructor to return the singleton instance
  factory SubscriptionRepo() {
    return _instance;
  }
  Future<RazorPayOrderId?> razorPayApi(int amount, String receiptId) async {
    var auth =
        'Basic ${base64Encode(utf8.encode('$razorPay_Api:$razorPaySecret'))}';
    var headers = {'content-type': 'application/json', 'Authorization': auth};
    var body = json.encode(
        {"amount": amount * 100, "currency": "INR", "receipt": receiptId});
    var response = await http.post(
        Uri.parse('https://api.razorpay.com/v1/orders'),
        headers: headers,
        body: body);

    debugPrint(response.statusCode.toString());
    if (response.statusCode == 200) {
      debugPrint('Api call successful ----------------->>  ');
      debugPrint(response.body);
      return RazorPayOrderId.fromJson(jsonDecode(response.body));
    } else {
      debugPrint('Api call failed ----------------->>  ');
      return null;
    }
  }

  Future<List<Subscription>?> getSubscription() async {
    try {
      return await realGet<Subscription>("/subscriptionplans/",
          decoder: (json) => Subscription.fromJson(json));
    } catch (e) {
      throw EbException(e);
    }
  }

  Future<List<Subscription>?> updateSubscriptionPlan(Subscription s) async {
    try {
      return await post<Subscription>("/subscriptionplans/",
          body: s.toJson(), decoder: (json) => Subscription.fromJson(json));
    } catch (e) {
      throw EbException(e);
    }
  }
}
