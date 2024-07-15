import 'package:easybill_app/app/modules/admin/bill_wise_report/views/widgets/detailed_bill.dart';
import 'package:easybill_app/app/modules/admin/bill_wise_report/views/widgets/paymentmode_filterdialog.dart';
import 'package:flutter/material.dart';

import 'package:get/get.dart';

import '../../../../constants/app_string.dart';
import '../../../../constants/app_text_style.dart';
import '../../../../constants/bools.dart';
import '../../../../constants/size_config.dart';
import '../../../../constants/themes.dart';
import '../../../../data/models/bill_reports.dart';
import '../../../../widgets/custom_widgets/custom_alert_dialog.dart';
import '../../../../widgets/custom_widgets/custom_container.dart';
import '../../../../widgets/custom_widgets/custom_elevated_button.dart';
import '../../../../widgets/custom_widgets/custom_list_tile.dart';
import '../../../../widgets/custom_widgets/custom_msg_widget.dart';
import '../../../../widgets/custom_widgets/custom_scaffold.dart';
import '../../../../widgets/loading_widget.dart';
import '../controllers/bill_wise_report_controller.dart';
import 'widgets/change_paymentmode.dart';

class BillWiseReportView extends GetView<BillWiseReportController> {
  const BillWiseReportView({super.key});
  @override
  Widget build(BuildContext context) {
    return Builder(builder: (context) {
      return GetBuilder<BillWiseReportController>(builder: (controller) {
        return EBCustomScaffold(
            noDrawer: true,
            actionWidgetList: [
              if (controller.billWiseDecisionKey == 0)
                IconButton(
                  icon: const Icon(
                    Icons.refresh,
                    size: 20,
                  ),
                  onPressed: () {
                    controller.filterableBillReports = controller.billReports;
                    controller.update();
                  },
                ),
              if (controller.billWiseDecisionKey == 0)
                IconButton(
                  icon: const Icon(
                    Icons.filter_list,
                    size: 20,
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
                    debugPrint(startDate.toString());

                    if (result != null) {
                      //  debugPrint('Start date ----------->>${result.start}');
                      // controller.filterBillsByDateRange(
                      //     result.start, result.end);
                      String startDate =
                          controller.formateBillDate(result.start.toString());
                      String endDate =
                          controller.formateBillDate(result.end.toString());
                      controller.filterByDateOrPaymentmode(
                          fromDate: startDate, toDate: endDate);
                      debugPrint('start date ------------------>>  $startDate');
                      // debugPrint('End date ----------->>${result.end}');
                      // debugPrint('range date ----------->>$result');
                    }
                  },
                ),
              if (controller.billWiseDecisionKey == 0)
                IconButton(
                  icon: const Icon(
                    Icons.download_rounded,
                    size: 20,
                  ),
                  onPressed: () {
                    controller.downLoadReports();
                  },
                ),
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
              child: GetBuilder<BillWiseReportController>(builder: (_) {
                if (EBBools.isLoading) return const LoadingWidget();

                return billReports(_);
              }),
            ));
      });
    });
  }

  Widget billReports(_) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.end,
      children: [
        CustomElevatedButton(
          isDefaultWidth: true,
          onPressed: () async {
            await paymentModeFilterDialog(_);
          },
          child: Text(
            EBAppString.filterByPaymentmode,
            style: EBAppTextStyle.button,
          ),
        ),
        EBSizeConfig.sizedBoxH15,
        GetBuilder<BillWiseReportController>(builder: (_) {
          if (_.filterableBillReports == null ||
              _.filterableBillReports!.isEmpty) return customMessageWidget();
          return Expanded(
            child: ListView.builder(
                itemCount: _.filterableBillReports!.length,
                itemBuilder: (context, index) {
                  Reports reports = _.filterableBillReports![index];
                  return GestureDetector(
                    onTap: () async {
                      _.getBillWiseFromReportType(reports);
                      await detailedbillDetailedInfoSheet(context);
                    },
                    child: CustomContainer(
                      noHeight: true,
                      child: Column(
                        children: [
                          Row(
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            children: [
                              Text('Shop Bill Id : ${reports.shopbillid}',
                                  style: EBAppTextStyle.catStyle),
                              Text(
                                'Quantity : ${reports.quantity}',
                                style: EBAppTextStyle.bodyText,
                              ),
                            ],
                          ),
                          EBSizeConfig.sizedBoxH15,
                          Row(
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            children: [
                              Text(
                                  'Bill Date : ${_.formateBillDate(reports.billdate!)}',
                                  style: EBAppTextStyle.bodyText),
                              Text(
                                'PaymentMode : ${reports.paymentmode}',
                                style: EBAppTextStyle.catStyle,
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
                          if (_.billWiseDecisionKey == -1)
                            EBCustomListTile(
                              contentPadding: EBSizeConfig.edgeInsetsZero,
                              trailingIconSize: 20,
                              titleName: EBAppString.changePaymentMode,
                              trailingIcon: Icons.edit,
                              onTap: () async {
                                _.currentPaymentMode =
                                    reports.paymentmode!.toUpperCase();
                                await changePaymentModeDialog(_, reports);
                              },
                            )
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
        EBSizeConfig.sizedBoxH15,
      ],
    );
  }

  Widget msgForReports() {
    return Center(
      child: Text('No Records Found', style: EBAppTextStyle.bodyText),
    );
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
}
