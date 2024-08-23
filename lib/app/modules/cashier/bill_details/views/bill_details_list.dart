// ignore_for_file: no_wildcard_variable_uses, prefer_const_constructors

import 'package:easybill_app/app/modules/admin/bill_wise_report/views/widgets/bill_top_widget.dart';
import 'package:easybill_app/app/modules/cashier/bill_details/views/wigdets/payment_qr.dart';
import 'package:easybill_app/app/modules/cashier/cashier_bills/controllers/cashier_bills_controller.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
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
      return billDetailedWidget(controller, Get.find<CashierBillsController>());
    });
  }
}

Widget billDetailedWidget(
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
              0: FlexColumnWidth(0.7),
              1: FlexColumnWidth(5),
              2: FlexColumnWidth(1.5),
              3: FlexColumnWidth(1.5),
              4: FlexColumnWidth(2.1),
              5: FlexColumnWidth(0.8),
            },
            children: [
              if (index == 0)
                const TableRow(
                  decoration: BoxDecoration(
                    border: Border.symmetric(
                      horizontal:
                          BorderSide(width: 1, color: EBTheme.blackColor),
                    ),
                  ),
                  children: [
                    Text('Sr', style: EBAppTextStyle.billItemsText),
                    Text(
                      'Name',
                      style: EBAppTextStyle.billItemsText,
                    ),
                    Text('Rate',
                        style: EBAppTextStyle.billItemsText,
                        textAlign: TextAlign.left),
                    Text('Qty',
                        style: EBAppTextStyle.billItemsText,
                        textAlign: TextAlign.left),
                    Text('Amount',
                        style: EBAppTextStyle.billItemsText,
                        textAlign: TextAlign.right),
                    Text('',
                        style: EBAppTextStyle.billItemsText,
                        textAlign: TextAlign.right),
                  ],
                ),
            ],
          ),

          Table(
            columnWidths: const {
              0: FlexColumnWidth(2),
              1: FlexColumnWidth(26),
              // 2: FlexColumnWidth(0),
              //3: FlexColumnWidth(0),
              //4: FlexColumnWidth(0),
            },
            children: [
              TableRow(
                children: [
                  Text(
                    '${index + 1}',
                    style: EBAppTextStyle.billItemsText,
                  ),
                  Text(
                      '${EBAppString.productlanguage == 'English' ? billItems.productNameEnglish : billItems.productnameTamil}',
                      style: EBAppTextStyle.billItemsText,
                      textAlign: TextAlign.left),
                  const Text('',
                      style: EBAppTextStyle.billItemsText,
                      textAlign: TextAlign.left),
                  const Text('',
                      style: EBAppTextStyle.billItemsText,
                      textAlign: TextAlign.left),
                  const Text('',
                      style: EBAppTextStyle.billItemsText,
                      textAlign: TextAlign.left),
                  const Text('',
                      style: EBAppTextStyle.billItemsText,
                      textAlign: TextAlign.left),
                ],
              ),
            ],
          ),

          Table(
            columnWidths: const {
              0: FlexColumnWidth(0.6),
              1: FlexColumnWidth(5),
              2: FlexColumnWidth(1.5),
              3: FlexColumnWidth(1.5),
              4: FlexColumnWidth(2.1),
              5: FlexColumnWidth(0.8),
            },
            children: [
              TableRow(
                children: [
                  const Text(
                    '',
                    style: EBAppTextStyle.billItemsText,
                  ),
                  const Text('', style: EBAppTextStyle.billItemsText),
                  Text('${billItems.price ?? '-'}',
                      style: EBAppTextStyle.billItemsText,
                      textAlign: TextAlign.left),
                  Text(billItems.quantity!.toStringAsFixed(2),
                      style: EBAppTextStyle.billItemsText,
                      textAlign: TextAlign.left),
                  Text('${(billItems.price ?? 0) * (billItems.quantity ?? 0)}',
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
                            context, _.billItems![index], _.billItems);
                        // _.groupBillItemsByTaxPercentage(_.billItems!);
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
                        style: EBAppTextStyle.billItemsText),
                    Text(
                        'Qty: ${cashierCtrl.billItemsTotalQty.toStringAsFixed(2)}',
                        style: EBAppTextStyle.billItemsText,
                        textAlign: TextAlign.left),
                    Text(cashierCtrl.billItemsTotalPrice.toStringAsFixed(2),
                        style: EBAppTextStyle.billItemsText,
                        textAlign: TextAlign.right),
                  ],
                ),
              ],
            ),
          if (index == _.billItems!.length - 1 &&
              cashierCtrl.billConfig?.gstenable == true)
            Table(
              columnWidths: const {
                0: FlexColumnWidth(1),
                1: FlexColumnWidth(1.1),
                2: FlexColumnWidth(1),
                3: FlexColumnWidth(1),
                4: FlexColumnWidth(1),
                5: FlexColumnWidth(1),
              },
              children: const [
                TableRow(
                  decoration: BoxDecoration(
                    border: BorderDirectional(
                      bottom: BorderSide(width: 1, color: EBTheme.blackColor),
                    ),
                  ),
                  children: [
                    Text(
                      'GST %',
                      style: EBAppTextStyle.billItemsText,
                    ),
                    Text('T.VAL', style: EBAppTextStyle.billItemsText),
                    Text('CGST%',
                        style: EBAppTextStyle.billItemsText,
                        textAlign: TextAlign.right),
                    Text('CGST',
                        style: EBAppTextStyle.billItemsText,
                        textAlign: TextAlign.right),
                    Text('SGST %',
                        style: EBAppTextStyle.billItemsText,
                        textAlign: TextAlign.right),
                    Text('SGST',
                        style: EBAppTextStyle.billItemsText,
                        textAlign: TextAlign.right),
                  ],
                ),
              ],
            ),
          if (index == _.billItems!.length - 1 &&
              cashierCtrl.billConfig?.gstenable == true)
            ListView.builder(
              physics: const ClampingScrollPhysics(),
              shrinkWrap: true,
              itemCount: _.gstBillItems.length,
              itemBuilder: (context, index) {
                /*
                 *  DayEndReport dayReports = dayEndIndex < _.filteredDayReports!.length
              ? _.filteredDayReports![dayEndIndex]
              : _.filteredDayReports![0];
                 */
                BillItems gstBillItem = index < _.gstBillItems.length
                    ? _.gstBillItems[index]
                    : _.gstBillItems[0];
                return Table(
                  columnWidths: const {
                    0: FlexColumnWidth(1),
                    1: FlexColumnWidth(1.1),
                    2: FlexColumnWidth(1),
                    3: FlexColumnWidth(1),
                    4: FlexColumnWidth(1),
                    5: FlexColumnWidth(1),
                  },
                  children: [
                    if (gstBillItem.taxpercentage != '0')
                      TableRow(
                        decoration: index == _.gstBillItems.length - 1
                            ? BoxDecoration(
                                border: const BorderDirectional(
                                  bottom: BorderSide(
                                      width: 1, color: EBTheme.blackColor),
                                ),
                              )
                            : null,
                        children: [
                          Text(
                            gstBillItem.taxpercentage ?? "-",
                            style: EBAppTextStyle.billItemsText,
                          ),
                          Text(
                              _
                                  .calculateGSTAmount(gstBillItem.totalprice!,
                                      double.parse(gstBillItem.taxpercentage!))
                                  .toStringAsFixed(2),
                              style: EBAppTextStyle.billItemsText),
                          Text(gstBillItem.cgstPercentage ?? '',
                              // '${double.parse(consolodatedItem.taxpercentage!) / 2}',
                              style: EBAppTextStyle.billItemsText,
                              textAlign: TextAlign.right),
                          Text(
                              _
                                  .calculateGSTAmount(
                                      gstBillItem.totalprice!,
                                      double.parse(
                                          '${double.parse(gstBillItem.taxpercentage!) / 2}'))
                                  .toStringAsFixed(2),
                              style: EBAppTextStyle.billItemsText,
                              textAlign: TextAlign.right),
                          Text(
                              gstBillItem.sgstPercentage ?? '',
                              style: EBAppTextStyle.billItemsText,
                              textAlign: TextAlign.right),
                          Text(
                              _
                                  .calculateGSTAmount(
                                      gstBillItem.totalprice!,
                                      double.parse(
                                          '${double.parse(gstBillItem.taxpercentage!) / 2}'))
                                  .toStringAsFixed(2),
                              style: EBAppTextStyle.billItemsText,
                              textAlign: TextAlign.right),
                        ],
                      ),
                  ],
                );
              },
            ),

          // --------->>  bill bottom messages
          if (index == _.billItems!.length - 1) EBSizeConfig.sizedBoxH20,
          if (index == _.billItems!.length - 1 &&
              cashierCtrl.billConfig?.upienable == true &&
              cashierCtrl.billConfig?.upi != null)

            // ----------------->>  payment qr
            paymentQrWidget(
                upiID: cashierCtrl.billConfig!.upi!,
                payeeName: cashierCtrl.billConfig?.businessname ?? "-",
                tolalAmt: cashierCtrl.billItemsTotalPrice),
          if (index == _.billItems!.length - 1) EBSizeConfig.sizedBoxH20,
          if (index == _.billItems!.length - 1)
            Text(
              'Rs ${cashierCtrl.billItemsTotalPrice.toStringAsFixed(2)}',
              style: EBAppTextStyle.customeTextStyleWTNR(
                  fontSize: 33, fontWeigh: FontWeight.w900),
            ),
          if (index == _.billItems!.length - 1)
            Text(
                cashierCtrl.billConfig?.footerenable == true
                    ? cashierCtrl.billConfig?.footer ?? '-'
                    : '',
                style: EBAppTextStyle.customeTextStyleWTNR(
                    fontSize: 18, fontWeigh: FontWeight.w700)),
        ],
      );
    },
  );
}
