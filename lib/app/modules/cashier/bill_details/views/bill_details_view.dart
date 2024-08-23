import 'package:easybill_app/app/constants/themes.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

import '../../../../constants/app_string.dart';
import '../../../../constants/app_text_style.dart';
import '../../../../constants/size_config.dart';
import '../../../../widgets/custom_widgets/custom_alert_dialog.dart';
import '../../../../widgets/custom_widgets/custom_container.dart';
import '../../../../widgets/custom_widgets/custom_scaffold.dart';
import '../../cashier_bills/views/bill_calculator_widget.dart';
import '../controllers/bill_details_controller.dart';
import 'bill_details_list.dart';

class BillDetailsView extends GetView<BillDetailsController> {
  const BillDetailsView({super.key});
  final bool canPop = false;
  @override
  Widget build(BuildContext context) {
    EBSizeConfig.init(context);
    return PopScope(
      canPop: false,
      onPopInvoked: (didPop) async {
        if (didPop) return;
        await deleteAlertDialog();
      },
      child: GetBuilder<BillDetailsController>(builder: (controller) {
        return EBCustomScaffold(
          noDrawer: true,
          body: Padding(
            padding: EBSizeConfig.edgeInsetsActivities,
            child: ListView(
              shrinkWrap: true,
              // mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                SizedBox(
                    height: EBSizeConfig.screenHeight * 0.8,
                    child: const BillDetailsItemList()),
                EBSizeConfig.dividerTH2,
                SizedBox(
                  height: EBSizeConfig.screenHeight * 0.1 / 1.3,
                  child: BillCalculatorWidget(
                    crossAxisCount: 3,
                    itemCount: controller.paymentMode.length,
                    itemBuilder: (context, index) => GestureDetector(
                      onTap: () async {
                        // final maduraiText = await ThermalPrinterSdk().textToImg(
                        //         TextToImageArgs(
                        //             text: "மதுரை",
                        //             textSize: 36,
                        //             interfaceType: "BOLD",
                        //             alignment: "CENTER")) ??
                        //     "";
                        // ThermalPrinterSdk().printUsb(PrinterTemplateSettings(
                        //     template: "template",
                        //     printerDpi: 200,
                        //     printerWidth: 72,
                        //     nbrCharPerLine: 48));

                        // ThermalPrinterSdk().print(PrinterTemplateSettings(
                        //     deviceAddress: "DC:0D:30:23:0E:00",
                        //     template: "template",
                        //     printerDpi: 200,
                        //     printerWidth: 72,
                        //     nbrCharPerLine: 48));

                        controller.currentIndex = index;
                        controller.update();
                        controller.addBillInfo();
                      },
                      child: CustomContainer(
                        height: 55,
                        borderColor: controller.currentIndex == index
                            ? EBTheme.kPrimaryColor
                            : Colors.transparent,
                        child: Center(
                          child: Text(
                            controller.paymentMode[index].toUpperCase(),
                            style: EBAppTextStyle.button,
                          ),
                        ),
                      ),
                    ),
                  ),
                ),

                // ListView(
                //   shrinkWrap: true,
                //   children: [
                //     Row(
                //       mainAxisAlignment: MainAxisAlignment.spaceBetween,
                //       children: [
                //         CustomTextButton(
                //           name: EBAppString.cancelOrder,
                //           onPressed: () {
                //             deleteAlertDialog();
                //           },
                //           padding: EBSizeConfig.edgeInsetsZero,
                //           textColor: Colors.red,
                //         ),
                //         Text(
                //           'Amount : Rs ${controller.cashierBillsController.totalPrice}',
                //           style: EBAppTextStyle.billItemStyle,
                //         )
                //       ],
                //     ),
                //     Row(
                //       mainAxisAlignment: MainAxisAlignment.start,
                //       children: [
                //         Text(
                //           'Item Count : ${controller.cashierBillsController.billItems.length}',
                //           style: EBAppTextStyle.billItemStyle,
                //         ),
                //       ],
                //     ),
                //     Text(
                //       'Total Amount : Rs ${controller.cashierBillsController.totalPrice}',
                //       style: EBAppTextStyle.heading2,
                //     ),
                //     BillCalculatorWidget(
                //       crossAxisCount: 3,
                //       itemCount: controller.paymentMode.length,
                //       itemBuilder: (context, index) => GestureDetector(
                //         onTap: () {
                //           controller.currentIndex = index;
                //           controller.update();
                //           controller.addBillInfo();
                //         },
                //         child: CustomContainer(
                //           height: 60,
                //           borderColor: controller.currentIndex == index
                //               ? EBTheme.kPrimaryColor
                //               : Colors.transparent,
                //           child: Center(
                //             child: Text(
                //               controller.paymentMode[index].toUpperCase(),
                //               style: EBAppTextStyle.button,
                //             ),
                //           ),
                //         ),
                //       ),
                //     ),
                //     // FractionallySizedBox(
                //     //   widthFactor: 0.50,
                //     //   child: CustomElevatedButton(
                //     //     onPressed: () {
                //     //       controller.addBillInfo();
                //     //     },
                //     //     child: Text(
                //     //       EBAppString.print,
                //     //       style: EBAppTextStyle.printBtn,
                //     //     ),
                //     //   ),
                //     // ),
                //   ]
                //       .expand(
                //         (element) => [
                //           element,
                //           EBSizeConfig.sizedBoxH15,
                //         ],
                //       )
                //       .toList(),
                // )
              ],
            ),
          ),
        );
      }),
    );
  }

  Future deleteAlertDialog() {
    return const CustomAlertDialog().alertDialog(
      dialogTitle: 'Delete Bill',
      confimBtnColor: EBTheme.redColor,
      isformChildrenNeeded: true,
      dialogContent: 'Are you sure you want delete this Bill items',
      formKey: key,
      confirmButtonText: EBAppString.allClear,
      confirmOnPressed: () {
        controller.cashierCtrl.cancelOrderPressed();
        Get.close(2);
      },
      cancelButtonText: EBAppString.cancel,
      cancelOnPressed: () {
        Get.back();
      },
    );
  }
}
