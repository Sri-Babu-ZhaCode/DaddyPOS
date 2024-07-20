import 'package:easybill_app/app/widgets/custom_widgets/custom_toast.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import '../../../../constants/app_string.dart';
import '../../../../constants/app_text_style.dart';
import '../../../../constants/size_config.dart';
import '../../../../constants/themes.dart';
import '../../../../data/models/product.dart';
import '../../../../widgets/custom_widgets/custom_container.dart';
import '../../../../widgets/custom_widgets/custom_elevated_button.dart';
import '../../cashier_bills/controllers/cashier_bills_controller.dart';
import '../../cashier_bills/views/bill_calculator_button_widget.dart';
import '../../cashier_bills/views/bill_calculator_widget.dart';
import '../controllers/qunatity_bill_calculator_controller.dart';

class QunatityBillCalculatorView
    extends GetView<QunatityBillCalculatorController> {
  const QunatityBillCalculatorView({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      resizeToAvoidBottomInset: false,
      body: Center(
        child: quantityBillCalculatorWidget(controller.selectedProduct),
      ),
    );
  }
}

Widget quantityBillCalculatorWidget(Product product) {
  return SafeArea(
    child: GetBuilder<CashierBillsController>(builder: (controller) {
      return Padding(
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
            Expanded(
              child: CustomContainer(
                color: EBTheme.kPrimaryWhiteColor,
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Text(
                      EBAppString.productlanguage == 'English'?
                      product.productnameEnglish ?? '-' : product.productnameTamil ?? '-',
                      style: EBAppTextStyle.heading2,
                    ),
                    Expanded(
                      child: Text(
                        'Enter quantity',
                        style: EBAppTextStyle.bodyText,
                      ),
                    ),
                  ],
                ),
              ),
            ),
            Expanded(
              child: CustomContainer(
                padding: EBSizeConfig.edgeInsetsAll10,
                // alignment: Alignment.bottomRight,
                color: EBTheme.kPrimaryWhiteColor,
                child: Row(
                  //crossAxisAlignment: CrossAxisAlignment.end,
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Expanded(
                      child: Text(
                        controller.productQuantity.isEmpty
                            ? '-'
                            : controller.productQuantity,
                        style: EBAppTextStyle.heading1,
                      ),
                    ),
                    IconButton(
                      icon: const Icon(Icons.backspace),
                      onPressed: () {
                        if (controller.productQuantity.isNotEmpty) {
                          controller.productQuantity =
                              controller.productQuantity.substring(
                                  0, controller.productQuantity.length - 1);
                          controller.update();
                        }
                      },
                    ),
                  ],
                ),
              ),
            ),

            // Quantiy Calulater
            QuantityCalulater(p: product),
            EBSizeConfig.sizedBoxH20,
            CustomElevatedButton(
                minWidth: double.infinity,
                onPressed: controller.productQuantity.isNotEmpty &&
                        double.parse(controller.productQuantity) >= 0.1
                    ? () {
                        controller.nextPressed(product);
                        Get.back();
                      }
                    : null,
                child: const Text(EBAppString.next))
          ],
        ),
      );
    }),
  );
}

class QuantityCalulater extends GetView<CashierBillsController> {
  final Product? p;
  const QuantityCalulater({
    this.p,
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return GetBuilder<CashierBillsController>(builder: (controller) {
      return BillCalculatorWidget(
        crossAxisCount: 3,
        itemCount: controller.quantityButtons.length,
        itemBuilder: (BuildContext context, int index) {
          if (controller.quantityButtons[index] is String) {
            if (p?.isDecimalAllowed == false && index == 9) {
              return const CalculatorButton(
                btnText: '',
                onButtonPressed: null,
              );
            }
          }
          return CalculatorButton(
            btnText: controller.quantityButtons[index],
            onButtonPressed: () {
              try {
                controller.productQuantity = controller.productQuantity +
                    controller.quantityButtons[index];
                double.parse(controller.productQuantity);
                 controller.update();
              } catch (e) {
                print('erroe occured ----->> $e');
                controller.productQuantity = '';
                ebCustomTtoastMsg(message: 'Enter valid Quantity');
              } 
            },
          );
          // } else {
          //   return CalculatorButton(
          //    btnIcon: controller.quantityButtons[index],
          //);
          // }
        },
      );
    });
  }
}
