import 'package:easybill_app/app/constants/size_config.dart';
import 'package:easybill_app/app/constants/themes.dart';
import 'package:easybill_app/app/data/models/bill_reports.dart';
import 'package:easybill_app/app/widgets/custom_widgets/custom_scaffold.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import '../../../../constants/app_string.dart';
import '../../../../constants/app_text_style.dart';
import '../../../../widgets/custom_widgets/custom_alert_dialog.dart';
import '../../../../widgets/custom_widgets/custom_container.dart';
import '../controllers/admin_report_controller.dart';

class AdminReportView extends GetView<AdminReportController> {
  const AdminReportView({super.key});
  @override
  Widget build(BuildContext context) {
    return Builder(builder: (context) {
      return GetBuilder<AdminReportController>(builder: (controller) {
        return EBCustomScaffold(
            noDrawer: true,
            
            actionWidgetList:  [
              if(controller.decitionKeyForReports == 1)
              IconButton(
                icon: const Icon(
                  Icons.refresh,
                  size: 26,
                ),
                onPressed: () {
                  controller.filterableBillReports = controller.billReports;
                  controller.update();
                },
              ),
              if(controller.decitionKeyForReports == 1)
              IconButton(
                icon: const Icon(
                  Icons.filter_list,
                  size: 26,
                ),
                onPressed: () async {
                  final result = await showDateRangePicker(
                    context: context,
                    firstDate: DateTime(2024),
                    lastDate: DateTime.now().add(
                      const Duration(days: 365),
                    ),
                  );

                  DateTime startDate = DateTime.utc(2021, 03, 01);
                  print(startDate);

                  if (result != null) {
                    print('Start date ----------->>${result.start}');
                    controller.formtDates(result.start, result.end);
                    print('End date ----------->>${result.end}');
                    print('range date ----------->>${result}');
                  }
                },
              ),
            ],
            body: Padding(
              padding: EBSizeConfig.edgeInsetsActivities,
              child: GetBuilder<AdminReportController>(builder: (_) {
                if (_.filterableBillReports == null) {
                  return msgForReports();
                } else {
                  switch (_.decitionKeyForReports) {
                    case 1:
                      return billReports(_);
                    case 2:
                      return productReports(_);
                    case 3:
                      return staffReports(_);
                    case 4:
                      return billReports(_);
                    default:
                      return msgForReports();
                  }
                }
              }),
            ));
      });
    });
  }

  Widget billReports(AdminReportController _) {
    return ListView.builder(
        itemCount: _.filterableBillReports!.length,
        itemBuilder: (context, index) {
          Reports reports = _.filterableBillReports![index];
          return CustomContainer(
            noHeight: true,
            child: Column(
              children: [
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Text(
                        _.decitionKeyForReports == 4
                            ? 'Cancel Bill Id : ${reports.cancelbillid}'
                            : 'Shop Bill Id : ${reports.shopbillid}',
                        style: EBAppTextStyle.catStyle),
                    Text(
                      'Quantity : ${reports.sumquantity}',
                      style: EBAppTextStyle.avtiveTxt,
                    ),
                  ],
                ),
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Text(
                      'Total : ${reports.sumtotalquantityamount}',
                      style: EBAppTextStyle.bodyText,
                    ),
                    if (controller.decitionKeyForReports == 1)
                      IconButton(
                        onPressed: () => _deleteAlertDialof(reports),
                        icon: const Icon(
                          Icons.delete,
                          size: 20,
                          color: EBTheme.redColor,
                        ),
                      )
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
          );

          // ListTile(
          //   title: Text('Bill ${index + 1}'),
          //   subtitle: Text('Amount: ${billInfo.billtype}'),
          //   onTap: () {
          //     // Handle onTap if needed
          //   },
          // );
        });
  }

  Widget productReports(AdminReportController _) {
    return ListView.builder(
        itemCount: _.filterableBillReports!.length,
        itemBuilder: (context, index) {
          Reports reports = _.filterableBillReports![index];
          return CustomContainer(
            noHeight: true,
            child: Column(
              children: [
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Text(
                        'Product Name : ${_.getProductName(reports.productId.toString())}',
                        style: EBAppTextStyle.catStyle),
                    Text(
                      'Quantity : ${reports.sumquantity}',
                      style: EBAppTextStyle.avtiveTxt,
                    ),
                  ],
                ),
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Text(
                      'Total : ${reports.sumtotalquantityamount}',
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
          );

          // ListTile(
          //   title: Text('Bill ${index + 1}'),
          //   subtitle: Text('Amount: ${billInfo.billtype}'),
          //   onTap: () {
          //     // Handle onTap if needed
          //   },
          // );
        });
  }

  Widget staffReports(AdminReportController _) {
    return ListView.builder(
        itemCount: _.filterableBillReports!.length,
        itemBuilder: (context, index) {
          Reports reports = _.filterableBillReports![index];
          return CustomContainer(
            noHeight: true,
            child: Column(
              children: [
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Text('Staff Id : ${reports.staffid}',
                        style: EBAppTextStyle.catStyle),
                    Text(
                      'Quantity : ${reports.sumquantity}',
                      style: EBAppTextStyle.avtiveTxt,
                    ),
                  ],
                ),
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Text(
                      'Total : ${reports.sumtotalquantityamount}',
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
          );

          // ListTile(
          //   title: Text('Bill ${index + 1}'),
          //   subtitle: Text('Amount: ${billInfo.billtype}'),
          //   onTap: () {
          //     // Handle onTap if needed
          //   },
          // );
        });
  }

  Future _deleteAlertDialof(Reports r) {
    return const CustomAlertDialog().alertDialog(
      dialogTitle: 'Delete Bill',
      isformChildrenNeeded: true,
      dialogContent: 'Are you sure you want delete this Bill',
      formKey: key,
      confirmButtonText: EBAppString.delete,
      confirmOnPressed: () => controller.onDeleteBillPressed(r),
      cancelButtonText: EBAppString.cancel,
      cancelOnPressed: () {
        Get.back();
      },
    );
  }

  Widget msgForReports([int? decitionKeyForReports]) {
    return Center(
      child: Text(
          decitionKeyForReports == null
              ? 'No Records Found'
              : 'No Records Cancel Bill',
          style: EBAppTextStyle.bodyText),
    );
  }
}
