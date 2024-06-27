// import 'package:easybill_app/app/constants/app_text_style.dart';
// import 'package:easybill_app/app/data/models/product.dart';
// import 'package:easybill_app/app/modules/admin/inventory/controllers/inventory_controller.dart';
// import 'package:easybill_app/app/routes/app_pages.dart';
// import 'package:easybill_app/app/widgets/loading_widget.dart';
// import 'package:flutter/material.dart';
// import 'package:get/get.dart';
// import '../../constants/app_string.dart';
// import '../../constants/size_config.dart';
// import '../../constants/themes.dart';
// import '../custom_widgets/custom_text_button.dart';

// class AddCategoryList extends GetView<InventoryController> {
//   const AddCategoryList({super.key});

//   @override
//   Widget build(BuildContext context) {
//     return GetBuilder<InventoryController>(builder: (_) {
//       if (controller.categoryList == null &&
//           controller.unitList == null &&
//           controller.taxType == null) return const LoadingWidget();
//       return ListView.builder(
//         itemCount: controller.categoryList!.length,
//         itemBuilder: (
//           BuildContext context,
//           int index,
//         ) =>
//             ExpansionTile(
//           title: Text(
//             controller.categoryList![index].categoryname ?? '',
//             style: EBAppTextStyle.bodyText,
//           ),
//           trailing: Row(
//             mainAxisSize: MainAxisSize.min,
//             children: [
//               controller.isProductPresent(
//                       controller.categoryList![index].categoryid)
//                   ? IconButton(
//                       onPressed: () {
//                         editCategory(index);
//                       },
//                       icon:
//                           const Icon(Icons.edit, color: EBTheme.kPrimaryColor))
//                   : IconButton(
//                       onPressed: () {},
//                       icon: const Icon(Icons.delete_forever, color: Colors.red),
//                     ),
//               const Icon(
//                   Icons.expand_more), // Default expansion tile arrow-down icon
//             ],
//           ),
//           children: <Widget>[
//             ListView.builder(
//               shrinkWrap: true,
//               padding: EBSizeConfig.textContentPadding,
//               itemCount: controller
//                   .categoryProductsList(
//                       controller.categoryList![index].categoryid!)!
//                   .length,
//               itemBuilder: (context, productIndex) {
//                 Product p = controller.categoryProductsList(
//                     controller.categoryList![index].categoryid!)![productIndex];
//                 return Column(
//                   children: [
//                     Row(
//                       mainAxisAlignment: MainAxisAlignment.spaceBetween,
//                       children: [Text(p.productnameEnglish!), Text(p.price!)],
//                     ),
//                     EBSizeConfig.dividerTH2,
//                   ],
//                 );
//               },
//             ),
//             CustomTextButton(
//               name: EBAppString.createNew,
//               onPressed: () {
//                 print('Create New botton called --------------- >>');
//                 print('${[controller.taxType]}');
//                 if (controller.taxType != null && controller.unitList != null) {
//                   print('${[controller.taxType]}');
//                   return;
//                 }
//                 Get.toNamed(Routes.PRODUCT_MANAGEMENT, arguments: {
//                   "selectedCategory": controller.categoryList![index],
//                   "categoryList": controller.categoryList,
//                   "isEditMode": true,
//                   "triggeredFromCategory": true,
//                   'unitList': controller.unitList,
//                   'taxType': controller.taxType,
//                 });
//               },
//               textColor: EBTheme.kPrimaryOrange,
//             ),
//           ],
//         ),
//       );
//     });
//   }

//   editCategory(int index) {
//     // controller.isCategoryEdited.value = true;
//     // controller.categoryController.value.text =
//     //     controller.categoryList![index].categoryname;
//     // controller.getCatIdByCatName(controller.categoryList![index].categoryname);
//     // return CategoryTab().showAlertDialog();
//   }
// }
