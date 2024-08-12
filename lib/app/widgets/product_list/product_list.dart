import 'package:easybill_app/app/constants/size_config.dart';
import 'package:easybill_app/app/modules/admin/inventory/controllers/inventory_controller.dart';
import 'package:easybill_app/app/routes/app_pages.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import '../../constants/app_string.dart';
import '../../constants/app_text_style.dart';
import '../../data/models/product.dart';
import '../custom_widgets/custom_alert_dialog.dart';
import '../custom_widgets/custom_container.dart';
import '../loading_widget.dart';

class ProductList extends GetView<InventoryController> {
  const ProductList({super.key});

  @override
  Widget build(BuildContext context) {
    return GetBuilder<InventoryController>(builder: (_) {
      if (controller.seachableProductList == null) return const LoadingWidget();
      return ListView.builder(
        itemCount: controller.seachableProductList!.length,
        itemBuilder: (context, index) => GestureDetector(
          onTap: () {
            Get.toNamed(Routes.PRODUCT_MANAGEMENT, arguments: {
              'isEditMode': false,
              'categoryList': controller.categoryList,
              'selectedProduct': controller.seachableProductList![index],
              'unitList': controller.unitList,
              'taxType': controller.taxType,
            });
          },
          child: CustomContainer(
            noHeight: true,
            child: Column(
              children: [
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Flexible(
                      child: Text(
                        // if user change language in settings it will be affected here
                        EBAppString.productlanguage == 'English'
                            ? controller.seachableProductList![index]
                                    .productnameEnglish ??
                                ''
                            : controller.seachableProductList![index]
                                    .productnameTamil ??
                                '',
                        style: EBAppTextStyle.button,
                      ),
                    ),
                    Text(
                      '${controller.seachableProductList![index].shopproductid}',
                      style: EBAppTextStyle.bodyText,
                    ),
                  ],
                ),
                EBSizeConfig.sizedBoxH10,
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    if (controller.seachableProductList![index].categoryid !=
                        null)
                      Text(
                          controller.categoryList!
                              .firstWhere((category) =>
                                  controller.seachableProductList![index]
                                      .categoryid ==
                                  category.categoryid)
                              .categoryname
                              .toString()
                              .toUpperCase(),
                          style: EBAppTextStyle.catStyle)
                    else
                      const Spacer(),
                    Text(
                      'TOKEN : ${controller.seachableProductList![index].istoken! ? 'Yes' : 'No'}',
                      style: EBAppTextStyle.bodyText,
                    ),
                  ],
                ),
                EBSizeConfig.sizedBoxH10,
                Row(
                  mainAxisAlignment: MainAxisAlignment.start,
                  children: [
                    Text(
                      'Rs . ${controller.seachableProductList![index].price}',
                      style: EBAppTextStyle.heading2,
                    ),
                    // IconButton(
                    //   onPressed: () {
                    //     _deleteAlertDialof(
                    //         controller.seachableProductList![index]);
                    //   },
                    //   icon: const Icon(Icons.delete_forever, color: Colors.red),
                    // ),
                  ],
                ),
              ],
            ),
          ),
        ),
      );
    });
  }

  Future _deleteAlertDialof(Product p) {
    return const CustomAlertDialog().alertDialog(
      dialogTitle: 'Delete Product',
      isformChildrenNeeded: true,
      dialogContent: 'Are you sure you want delete this product',
      formKey: key,
      confirmButtonText: EBAppString.delete,
      confirmOnPressed: () => controller.deleteProducts(p),
      cancelButtonText: EBAppString.cancel,
      cancelOnPressed: () {
        Get.back();
      },
    );
  }
}
