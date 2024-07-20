import 'package:easybill_app/app/modules/admin/admin_report/controllers/admin_report_controller.dart';
import 'package:easybill_app/app/widgets/custom_widgets/custom_alert_dialog.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import '../../../../../constants/app_string.dart';
import '../../../../../constants/app_text_style.dart';
import '../../../../../constants/size_config.dart';
import '../../../../../widgets/custom_widgets/custom_dropdownbtn.dart';
import '../../../../../widgets/custom_widgets/custom_list_tile.dart';

Future filterDialogForAdminReport(
    AdminReportController _, BuildContext context) {
  return const CustomAlertDialog().alertDialog(
      formChildren: [
        EBCustomListTile(
            contentPadding: EBSizeConfig.edgeInsetsOnlyW04,
            trailingIconSize: 26,
            onTap: () async {
              await _.showDateCalender(context);
              Get.back();
            },
            titleName: 'Date Filter',
            trailingIcon: Icons.calendar_month_outlined),
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
      dialogTitle: EBAppString.filter,
      dialogContent: 'You can filter you reports here',
      confirmButtonText: EBAppString.summit,
      confirmOnPressed: () async {
        await _.filterByDateOrPaymentmode();
        Get.back();
      },
      cancelButtonText: EBAppString.cancel,
      cancelOnPressed: () => Get.back());
}
