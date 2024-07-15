import 'package:flutter/material.dart';
import 'package:get/get.dart';
import '../../../../../../constants/app_string.dart';
import '../../../../../../constants/app_text_style.dart';
import '../../../../../../constants/size_config.dart';
import '../../../controllers/cashier_bills_controller.dart';
import '../../bill_items_edit.dart';

Widget tabBillItemsWidget(context) {
  EBSizeConfig.init(context);
  return GetBuilder<CashierBillsController>(builder: (controller) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Padding(
          padding: const EdgeInsets.only(right: 6),
          child: Text(
            controller.shopproductid,
            style: EBAppTextStyle.billQty,
          ),
        ),
        SizedBox(
          height: EBSizeConfig.screenWidth > 900
              ? EBSizeConfig.screenHeight * 0.15
              : EBSizeConfig.screenWidth > 572
                  ? EBSizeConfig.screenHeight * 0.25
                  : EBSizeConfig.screenHeight * 0.19,
          child: ListView.builder(
            padding: EBSizeConfig.textContentPadding,
            itemCount: controller.billItems.length,
            itemBuilder: (context, index) => Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Flexible(
                  child: Text(
                      '${EBAppString.productlanguage == 'English' ? controller.billItems[index].productNameEnglish : controller.billItems[index].productnameTamil} ( ${controller.converDecimalConditionally(controller.billItems[index].quantity!)} )',
                      style: EBAppTextStyle.billItemStyle),
                ),
                Row(
                  children: [
                    Text(' + ${controller.billItems[index].totalprice!.toStringAsFixed(3)}',
                        style: EBAppTextStyle.avtiveTxt),
                    IconButton(
                      icon: const Icon(
                        Icons.edit_outlined,
                        size: 16,
                      ), // 'x' icon
                      onPressed: () {
                        // edit bottom sheet
                        controller.billItemIndex = index;

                        controller.itemQuantityController.text =
                            controller.billItems[index].quantity.toString();
                        billItemEditorBottomSheet(
                            context, controller.billItems[index]);
                      },
                    ),
                  ],
                )
              ],
            ),
          ),
        ),
      ],
    );
  });
}
