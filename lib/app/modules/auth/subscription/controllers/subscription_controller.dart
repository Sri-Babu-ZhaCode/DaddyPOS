// ignore_for_file: unnecessary_override, unnecessary_overrides

import 'dart:convert';
import 'dart:math';
import 'package:crypto/crypto.dart';
import 'package:easybill_app/app/constants/app_string.dart';
import 'package:easybill_app/app/data/models/login.dart';
import 'package:easybill_app/app/data/models/subscription.dart';
import 'package:easybill_app/app/data/repositories/subscription_repo.dart';
import 'package:easybill_app/app/modules/auth/register/controllers/register_controller.dart';
import 'package:easybill_app/app/widgets/custom_widgets/custom_toast.dart';
import 'package:easybill_app/secrets.dart';
import 'package:flutter/widgets.dart';
import 'package:get/get.dart';
import 'package:razorpay_flutter/razorpay_flutter.dart';
import '../../../../data/api/local_storage.dart';
import '../../../../data/repositories/auth_repository.dart';
import '../../../../routes/app_pages.dart';
import '../../../../widgets/custom_widgets/custom_snackbar.dart';
import '../../../../widgets/set_password_dialog.dart';

class SubscriptionController extends GetxController {
  List<Subscription>? subscriptionList;
  Subscription? selectedSubscription;

  final AuthRepo _authRepo = AuthRepo();
  final SubscriptionRepo _subscriptionRepo = SubscriptionRepo();

  final formKey = GlobalKey<FormState>();

  final _razorpay = Razorpay();

  bool subscriptionVal = false;

  int? selectedContainerIndex;

  String? orderid, generatedSignature, razorpaySignature;

  int selectedIndex = 0;

  bool isFreeSelected = false;
  @override
  void onInit() {
    super.onInit();
    getSubscriptionPlans();
    _razorpay.on(Razorpay.EVENT_PAYMENT_SUCCESS, _handlePaymentSuccess);
    _razorpay.on(Razorpay.EVENT_PAYMENT_ERROR, _handlePaymentError);
    _razorpay.on(Razorpay.EVENT_EXTERNAL_WALLET, _handleExternalWallet);
  }

  void _handlePaymentSuccess(PaymentSuccessResponse response) {
    razorpaySignature = response.signature;
    updateTransaction(successResponse: response);
  }

  void _handlePaymentError(PaymentFailureResponse response) {
    ebCustomTtoastMsg(message: 'Payment Fail ${response.message}');
    updateTransaction(failureResponse: response);
  }

  void _handleExternalWallet(ExternalWalletResponse response) {
    ebCustomTtoastMsg(message: 'External Wallet ${response.walletName}');
    updateTransaction(externalWaletResponse: response);
  }

  @override
  void onReady() {
    super.onReady();
  }

  @override
  void onClose() {
    super.onClose();
    _razorpay.clear();
  }

  Future<void> getSubscriptionPlans() async {
    try {
      final x = await _subscriptionRepo.getSubscription();
      subscriptionList = x;
      if (subscriptionList != null) {
        for (var sub in subscriptionList!) {
          debugPrint("subscription Id ----------->>  ${sub.subscriptionId}");
          debugPrint("subscription plans ----------->>  ${sub.planname}");
          debugPrint("subscription price ----------->>  ${sub.price}");
          debugPrint(
              "subscription valididty ----------->>  ${sub.validityInMonths}");
          update();
        }
      }
    } catch (e) {
      debugPrint(e.toString());
    }
  }

  Future<void> updateTransaction(
      {PaymentSuccessResponse? successResponse,
      PaymentFailureResponse? failureResponse,
      ExternalWalletResponse? externalWaletResponse}) async {
    try {
      Subscription subscription = Subscription(
        paymentStatus: successResponse != null
            ? 'success'
            : failureResponse != null
                ? 'failure'
                : 'external wallet',
        paymentId: successResponse != null
            ? successResponse.paymentId
            : failureResponse != null
                ? failureResponse.code.toString()
                : '',
        orderId: orderid,
        razorpaySignature:
            successResponse != null ? successResponse.signature : '',
        transactionMessage: successResponse != null
            ? 'transaction was successful'
            : failureResponse != null
                ? failureResponse.message
                : externalWaletResponse!.walletName,
        price: selectedSubscription?.price,
        description: 'payment done with razor pay',
        subscriptionId: selectedSubscription?.subscriptionId,
      );

      final updateTransaction =
          await _subscriptionRepo.updateSubscriptionPlan(subscription);

      if (updateTransaction != null) {
        successResponse != null ? _checkPayMentSecured(successResponse) : null;
      }
      update();
    } catch (e) {
      debugPrint(e.toString());
    }
  }

  void onUpdatePressed(String pwd) {
    debugPrint('form validated------------>>  ');
    if (formKey.currentState?.validate() == true) {
      debugPrint('form validated------------>>  ');
      setPassword(pwd);
      update();
    }
  }

  Future<void> setPassword(String pwd) async {
    try {
      debugPrint(
          'Local storage in Sub controller -------------->>  ${LocalStorage.registeredUserId}');

      final login = Login(
        userpassword: pwd,
      );
      final res = await _authRepo.setPassword(login);
      debugPrint('setPassword api called--------->>  ');
      debugPrint(res.toString());
      debugPrint('setPassword mehtod ended--------->>  ');
      navigationForSettingPwd(res);
    } catch (e) {
      debugPrint(e.toString());
    }
  }

  void navigationForSettingPwd(List<Login>? login) {
    if (login == null) return;
    int decisionKey = login[0].decisionkey!;
    switch (decisionKey) {
      case 0:
        debugPrint('decision key --------------->>  $decisionKey');
        EBCustomSnackbar.show('Not Registered');
        Get.toNamed(Routes.REGISTER);
        break;
      case 1:
        debugPrint('decision key --------------->>  $decisionKey');
        Get.offAllNamed(Routes.LOGIN);
        break;
      case 2:
        debugPrint('decision key --------------->>  $decisionKey');
        EBCustomSnackbar.show('No subscription');
        Get.toNamed(Routes.SUBSCRIPTION);
        break;
      case 3:
        debugPrint('decision key --------------->>  $decisionKey');
        EBCustomSnackbar.show('Password already created');
        break;
      default:
        debugPrint('decision key --------------->>  $decisionKey');
        debugPrint('Some this went wrong  ------------------??  ');
        // Handle unexpected values
        break;
    }
  }

  void onNextBtnPressed() async {
    // ----------->>  ON successful payment

    String receiptId = "${Random().nextInt(99999) + 10000}";

    // subscription amount

    int? subscriptionAmt;

    if (generatedSignature != null && razorpaySignature != null) {
      if (generatedSignature == razorpaySignature) {
        SetPasswordAlertDialog.setPasswordAlertDialof(
            formKey: formKey,
            loginMobileNum:
                Get.find<RegisterController>().mobileController.text);
      }
    }

    debugPrint(
        'selected paln ${selectedSubscription?.price}  ${selectedSubscription?.planname}');

    if (selectedSubscription != null) {
      subscriptionAmt = int.tryParse(selectedSubscription!.price!);
    }

    if (subscriptionAmt == 0) {
      Subscription subscription = Subscription(
        paymentStatus: 'success',
        paymentId: '1234',
        orderId: "sdfhakjshdfkjashdfksdh",
        razorpaySignature: '_free_signature_123456',
        transactionMessage: 'transaction was successful',
        price: selectedSubscription?.price,
        description: 'payment done with razor pay',
        subscriptionId: selectedSubscription?.subscriptionId,
      );
      final updateTransaction =
          await _subscriptionRepo.updateSubscriptionPlan(subscription);

      if (updateTransaction != null) {
        SetPasswordAlertDialog.setPasswordAlertDialof(
            formKey: formKey,
            // loginmobile number will be updated while resgistion and login
            loginMobileNum:
             EBAppString.loginmobilenumber != null
                ? EBAppString.loginmobilenumber!
                : "--"
                );
      }
    }

    if (subscriptionAmt != null && subscriptionAmt != 0) {
      final respose =
          await _subscriptionRepo.razorPayApi(subscriptionAmt, receiptId);
      if (respose != null) {
        orderid = respose.id;
        debugPrint("order id ===================================>>  $orderid");
        if (orderid != null) {
          _checkOut(orderid!);
        } else {
          debugPrint('some thing went wrong ---------->>');
        }
      }
    }
  }

  void _checkOut(String orderId) {
    var options = {
      'key': razorPay_Api,
      'amount': 1,
      'order_id': orderId,
      'name': 'Azhi Inovations',
      'description': 'Fine T-Shirt',
    };

    try {
      _razorpay.open(options);
    } catch (e) {
      debugPrint('Exception occured --------->>  $e');
    }
  }

  void _checkPayMentSecured(PaymentSuccessResponse response) {
    debugPrint('inside _checkPayMentSecured method --------------------->> ');
    generatedSignature =
        hmacSha256('${response.orderId}|${response.paymentId}', razorPaySecret);
    debugPrint(generatedSignature);
    debugPrint('response seginature --->${response.signature}');

    if (generatedSignature == response.signature) {
      // payment is successfull
      debugPrint(
          'inside success state wainting to open dialog ----------------------->>');
      SetPasswordAlertDialog.setPasswordAlertDialof(
          formKey: formKey,
          loginMobileNum: Get.find<RegisterController>().mobileController.text);
    } else {
      ebCustomTtoastMsg(message: 'Something went wrong');
    }
  }

  String hmacSha256(String data, String secret) {
    var key = utf8.encode(secret);
    var bytes = utf8.encode(data);

    var hmacSha256 = Hmac(sha256, key); // HMAC-SHA256
    var digest = hmacSha256.convert(bytes);

    return digest.toString();
  }
}
