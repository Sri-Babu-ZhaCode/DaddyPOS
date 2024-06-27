import 'package:easybill_app/app/modules/admin/admin_profile/controllers/admin_profile_controller.dart';
import 'package:easybill_app/app/widgets/custom_widgets/custom_alert_dialog.dart';
import 'package:get/get.dart';

import '../../../../constants/app_string.dart';
import '../../../../constants/validation.dart';
import '../../../../widgets/custom_widgets/custom_text_form_field.dart';

Future updatePassDialog(AdminProfileController _) {
  _.passwordController.text = '';
  return const CustomAlertDialog().alertDialog(
      formChildren: [
        CustomTextFormField(
          controller: _.passwordController,
          labelText: EBAppString.pass,
          validator: (value) => EBValidation.validateIsEmpty(value!),
        ),
      ],
      dialogTitle: EBAppString.updatePassword,
      dialogContent: 'Update your password here',
      confirmButtonText: EBAppString.update,
      confirmOnPressed: () => _.onUpdatePass(),
      cancelButtonText: EBAppString.cancel,
      cancelOnPressed: () => Get.back());
}
