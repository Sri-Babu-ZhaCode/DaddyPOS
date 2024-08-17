// ignore_for_file: no_wildcard_variable_uses

import 'package:easybill_app/app/constants/size_config.dart';
import 'package:easybill_app/app/constants/themes.dart';
import 'package:easybill_app/app/modules/admin/qr_scanner/views/qr_scanner_view.dart';
import 'package:easybill_app/app/modules/cashier/cashier_bills/controllers/cashier_bills_controller.dart';
import 'package:easybill_app/app/modules/cashier/cashier_bills/views/bill_items_edit.dart';
import 'package:easybill_app/app/widgets/custom_widgets/custom_scaffold.dart';
import 'package:easybill_app/app/widgets/custom_widgets/custom_text_button.dart';
import 'package:easybill_app/app/widgets/responsive.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:mobile_scanner/mobile_scanner.dart';
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
            height: 70,
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
              padding: EBSizeConfig.edgeInsetsAll08,
              child: Row(
                children: [
                  Expanded(
                    flex: 3,
                    child: CustomElevatedButton(
                      btnColor: EBTheme.kPrimaryWhiteColor,
                      onPressed: () async {
                        if (controller.showScanner == true) {
                          debugPrint(
                              'scanner controller disposed ----------------------->>');
                          await controller.mobileScannerCtrl?.dispose();
                          await controller.mobileScannerCtrl?.stop();
                        }
                        EBBools.triggeredFromBillTab = true;
                        controller.qrQuantity = 1;
                        controller.showScanner = !controller.showScanner;
                        controller.update();
                        // await Get.toNamed(Routes.QR_SCANNER);
                      },
                      child: !controller.showScanner
                          ? const Icon(
                              color: EBTheme.kPrintBtnColor,
                              Icons.qr_code_scanner_outlined,
                              size: 30,
                            )
                          : const Icon(
                              color: EBTheme.kCancelBtnColor,
                              Icons.close_outlined,
                              size: 35,
                            ),
                    ),
                  ),
                  Expanded(
                    flex: 6,
                    child: CustomElevatedButton(
                      btnColor: EBTheme.kPrintBtnColor,
                      onPressed: () {
                        controller.billItemsTotalPrice > 0.01
                            ? Get.toNamed(Routes.BILL_DETAILS,
                                arguments: {'billItems': controller.billItems})
                            : null;
                      },
                      child: Text(
                        '${controller.billItemsTotalPrice.toStringAsFixed(1)}  Bill',
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
            mobile: mobileBillItemsWidget(context),
            tablet: tabBillItemsWidget(context),
          ),
        );
      },
    );
  }

  Widget mobileBottomSheet(
      CashierBillsController controller, BuildContext context) {
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
      child: Column(
        mainAxisAlignment: MainAxisAlignment.end,
        children: [
          GestureDetector(
            onTap: controller.toggleSheetForTab,
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
                            controller.tabIndex = index;
                          },
                          overlayColor: WidgetStatePropertyAll(
                              EBTheme.kPrimaryLightColor),
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

Widget qrScannerWidget(CashierBillsController _, context) {
  // _.qrInitScanner();
  _.mobileScannerCtrl = MobileScannerController(
    // formats: const [BarcodeFormat.qrCode],
    formats: const [BarcodeFormat.all],
    detectionTimeoutMs: int.parse(EBAppString.settimeinterval ?? '2') * 1000,
  );
  EBSizeConfig.init(context);

  //  Rect.fromCenter(center: Offset.fromDirection(5), height: 200, width: 200);//
  Rect scanWindow =
      Rect.fromLTWH(0, 0, EBSizeConfig.screenWidth, EBSizeConfig.screenHeight);
  // var scanWindow = Rect.fromCenter(
  //   center: MediaQuery.sizeOf(context).center(Offset.zero),
  //   width: 200,
  //   height: 200,
  // );
  return Stack(
    fit: StackFit.expand,
    children: [
      Center(
        child: MobileScanner(
          fit: BoxFit.fill,
          controller: _.mobileScannerCtrl,
          scanWindow: scanWindow,
          errorBuilder: (context, error, child) {
            return ScannerErrorWidget(error: error);
          },
          overlayBuilder: (context, constraints) {
            return Padding(
              padding: const EdgeInsets.all(16.0),
              child: Align(
                alignment: Alignment.topCenter,
                child: ScannedBarcodeLabel(
                    barcodes: _.mobileScannerCtrl!.barcodes),
              ),
            );
          },
          onDetect: (capture) async {
            _.mobileScannerCtrl!.detectionTimeoutMs;
            final List<Barcode> barcodes = capture.barcodes;
            //   LogUtility.custom('Capture Object ${capture.raw}');
            //   LogUtility.custom('RAW ${capture.raw}');
            var value = barcodes.isNotEmpty ? barcodes.first.rawValue : null;
            if (value != null) {
              debugPrint(
                  ' ----------------------------------->>  : barcode value $value');
              if (EBBools.triggeredFromBillTab) {
                //   Timer(const Duration(seconds: 2), () {
                Get.find<CashierBillsController>()
                    .addBillItemByQrOrBarcode(value);
                _.update();

                //  });
              } else {
                debugPrint(
                    ' oppes else part executed ------------------------->>>');
                Get.back(result: value);
                _.mobileScannerCtrl!.stop();
              }
              //  context.pop(value);
            }
          },
        ),
      ),
      ValueListenableBuilder(
        valueListenable: _.mobileScannerCtrl!,
        builder: (context, value, child) {
          if (!value.isInitialized || !value.isRunning || value.error != null) {
            return const SizedBox();
          }

          return CustomPaint(
            painter: ScannerOverlay(scanWindow: scanWindow),
          );
        },
      ),
      Align(
        alignment: Alignment.bottomCenter,
        child: Padding(
          padding: const EdgeInsets.all(16.0),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceEvenly,
            children: [
              ToggleFlashlightButton(controller: _.mobileScannerCtrl!),
              SwitchCameraButton(controller: _.mobileScannerCtrl!),
            ],
          ),
        ),
      ),
    ],
  );
}

Widget mobileBillItemsWidget(BuildContext context) {
  EBSizeConfig.init(context);
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
          height: !controller.isExpanded
              ? EBSizeConfig.screenHeight * 0.17
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
                      style: EBAppTextStyle.billItemsText),
                ),
                Row(
                  children: [
                    Text(
                        ' + ${controller.billItems[index].totalprice!.toStringAsFixed(2)}',
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
