import 'package:easybill_app/app/modules/auth/login/controllers/login_controller.dart';
import 'package:easybill_app/app/modules/auth/subscription/controllers/subscription_controller.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:get/get.dart';
import '../constants/app_string.dart';
import '../constants/validation.dart';
import 'custom_widgets/custom_alert_dialog.dart';
import 'custom_widgets/custom_text_form_field.dart';

class SetPasswordAlertDialog extends StatelessWidget {
  const SetPasswordAlertDialog({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return const Placeholder();
  }

  static Future setPasswordAlertDialof(
      {required Key formKey,
      required String loginMobileNum,
      bool? triggeredFromLogin}) {
    final pwdController = TextEditingController();
    return const CustomAlertDialog().alertDialog(
      formKey: formKey,
      makeUpPopbale: true,
      dialogTitle: 'Create Password',
      dialogContent: 'Please update password',
      formChildren: [
        CustomTextFormField(
          initialValue: loginMobileNum,
          readOnly: true,
          labelText: EBAppString.mobile,
          maxLength: 10,
          keyboardType: TextInputType.phone,
          inputFormatters: <TextInputFormatter>[
            FilteringTextInputFormatter.digitsOnly
          ],
        ),
        // EBSizeConfig.sizedBoxH15,
        CustomTextFormField(
            controller: pwdController,
            labelText: EBAppString.pass,
            validator: (value) => EBValidation.validateIsEmpty(value!)),
      ],
      confirmButtonText: EBAppString.update,
      confirmOnPressed: () {
        triggeredFromLogin == true  
            ? Get.find<LoginController>().loginPressed(pwd:pwdController.text)
            : Get.find<SubscriptionController>().onUpdatePressed(pwdController.text);
      },
      cancelButtonText: EBAppString.cancel,
      cancelOnPressed: () {
        Get.back();
      },
    );
  }
}
