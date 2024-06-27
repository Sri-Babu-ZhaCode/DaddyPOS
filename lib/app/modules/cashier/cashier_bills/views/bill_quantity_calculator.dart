// import 'package:easybill_app/app/modules/cashier/cashier_bills/controllers/cashier_bills_controller.dart';
// import 'package:flutter/material.dart';
// import 'package:get/get.dart';

// import '../../../../constants/app_string.dart';
// import '../../../../constants/app_text_style.dart';
// import '../../../../constants/size_config.dart';
// import '../../../../constants/themes.dart';
// import '../../../../data/models/product.dart';
// import '../../../../widgets/custom_widgets/custom_container.dart';
// import '../../../../widgets/custom_widgets/custom_elevated_button.dart';

// Future<void> quantityBillCalculatorBottomSheet(context, Product p) {
//   return showModalBottomSheet<void>(
//     context: context,
//     isScrollControlled: true,
//     constraints: const BoxConstraints(
//       maxWidth: double.infinity,
//     ),
//     builder: (BuildContext context) {
//       return GetBuilder<CashierBillsController>(builder: (controller) {
//         return Padding(
//           padding: EBSizeConfig.edgeInsetsAll15,
//           child: Column(
//             mainAxisAlignment: MainAxisAlignment.end,
//             children: [
//               EBSizeConfig.sizedBoxH20,
//               Row(
//                 children: [
//                   IconButton(
//                     icon: const Icon(
//                       Icons.close,
//                       size: 30,
//                     ), // 'x' icon
//                     onPressed: () {
//                       Get.back();
//                     },
//                   ),
//                   // You can adjust the alignment or add more widgets here
//                 ],
//               ),
//               Expanded(
//                 child: CustomContainer(
//                   color: EBTheme.kPrimaryWhiteColor,
//                   child: Column(
//                     crossAxisAlignment: CrossAxisAlignment.start,
//                     mainAxisAlignment: MainAxisAlignment.spaceBetween,
//                     children: [
//                       Text(
//                         p.productnameEnglish!,
//                         style: EBAppTextStyle.heading2,
//                       ),
//                       Expanded(
//                         child: Text(
//                           'Enter quantity',
//                           style: EBAppTextStyle.bodyText,
//                         ),
//                       ),
//                     ],
//                   ),
//                 ),
//               ),
//               Expanded(
//                 child: CustomContainer(
//                   padding: EBSizeConfig.edgeInsetsAll10,
//                   // alignment: Alignment.bottomRight,
//                   color: EBTheme.kPrimaryWhiteColor,
//                   child: Row(
//                     //crossAxisAlignment: CrossAxisAlignment.end,
//                     mainAxisAlignment: MainAxisAlignment.spaceBetween,
//                     children: [
//                       Expanded(
//                         child: Text(
//                           controller.productQuantity.isEmpty
//                               ? '0'
//                               : controller.productQuantity,
//                           style: EBAppTextStyle.heading1,
//                         ),
//                       ),
//                       IconButton(
//                         icon: const Icon(Icons.backspace),
//                         onPressed: () {
//                           if (controller.productQuantity.isNotEmpty) {
//                             controller.productQuantity =
//                                 controller.productQuantity.substring(
//                                     0, controller.productQuantity.length - 1);
//                             controller.update();
//                           }
//                         },
//                       ),
//                     ],
//                   ),
//                 ),
//               ),

//               // Quantiy Calulater
//               const QuantityCalulater(),
//               EBSizeConfig.sizedBoxH20,
//               CustomElevatedButton(
//                   minWidth: double.infinity,
//                   onPressed: controller.productQuantity.isNotEmpty &&
//                           double.parse(controller.productQuantity) >= 1
//                       ? () {
//                           controller.nextPressed(p);
//                         }
//                       : null,
//                   child: const Text(EBAppString.next))
//             ],
//           ),
//         );
//       });
//     },
//   );
// }



