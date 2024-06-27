// import 'package:easybill_app/app/modules/admin/admin_report/controllers/admin_report_controller.dart';
// import 'package:flutter/material.dart';
// import 'package:get/get.dart';
// import '../../../../../constants/app_text_style.dart';
// import '../../../../../constants/size_config.dart';
// import '../../../../../constants/themes.dart';

// Future<void> detailedbillDetailedInfoSheet(context) {
//   return showModalBottomSheet<void>(
//     backgroundColor: EBTheme.kPrimaryWhiteColor,
//     context: context,
//     isScrollControlled: true,
//     constraints: const BoxConstraints(
//       maxWidth: double.infinity,
//     ),
//     builder: (BuildContext context) {
//       return GetBuilder<AdminReportController>(builder: (controller) {
//         return FractionallySizedBox(
//           heightFactor: 0.90,
//           child: Padding(
//             padding: EBSizeConfig.edgeInsetsAll15,
//             child: Column(
//               children: [
//                 Row(
//                   mainAxisAlignment: MainAxisAlignment.end,
//                   children: [
//                     IconButton(
//                       icon: const Icon(
//                         Icons.close,
//                         size: 30,
//                       ), // 'x' icon
//                       onPressed: () {
//                         Get.back();
//                       },
//                     ),
//                     // You can adjust the alignment or add more widgets here
//                   ],
//                 ),
//                 EBSizeConfig.sizedBoxH20,
//                 Expanded(
//                   child: ListView.builder(
//                     padding: EBSizeConfig.textContentPadding,
//                     itemCount: controller.billDetailedInfo.length,
//                     itemBuilder: (context, index) => Row(
//                       mainAxisAlignment: MainAxisAlignment.spaceBetween,
//                       children: [
//                         Text(
//                             '${controller.billDetailedInfo[index].productName} ( ${controller.billDetailedInfo[index].quantity} )',
//                             style: EBAppTextStyle.heading2),
//                         Row(
//                           children: [
//                             Text(
//                                 ' + ${controller.billDetailedInfo[index].totalPrice}',
//                                 style: EBAppTextStyle.avtiveTxt),
//                           ],
//                         )
//                       ],
//                     ),
//                   ),
//                 ),
//               ],
//             ),
//           ),
//         );
//       });
//     },
//   );
// }
