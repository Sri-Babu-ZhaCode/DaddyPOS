import 'package:easybill_app/app/widgets/custom_widgets/custom_text_form_field.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import '../../../../constants/app_string.dart';
import '../../../../constants/size_config.dart';
import '../../../../constants/themes.dart';
import '../controllers/cashier_bills_controller.dart';
import 'cashier_bills_view.dart';

Future<void> productSearchSheet(context) {
  return showModalBottomSheet<void>(
    backgroundColor: EBTheme.kPrimaryWhiteColor,
    context: context,
    isScrollControlled: true,
    constraints:  const BoxConstraints(
       maxWidth: double.infinity,
   ),
    builder: (BuildContext context) {
      return GetBuilder<CashierBillsController>(builder: (controller) {
        return FractionallySizedBox(
          heightFactor: 0.80,
          child: Padding(
            padding: EBSizeConfig.edgeInsetsAll15,
            child: Column(
              children: [
                Row(
                  mainAxisAlignment: MainAxisAlignment.end,
                  children: [
                    IconButton(
                      icon: const Icon(
                        Icons.close,
                        size: 30,
                      ), // 'x' icon
                      onPressed: () {
                        Get.back();
                      },
                    ),
                    // You can adjust the alignment or add more widgets here
                  ],
                ),
                EBSizeConfig.sizedBoxH20,
                CustomTextFormField(
                  fillColor: EBTheme.listColor,
                  labelText: EBAppString.search,
                  validator: (value) {
                    return null;
                  },
                  onChanged: (value) {
                    controller.inventoryController.searchList(value);
                    controller.update();
                  },
                  prefixIcon: const Icon(
                    Icons.search,
                    size: 32,
                    color: EBTheme.textFillColor,
                  ),
                ),
                EBSizeConfig.sizedBoxH20,
                const Expanded(
                  child: BillItemListWidget(),
                ),
              ],
            ),
          ),
        );
      });
    },
  );
}
