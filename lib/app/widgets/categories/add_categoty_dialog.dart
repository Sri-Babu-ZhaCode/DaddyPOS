// import 'package:flutter/material.dart';
// import 'package:get/get.dart';
// import '../../../../controller/admin_controller/tab_view_controller/tab1_controller.dart';
// import '../../../utils/constants/colors.dart';
// import '../../../utils/constants/sizes.dart';
// import '../../../utils/constants/strings.dart';
// import '../../../utils/constants/text_styles.dart';
// import '../../../utils/validators/form_validators.dart';
// import '../custom_widgets/custom_elevated_button.dart';
// import '../custom_widgets/custom_text_form_field.dart';

// Future addCategoryDialog() {
//   final tab1Controller = Get.find<Tab1Controller>();

//   return Get.defaultDialog(
//       title: EBAppString.addCategory,
//       content: Padding(
//         padding: AppSize.edgeInsetsActivities,
//         child: Form(
//           key: tab1Controller.formKey,
//           child: Column(
//             crossAxisAlignment: CrossAxisAlignment.start,
//             children: [
//               Text(
//                 'Enter Category name',
//                 style: EBAppTextStyle.bodyText,
//               ),
//               AppSize.sizedBoxH20,
//               CustomTextFormField(
//                 controller: tab1Controller.categoryController.value,
//                 labelText: EBAppString.addCategory,
//                 fillColor: EBTheme.textFillColor,
//                 validator: (value) => Formvalidateors.validateCategory(value!),
//               ),
//             ],
//           ),
//         ),
//       ),
//       actions: [
//         Padding(
//           padding: AppSize.edgeInsetsOnlyW30,
//           child: CustomElevatedButton(
//             onPressed: () {
//               tab1Controller.saveIems();
//               print(
//                   '--------------->>  ${tab1Controller.categoryController.value.text}');
//               if (tab1Controller.isValid) {
//                 tab1Controller
//                     .addCategory(tab1Controller.categoryController.value.text);
//                 tab1Controller.resetForm();
//                 print(
//                     '--------------->>  ${tab1Controller.categoryController.value.text}');
//                 Get.back();
//               }
//               return;
//             },
//             child: Text(
//               EBAppString.add,
//               style: EBAppTextStyle.button,
//             ),
//           ),
//         ),
//         Padding(
//           padding: AppSize.edgeInsetsOnlyW30,
//           child: CustomElevatedButton(
//             onPressed: () {
//               Get.back();
//               tab1Controller.resetForm();
//             },
//             child: Text(
//               EBAppString.cancel,
//               style: EBAppTextStyle.button,
//             ),
//           ),
//         ),
//       ]);
// }
