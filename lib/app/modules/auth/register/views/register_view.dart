import 'package:easybill_app/app/constants/validation.dart';
import 'package:easybill_app/app/modules/auth/register/controllers/register_controller.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:get/get.dart';
import '../../../../constants/app_string.dart';
import '../../../../constants/app_text_style.dart';
import '../../../../constants/size_config.dart';
import '../../../../constants/themes.dart';
import '../../../../widgets/custom_widgets/custom_elevated_button.dart';
import '../../../../widgets/custom_widgets/custom_text_form_field.dart';

class RegisterView extends GetView<RegisterController> {
  const RegisterView({super.key});

  @override
  Widget build(BuildContext context) {
    return GetBuilder<RegisterController>(builder: (_) {
      return Scaffold(
        bottomNavigationBar: buildRegisterButton(),
        body: Padding(
          padding: EBSizeConfig.edgeInsetsActivities,
          child: ListView(
            children: [
              EBSizeConfig.sizedBoxH20,
              Row(
                children: [
                  Text(
                    EBAppString.createUser,
                    style: EBAppTextStyle.heading1,
                  ),
                ],
              ),
              EBSizeConfig.sizedBoxH20,
              buildRegForm(context),
            ],
          ),
        ),
      );
    });
  }

  Widget buildRegisterButton() {
    return Container(
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
        child: GetBuilder<RegisterController>(builder: (_) {
          return CustomElevatedButton(
            onPressed: () {
              controller.onRegisterButtonPressed();
            },
            child: Text(
              EBAppString.register,
              style: EBAppTextStyle.button,
            ),
          );
        }),
      ),
    );
  }

  Widget buildRegForm(BuildContext context) {
    return Form(
      key: controller.formKey,
      child: Padding(
        padding: EBSizeConfig.edgeInsetsActivities,
        child: Column(
          children: [
            CustomTextFormField(
              controller: controller.businessController,
              labelText: EBAppString.business,
              validator: (value) => EBValidation.validateIsEmpty(value!),
            ),
            CustomTextFormField(
              controller: controller.addressController,
              labelText: EBAppString.address,
              validator: (value) => EBValidation.validateIsEmpty(value!),
            ),
            CustomTextFormField(
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
              controller: controller.emailController,
              labelText: EBAppString.email,
              validator: (value) => EBValidation.validateEmail(value!),
            ),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 10),
                  child: Text(
                    EBAppString.gstApplication,
                    style: EBAppTextStyle.bodyText,
                  ),
                ),
                Switch(
                  value: controller.isGstApplicable,
                  onChanged: (value) {
                    print(value);
                    controller.isGstApplicable = value;
                    print(controller.isGstApplicable);
                    controller.gstController.clear();
                    controller.update();
                  },
                  activeTrackColor: EBTheme.kPrimaryColor,
                  inactiveTrackColor: EBTheme.kPrimaryWhiteColor,
                  inactiveThumbColor: EBTheme.textFillColor,
                ),
              ],
            ),
            if (controller.isGstApplicable)
              CustomTextFormField(
                controller: controller.gstController,
                labelText: EBAppString.gst,
                maxLength: 15,
                validator: (value) => EBValidation.validateGst(value!),
              )
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
    );
  }
}
