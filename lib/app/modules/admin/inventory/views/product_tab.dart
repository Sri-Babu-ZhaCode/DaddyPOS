import 'package:easybill_app/app/constants/app_string.dart';
import 'package:easybill_app/app/constants/app_text_style.dart';
import 'package:easybill_app/app/constants/size_config.dart';
import 'package:easybill_app/app/constants/themes.dart';
import 'package:easybill_app/app/data/models/category.dart';
import 'package:easybill_app/app/modules/admin/inventory/controllers/inventory_controller.dart';
import 'package:easybill_app/app/routes/app_pages.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

import '../../../../widgets/custom_widgets/custom_elevated_icon_button.dart';
import '../../../../widgets/custom_widgets/custom_text_form_field.dart';
import '../../../../widgets/product_list/product_list.dart';

class ProductTab extends GetView<InventoryController> {
  const ProductTab({super.key});

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        Row(
          mainAxisAlignment: MainAxisAlignment.end,
          children: [
            CustomElevatedIconButton(
              onPressed: () {
                debugPrint('Add product bottn tapped ------------->> ');
                debugPrint('${controller.unitList}');
                Get.toNamed(Routes.PRODUCT_MANAGEMENT, arguments: {
                  'isEditMode': true,
                  'categoryList': controller.categoryList,
                  'unitList': controller.unitList,
                  'taxType': controller.taxType,
                });
              },
              label: Text(
                EBAppString.addProduct,
                style: EBAppTextStyle.button,
              ),
            ),
          ],
        ),
        Expanded(
          child: GetBuilder<InventoryController>(builder: (_) {
            return Column(
              children: [
                Row(
                  children: [
                    Expanded(
                      child: CustomTextFormField(
                        controller: _.searchController,
                        labelText: EBAppString.search,
                        validator: (value) {
                          return null;
                        },
                        onChanged: (value) => _.searchList(value),
                        prefixIcon: const Icon(
                          Icons.search,
                          size: 32,
                          color: EBTheme.textFillColor,
                        ),
                      ),
                    ),
                    PopupMenuButton<Category>(
                      padding: EBSizeConfig.alertDialogContentPadding,
                      elevation: 4.5,
                      offset: const Offset(0, 50),
                      icon: const Icon(
                        Icons.filter_list,
                        size: 36,
                      ),
                      itemBuilder: (context) {
                        return controller.filterableCategoryList!
                            .map<PopupMenuItem<Category>>(
                                (element) => PopupMenuItem<Category>(
                                      value: element,
                                      child: Text(
                                        element.categoryname!.toUpperCase(),
                                        style: EBAppTextStyle.bodyText,
                                      ),
                                    ))
                            .toList();
                      },
                      onSelected: (value) {
                        controller.searchController.clear();
                        controller.filterProdutListByCatId(value.categoryid!);
                      },
                      
                      
                    ),
                  ],
                ),
                controller.seachableProductList==null || controller.seachableProductList!.isEmpty
                    ? msgForNoProductList()
                    : const Expanded(
                        child: ProductList(),
                      ),
              ],
            );
          }),
        )
      ],
    );
  }
}

Widget msgForNoProductList() {
  return Center(
    child: Text(
      'Add your first Product',
      style: EBAppTextStyle.bodyText,
    ),
  );
}
