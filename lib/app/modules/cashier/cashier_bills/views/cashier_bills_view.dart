import 'package:easybill_app/app/constants/size_config.dart';
import 'package:easybill_app/app/constants/themes.dart';
import 'package:easybill_app/app/modules/cashier/cashier_bills/controllers/cashier_bills_controller.dart';
import 'package:easybill_app/app/modules/cashier/cashier_bills/views/bill_items_edit.dart';
import 'package:easybill_app/app/widgets/custom_widgets/custom_scaffold.dart';
import 'package:easybill_app/app/widgets/custom_widgets/custom_text_button.dart';
import 'package:easybill_app/app/widgets/responsive.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import '../../../../constants/app_string.dart';
import '../../../../constants/app_text_style.dart';
import '../../../../constants/bools.dart';
import '../../../../routes/app_pages.dart';
import '../../../../widgets/custom_widgets/custom_elevated_button.dart';
import 'widgets/bill_tab.dart';
import 'widgets/delete_dialog.dart';
import 'widgets/sales_tab.dart';
import 'widgets/tab_widgets/tab_bill_items.dart';
import 'widgets/tab_widgets/tab_bottom_sheet.dart';
import 'widgets/token_tab.dart';

class CashierBillsView extends GetView<CashierBillsController> {
  const CashierBillsView({super.key});

  @override
  Widget build(BuildContext context) {
    EBSizeConfig.init(context);
    return GetBuilder<CashierBillsController>(
      builder: (controller) {
        return EBCustomScaffold(
          resizeToAvoidBottomInset: false,
          bottomNavBar: Container(
            height: 85,
            decoration: const BoxDecoration(
              color: Colors.white,
              boxShadow: [
                BoxShadow(
                  color: Color.fromRGBO(58, 57, 57, 1),
                  offset: Offset(0.0, 1.0), //(x,y)
                  blurRadius: 6.0,
                ),
              ],
            ),
            child: Padding(
              padding: EBSizeConfig.edgeInsetsAll20,
              child: Row(
                children: [
                  Expanded(
                    flex: 3,
                    child: CustomElevatedButton(
                      btnColor: EBTheme.kPrimaryWhiteColor,
                      onPressed: () async {
                        EBBools.triggeredFromBillTab = true;
                        controller.qrQuantity = 1;
                        await Get.toNamed(Routes.QR_SCANNER);
                      },
                      child: Icon(
                        color: controller.showScanner
                            ? EBTheme.kCancelBtnColor
                            : EBTheme.kPrintBtnColor,
                        controller.showScanner
                            ? Icons.close
                            : Icons.qr_code_scanner_outlined,
                        size: 25,
                      ),
                    ),
                  ),
                  Expanded(
                    flex: 6,
                    child: CustomElevatedButton(
                      btnColor: EBTheme.kPrintBtnColor,
                      onPressed: () {
                        controller.totalPrice > 0.01
                            ? Get.toNamed(Routes.BILL_DETAILS,
                                arguments: {'billItems': controller.billItems})
                            : null;
                      },
                      child: Text(
                        '${controller.totalPrice.toStringAsFixed(1)}  Bill',
                        style: EBAppTextStyle.appBarTxt,
                      ),
                    ),
                  ),
                ]
                    .expand(
                      (element) => [element, EBSizeConfig.sizedBoxW08],
                    )
                    .toList(),
              ),
            ),
          ),
          bottomSheet: Responsive(
            mobile: mobileBottomSheet(controller, context),
            tablet: tabBottomSheet(controller, context),
          ),
          body: Responsive(
            mobile: mobileBillItemsWidget(),
            tablet: tabBillItemsWidget(context),
          ),
        );
      },
    );
  }

  Widget mobileBottomSheet(
      CashierBillsController controller, BuildContext context) {
    return SingleChildScrollView(
      child: Column(
        mainAxisAlignment: MainAxisAlignment.end,
        children: [
          GestureDetector(
            onTap: controller.toggleSheet,
            child: Container(
              height: 30,
              color: EBTheme.listColor,
              padding: EBSizeConfig.edgeInsetsActivities,
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
                    width: 40,
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
          AnimatedContainer(
            height: controller.sheetHeight,
            duration: const Duration(milliseconds: 200),
            decoration: const BoxDecoration(
              color: Colors.white,
              borderRadius: BorderRadius.only(
                topLeft: Radius.circular(20.0),
                topRight: Radius.circular(20.0),
              ),
            ),
            child: DefaultTabController(
              length: 3,
              initialIndex: 0,
              child: Column(
                mainAxisSize: MainAxisSize.min,
                children: [
                  TabBar(
                    controller: controller.tabController,
                    onTap: (index) {
                      controller.updateseachableProductList(index);
                      controller.tabIndex = index;
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
                        if (EBBools.isQuickPresent) billTab(),
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
}

Widget mobileBillItemsWidget() {
  return GetBuilder<CashierBillsController>(builder: (controller) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.end,
      children: [
        Padding(
          padding: const EdgeInsets.only(right: 6),
          child: Text(
            controller.shopproductid,
            style: EBAppTextStyle.billQty,
          ),
        ),
        SizedBox(
          height: controller.isExpanded
              ? EBSizeConfig.screenHeight * 0.18
              : EBSizeConfig.screenHeight * 0.60,
          child: ListView.builder(
            padding: EBSizeConfig.textContentPadding,
            itemCount: controller.billItems.length,
            itemBuilder: (context, index) => Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Flexible(
                  child: Text(
                      '${EBAppString.productlanguage == 'English' ? controller.billItems[index].productNameEnglish : controller.billItems[index].productnameTamil} (${controller.converDecimalConditionally(controller.billItems[index].quantity!)})',
                      style: EBAppTextStyle.billItemStyle),
                ),
                Row(
                  children: [
                    Text(' + ${controller.billItems[index].totalprice!.toStringAsFixed(2)}',
                        style: EBAppTextStyle.avtiveTxt),
                    IconButton(
                      icon: const Icon(
                        Icons.edit_outlined,
                        size: 16,
                      ), // 'x' icon
                      onPressed: () {
                        // edit bottom sheet
                        controller.billItemIndex = index;

                        controller.itemQuantityController.text =
                            controller.billItems[index].quantity.toString();
                        billItemEditorBottomSheet(
                            context, controller.billItems[index]);
                      },
                    ),
                  ],
                )
              ],
            ),
          ),
        ),
      ],
    );
  });
}
