import 'package:easybill_app/app/constants/validation.dart';
import 'package:easybill_app/app/widgets/custom_widgets/custom_scaffold.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:get/get.dart';

import '../../../../constants/app_string.dart';
import '../../../../constants/app_text_style.dart';
import '../../../../constants/size_config.dart';
import '../../../../constants/themes.dart';
import '../../../../data/models/cashier.dart';
import '../../../../widgets/custom_widgets/custom_alert_dialog.dart';
import '../../../../widgets/custom_widgets/custom_elevated_button.dart';
import '../../../../widgets/custom_widgets/custom_text_form_field.dart';
import '../controllers/cashier_register_controller.dart';

class CashierRegisterView extends GetView<CashierRegisterController> {
  const CashierRegisterView({super.key});
  @override
  Widget build(BuildContext context) {
    EBSizeConfig.init(context);
    return GetBuilder<CashierRegisterController>(builder: (_) {
      return EBCustomScaffold(
        noDrawer: true,
        actionWidget: _.selectedCashier != null
            ? PopupMenuButton<String>(
                elevation: 4.5,
                // icon: const Icon(
                //     Icons.delete_forever,
                //     size: 22,
                //     color: Colors.red),
                offset: const Offset(0, 40),
                color: Colors.red.shade300,
                itemBuilder: (context) => [
                  PopupMenuItem<String>(
                    value: EBAppString.delete,
                    child: Text(
                      EBAppString.delete,
                      style: EBAppTextStyle.heading2,
                    ),
                  ),
                ],
                onSelected: (value) {
                  _deleteAlertDialof(controller.selectedCashier!);
                },
              )
            : null,
        body: SafeArea(
          child: SingleChildScrollView(
            child: Padding(
              padding: EBSizeConfig.edgeInsetsActivities,
              child: Form(
                key: controller.formKey,
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    EBSizeConfig.sizeBoxH(height: EBSizeConfig.screenHeight10),
                    Text(
                      '${EBAppString.create} ${EBAppString.staff}',
                      style: EBAppTextStyle.heading1,
                      textAlign: TextAlign.left,
                    ),
                    CustomTextFormField(
                      readOnly: _.selectedCashier != null ? true : false,
                      controller: controller.mobileController,
                      labelText: EBAppString.mobile,
                      maxLength: 10,
                      keyboardType: TextInputType.phone,
                      inputFormatters: <TextInputFormatter>[
                        FilteringTextInputFormatter.digitsOnly
                      ],
                      validator: (value) => EBValidation.validateMobile(value!),
                    ),
                    CustomTextFormField(
                        readOnly: _.isEditMode,
                        controller: controller.userPasswordController,
                        labelText: EBAppString.userpass,
                        validator: (value) =>
                            EBValidation.validateIsEmpty(value!)),
                    Row(
                      children: [
                        _.isEditMode
                            ? Expanded(
                                child: CustomElevatedButton(
                                    isDefaultWidth: true,
                                    onPressed: () {
                                      _.isEditMode = false;
                                      _.update();
                                    },
                                    child: const Text(EBAppString.edit)),
                              )
                            : Expanded(
                                child: CustomElevatedButton(
                                    isDefaultWidth: true,
                                    onPressed: _.selectedCashier != null
                                        ? _.editCashierPressed
                                        : _.addCashierPressed,
                                    child: Text(EBAppString.save)),
                              ),
                        EBSizeConfig.sizedBoxW15,
                        Expanded(
                          child: CustomElevatedButton(
                            isDefaultWidth: true,
                            btnColor: EBTheme.kCancelBtnColor,
                            onPressed: () {
                              Get.back();
                            },
                            child: const Text(EBAppString.cancel),
                          ),
                        ),
                      ],
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
          ),
        ),
      );
    });
  }

  Future _deleteAlertDialof(Cashier c) {
    return const CustomAlertDialog().alertDialog(
      dialogTitle: 'Delete Product',
      isformChildrenNeeded: true,
      dialogContent: 'Are you sure you want delete this staff',
      formKey: key,
      confirmButtonText: EBAppString.delete,
      confirmOnPressed: () => controller.deleteCashier(c),
      cancelButtonText: EBAppString.cancel,
      cancelOnPressed: () {
        Get.back();
      },
    );
  }
}
