// ignore_for_file: no_wildcard_variable_uses

import 'package:easybill_app/app/constants/size_config.dart';
import 'package:easybill_app/app/data/models/bill_reports.dart';
import 'package:easybill_app/app/modules/admin/admin_report/views/widgets/admin_filter_dialog.dart';
import 'package:easybill_app/app/modules/admin/bill_wise_report/views/widgets/detailed_bill.dart';
import 'package:easybill_app/app/widgets/custom_widgets/custom_scaffold.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import '../../../../constants/app_string.dart';
import '../../../../constants/app_text_style.dart';
import '../../../../constants/bools.dart';
import '../../../../widgets/custom_widgets/custom_container.dart';
import '../../../../widgets/custom_widgets/custom_msg_widget.dart';
import '../../../../widgets/custom_widgets/custom_text_form_field.dart';
import '../../../../widgets/loading_widget.dart';
import '../controllers/admin_report_controller.dart';

class AdminReportView extends GetView<AdminReportController> {
  const AdminReportView({super.key});
  @override
  Widget build(BuildContext context) {
    return Builder(builder: (context) {
      return GetBuilder<AdminReportController>(builder: (controller) {
        return EBCustomScaffold(
            noDrawer: true,
            actionWidgetList: [
              IconButton(
                icon: const Icon(
                  Icons.refresh,
                  size: 20,
                ),
                onPressed: () {
                  controller.getOtherBillReports();
                },
              ),
              IconButton(
                  icon: const Icon(
                    Icons.filter_list,
                    size: 20,
                  ),
                  onPressed: () async {
                    filterDialogForAdminReport(controller, context);
                  }),
              // IconButton(
              //   icon: const Icon(
              //     Icons.download_rounded,
              //     size: 20,
              //   ),
              //   onPressed: () {},
              // ),
              IconButton(
                icon: const Icon(
                  Icons.print_outlined,
                  size: 20,
                ),
                onPressed: () {},
              ),
            ],
            body: Padding(
              padding: EBSizeConfig.edgeInsetsActivities,
              child: GetBuilder<AdminReportController>(builder: (_) {
                if (EBBools.isLoading) return const LoadingWidget();

                switch (_.otherReportsDecisionKey) {
                  case 1:
                    return productReports(_);
                  case 2:
                    return staffReports(_);
                  case 3:
                    return cancelReport(_);
                  default:
                    return msgForReports();
                }
              }),
            ));
      });
    });
  }

  Widget cancelReport(AdminReportController _) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.end,
      children: [
        // EBSizeConfig.sizedBoxH15,
        // CustomElevatedButton(
        //   isDefaultWidth: true,
        //   onPressed: () async {
        //     await filterDialogForAdminReport(_);
        //   },
        //   child: Text(
        //     EBAppString.filterByPaymentmode,
        //     style: EBAppTextStyle.button,
        //   ),
        // ),
        EBSizeConfig.sizedBoxH15,
        GetBuilder<AdminReportController>(builder: (_) {
          if (_.filterableBillReports == null ||
              _.filterableBillReports!.isEmpty) return customMessageWidget();
          return Expanded(
            child: ListView.builder(
                itemCount: _.filterableBillReports!.length,
                itemBuilder: (context, index) {
                  Reports reports = _.filterableBillReports![index];
                  return GestureDetector(
                    onTap: () async {
                      _.cancelBillPressed(reports);
                      await detailedbillDetailedInfoSheet(context);
                    },
                    child: CustomContainer(
                      noHeight: true,
                      child: Column(
                        children: [
                          Row(
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            children: [
                              Text('Canceled Bill Id : ${reports.shopbillid}',
                                  style: EBAppTextStyle.catStyle),
                              Text(
                                'Quantity : ${reports.quantity}',
                                style: EBAppTextStyle.bodyText,
                              ),
                            ],
                          ),
                          Row(
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            children: [
                              Text(
                                'Total : ${reports.totalquantityamount}',
                                style: EBAppTextStyle.bodyText,
                              ),
                            ],
                          ),
                          // Row(
                          //   mainAxisAlignment:
                          //       MainAxisAlignment.spaceBetween,
                          //   children: [
                          //     Text(
                          //       'Date-Time : ${filterableBillInfo.datetime}',
                          //       style: EBAppTextStyle.bodyText,
                          //     ),
                          //   ],
                          // ),
                        ],
                      ),
                    ),
                  );

                  // ListTile(
                  //   title: Text('Bill ${index + 1}'),
                  //   subtitle: Text('Amount: ${billInfo.billtype}'),
                  //   onTap: () {
                  //     // Handle onTap if needed
                  //   },
                  // );
                }),
          );
        }),
      ],
    );
  }

  Widget productReports(AdminReportController _) {
    return Column(
      children: [
        EBSizeConfig.sizedBoxH15,
        Row(
          children: [
            Expanded(
              flex: 2,
              child: CustomTextFormField(
                controller: _.scannerController,
                prefixIcon: const Icon(Icons.search, size: 30),
                labelText: 'Search by product name...',
                onChanged: (value) => _.searchForProduct(value),
              ),
            ),
            // Expanded(
            //   child: CustomElevatedButton(
            //     isDefaultWidth: true,
            //     onPressed: () {
            //       filterDialogForAdminReport(_);
            //     },
            //     child: Text(
            //       EBAppString.filterByPaymentmode,
            //       style: EBAppTextStyle.button,
            //     ),
            //   ),
            // ),
          ],
        ),
        EBSizeConfig.sizedBoxH15,
        GetBuilder<AdminReportController>(builder: (_) {
          if (_.filterableBillReports == null ||
              _.filterableBillReports!.isEmpty) return customMessageWidget();//msg: 'No Product in this name'
          return Expanded(
            child: ListView.builder(
                itemCount: _.filterableBillReports!.length,
                itemBuilder: (context, index) {
                  Reports reports = _.filterableBillReports![index];
                  return GestureDetector(
                    onTap: () {
                      //  _.onReportsPressed(reports);
                    },
                    child: CustomContainer(
                      noHeight: true,
                      child: Column(
                        children: [
                          Row(
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            children: [
                              Flexible(
                                child: Text(
                                    'Product Name : ${EBAppString.productlanguage == 'English' ? reports.productnameEnglish : reports.productnameTamil}',
                                    style: EBAppTextStyle.catStyle),
                              ),
                              Text(
                                'Quantity : ${reports.quantity}',
                                style: EBAppTextStyle.bodyText,
                              ),
                            ],
                          ),
                          Row(
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            children: [
                              Text(
                                'Total : ${reports.totalquantityamount}',
                                style: EBAppTextStyle.bodyText,
                              ),
                            ],
                          ),
                          // Row(
                          //   mainAxisAlignment:
                          //       MainAxisAlignment.spaceBetween,
                          //   children: [
                          //     Text(
                          //       'Date-Time : ${filterableBillInfo.datetime}',
                          //       style: EBAppTextStyle.bodyText,
                          //     ),
                          //   ],
                          // ),
                        ],
                      ),
                    ),
                  );

                  // ListTile(
                  //   title: Text('Bill ${index + 1}'),
                  //   subtitle: Text('Amount: ${billInfo.billtype}'),
                  //   onTap: () {
                  //     // Handle onTap if needed
                  //   },
                  // );
                }),
          );
        }),
      ],
    );
  }

  Widget staffReports(AdminReportController _) {
    return Column(
      children: [
        EBSizeConfig.sizedBoxH15,
        Row(
          children: [
            Expanded(
              flex: 2,
              child: CustomTextFormField(
                controller: _.scannerController,
                prefixIcon: const Icon(Icons.search, size: 30),
                labelText: 'Search by Staff name...',
                onChanged: (value) => _.searchForStaff(value),
              ),
            ),
            // Expanded(
            //   child: CustomElevatedButton(
            //     isDefaultWidth: true,
            //     onPressed: () {
            //       filterDialogForAdminReport(_);
            //     },
            //     child: Text(
            //       EBAppString.filterByPaymentmode,
            //       style: EBAppTextStyle.button,
            //     ),
            //   ),
            // ),
          ],
        ),
        EBSizeConfig.sizedBoxH15,
        GetBuilder<AdminReportController>(builder: (_) {
          if (_.filterableBillReports == null ||
              _.filterableBillReports!.isEmpty) return customMessageWidget();//msg: 'No staff with this name'
          return Expanded(
            child: ListView.builder(
                itemCount: _.filterableBillReports!.length,
                itemBuilder: (context, index) {
                  Reports reports = _.filterableBillReports![index];
                  return GestureDetector(
                    onTap: () {
                      //  _.onReportsPressed(reports);
                    },
                    child: CustomContainer(
                      noHeight: true,
                      child: Column(
                        children: [
                          Row(
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            children: [
                              Flexible(
                                child: Text('Username: ${reports.fullname}',
                                    style: EBAppTextStyle.catStyle),
                              ),
                              Text(
                                'Quantity : ${reports.quantity}',
                                style: EBAppTextStyle.bodyText,
                              ),
                            ],
                          ),
                          Row(
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            children: [
                              Text(
                                'Total : ${reports.totalquantityamount}',
                                style: EBAppTextStyle.bodyText,
                              ),
                            ],
                          ),
                          // Row(
                          //   mainAxisAlignment:
                          //       MainAxisAlignment.spaceBetween,
                          //   children: [
                          //     Text(
                          //       'Date-Time : ${filterableBillInfo.datetime}',
                          //       style: EBAppTextStyle.bodyText,
                          //     ),
                          //   ],
                          // ),
                        ],
                      ),
                    ),
                  );

                  // ListTile(
                  //   title: Text('Bill ${index + 1}'),
                  //   subtitle: Text('Amount: ${billInfo.billtype}'),
                  //   onTap: () {
                  //     // Handle onTap if needed
                  //   },
                  // );
                }),
          );
        }),
      ],
    );
  }

  Widget msgForReports([int? decitionKeyForReports]) {
    return Column(
      mainAxisAlignment: MainAxisAlignment.center,
      crossAxisAlignment: CrossAxisAlignment.center,
      children: [
        Text(
            decitionKeyForReports == null
                ? 'No Records Found'
                : 'No Records Cancel Bill',
            style: EBAppTextStyle.bodyText),
      ],
    );
  }
}
