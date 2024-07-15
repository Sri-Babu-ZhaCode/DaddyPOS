import 'package:easybill_app/app/constants/app_text_style.dart';
import 'package:easybill_app/app/constants/size_config.dart';
import 'package:easybill_app/app/constants/themes.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

import 'custom_elevated_button.dart';

class CustomAlertDialog {
  const CustomAlertDialog({
    this.dialogTitle,
    this.dialogContent,
    this.key,
    this.formChild,
    this.formChildren,
    this.confirmBtTxt,
    this.confirmOnPressed,
    this.cancelBtTxt,
    this.cancelOnPressed,
  });

  final Key? key;
  final Widget? formChild;
  final String? dialogTitle;
  final String? dialogContent;
  final String? confirmBtTxt;
  final String? cancelBtTxt;
  final VoidCallback? confirmOnPressed;
  final VoidCallback? cancelOnPressed;
  final List<Widget>? formChildren;

  Future<dynamic> alertDialog({
    required String? dialogTitle,
    required String? dialogContent,
    Key? formKey,
    List<Widget>? formChildren,
    //  WillPopCallback? onWillPop,
    required String confirmButtonText,
    required VoidCallback? confirmOnPressed,
    required String cancelButtonText,
    required VoidCallback? cancelOnPressed,
    Color? confimBtnColor,
    bool? makeUpPopbale = false,
    bool isformChildrenNeeded = false,
  }) async {
    isformChildrenNeeded
        ? Get.defaultDialog(
            //  onWillPop: onWillPop,
            backgroundColor: EBTheme.kPrimaryWhiteColor,
            barrierDismissible: makeUpPopbale!,
            title: dialogTitle ?? "",

            content: Padding(
              padding: EBSizeConfig.edgeInsetsActivities,
              child: Form(
                key: formKey,
                child: Column(
                  mainAxisSize: MainAxisSize.min,
                  children: [
                    if (dialogContent != null)
                      Text(
                        dialogContent,
                        style: EBAppTextStyle.txtStyle,
                      ),
                  ]
                      .expand(
                        (element) => [
                          element,
                          EBSizeConfig.sizedBoxH15,
                        ],
                      )
                      .toList(),
                ),
              ),
            ),
            actions: [
              CustomElevatedButton(
                btnColor: confimBtnColor,
                isDefaultWidth: true,
                onPressed: confirmOnPressed,
                child: Text(
                  confirmButtonText,
                  style: EBAppTextStyle.button,
                ),
              ),
              CustomElevatedButton(
                isDefaultWidth: true,
                onPressed: cancelOnPressed,
                child: Text(
                  cancelButtonText,
                  style: EBAppTextStyle.button,
                ),
              )
            ],
          )
        : Get.defaultDialog(
            barrierDismissible: makeUpPopbale!,
            title: dialogTitle ?? "",
            content: Padding(
              padding: EBSizeConfig.edgeInsetsActivities,
              child: Form(
                key: formKey,
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    if (dialogContent != null)
                      Text(
                        dialogContent,
                        style: EBAppTextStyle.bodyText,
                      ),
                    ...formChildren!
                  ]
                      .expand(
                        (element) => [
                          element,
                          EBSizeConfig.sizedBoxH15,
                        ],
                      )
                      .toList(),
                ),
              ),
            ),
            actions: [
              CustomElevatedButton(
                isDefaultWidth: true,
                onPressed: confirmOnPressed,
                child: Text(
                  confirmButtonText,
                  style: EBAppTextStyle.button,
                ),
              ),
              CustomElevatedButton(
                isDefaultWidth: true,
                onPressed: cancelOnPressed,
                child: Text(
                  cancelButtonText,
                  style: EBAppTextStyle.button,
                ),
              )
            ],
          );
  }
}
