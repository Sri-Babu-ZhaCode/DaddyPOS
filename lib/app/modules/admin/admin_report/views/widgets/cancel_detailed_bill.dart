import 'package:easybill_app/app/constants/app_string.dart';
import 'package:easybill_app/app/constants/bools.dart';
import 'package:easybill_app/app/data/models/bill_reports.dart';
import 'package:easybill_app/app/modules/admin/admin_report/controllers/admin_report_controller.dart';
import 'package:easybill_app/app/widgets/custom_widgets/custom_msg_widget.dart';
import 'package:easybill_app/app/widgets/loading_widget.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import '../../../../../constants/app_text_style.dart';
import '../../../../../constants/size_config.dart';
import '../../../../../constants/themes.dart';

Future<void> cancelDetailedbillDetailedInfoSheet(context) {
  EBSizeConfig.init(context);
  return showModalBottomSheet<void>(
      backgroundColor: EBTheme.kPrimaryWhiteColor,
      context: context,
      isScrollControlled: true,
      constraints: const BoxConstraints(
        maxWidth: double.infinity,
      ),
      builder: (BuildContext context) {
        return Padding(
          padding: EBSizeConfig.edgeInsetsAll15,
          child: Column(
            children: [
              EBSizeConfig.sizedBoxH20,
              Row(
                mainAxisAlignment: MainAxisAlignment.end,
                children: [
                  IconButton(
                    icon: const Icon(
                      Icons.close,
                      size: 30,
                    ), // 'x' icon
                    onPressed: () {
                      Get.back();
                    },
                  ),
                  // You can adjust the alignment or add more widgets here
                ],
              ),
              EBSizeConfig.sizedBoxH20,
              GetBuilder<AdminReportController>(builder: (_) {
                if (EBBools.isLoading) return const LoadingWidget();
                if (_.cancelillDetailedReports == null ||
                    _.cancelillDetailedReports!.isEmpty)
                  return customMessageWidget();
                return Expanded(
                  child: ListView.builder(
                      padding: EBSizeConfig.textContentPadding,
                      itemCount: _.cancelillDetailedReports!.length,
                      itemBuilder: (context, index) {
                        Reports reports = _.cancelillDetailedReports![index];
                        return Column(
                          children: [
                            if (index == 0)
                              Row(
                                mainAxisAlignment:
                                    MainAxisAlignment.spaceBetween,
                                children: [
                                  Text('Product name ',
                                      style: EBAppTextStyle.button),
                                  Text('Qty ', style: EBAppTextStyle.button),
                                  Text('Total ', style: EBAppTextStyle.button),
                                ],
                              ),
                            if (index == 0) EBSizeConfig.sizedBoxH10,
                            Row(
                                mainAxisAlignment:
                                    MainAxisAlignment.spaceBetween,
                                children: [
                                  SizedBox(
                                    width: EBSizeConfig.screenWidth * 0.3,
                                    child: Text(
                                        '${EBAppString.productlanguage == 'English' ? reports.productnameEnglish : reports.productnameTamil}',
                                        style: EBAppTextStyle.bodyText),
                                  ),
                                  Text('${reports.quantity}',
                                      style: EBAppTextStyle.bodyText),
                                  Text('${reports.totalquantityamount}',
                                      style: EBAppTextStyle.bodyText),
                                ]),
                          ],
                        );
                      }),
                );
              }),
            ],
          ),
        );
      });
}
