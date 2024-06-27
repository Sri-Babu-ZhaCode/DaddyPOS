import 'package:easybill_app/app/constants/app_string.dart';
import 'package:easybill_app/app/constants/app_text_style.dart';
import 'package:easybill_app/app/constants/size_config.dart';
import 'package:easybill_app/app/data/models/category.dart';
import 'package:easybill_app/app/modules/admin/inventory/controllers/inventory_controller.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import '../../../../widgets/categories/category_list.dart';
import '../../../../widgets/custom_widgets/custom_alert_dialog.dart';
import '../../../../widgets/custom_widgets/custom_elevated_icon_button.dart';
import '../../../../widgets/custom_widgets/custom_text_form_field.dart';

class CategoryTab extends GetView<InventoryController> {
  const CategoryTab({super.key});
  Future<dynamic> addCategoryDialog(Category? category) {
    // if category is present in initialize
    category != null
        ? controller.categoryController.text = category.categoryname! 
        : controller.categoryController.text = "";

    return const CustomAlertDialog().alertDialog(
        dialogTitle: EBAppString.addCategory,
        dialogContent: 'Enter Category name',
        formKey: Get.find<InventoryController>().formKey,
        formChildren: [
          GetBuilder<InventoryController>(builder: (_) {
            return CustomTextFormField(
              controller: controller.categoryController,
              labelText: EBAppString.addCategory,
              validator: (value) => controller.validateCategory(value!),
            );
          }),
        ],
        confirmButtonText:
            category != null ? EBAppString.edit : EBAppString.add,
        confirmOnPressed: () {
          category != null
              ? controller.editPressed(category)
              : controller.addPressed();
        },
        cancelButtonText: EBAppString.cancel,
        cancelOnPressed: () {
          Get.back();
        });
  }

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        Row(
          mainAxisAlignment: MainAxisAlignment.end,
          children: [
            CustomElevatedIconButton(
              onPressed: () {
                addCategoryDialog(null);
              },
              label: Text(
                EBAppString.addCategory,
                style: EBAppTextStyle.button,
              ),
            ),
          ],
        ),
        EBSizeConfig.sizedBoxH10,
        // controller.categoryList == null
        //     ? msgForNoCategories()
        //     :
        const Expanded(
          child: CategoryList(),
        ),
      ],
    );
  }

  Widget msgForNoCategories() {
    return Center(
      child: Text(
        'Add your first cartegory',
        style: EBAppTextStyle.bodyText,
      ),
    );
  }
}
