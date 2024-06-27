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
    return GetBuilder<BillDetailsController>(builder: (controller) {
      return ListView.builder(
        shrinkWrap: true,
        padding: EBSizeConfig.alertDialogContentPadding,
        itemCount: controller.billItems!.length,
        itemBuilder: (context, index) => Column(
          children: [
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Padding(
                  padding: const EdgeInsets.only(right: 20),
                  child: Text(' ${controller.billItems![index].quantity} X',
                      style: EBAppTextStyle.billItemStyle),
                ),
                Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Row(
                      children: [
                        Text(
                            EBAppString.productlanguage == 'English'
                                ? controller
                                    .billItems![index].productNameEnglish!
                                : controller
                                    .billItems![index].productnameTamil!,
                            style: EBAppTextStyle.billItemStyle),
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
                            await billItemEditorBottomSheet(
                                context, controller.billItems![index]);
                            controller.update();
                          },
                        ),
                      ],
                    ),
                    Text('${controller.billItems![index].price}',
                        style: EBAppTextStyle.billItemStyle),
                  ],
                ),
                const Spacer(),
                Text(' + ${controller.billItems![index].totalprice}',
                    style: EBAppTextStyle.avtiveTxt),
              ],
            ),
            EBSizeConfig.dividerTH2
          ],
        ),
      );
    });
  }
}
