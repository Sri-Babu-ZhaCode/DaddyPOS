import 'package:easybill_app/app/constants/app_string.dart';
import 'package:easybill_app/app/constants/bools.dart';
import 'package:easybill_app/app/data/models/bill_reports.dart';
import 'package:easybill_app/app/modules/admin/bill_wise_report/views/widgets/bill_top_widget.dart';
import 'package:easybill_app/app/widgets/custom_widgets/custom_msg_widget.dart';
import 'package:easybill_app/app/widgets/loading_widget.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

import '../../../../../constants/app_text_style.dart';
import '../../../../../constants/size_config.dart';
import '../../../../../constants/themes.dart';
import '../../../../../data/models/setting.dart';
import '../../../../cashier/bill_details/views/wigdets/payment_qr.dart';
import '../../controllers/bill_wise_report_controller.dart';

Future<void> detailedbillDetailedInfoSheet(context) {
  EBSizeConfig.init(context);
  return showModalBottomSheet<void>(
      backgroundColor: EBTheme.kPrimaryWhiteColor,
      context: context,
      isScrollControlled: true,
      constraints: const BoxConstraints(
        maxWidth: double.infinity,
      ),
      builder: (BuildContext context) {
        return Padding(
          padding: EBSizeConfig.edgeInsetsAll15,
          child: Column(
            //mainAxisSize: MainAxisSize.min,
            children: [
              EBSizeConfig.sizedBoxH20,
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
              Row(
                children: [
                  IconButton(
                    icon: const Icon(
                      Icons.download_rounded,
                      size: 26,
                    ),
                    onPressed: () {},
                  ),
                  IconButton(
                    icon: const Icon(
                      Icons.print_outlined,
                      size: 26,
                    ),
                    onPressed: () {},
                  ),
                ],
              ),
              EBSizeConfig.sizedBoxH20,
              GetBuilder<BillWiseReportController>(builder: (_) {
                if (EBBools.isLoading || _.settingsList == null) return const LoadingWidget();
                if (_.billDetailedReports == null ||
                    _.billDetailedReports!.isEmpty) return customMessageWidget();
                Setting billConfig = _.settingsList![0];
                return Flexible(
                  fit: FlexFit.loose,
                  child: Column(
                    mainAxisSize: MainAxisSize.min,
                    children: [
                      // --------->>  bill top design

                      // --------->>  bill design
                      Expanded(
                        child: ListView.builder(
                            padding: EBSizeConfig.textContentPadding,
                            itemCount: _.billDetailedReports!.length,
                            itemBuilder: (context, index) {
                              Reports reports = _.billDetailedReports![index];
                              return Column(
                                mainAxisSize: MainAxisSize.min,
                                children: [
                                  if (index == 0)
                                    billTopWidget(_, billConfig, context),
                                  if (index == 0)
                                    Row(
                                      mainAxisAlignment:
                                          MainAxisAlignment.spaceBetween,
                                      children: [
                                        Text(
                                            'Date: ${_.formateBillDate(reports.billdate!)}',
                                            style: EBAppTextStyle.billItemsText),
                                        Text(
                                          'Time: ${_.formattedTime ?? '-'}',
                                          style: EBAppTextStyle.billItemsText,
                                        ),
                                      ],
                                    ),
                                  if (index == 0) EBSizeConfig.sizedBoxH15,
                                  Table(
                                    // border: const TableBorder.symmetric(
                                    //     inside: BorderSide(
                                    //         width: 2, color: Colors.black)),
                                    // defaultVerticalAlignment:
                                    //  TableCellVerticalAlignment.middle,
                                    columnWidths: const {
                                      0: FlexColumnWidth(0.8),
                                      1: FlexColumnWidth(4),
                                      2: FlexColumnWidth(1.2),
                                      3: FlexColumnWidth(1.2),
                                      4: FlexColumnWidth(1.5),
                                    },
                                    children: [
                                      if (index == 0)
                                        const TableRow(
                                          decoration: BoxDecoration(
                                            border: Border.symmetric(
                                              horizontal: BorderSide(
                                                  width: 1,
                                                  color: EBTheme.blackColor),
                                            ),
                                          ),
                                          children: [
                                            Text('Sr ',
                                                style: EBAppTextStyle.billItemsText),
                                            Text(
                                              'Name',
                                              style: EBAppTextStyle.billItemsText,
                                            ),
                                            Text(
                                              'Rate ',
                                              style: EBAppTextStyle.billItemsText,
                                              textAlign: TextAlign.left
                                            ),
                                            Text('Qty ',
                                                style: EBAppTextStyle.billItemsText,
                                                textAlign: TextAlign.left),
                                            Text('Amt ',
                                                style: EBAppTextStyle.billItemsText,
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
                                              '${EBAppString.productlanguage == 'English' ? reports.productnameEnglish : reports.productnameTamil}',
                                              style: EBAppTextStyle.billItemsText),
                                          Text('',
                                              style: EBAppTextStyle.bodyText,
                                              textAlign: TextAlign.right),
                                          Text('',
                                              style: EBAppTextStyle.bodyText,
                                              textAlign: TextAlign.right),
                                          Text('',
                                              style: EBAppTextStyle.bodyText,
                                              textAlign: TextAlign.right),
                                        ],
                                      ),
                                      TableRow(
                                        children: [
                                          Text(
                                            '',
                                            style: EBAppTextStyle.bodyText,
                                          ),
                                          Text('',
                                              style: EBAppTextStyle.bodyText),
                                          Text(reports.rateperitem ?? '-',
                                              style: EBAppTextStyle.billItemsText,
                                              textAlign: TextAlign.left),
                                          Text(
                                              reports.quantity!
                                                  .toStringAsFixed(2),
                                              style: EBAppTextStyle.billItemsText,
                                              textAlign: TextAlign.left),
                                          Text('${reports.totalquantityamount}',
                                              style: EBAppTextStyle.billItemsText,
                                              textAlign: TextAlign.right),
                                        ],
                                      ),
                                    ],
                                  ),
                                  if (index ==
                                      _.billDetailedReports!.length - 1)
                                    Table(
                                      children: [
                                        TableRow(
                                          decoration: const BoxDecoration(
                                            border: Border.symmetric(
                                              horizontal: BorderSide(
                                                  width: 1,
                                                  color: EBTheme.blackColor),
                                            ),
                                          ),
                                          children: [
                                            Text(
                                                'Items: ${_.billDetailedReports!.length}',
                                                style: EBAppTextStyle.billItemsText),
                                            Text(
                                                'Qty: ${_.totalQty.toStringAsFixed(2)}',
                                                style: EBAppTextStyle.billItemsText,
                                                textAlign: TextAlign.left),
                                            Text(
                                                _.totalBillAmt
                                                    .toStringAsFixed(2),
                                                style: EBAppTextStyle.billItemsText,
                                                textAlign: TextAlign.right),
                                          ],
                                        ),
                                      ],
                                    ),
                                  // --------->>  bill bottom messages  
                                  if (index ==
                                      _.billDetailedReports!.length - 1)
                                    EBSizeConfig.sizedBoxH20,
                                if (index == _.billDetailedReports!.length - 1  && billConfig.upienable == true && billConfig.upi != null )

                                    // ----------------->>  payment qr
                                    paymentQrWidget(
                                        upiID: billConfig.upi!,
                                        payeeName:
                                            billConfig.businessname ?? "-",
                                        tolalAmt: _.totalBillAmt),
                                  if (index ==
                                      _.billDetailedReports!.length - 1)
                                    EBSizeConfig.sizedBoxH20,
                                  if (index ==
                                      _.billDetailedReports!.length - 1)
                                    Text(
                                      'Rs ${_.totalBillAmt.toStringAsFixed(2)}',
                                      style: EBAppTextStyle.customeTextStyleWTNR(fontSize: 33,fontWeigh: FontWeight.w900),
                                    ),
                                  if (index ==
                                      _.billDetailedReports!.length - 1)
                                    Text(
                                        billConfig.footerenable == true
                                            ? billConfig.footer ?? '-'
                                            : '',
                                        style: EBAppTextStyle.customeTextStyleWTNR(fontSize: 18,fontWeigh: FontWeight.w700)),
                                ],
                              );
                            }),
                      ),
                    ],
                  ),
                );
              }),
            ],
          ),
        );
      });
}
