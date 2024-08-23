import 'package:flutter/material.dart';

import '../../../../../../constants/app_string.dart';
import '../../../../../../constants/app_text_style.dart';
import '../../../../../../constants/bools.dart';
import '../../../../../../constants/size_config.dart';
import '../../../../../../constants/themes.dart';
import '../../../../../../widgets/custom_widgets/custom_text_button.dart';
import '../../../controllers/cashier_bills_controller.dart';
import '../../cashier_bills_view.dart';
import '../bill_tab.dart';
import '../delete_dialog.dart';
import '../sales_tab.dart';
import '../token_tab.dart';

Widget tabBottomSheet(CashierBillsController controller, BuildContext context) {
  EBSizeConfig.init(context);
  controller.deviceScreenHeight = EBSizeConfig.screenHeight;
  controller.screenWidth = EBSizeConfig.screenWidth;

  if (!controller.isExpanded) {
    controller.sheetHeight = EBSizeConfig.screenHeight * 0.60;
  }
  return AnimatedContainer(
    duration: const Duration(milliseconds: 500),
    curve: Curves.easeIn,
    //  curve:  Curves.fastOutSlowIn,
    height: controller.sheetHeight,
    color: controller.screenWidth! > 576 ? EBTheme.platinumColor : null,
    child: Column(
      mainAxisAlignment: MainAxisAlignment.end,
      children: [
        GestureDetector(
          onTap: controller.toggleSheetForTab,
          child: Container(
            height: 30,
            padding: EBSizeConfig.edgeInsetsActivities,
            decoration: const BoxDecoration(
              color: EBTheme.listColor,
            ),
            child: Row(
              mainAxisAlignment: controller.billItems.isNotEmpty
                  ? MainAxisAlignment.spaceBetween
                  : MainAxisAlignment.center,
              children: [
                if (controller.billItems.isNotEmpty)
                  CustomTextButton(
                    padding: EBSizeConfig.edgeInsetsZero,
                    textColor: Colors.red,
                    name: EBAppString.cancelOrder,
                    onPressed: () {
                      deleteAlertDialog();
                    },
                  ),
                Container(
                  width: controller.screenWidth! * 0.1 / 2,
                  height: 5,
                  decoration: BoxDecoration(
                    color: Colors.grey,
                    borderRadius: BorderRadius.circular(30),
                  ),
                ),
                Text(
                    controller.billItems.isNotEmpty
                        ? 'Items :  ${controller.billItems.length} '
                        : '',
                    style: EBAppTextStyle.bodyText)
              ],
            ),
          ),
        ),
        Expanded(
          child: controller.showScanner
              ? qrScannerWidget(controller, context)
              : DefaultTabController(
                  length: 3,
                  initialIndex: 0,
                  child: Column(
                    mainAxisSize: MainAxisSize.min,
                    children: [
                      TabBar(
                        controller: controller.tabController,
                        onTap: (index) {
                          controller.updateseachableProductList(index);
                        },
                        overlayColor:
                            WidgetStatePropertyAll(EBTheme.kPrimaryLightColor),
                        labelColor: EBTheme.kPrimaryColor,
                        indicatorSize: TabBarIndicatorSize.tab,
                        indicatorColor: EBTheme.kPrimaryColor,
                        tabs: [
                          if (EBBools.isSalePresent) EBAppString.salesAll,
                          if (EBBools.isQuickPresent) EBAppString.quickSale,
                          if (EBBools.isTokenPresent) EBAppString.token
                        ]
                            .map(
                              (e) => Tab(
                                child: Text(
                                  e,
                                  overflow: TextOverflow.ellipsis,
                                  style: EBAppTextStyle.bodyText,
                                ),
                              ),
                            )
                            .toList(),
                        // onTap: (index) {
                        //   controller.pageController.jumpToPage(index);
                        //   controller.updateseachableProductList(index);
                        //   controller.update();
                        //   print('current index -------------->>  $index');
                        // }
                      ),
                      Expanded(
                        child: TabBarView(
                          physics: const NeverScrollableScrollPhysics(),
                          controller: controller.tabController,
                          //  controller: controller.pageController,
                          children: [
                            if (EBBools.isSalePresent) saleTab(context),
                            if (EBBools.isQuickPresent) billTab(context),
                            if (EBBools.isTokenPresent) tokenTab(),
                          ],
                          // onPageChanged: (index) {
                          //   controller.updateseachableProductList(index);
                          // },
                        ),
                      )
                    ],
                  ),
                ),
        ),
      ],
    ),
  );
}
