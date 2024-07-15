import 'package:easybill_app/app/constants/app_string.dart';
import 'package:easybill_app/app/constants/bools.dart';
import 'package:easybill_app/app/data/models/bill_reports.dart';
import 'package:easybill_app/app/widgets/custom_widgets/custom_msg_widget.dart';
import 'package:easybill_app/app/widgets/loading_widget.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import '../../../../../constants/app_text_style.dart';
import '../../../../../constants/size_config.dart';
import '../../../../../constants/themes.dart';
import '../../../../../data/models/setting.dart';
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
                if (EBBools.isLoading) return const LoadingWidget();
                if (_.billDetailedReports == null ||
                    _.billDetailedReports!.isEmpty) return customMessageWidget();
                Setting billConfig = _.settingsList![0];
                return Expanded(
                  child: Column(
                    children: [
                      // --------->>  bill top design
                      Flexible(
                        child: Text(billConfig.businessname ?? '-',
                            style: EBAppTextStyle.heading2),
                      ),
                      Flexible(
                        child: Text(billConfig.businessaddress ?? '-',
                            style: EBAppTextStyle.heading2,
                            textAlign: TextAlign.center),
                      ),
                      Flexible(
                        child: Text('Ph: ${billConfig.businessmobile ?? '-'}',
                            style: EBAppTextStyle.heading2),
                      ),
                      Text('Bill No:  ${_.billDetailedReports![0].shopbillid}',
                          textAlign: TextAlign.right,
                          style: EBAppTextStyle.heading2),
                      // --------->>  bill design
                      ListView.builder(
                          shrinkWrap: true,
                          padding: EBSizeConfig.textContentPadding,
                          itemCount: _.billDetailedReports!.length,
                          itemBuilder: (context, index) {
                            Reports reports = _.billDetailedReports![index];
                            return Column(
                              children: [
                                if (index == 0)
                                  Row(
                                    mainAxisAlignment:
                                        MainAxisAlignment.spaceBetween,
                                    children: [
                                      Text(
                                          'Bill Date : ${_.formateBillDate(reports.billdate!)}',
                                          style: EBAppTextStyle.bodyText),
                                      Text(
                                        'Time : ${_.formattedTime ?? '-'}',
                                        style: EBAppTextStyle.bodyText,
                                      ),
                                    ],
                                  ),
                                if (index == 0) EBSizeConfig.sizedBoxH15,
                                //Container(
                                // decoration: BoxDecoration(
                                //   border: Border.all(
                                //     width: 1,
                                //   ),
                                //   borderRadius: const BorderRadius.all(
                                //     Radius.circular(2),
                                //   ),
                                // ),
                                // child:
                                Table(
                                  // border: const TableBorder.symmetric(
                                  //     inside: BorderSide(
                                  //         width: 2, color: Colors.black)),
                                  // defaultVerticalAlignment:
                                  //  TableCellVerticalAlignment.middle,
                                  columnWidths: const {
                                    0: FlexColumnWidth(0.8),
                                    1: FlexColumnWidth(4),
                                    2: FlexColumnWidth(1),
                                    3: FlexColumnWidth(1),
                                    4: FlexColumnWidth(2),
                                  },
                                  children: [
                                    if (index == 0)
                                      TableRow(
                                        decoration: const BoxDecoration(
                                          border: Border.symmetric(
                                            horizontal: BorderSide(
                                                width: 1,
                                                color: EBTheme.blackColor),
                                          ),
                                        ),
                                        children: [
                                          Text('Sr ',
                                              style: EBAppTextStyle.button),
                                          Text(
                                            'Name',
                                            style: EBAppTextStyle.button,
                                          ),
                                          Text(
                                            'Rate ',
                                            style: EBAppTextStyle.button,
                                          ),
                                          Text('Qty ',
                                              style: EBAppTextStyle.button,
                                              textAlign: TextAlign.right),
                                          Text('Amt ',
                                              style: EBAppTextStyle.button,
                                              textAlign: TextAlign.right),
                                        ],
                                      ),
                                    TableRow(
                                      children: [
                                        Text(
                                          '${index + 1}.',
                                          style: EBAppTextStyle.bodyText,
                                        ),
                                        Text(
                                            '${EBAppString.productlanguage == 'English' ? reports.productnameEnglish : reports.productnameTamil}',
                                            style: EBAppTextStyle.bodyText),
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
                                        Text(reports.rateperitem!,
                                            style: EBAppTextStyle.bodyText,
                                            textAlign: TextAlign.right),
                                        Text(
                                            reports.quantity!
                                                .toStringAsFixed(2),
                                            style: EBAppTextStyle.bodyText,
                                            textAlign: TextAlign.right),
                                        Text('${reports.totalquantityamount}',
                                            style: EBAppTextStyle.bodyText,
                                            textAlign: TextAlign.right),
                                      ],
                                    ),
                                  ],
                                ),
                                if (index == _.billDetailedReports!.length - 1)
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
                                              style: EBAppTextStyle.button),
                                          Text(
                                              'Qty: ${_.totalQty.toStringAsFixed(2)}',
                                              style: EBAppTextStyle.button,
                                              textAlign: TextAlign.left),
                                          Text(
                                              _.totalBillAmt.toStringAsFixed(2),
                                              style: EBAppTextStyle.totalAmt,
                                              textAlign: TextAlign.right),
                                        ],
                                      ),
                                    ],
                                  ),
                                // --------->>  bill bottom messages
                                if (index == _.billDetailedReports!.length - 1)
                                  EBSizeConfig.sizedBoxH200,
                                if (index == _.billDetailedReports!.length - 1)
                                  Text(
                                      billConfig.footerenable == true
                                          ? billConfig.footer ?? '-'
                                          : '',
                                      style: EBAppTextStyle.heading2),

                                if (index == _.billDetailedReports!.length - 1)
                                  Text(
                                    _.totalBillAmt.toStringAsFixed(2),
                                    style: EBAppTextStyle.heading2,
                                  ),
                              ],
                            );
                          }),
                    ],
                  ),
                );
              }),
            ],
          ),
        );
      });
}
