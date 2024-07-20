import 'package:easybill_app/app/constants/app_string.dart';
import 'package:easybill_app/app/constants/bools.dart';
import 'package:easybill_app/app/constants/validation.dart';
import 'package:easybill_app/app/routes/app_pages.dart';
import 'package:easybill_app/app/widgets/loading_widget.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:get/get.dart';
import '../../../../constants/app_text_style.dart';
import '../../../../constants/size_config.dart';
import '../../../../constants/themes.dart';
import '../../../../widgets/custom_widgets/custom_elevated_button.dart';
import '../../../../widgets/custom_widgets/custom_text_button.dart';
import '../../../../widgets/custom_widgets/custom_text_form_field.dart';
import '../controllers/login_controller.dart';

class LoginView2 extends GetView<LoginController> {
  const LoginView2({super.key});
  @override
  Widget build(BuildContext context) {
    EBSizeConfig.init(context);
    return GetBuilder<LoginController>(builder: (controller) {
      return Scaffold(
        resizeToAvoidBottomInset: false,
        body: Padding(
          padding: EBSizeConfig.edgeInsetsActivities,
          child: Column(
            children: [
              SizedBox(height: EBSizeConfig.screenHeight * 0.2),
              Expanded(
                child: DefaultTabController(
                  length: 2,
                  child: Padding(
                    padding: EBSizeConfig.edgeInsetsActivities,
                    child: Column(
                      children: [
                        TabBar(
                          onTap: (index) {
                            controller.tappedIndex = index;
                            controller.onTabChanged(index);
                          },
                          overlayColor: WidgetStatePropertyAll(
                              EBTheme.kPrimaryLightColor),
                          labelColor: EBTheme.kPrimaryColor,
                          indicatorSize: TabBarIndicatorSize.tab,
                          indicatorColor: EBTheme.kPrimaryColor,
                          tabs: [EBAppString.login, EBAppString.staffLogin]
                              .map((e) => Tab(
                                    child: Text(
                                      e,
                                      overflow: TextOverflow.ellipsis,
                                      style: EBAppTextStyle.heading2,
                                    ),
                                  ))
                              .toList(),
                        ),
                        const Expanded(
                          child: Padding(
                            padding: EBSizeConfig.edgeInsetsOnlyH30,
                            child: TabBarView(
                              physics: NeverScrollableScrollPhysics(),
                              children: [
                                LoginForm(),
                                LoginForm(),
                              ],
                            ),
                          ),
                        ),
                      ],
                    ),
                  ),
                ),
              ),
            ],
          ),
        ),
      );
    });
  }
}

// Login Form

class LoginForm extends StatelessWidget {
  const LoginForm({super.key});

  @override
  Widget build(BuildContext context) {
    return GetBuilder<LoginController>(builder: (controller) {
      return Padding(
        padding: EBSizeConfig.edgeInsetsActivities,
        child: Column(
          children: <Widget>[
            CustomTextFormField(
              controller: controller.isStaffTabTapped
                  ? controller.staffMobileController
                  : controller.mobileController,
              labelText: EBAppString.mobile,
              maxLength: 10,
              keyboardType: TextInputType.phone,
              inputFormatters: <TextInputFormatter>[
                FilteringTextInputFormatter.digitsOnly
              ],
              validator: (value) => controller.validateMobile(value!),
            ),
            CustomTextFormField(
              obscureText: controller.pwdVisibility,
              controller: controller.isStaffTabTapped
                  ? controller.staffPwdController
                  : controller.pwdController,
              labelText: EBAppString.pass,
              suffixIcon: IconButton(
                icon: Icon(controller.pwdVisibility
                    ? Icons.visibility_off_outlined
                    : Icons.visibility_outlined),
                onPressed: () => controller.changePwdVisibility(),
              ),
              validator: (value) => controller.validateIsEmpty(value!),
            ),
            loginButton(controller),
            if (!controller.isStaffTabTapped) const LoginOrRegister(),
          ]
              .expand(
                (element) => [
                  element,
                  EBSizeConfig.sizedBoxH15,
                ],
              )
              .toList(),
        ),
      );
    });
  }
}

//  Login OR Register Text

class LoginOrRegister extends StatelessWidget {
  const LoginOrRegister({super.key});

  @override
  Widget build(BuildContext context) {
    return GetBuilder<LoginController>(builder: (controller) {
      return Column(children: [
        Text(
          "or",
          style: EBAppTextStyle.heading2,
        ),
        Row(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Text(
              'If you are new ',
              style: EBAppTextStyle.bodyText,
            ),
            CustomTextButton(
              name: EBAppString.register,
              padding: EBSizeConfig.edgeInsetsZero,
              onPressed: () => Get.toNamed(Routes.REGISTER),
              textColor: EBTheme.blue,
            ),
          ],
        ),
      ]);
    });
  }
}

// Login Button

Widget loginButton(LoginController controller) {
  debugPrint('login button build method called ----------------------->>');
 // debugPrint( ' is loading --------------------->>  ${EBBools.isLoading}');

  return Padding(
    padding: EBSizeConfig.edgeInsetsAll20,
    child: CustomElevatedButton(
        minWidth: EBSizeConfig.screenWidthForEle,
        onPressed: () {
          controller.loginPressed();
        },
        child: EBBools.isLoading
            ? const LoadingWidget(color: EBTheme.kPrimaryWhiteColor)
            : Text(
                !controller.isStaffTabTapped
                    ? EBAppString.login
                    : EBAppString.staffLogin,
                style: EBAppTextStyle.button,
              )),
  );
}
  
  //  Future setPasswordAlertDialof() {
  //   final
  //   return const CustomAlertDialog().alertDialog(
  //     key: key,
  //     makeUpPopbale: true,
  //     dialogTitle: 'Create Password',
  //     dialogContent: 'Please update password',
  //     formChildren: [
  //       Form(
  //         key: controller.formKey,
  //         child: Column(
  //           children: [
  //             CustomTextFormField(
  //               controller: controller.mobileController,
  //               readOnly: true,
  //               labelText: EBAppString.mobile,
  //               maxLength: 10,
  //               keyboardType: TextInputType.phone,
  //               inputFormatters: <TextInputFormatter>[
  //                 FilteringTextInputFormatter.digitsOnly
  //               ],
  //             ),
  //             EBSizeConfig.sizedBoxH15,
  //             CustomTextFormField(
  //                 controller: controller.passwordController,
  //                 labelText: EBAppString.pass,
  //                 validator: (value) => EBValidation.validateIsEmpty(value!)),
  //           ],
  //         ),
  //       ),
  //     ],
  //     confirmButtonText: EBAppString.update,
  //     confirmOnPressed: () {
  //       controller.onUpdatePressed();
  //     },
  //     cancelButtonText: EBAppString.cancel,
  //     cancelOnPressed: () {
  //       Get.back();
  //     },
  //   );
  // }

