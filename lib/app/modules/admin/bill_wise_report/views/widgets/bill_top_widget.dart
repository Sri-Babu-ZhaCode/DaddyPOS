import 'dart:convert';

import 'package:easybill_app/app/constants/size_config.dart';
import 'package:flutter/material.dart';
import '../../../../../constants/app_text_style.dart';
import '../../../../../constants/themes.dart';
import '../../../../../data/models/setting.dart';
import '../../../../../widgets/custom_widgets/custom_container.dart';
import '../../controllers/bill_wise_report_controller.dart';

Widget billTopWidget(_, Setting billConfig, context) {
  EBSizeConfig.init(context);
  return Flexible(
    fit: FlexFit.loose,
    child: Column(
      mainAxisSize: MainAxisSize.min,
      children: [
       if ( billConfig.logoenable == true && billConfig.businesslogo != null)
          CustomContainer(
            padding: EBSizeConfig.edgeInsetsZero,
            color: EBTheme.kPrimaryWhiteColor,
            height: 90,
            child: Center(
              child: Image.memory(
                base64Decode(billConfig.businesslogo),
                fit: BoxFit.fill,
              ),
            ),
          ),
        Flexible(
            child: Text(billConfig.businessname ?? '-',
                style: EBAppTextStyle.heading2, textAlign: TextAlign.center)),
        Flexible(
          child: Text(billConfig.businessaddress ?? '-',
              style: EBAppTextStyle.heading2, textAlign: TextAlign.center),
        ),
        Flexible(
          child: Text('Ph: ${billConfig.businessmobile ?? '-'}',
              style: EBAppTextStyle.heading2, textAlign: TextAlign.center),
        ),
        if (_ is BillWiseReportController)
          Row(
            mainAxisAlignment: MainAxisAlignment.start,
            children: [
              Flexible(
                child: Text('Bill No:  ${_.billDetailedReports![0].shopbillid}',
                    textAlign: TextAlign.right, style: EBAppTextStyle.heading2),
              ),
            ],
          ),
      ]
          .expand(
            (element) => [
              element,
              EBSizeConfig.sizedBoxH02,
            ],
          )
          .toList(),
    ),
  );
}
