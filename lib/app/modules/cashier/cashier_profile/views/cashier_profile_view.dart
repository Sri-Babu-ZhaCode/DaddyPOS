import 'package:flutter/material.dart';

import 'package:get/get.dart';

import '../../../../constants/app_string.dart';
import '../../../../constants/app_text_style.dart';
import '../../../../constants/size_config.dart';
import '../../../../constants/themes.dart';
import '../../../../constants/validation.dart';
import '../../../../widgets/custom_widgets/custom_container.dart';
import '../../../../widgets/custom_widgets/custom_elevated_button.dart';
import '../../../../widgets/custom_widgets/custom_list_tile.dart';
import '../../../../widgets/custom_widgets/custom_scaffold.dart';
import '../../../../widgets/custom_widgets/custom_text_form_field.dart';
import '../controllers/cashier_profile_controller.dart';

class CashierProfileView extends GetView<CashierProfileController> {
  const CashierProfileView({super.key});
  @override
  Widget build(BuildContext context) {
    return EBCustomScaffold(
      bottomSheet: Container(
        height: 85,
        decoration: const BoxDecoration(
          color: Colors.white,
          boxShadow: [
            BoxShadow(
              color: Color.fromRGBO(58, 57, 57, 1),
              offset: Offset(0.0, 1.0), //(x,y)
              blurRadius: 6.0,
            ),
          ],
        ),
        child: Padding(
          padding: EBSizeConfig.edgeInsetsAll20,
          child: GetBuilder<CashierProfileController>(builder: (_) {
            return CustomElevatedButton(
              onPressed: null,
              child: Text(
                EBAppString.update,
                style: EBAppTextStyle.button,
              ),
            );
          }),
        ),
      ),
      body: Padding(
        padding: EBSizeConfig.edgeInsetsActivities,
        child: ListView(
          children: [
            const Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                CircleAvatar(
                  backgroundColor: EBTheme.listColor,
                  maxRadius: 60,
                  backgroundImage: AssetImage("assets/icons/profile.png"),
                ),
              ],
            ),
            Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Flexible(
                  child: Text(
                    "Zha Code",
                    overflow: TextOverflow.ellipsis,
                    style: EBAppTextStyle.heading1,
                  ),
                )
              ],
            ),
            GetBuilder<CashierProfileController>(builder: (_) {
              return Form(
                //   key: _.formKey,
                child: Padding(
                  padding: EBSizeConfig.edgeInsetsActivities,
                  child: CustomContainer(
                    noHeight: true,
                    borderWidth: 2,
                    padding: EBSizeConfig.edgeInsetsAll20,
                    color: EBTheme.kPrimaryWhiteColor,
                    borderColor: EBTheme.silverColor,
                    child: Column(
                      children: [
                        const EBCustomListTile(
                          trailingIconSize: 20,
                          titleName: EBAppString.edit,
                          trailingIcon: Icons.edit,
                        ),
                        CustomTextFormField(
                          controller: _.loginUserName,
                          labelText: EBAppString.loginUserName,
                          validator: (value) =>
                              EBValidation.validateIsEmpty(value!),
                        ),
                        CustomTextFormField(
                          controller: _.username,
                          labelText: EBAppString.userName,
                          validator: (value) =>
                              EBValidation.validateIsEmpty(value!),
                        ),
                        CustomTextFormField(
                          controller: _.passwordController,
                          labelText: EBAppString.pass,
                          validator: (value) =>
                              EBValidation.validateEmail(value!),
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
              );
            }),
          ],
        ),
      ),
    );
  }
}
