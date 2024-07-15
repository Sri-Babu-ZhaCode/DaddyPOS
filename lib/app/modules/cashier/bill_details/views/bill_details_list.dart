import 'package:easybill_app/app/modules/cashier/cashier_bills/controllers/cashier_bills_controller.dart';
import 'package:easybill_app/app/widgets/custom_widgets/custom_container.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import '../../../../constants/app_string.dart';
import '../../../../constants/app_text_style.dart';
import '../../../../constants/size_config.dart';
import '../../../../constants/themes.dart';
import '../../cashier_bills/views/bill_items_edit.dart';
import '../controllers/bill_details_controller.dart';

class BillDetailsItemList extends StatelessWidget {
  const BillDetailsItemList({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    EBSizeConfig.init(context);
    return GetBuilder<BillDetailsController>(builder: (controller) {
      return ListView.builder(
        padding: EBSizeConfig.edgeInsetsZero,
        itemCount: controller.billItems!.length,
        itemBuilder: (context, index) => CustomContainer(
          color: EBTheme.kPrimaryWhiteColor,
          padding: EBSizeConfig.edgeInsetsZero,
          margin: EBSizeConfig.edgeInsetsZero,
          height: 90,
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Padding(
                    padding: const EdgeInsets.only(right: 20),
                    child: Text(
                        ' ${Get.find<CashierBillsController>().converDecimalConditionally(controller.billItems![index].quantity!)} X',
                        style: EBAppTextStyle.billItemStyle),
                  ),
                  Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Row(
                        children: [
                          SizedBox(
                            width: EBSizeConfig.screenWidth * 0.4,
                            child: Text(
                              EBAppString.productlanguage == 'English'
                                  ? controller
                                      .billItems![index].productNameEnglish!
                                  : controller
                                      .billItems![index].productnameTamil!,
                              style: EBAppTextStyle.billItemStyle,
                            ),
                          ),
                          IconButton(
                            icon: const Icon(
                              Icons.edit_outlined,
                              size: 18,
                              color: EBTheme.kPrimaryColor,
                            ), // 'x' icon
                            onPressed: () async {
                              // edit bottom sheet
                              controller.cashierBillsController.billItemIndex =
                                  index;
                              // passing qty to edit bottom sheet itemQuantityController
                              controller.cashierBillsController
                                      .itemQuantityController.text =
                                  controller.billItems![index].quantity
                                      .toString();
                              await billItemEditorBottomSheet(
                                  context, controller.billItems![index]);
                              controller.update();
                            },
                          ),
                        ],
                      ),
                      Text(controller.billItems![index].price!.toStringAsFixed(3),
                          style: EBAppTextStyle.billItemStyle),
                    ],
                  ),
                  Text(' + ${controller.billItems![index].totalprice!.toStringAsFixed(3)}',
                      style: EBAppTextStyle.avtiveTxt),
                ],
              ),
              EBSizeConfig.dividerTH2
            ],
          ),
        ),
      );
    });
  }
}
