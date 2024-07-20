import 'package:easybill_app/app/modules/admin/bill_wise_report/views/widgets/bill_top_widget.dart';
import 'package:easybill_app/app/modules/cashier/bill_details/views/wigdets/payment_qr.dart';
import 'package:easybill_app/app/modules/cashier/cashier_bills/controllers/cashier_bills_controller.dart';
import 'package:easybill_app/app/widgets/custom_widgets/custom_container.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:upi_payment_qrcode_generator/upi_payment_qrcode_generator.dart';
import '../../../../constants/app_string.dart';
import '../../../../constants/app_text_style.dart';
import '../../../../constants/size_config.dart';
import '../../../../constants/themes.dart';
import '../../../../data/models/bill_items.dart';
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
      return newBillDetailedWidget(
          controller, Get.find<CashierBillsController>());
    });
  }

  Widget oldBillDetails(BillDetailsController controller) {
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
                Text(
                    ' + ${controller.billItems![index].totalprice!.toStringAsFixed(3)}',
                    style: EBAppTextStyle.avtiveTxt),
              ],
            ),
            EBSizeConfig.dividerTH2
          ],
        ),
      ),
    );
  }
}

Widget newBillDetailedWidget(
    BillDetailsController _, CashierBillsController cashierCtrl) {
  return ListView.builder(
    itemCount: _.billItems!.length,
    itemBuilder: (context, index) {
      BillItems billItems = _.billItems![index];
      return Column(
        mainAxisSize: MainAxisSize.min,
        children: [
          // Bill items top names
          if (index == 0) billTopWidget(_, cashierCtrl.billConfig!, context),
          if (index == 0) EBSizeConfig.sizedBoxH15,

          Table(
            // border: const TableBorder.symmetric(
            //     inside: BorderSide(
            //         width: 2, color: Colors.black)),
            // defaultVerticalAlignment:
            //  TableCellVerticalAlignment.middle,
            columnWidths: const {
              0: FlexColumnWidth(0.8),
              1: FlexColumnWidth(5),
              2: FlexColumnWidth(1.5),
              3: FlexColumnWidth(1.5),
              4: FlexColumnWidth(1.8),
              5: FlexColumnWidth(0.8),
            },
            children: [
              if (index == 0)
                TableRow(
                  decoration: const BoxDecoration(
                    border: Border.symmetric(
                      horizontal:
                          BorderSide(width: 1, color: EBTheme.blackColor),
                    ),
                  ),
                  children: [
                    Text('Sr ', style: EBAppTextStyle.button),
                    Text(
                      'Name',
                      style: EBAppTextStyle.button,
                    ),
                    Text('Rate ',
                        style: EBAppTextStyle.button,
                        textAlign: TextAlign.left),
                    Text('Qty ',
                        style: EBAppTextStyle.button,
                        textAlign: TextAlign.left),
                    Text('Amt ',
                        style: EBAppTextStyle.button,
                        textAlign: TextAlign.right),
                    Text('',
                        style: EBAppTextStyle.button,
                        textAlign: TextAlign.right),
                  ],
                ),
              TableRow(
                children: [
                  Text(
                    '${index + 1}.',
                    style: EBAppTextStyle.billItemsText,
                  ),
                  Text(
                      '${EBAppString.productlanguage == 'English' ? billItems.productNameEnglish : billItems.productnameTamil}',
                      style: EBAppTextStyle.billItemsText,
                      textAlign: TextAlign.left),
                  Text('',
                      style: EBAppTextStyle.bodyText,
                      textAlign: TextAlign.left),
                  Text('',
                      style: EBAppTextStyle.billItemsText,
                      textAlign: TextAlign.left),
                  Text('',
                      style: EBAppTextStyle.bodyText,
                      textAlign: TextAlign.left),
                  Text('',
                      style: EBAppTextStyle.bodyText,
                      textAlign: TextAlign.left),
                ],
              ),
              TableRow(
                children: [
                  Text(
                    '',
                    style: EBAppTextStyle.bodyText,
                  ),
                  Text('', style: EBAppTextStyle.bodyText),
                  Text('${billItems.price ?? '-'}',
                      style: EBAppTextStyle.billItemsText,
                      textAlign: TextAlign.left),
                  Text(billItems.quantity!.toStringAsFixed(2),
                      style: EBAppTextStyle.billItemsText,
                      textAlign: TextAlign.left),
                  Text('${billItems.totalprice}',
                      style: EBAppTextStyle.billItemsText,
                      textAlign: TextAlign.right),
                  Align(
                    alignment: AlignmentDirectional.centerEnd,
                    child: GestureDetector(
                      child: const Icon(
                        Icons.edit_outlined,
                        size: 16,
                        color: EBTheme.kPrimaryColor,
                      ),
                      onTap: () async {
                        // edit bottom sheet
                        cashierCtrl.billItemIndex = index;
                        // passing qty to edit bottom sheet itemQuantityController
                        cashierCtrl.itemQuantityController.text =
                            _.billItems![index].quantity.toString();
                        await billItemEditorBottomSheet(
                            context, _.billItems![index]);
                        _.update();
                      },
                    ),
                  ),
                ],
              ),
            ],
          ),
          if (index == _.billItems!.length - 1)
            Table(
              children: [
                TableRow(
                  decoration: const BoxDecoration(
                    border: Border.symmetric(
                      horizontal:
                          BorderSide(width: 1, color: EBTheme.blackColor),
                    ),
                  ),
                  children: [
                    Text('Items: ${_.billItems!.length}',
                        style: EBAppTextStyle.button),
                    Text(
                        'Qty: ${cashierCtrl.billItemsTotalQty.toStringAsFixed(2)}',
                        style: EBAppTextStyle.button,
                        textAlign: TextAlign.left),
                    Text(cashierCtrl.billItemsTotalPrice.toStringAsFixed(2),
                        style: EBAppTextStyle.totalAmt,
                        textAlign: TextAlign.right),
                  ],
                ),
              ],
            ),

          // --------->>  bill bottom messages
          if (index == _.billItems!.length - 1) EBSizeConfig.sizedBoxH50,
          if (index == _.billItems!.length - 1  && cashierCtrl.billConfig?.upienable == true && cashierCtrl.billConfig?.upi != null )
            paymentQrWidget(
                upiID: cashierCtrl.billConfig!.upi!,
                payeeName: cashierCtrl.billConfig?.businessname ?? "-",
                tolalAmt: cashierCtrl.billItemsTotalPrice),
          if (index == _.billItems!.length - 1  && cashierCtrl.billConfig?.upienable == true && cashierCtrl.billConfig?.upi != null ) EBSizeConfig.sizedBoxH50,
          if (index == _.billItems!.length - 1)
            Text(
              cashierCtrl.billItemsTotalPrice.toStringAsFixed(2),
              style: EBAppTextStyle.heading2,
            ),
          if (index == _.billItems!.length - 1)
            Text(
                cashierCtrl.billConfig?.footerenable == true
                    ? cashierCtrl.billConfig?.footer ?? '-'
                    : '',
                style: EBAppTextStyle.heading2),
        ],
      );
    },
  );
}
