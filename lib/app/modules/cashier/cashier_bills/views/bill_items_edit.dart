import 'package:easybill_app/app/data/models/bill_items.dart';
import 'package:easybill_app/app/widgets/custom_widgets/custom_text_form_field.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:get/get.dart';

import '../../../../constants/app_string.dart';
import '../../../../constants/app_text_style.dart';
import '../../../../constants/size_config.dart';
import '../../../../constants/themes.dart';
import '../../../../constants/validation.dart';
import '../../../../widgets/custom_widgets/custom_elevated_button.dart';
import '../../../../widgets/custom_widgets/custom_round_btn.dart';
import '../controllers/cashier_bills_controller.dart';

Future<void> billItemEditorBottomSheet(context, BillItems billItem) {
  return showModalBottomSheet<void>(
    backgroundColor: EBTheme.kPrimaryWhiteColor,
    context: context,
    isScrollControlled: true,
    builder: (BuildContext context) {
      final allowedValues = [0.250, 0.500, 0.700];
      final cashierController = Get.find<CashierBillsController>();
      cashierController.itemNameController.text =
          EBAppString.productlanguage == 'English'
              ? billItem.productNameEnglish!
              : billItem.productnameTamil!;
      cashierController.itemPriceController.text = billItem.price.toString();
      cashierController.itemQuantityController.text =
          billItem.quantity.toString();
      return GetBuilder<CashierBillsController>(builder: (controller) {
        return FractionallySizedBox(
          heightFactor: 0.80,
          child: Padding(
            padding: EBSizeConfig.edgeInsetsAll15,
            child: Column(
              mainAxisAlignment: MainAxisAlignment.end,
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
                  labelText: 'Item Name',
                  readOnly: true,
                  controller: controller.itemNameController,
                ),
                Row(
                  children: [
                    Expanded(
                      flex: 3,
                      child: CustomTextFormField(
                        readOnly: true,
                        controller: controller.itemPriceController,
                        labelText: EBAppString.price,
                      ),
                    ),
                    RoundedButton(
                      icon: Icons.remove,
                      iconColor: Colors.red,
                      bgColor: Colors.red,
                      onPressed: () {
                        double quntityIncremetal = double.parse(
                            controller.itemQuantityController.text);

                        if (quntityIncremetal > 1.0) {
                          quntityIncremetal = quntityIncremetal - 1;
                          controller.itemQuantityController.text =
                              quntityIncremetal.toString();
                          controller.update();
                        }
                      },
                    ),
                    // Adjust spacing between buttons

                    Expanded(
                      child: CustomTextFormField(
                        controller: controller.itemQuantityController,
                        readOnly: billItem.isDecimal == true ? false : true,
                        labelText: EBAppString.quantity,
                        keyboardType: const TextInputType.numberWithOptions(
                            decimal: true),
                        inputFormatters: <TextInputFormatter>[
                          FilteringTextInputFormatter.allow(
                              RegExp(r'^\d*\.?\d*')),
                        ],
                        validator: (value) =>
                            EBValidation.validateDouble(value!, allowedValues),
                      ),
                    ),
                    RoundedButton(
                      icon: Icons.add,
                      iconColor: EBTheme.greenColor,
                      bgColor: EBTheme.greenColor,
                      onPressed: () {
                        double quntityDecremental = double.parse(
                            controller.itemQuantityController.text);

                        quntityDecremental = quntityDecremental + 1;
                        controller.itemQuantityController.text =
                            quntityDecremental.toString();
                        controller.update();
                      },
                    ),
                    EBSizeConfig.sizedBoxH20,
                  ],
                ),
                Text(
                  'Total Price : ${double.parse(controller.itemPriceController.text) * double.parse(controller.itemQuantityController.text)}',
                  style: EBAppTextStyle.heading2,
                ),
                CustomElevatedButton(
                  onPressed: () {
                    controller.updateBillItem(billItem);
                  },
                  child: Text(
                    EBAppString.update,
                    style: EBAppTextStyle.button,
                  ),
                ),
                EBSizeConfig.sizedBoxW10,
                CustomElevatedButton(
                  btnColor: EBTheme.kCancelBtnColor,
                  onPressed: () {
                    controller.deleteBillItem(billItem);
                  },
                  child: Text(
                    EBAppString.delete,
                    style: EBAppTextStyle.button,
                  ),
                ),
                const Spacer(),
              ]
                  .expand(
                    (element) => [
                      element,
                      EBSizeConfig.sizedBoxH15,
                    ],
                  )
                  .toList(),
            ),
          ),
        );
      });
    },
  );
}
