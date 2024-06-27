// import 'package:easybill_app/app/constants/app_string.dart';
// import 'package:easybill_app/app/constants/validation.dart';
// import 'package:easybill_app/app/routes/app_pages.dart';
// import 'package:flutter/material.dart';
// import 'package:flutter/services.dart';
// import 'package:get/get.dart';
// import '../../../../constants/app_text_style.dart';
// import '../../../../constants/size_config.dart';
// import '../../../../constants/themes.dart';
// import '../../../../widgets/custom_widgets/custom_elevated_button.dart';
// import '../../../../widgets/custom_widgets/custom_text_button.dart';
// import '../../../../widgets/custom_widgets/custom_text_form_field.dart';
// import '../controllers/login_controller.dart';



// class LoginView extends GetView<LoginController> {
//   const LoginView({super.key});
//   @override
//   Widget build(BuildContext context) {
//     EBSizeConfig.init(context);
//     return GetBuilder<LoginController>(builder: (controller) {
//       return Scaffold(
//         body: SingleChildScrollView(
//           child: Padding(
//             padding: EBSizeConfig.edgeInsetsActivities,
//             child:  Column(
//               crossAxisAlignment: CrossAxisAlignment.start,
//               children: [
//                 EBSizeConfig.sizeBoxH(height: EBSizeConfig.screenHeight6),
//                 Text(
//                   EBAppString.login,
//                   style: EBAppTextStyle.heading1,
//                 ),
//                 Text(
//                   "Please sign in to continue",
//                   style: EBAppTextStyle.txtStyle,
//                 ),
//                 const Padding(
//                   padding: EBSizeConfig.edgeInsetsOnlyW04,
//                   child: Column(
//                     crossAxisAlignment: CrossAxisAlignment.center,
//                     children: [
//                       EBSizeConfig.sizedBoxH20,
//                       LoginForm(),
//                       LoginButton(),
//                       LoginOrRegister(),
//                     ],
//                   ),
//                 ),
//               ],
//             ),
//           ),
//         ),
//       );
//     });
//   }
// }

// // Login Form

// class LoginForm extends StatelessWidget {
//   const LoginForm({super.key});

//   @override
//   Widget build(BuildContext context) {
//     return GetBuilder<LoginController>(builder: (controller) {
//       return Form(
//         key: controller.formKey,
//         child: Padding(
//           padding: EBSizeConfig.edgeInsetsActivities,
//           child: Column(
//             children: [
//               CustomTextFormField(
//                 controller: controller.mobileController,
//                 labelText: EBAppString.mobile,
//                 maxLength: 10,
//                 keyboardType: TextInputType.phone,
//                 inputFormatters: <TextInputFormatter>[
//                   FilteringTextInputFormatter.digitsOnly
//                 ],
//                 validator: (value) => EBValidation.validateMobile(value!),
//               ),
//               CustomTextFormField(
//                 controller: controller.pwdController,
//                 labelText: EBAppString.pass,
//                 suffixIcon: IconButton(
//                   icon: const Icon(Icons.visibility_outlined),
//                   onPressed: () => "",
//                 ),
//                 validator: (value) => EBValidation.validateIsEmpty(value!),
//               ),
//             ]
//                 .expand(
//                   (element) => [
//                     element,
//                     EBSizeConfig.sizedBoxH15,
//                   ],
//                 )
//                 .toList(),
//           ),
//         ),
//       );
//     });
//   }
// }




// //  Login OR Register Text

// class LoginOrRegister extends StatelessWidget {
//   const LoginOrRegister({super.key});

//   @override
//   Widget build(BuildContext context) {
//     return GetBuilder<LoginController>(builder: (controller) {
//       return Column(children: [
//         Text(
//           "or",
//           style: EBAppTextStyle.heading2,
//         ),
//         Row(
//           mainAxisAlignment: MainAxisAlignment.center,
//           children: [
//             Text(
//               'If you are new ',
//               style: EBAppTextStyle.bodyText,
//             ),
//             CustomTextButton(
//               name: EBAppString.register,
//               padding: EBSizeConfig.edgeInsetsZero,
//               onPressed: () => Get.toNamed(Routes.REGISTER),
//               textColor: EBTheme.blue,
//             ),
//           ],
//         ),
//         CustomTextButton(
//           name: 'Staff Login',
//           padding: EBSizeConfig.edgeInsetsZero,
//           onPressed: () {
//             Get.offNamed(Routes.STAFF_LOGIN);
//             // Get.toNamed(Routes.INVENTORY, arguments: {
//             //   'triggeredFromStaff': true,
//             // });
//           },
//           textColor: EBTheme.blue,
//         ),
//       ]);
//     });
//   }
// }

// // Login Button
// class LoginButton extends StatelessWidget {
//   const LoginButton({
//     super.key,
//   });

//   @override
//   Widget build(BuildContext context) {
//     EBSizeConfig.init(context);
//     return GetBuilder<LoginController>(builder: (controller) {
//       return Padding(
//         padding: EBSizeConfig.edgeInsetsAll20,
//         child: CustomElevatedButton(
//           minWidth: EBSizeConfig.screenWidthForEle,
//           onPressed: controller.loginPressed,

//           //  controller.summit == true
//           //     ? () {
//           //         controller.summit = false;
//           //         controller.adminLogin();
//           //         controller.formKey.currentState!.save();
//           //         controller.formKey.currentState!.reset();
//           //         controller.update();
//           //       }
//           //     : null,
//           child: Text(
//             EBAppString.login,
//             style: EBAppTextStyle.button,
//           ),
//         ),
//       );
//     });
//   }
//   //  Future setPasswordAlertDialof() {
//   //   final 
//   //   return const CustomAlertDialog().alertDialog(
//   //     key: key,
//   //     makeUpPopbale: true,
//   //     dialogTitle: 'Create Password',
//   //     dialogContent: 'Please update password',
//   //     formChildren: [
//   //       Form(
//   //         key: controller.formKey,
//   //         child: Column(
//   //           children: [
//   //             CustomTextFormField(
//   //               controller: controller.mobileController,
//   //               readOnly: true,
//   //               labelText: EBAppString.mobile,
//   //               maxLength: 10,
//   //               keyboardType: TextInputType.phone,
//   //               inputFormatters: <TextInputFormatter>[
//   //                 FilteringTextInputFormatter.digitsOnly
//   //               ],
//   //             ),
//   //             EBSizeConfig.sizedBoxH15,
//   //             CustomTextFormField(
//   //                 controller: controller.passwordController,
//   //                 labelText: EBAppString.pass,
//   //                 validator: (value) => EBValidation.validateIsEmpty(value!)),
//   //           ],
//   //         ),
//   //       ),
//   //     ],
//   //     confirmButtonText: EBAppString.update,
//   //     confirmOnPressed: () {
//   //       controller.onUpdatePressed();
//   //     },
//   //     cancelButtonText: EBAppString.cancel,
//   //     cancelOnPressed: () {
//   //       Get.back();
//   //     },
//   //   );
//   // }
// }
