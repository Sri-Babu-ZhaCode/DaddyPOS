// ignore_for_file: no_wildcard_variable_uses

import 'package:easybill_app/app/constants/app_string.dart';
import 'package:easybill_app/app/constants/bools.dart';
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
    return GetBuilder<LoginController>(builder: (_) {
      return Scaffold(
        resizeToAvoidBottomInset: false,
        body: Padding(
          padding: EBSizeConfig.edgeInsetsActivities,
          child: Column(
            children: [
              SizedBox(height: EBSizeConfig.screenHeight * 0.1 / 2),
              AspectRatio(
                aspectRatio: 2.6,
                child: Image.asset(
                  EBAppString.ogDaddyPosImg,
                ),
              ),
              SizedBox(height: EBSizeConfig.screenHeight * 0.1 / 5),
              Text(
                'FAST  AND  EASY  BILLING',
                style: EBAppTextStyle.customeTextStyleWTNR(
                    color: Colors.grey.shade500,
                    fontSize: 16,
                    fontWeigh: FontWeight.w800),
              ),
              SizedBox(height: EBSizeConfig.screenHeight * 0.1 / 8),
              Expanded(
                child: DefaultTabController(
                  length: 2,
                  child: Padding(
                    padding: EBSizeConfig.edgeInsetsActivities,
                    child: Column(
                      children: [
                        TabBar(
                          onTap: (index) {
                            _.tappedIndex = index;
                            _.onTabChanged(index);
                          },
                          controller: _.tabController,
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
                         Expanded(
                          child: Padding(
                            padding: EBSizeConfig.edgeInsetsOnlyH30,
                            child: TabBarView(
                              controller: _.tabController,
                              physics: const NeverScrollableScrollPhysics(),
                              children: const [
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
    return GetBuilder<LoginController>(builder: (_) {
      return Padding(
        padding: EBSizeConfig.edgeInsetsActivities,
        child: Column(
          children: [
            CustomTextFormField(
              controller: _.isStaffTabTapped
                  ? _.staffMobileController
                  : _.mobileController,
              labelText: EBAppString.mobile,
              maxLength: 10,
              keyboardType: TextInputType.phone,
              inputFormatters: <TextInputFormatter>[
                FilteringTextInputFormatter.digitsOnly
              ],
              validator: (value) => _.validateMobile(value!),
            ),
            CustomTextFormField(
              obscureText: _.pwdVisibility,
              controller: _.isStaffTabTapped
                  ? _.staffPwdController
                  : _.pwdController,
              labelText: EBAppString.pass,
              suffixIcon: IconButton(
                icon: Icon(_.pwdVisibility
                    ? Icons.visibility_off_outlined
                    : Icons.visibility_outlined),
                onPressed: () => _.changePwdVisibility(),
              ),
              validator: (value) => _.validateIsEmpty(value!),
            ),
            loginButton(_),
            if (!_.isStaffTabTapped) const LoginOrRegister(),
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
    return GetBuilder<LoginController>(builder: (_) {
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

Widget loginButton(LoginController _) {
  debugPrint('login button build method called ----------------------->>');
  // debugPrint( ' is loading --------------------->>  ${EBBools.isLoading}');

  return Padding(
    padding: EBSizeConfig.edgeInsetsAll20,
    child: CustomElevatedButton(
        minWidth: EBSizeConfig.screenWidthForEle,
        onPressed: () {
          _.loginPressed();
        },
        child: EBBools.isLoading
            ? const LoadingWidget(color: EBTheme.kPrimaryWhiteColor)
            : Text(
                !_.isStaffTabTapped
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
  //         key: _.formKey,
  //         child: Column(
  //           children: [
  //             CustomTextFormField(
  //               _: _.mobileController,
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
  //                 _: _.passwordController,
  //                 labelText: EBAppString.pass,
  //                 validator: (value) => EBValidation.validateIsEmpty(value!)),
  //           ],
  //         ),
  //       ),
  //     ],
  //     confirmButtonText: EBAppString.update,
  //     confirmOnPressed: () {
  //       _.onUpdatePressed();
  //     },
  //     cancelButtonText: EBAppString.cancel,
  //     cancelOnPressed: () {
  //       Get.back();
  //     },
  //   );
  // }

