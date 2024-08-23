import 'package:easybill_app/app/constants/app_text_style.dart';
import 'package:easybill_app/app/data/models/category.dart';
import 'package:easybill_app/app/data/models/product.dart';
import 'package:easybill_app/app/modules/admin/inventory/controllers/inventory_controller.dart';
import 'package:easybill_app/app/modules/admin/inventory/views/category_tab.dart';
import 'package:easybill_app/app/routes/app_pages.dart';
import 'package:easybill_app/app/widgets/custom_widgets/custom_container.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

import '../../constants/app_string.dart';
import '../../constants/size_config.dart';
import '../../constants/themes.dart';
import '../custom_widgets/custom_alert_dialog.dart';
import '../custom_widgets/custom_text_button.dart';
import '../loading_widget.dart';

class CategoryList extends GetView<InventoryController> {
  const CategoryList({super.key});

  @override
  Widget build(BuildContext context) {
    // controller.categoryList == null
    //     ? const LoadingWidget()
    //     : controller.update();
    return GetBuilder<InventoryController>(builder: (_) {
      return controller.categoryList == null
          ? const LoadingWidget()
          : CustomContainer(
            noHeight: true,
              color: EBTheme.listColor,
              child: ListView.builder(
                itemCount: controller.categoryList!.length,
                itemBuilder: (
                  BuildContext context,
                  int index,
                ) =>
                    Column(
                  children: [
                    ExpansionTile(
                      title: Text(
                        overflow: TextOverflow.ellipsis,
                        maxLines: 1,
                        controller.categoryList![index].categoryname == null
                            ? ''
                            : controller.categoryList![index].categoryname!
                                .toUpperCase(),
                        style: EBAppTextStyle.bodyText,
                      ),
                      trailing: Row(
                        mainAxisSize: MainAxisSize.min,
                        children: [
                          controller.isProductPresent(
                                  controller.categoryList![index].categoryid)
                              ? IconButton(
                                  onPressed: controller
                                              .categoryList![index].isdefault ==
                                          true
                                      ? null
                                      : () {
                                          const CategoryTab().addCategoryDialog(
                                              controller.categoryList![index]);
                                        },
                                  icon: Icon(
                                      controller.categoryList![index]
                                                  .isdefault ==
                                              true
                                          ? null
                                          : Icons.edit,
                                      color: EBTheme.kPrimaryColor))
                              : IconButton(
                                  onPressed: controller
                                              .categoryList![index].isdefault ==
                                          true
                                      ? null
                                      : () {
                                          _deleteAlertDialog(
                                              controller.categoryList![index]);
                                        },
                                  icon: Icon(
                                      controller.categoryList![index]
                                                  .isdefault ==
                                              true
                                          ? null
                                          : Icons.delete_forever,
                                      color: Colors.red),
                                ),
                          const Icon(Icons
                              .expand_more), // Default expansion tile arrow-down icon
                        ],
                      ),
                      children: [
                        ListView.builder(
                          physics: const NeverScrollableScrollPhysics(),
                          shrinkWrap: true,
                          padding: EBSizeConfig.textContentPadding,
                          itemCount: controller
                              .categoryProductsList(
                                  controller.categoryList![index].categoryid!)!
                              .length,
                          itemBuilder: (context, productIndex) {
                            Product p = controller.categoryProductsList(
                                controller.categoryList![index]
                                    .categoryid!)![productIndex];
                            return Column(
                              children: [
                                Row(
                                  mainAxisAlignment:
                                      MainAxisAlignment.spaceBetween,
                                  children: [
                                    Flexible(
                                      child: Text(
                                        EBAppString.productlanguage == 'English'
                                            ? p.productnameEnglish!
                                            : p.productnameTamil!,
                                        style: EBAppTextStyle.bodyText,
                                      ),
                                    ),
                                    Flexible(
                                        child: Text(
                                      p.price!,
                                      style: EBAppTextStyle.catStyle,
                                    ))
                                  ],
                                ),
                                EBSizeConfig.dividerTH2,
                              ],
                            );
                          },
                        ),
                        CustomTextButton(
                          name: EBAppString.createNew,
                          onPressed: () {
                            Get.toNamed(Routes.PRODUCT_MANAGEMENT, arguments: {
                              "selectedCategory":
                                  controller.categoryList![index],
                              "categoryList": controller.categoryList,
                              "isEditMode": true,
                              "triggeredFromCategory": true,
                              'unitList': controller.unitList,
                              'taxType': controller.taxType,
                            });
                          },
                          textColor: EBTheme.kPrimaryOrange,
                        ),
                      ],
                    ),
                  ],
                ),
              ),
            );
    });
  }

  Future _deleteAlertDialog(Category c) {
    return const CustomAlertDialog().alertDialog(
      dialogTitle: 'Delete Category',
      isformChildrenNeeded: true,
      dialogContent: 'Are you sure you want delete this category',
      formKey: key,
      confirmButtonText: 'Delete',
      confirmOnPressed: () {
        controller.deleteCategory(c);
      },
      cancelButtonText: 'Cancel',
      cancelOnPressed: () {
        Get.back();
      },
    );
  }
}
