// ignore_for_file: sized_box_for_whitespace

import 'package:flutter/material.dart';
import '../constants/app_string.dart';
import '../constants/app_text_style.dart';
import '../constants/size_config.dart';
import '../constants/themes.dart';

//RegisterLogo

class RegisterLogo extends StatelessWidget {
  const RegisterLogo({super.key});

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: EBSizeConfig.edgeInsetsActivities,
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.center,
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Text(
            EBAppString.businessLogo,
            style: EBAppTextStyle.heading2,
          ),
          Container(
            height: EBSizeConfig.logoHeight,
            width: EBSizeConfig.logoWidth,
            decoration: const BoxDecoration(
              color: EBTheme.textFillColor,
            ),
          ),
          Container(
            height: EBSizeConfig.logoHeight,
            width: EBSizeConfig.logoWidth,
          ),
        ],
      ),
    );
  }
}

// Invoice Box

class InvoiceBox extends StatelessWidget {
  const InvoiceBox({super.key});

  @override
  Widget build(context) {
    EBSizeConfig.init(context);
    return Container(
      height: EBSizeConfig.screenHeight10,
      width: double.infinity,
      decoration: BoxDecoration(
        color: EBTheme.textFillColor,
        border: Border.all(
          color: EBTheme.kPrimaryColor,
          width: 1.5,
        ),
        borderRadius: EBSizeConfig.borderRadiusCircular10,
      ),
      child: Padding(
        padding: EBSizeConfig.edgeInsetsActivities,
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(EBAppString.invoicePrefix, style: EBAppTextStyle.bodyText),
            EBSizeConfig.sizedBoxH10,
            Text(EBAppString.invoiceNumber, style: EBAppTextStyle.bodyText),
          ],
        ),
      ),
    );
  }
}

// no category message widget

Widget msgForNoCategories() {
  return Center(
    child: Text(
      'Add your first cartegory',
      style: EBAppTextStyle.bodyText,
    ),
  );
}
