import 'package:easybill_app/app/constants/app_text_style.dart';
import 'package:easybill_app/app/constants/themes.dart';
import 'package:easybill_app/app/modules/admin/admin_profile/views/update_pass_dialog.dart';
import 'package:easybill_app/app/widgets/custom_widgets/custom_container.dart';
import 'package:easybill_app/app/widgets/custom_widgets/custom_scaffold.dart';
import 'package:easybill_app/app/widgets/loading_widget.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import '../../../../constants/app_string.dart';
import '../../../../constants/bools.dart';
import '../../../../constants/size_config.dart';
import '../../../../constants/validation.dart';
import '../../../../widgets/custom_widgets/custom_elevated_button.dart';
import '../../../../widgets/custom_widgets/custom_list_tile.dart';
import '../../../../widgets/custom_widgets/custom_text_form_field.dart';
import '../controllers/admin_profile_controller.dart';

class AdminProfileView extends GetView<AdminProfileController> {
  const AdminProfileView({super.key});
  @override
  Widget build(BuildContext context) {
    return EBCustomScaffold(
      actionWidget: IconButton(
          icon: const Icon(
            Icons.edit,
            size: 20,
            color: EBTheme.listColor,
          ),
          onPressed: () {
            controller.readOnly = false;
            controller.update();
          }),
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
          child: GetBuilder<AdminProfileController>(builder: (_) {
            return CustomElevatedButton(
              onPressed: _.readOnly ? null : _.onEditProfile,
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
          padding: EBSizeConfig.edgeInsetsOnlyH70,
          children: [
            Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Flexible(
                  child: Text(
                    "Edit Profile",
                    overflow: TextOverflow.ellipsis,
                    style: EBAppTextStyle.heading1,
                  ),
                )
              ],
            ),
            GetBuilder<AdminProfileController>(builder: (_) {
              if (EBBools.isLoading) return const LoadingWidget();
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
                        CustomTextFormField(
                          readOnly: _.readOnly,
                          controller: _.businessController,
                          labelText: EBAppString.business,
                          validator: (value) =>
                              EBValidation.validateIsEmpty(value!),
                        ),
                        CustomTextFormField(
                          readOnly: _.readOnly,
                          controller: _.addressController,
                          labelText: EBAppString.address,
                          validator: (value) =>
                              EBValidation.validateIsEmpty(value!),
                        ),
                        CustomTextFormField(
                          readOnly: true,
                          controller: _.mobilController,
                          labelText: EBAppString.mobile,
                        ),
                        if (_.gstFlag)
                          CustomTextFormField(
                            readOnly: true,
                            controller: _.gstController,
                            labelText: EBAppString.gst,
                          ),
                        CustomTextFormField(
                          readOnly: _.readOnly,
                          controller: _.emailController,
                          labelText: EBAppString.email,
                          validator: (value) =>
                              EBValidation.validateEmail(value!),
                        ),
                        gstWidget(_),
                        EBCustomListTile(
                          trailingIconSize: 20,
                          titleName: EBAppString.updatePassword,
                          trailingIcon: Icons.edit,
                          onTap: () async {
                            await updatePassDialog(_);
                          },
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

  Widget gstWidget(AdminProfileController _) {
    return Visibility(
      visible: !_.gstFlag,
      child: Column(
        children: [
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
                onChanged: _.readOnly
                    ? null
                    : (value) {
                        controller.isGstApplicable = value;
                        controller.gstController.clear();
                        controller.update();
                      },
                activeTrackColor: EBTheme.kPrimaryColor,
                inactiveTrackColor: EBTheme.kPrimaryWhiteColor,
                inactiveThumbColor: EBTheme.textFillColor,
              ),
            ],
          ),
          if (_.isGstApplicable)
            CustomTextFormField(
              readOnly: _.readOnly,
              controller: _.gstController,
              labelText: EBAppString.gst,
              maxLength: 15,
              validator: (value) => EBValidation.validateGst(value!),
            )
        ],
      ),
    );
  }
}
