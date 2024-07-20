import 'package:flutter/widgets.dart';
import 'package:upi_payment_qrcode_generator/upi_payment_qrcode_generator.dart';

import '../../../../../constants/app_string.dart';
import '../../../../../constants/themes.dart';

Widget paymentQrWidget({
  required String upiID,
  required String payeeName,
  required double tolalAmt,
}) {
  final upiDetails = UPIDetails(
    upiID: upiID,
    payeeName: payeeName,
    amount: tolalAmt,
  );
  return UPIPaymentQRCode(
    upiDetails: upiDetails,
    size: 130,
    embeddedImagePath: EBAppString.daddyPosImg,
    embeddedImageSize: const Size(50, 50),
    eyeStyle: const QrEyeStyle(
        eyeShape: QrEyeShape.square, color: EBTheme.blackColor),
    dataModuleStyle: const QrDataModuleStyle(
        dataModuleShape: QrDataModuleShape.square, color: EBTheme.blackColor),
  );
}
