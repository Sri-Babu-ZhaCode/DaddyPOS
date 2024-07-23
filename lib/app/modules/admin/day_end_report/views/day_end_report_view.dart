import 'package:easybill_app/app/constants/bools.dart';
import 'package:easybill_app/app/data/models/day_end_report.dart';
import 'package:easybill_app/app/widgets/loading_widget.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import '../../../../constants/app_text_style.dart';
import '../../../../constants/size_config.dart';
import '../../../../constants/themes.dart';
import '../../../../widgets/custom_widgets/custom_container.dart';
import '../../../../widgets/custom_widgets/custom_scaffold.dart';
import '../controllers/day_end_report_controller.dart';

class DayEndReportView extends GetView<DayEndReportController> {
  const DayEndReportView({super.key});
  @override
  Widget build(BuildContext context) {
    return GetBuilder<DayEndReportController>(builder: (_) {
      return DefaultTabController(
        length: 2,
        child: EBCustomScaffold(
            actionWidgetList: [
              IconButton(
                onPressed: () {
                  _.getDayEndReports();
                },
                icon: const Icon(Icons.refresh_outlined),
              ),
            ],
            body: Padding(
              padding: EBSizeConfig.edgeInsetsActivities,
              child: Column(
                children: [
                  TabBar(
                    controller: _.tabController,
                    onTap: (index) {
                      _.tabIndex = index;
                      _.updateDayEndReport(index);
                    },
                    overlayColor:
                        MaterialStatePropertyAll(EBTheme.kPrimaryLightColor),
                    labelColor: EBTheme.kPrimaryColor,
                    indicatorSize: TabBarIndicatorSize.tab,
                    indicatorColor: EBTheme.kPrimaryColor,
                    tabs: ["Product", 'Payment Mode', 'Cashier']
                        .map((e) => Tab(
                              child: Text(
                                e,
                                overflow: TextOverflow.ellipsis,
                                style: EBAppTextStyle.billItemsText,
                              ),
                            ))
                        .toList(),
                  ),
                  Expanded(
                    child: Padding(
                      padding: EBSizeConfig.edgeInsetsOnlyH10,
                      child: TabBarView(
                        physics: const NeverScrollableScrollPhysics(),
                        controller: _.tabController,
                        children: [
                          dayEndBillReports(controller),
                          dayEndBillReports(controller),
                          dayEndBillReports(controller),
                        ],
                      ),
                    ),
                  ),
                ],
              ),
            )),
      );
    });
  }

  Widget dayEndBillReports(DayEndReportController _) {
    if (EBBools.isLoading) return const LoadingWidget();
    if (_.filteredDayReports == null || _.filteredDayReports!.isEmpty) return msgForNoDayReports();
    return ListView.builder(
        itemCount: _.filteredDayReports!.length,
        itemBuilder: (context, dayEndIndex) {
          debugPrint(
              " length of ------------->> ${_.filteredDayReports!.length}");

          DayEndReport dayReports = dayEndIndex < _.filteredDayReports!.length
              ? _.filteredDayReports![dayEndIndex]
              : _.filteredDayReports![0];
          return Column(
            crossAxisAlignment: CrossAxisAlignment.end,
            children: [
              CustomContainer(
                noHeight: true,
                child: Column(
                  children: [
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Flexible(
                          child: Text(
                            // '${dayReports.report == 'Product'? 'Product Name: ' :  dayReports.report == 'paymentMode'?  'Payment Mode: ' : 'Report Name:'} ${dayReports.reportname}',

                            'Report: ${dayReports.reportname}',
                            style: EBAppTextStyle.bodyText,
                          ),
                        ),
                      ],
                    ),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Text('Bills: ${dayReports.bills}',
                            style: EBAppTextStyle.catStyle),
                        Text('Amount: ${dayReports.amount}',
                            style: EBAppTextStyle.avtiveTxt),
                      ],
                    ),
                  ],
                ),
              ),
              if (dayEndIndex == _.filteredDayReports!.length - 1)
                Text(
                  'Total amount: ${dayReports.totalamount}',
                  style: EBAppTextStyle.heading2,
                ),
            ],
          );
        });
  }
}

Widget msgForNoDayReports() {
  return Center(
    child: Text(
      'No Reports Found',
      style: EBAppTextStyle.bodyText,
    ),
  );
}
