import 'package:easybill_app/app/data/models/response_model.dart';

class Subscription extends BaseModel {
  int? subscriptionId;
  String? planname;
  List<String>? screenAcess;
  String? description;
  String? price;
  int? validityInMonths;
  String? paymentStatus;
  String? paymentId;
  String? orderId;
  String? razorpaySignature;
  String? transactionMessage;
  String? userregistrationid;
  String? expirydate;

  Subscription(
      {this.subscriptionId,
      this.planname,
      this.screenAcess,
      this.description,
      this.price,
      this.validityInMonths,
      this.paymentStatus,
      this.paymentId,
      this.orderId,
      this.razorpaySignature,
      this.transactionMessage,
      this.userregistrationid,
      this.expirydate});

  Subscription.fromJson(Map<String, dynamic> json) {
    subscriptionId = json['subscription_id'];
    planname = json['planname'];
    screenAcess = json['screen_acess'].cast<String>();
    description = json['description'];
    price = json['price'];
    validityInMonths = json['validity_in_months'];
  }

  @override
  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['userregistrationid'] = userregistrationid;
    data['payment_status'] = paymentStatus;
    data['payment_id'] = paymentId;
    data['order_id'] = orderId;
    data['razorpay_signature'] = razorpaySignature;
    data['transaction_message'] = transactionMessage;
    data['amount'] = price;
    data['expirydate'] = expirydate;
    data['subscription_id'] = subscriptionId;
    data['planname'] = planname;
    data['screen_acess'] = screenAcess;
    data['description'] = description;
    data['validity_in_months'] = validityInMonths;
    return data;
  }

  @override
  List<Object?> get props => [subscriptionId];
}
