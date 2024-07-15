import 'package:easybill_app/app/widgets/custom_widgets/custom_alert_dialog.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import '../../../../../constants/app_string.dart';
import '../../../../../constants/app_text_style.dart';
import '../../../../../widgets/custom_widgets/custom_dropdownbtn.dart';
import '../../controllers/bill_wise_report_controller.dart';

Future paymentModeFilterDialog(BillWiseReportController _) {
  return const CustomAlertDialog().alertDialog(
      formChildren: [
        CustomDropDownFormField<String>(
          value: _.currentPaymentMode,
          items: _.paymentMode
              .map<DropdownMenuItem<String>>(
                (element) => DropdownMenuItem<String>(
                  value: element.toString(),
                  child: Text(element.toString().toUpperCase(),
                      overflow: TextOverflow.ellipsis,
                      style: EBAppTextStyle.bodyText),
                ),
              )
              .toList(),
          onChanged: (value) {
            if (value == null) {
              return;
            }
            _.currentPaymentMode = value;
            _.update();
          },
        ),
      ],
      dialogTitle: EBAppString.changePaymentMode,
      dialogContent: 'Filter By Paymentmode',
      confirmButtonText: EBAppString.summit,
      confirmOnPressed: () {
        _.filterByDateOrPaymentmode();
         Get.back();
      },
      cancelButtonText: EBAppString.cancel,
      cancelOnPressed: () => Get.back());
}
