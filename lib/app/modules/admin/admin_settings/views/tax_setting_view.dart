// import 'package:easybill_app/app/constants/app_string.dart';
// import 'package:easybill_app/app/constants/app_text_style.dart';
// import 'package:easybill_app/app/constants/size_config.dart';
// import 'package:easybill_app/app/constants/themes.dart';
// import 'package:easybill_app/app/widgets/custom_widgets/custom_elevated_button.dart';
// import 'package:easybill_app/app/widgets/custom_widgets/custom_text_form_field.dart';
// import 'package:flutter/material.dart';
// import 'package:get/get.dart';
// import '../../../../widgets/custom_widgets/custom_dropdownbtn.dart';
// import '../../../../widgets/custom_widgets/custom_list_tile.dart';
// import '../controllers/admin_settings_controller.dart';

// class TaxSettingView extends GetView<AdminSettingsController> {
//   const TaxSettingView({super.key});
//   @override
//   Widget build(BuildContext context) {
//     return Scaffold(
//       appBar: AppBar(
//         title: Text(
//           'TaxSettingView',
//           style: EBAppTextStyle.printBtn,
//         ),
//         backgroundColor: EBTheme.kPrimaryColor,
//         centerTitle: true,
//       ),
//       body: Padding(
//         padding: EBSizeConfig.edgeInsetsActivities,
//         child: Column(
//           crossAxisAlignment: CrossAxisAlignment.center,
//           children: [
//             Text(
//               '${EBAppString.add} New Tax',
//               style: EBAppTextStyle.heading2,
//             ),
//             Row(
//               mainAxisAlignment: MainAxisAlignment.spaceBetween,
//               children: [
//                 Expanded(
//                     child: CustomTextFormField(
//                   labelText: EBAppString.tax,
//                   validator: (p0) => '',
//                 )),
//                 Expanded(
//                   child: CustomDropDownFormField<String>(
//                     value: controller.taxList[0],
//                     items: controller.taxList
//                         .map<DropdownMenuItem<String>>(
//                           (element) => DropdownMenuItem<String>(
//                             value: element,
//                             child: Text(element.toString().toUpperCase()),
//                           ),
//                         ) 
//                         .toList(),
//                     onChanged: (value) {
//                       if (value == null) {
//                         return;
//                       }
//                       controller.seletedTax = value;
//                       controller.update();
//                     },
//                   ),
//                 )
//               ],
//             ),
//             const CustomElevatedButton(
//                 onPressed: null, child: Text(EBAppString.add)),
//             EBSizeConfig.dividerTH2,
//             ListView(
//               shrinkWrap: true,
//               children: const [
//                 EBCustomListTile(
//                   titleName: 'CGST',
//                   trailingIcon: Icons.arrow_forward_ios_rounded,
//                 ),
//                 EBCustomListTile(
//                   titleName: 'SGST',
//                   trailingIcon: Icons.arrow_forward_ios_rounded,
//                 ),
//                 EBCustomListTile(
//                   titleName: 'SGST',
//                   trailingIcon: Icons.arrow_forward_ios_rounded,
//                 ),
//               ],
//             )
//           ].expand(
//                 (element) => [
//                   element,
//                   EBSizeConfig.sizedBoxH15,
//                 ],
//               )
//               .toList(),
//         ),
//       ),
//     );
//   }
// }
