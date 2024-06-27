import 'package:easybill_app/app/constants/size_config.dart';
import 'package:easybill_app/app/constants/themes.dart';
import 'package:easybill_app/app/modules/cashier/cashier_bills/controllers/cashier_bills_controller.dart';
import 'package:easybill_app/app/modules/cashier/cashier_bills/views/bill_calculator_button_widget.dart';
import 'package:easybill_app/app/modules/cashier/cashier_bills/views/bill_calculator_widget.dart';
import 'package:easybill_app/app/modules/cashier/cashier_bills/views/bill_items_edit.dart';
import 'package:easybill_app/app/modules/cashier/cashier_bills/views/product_search_sheet.dart';
import 'package:easybill_app/app/widgets/custom_widgets/custom_container.dart';
import 'package:easybill_app/app/widgets/custom_widgets/custom_scaffold.dart';
import 'package:easybill_app/app/widgets/custom_widgets/custom_text_button.dart';
import 'package:easybill_app/app/widgets/responsive.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import '../../../../constants/app_string.dart';
import '../../../../constants/app_text_style.dart';
import '../../../../constants/bools.dart';
import '../../../../data/models/product.dart';
import '../../../../routes/app_pages.dart';
import '../../../../widgets/custom_widgets/custom_alert_dialog.dart';
import '../../../../widgets/custom_widgets/custom_elevated_button.dart';
import '../../../../widgets/loading_widget.dart';

class CashierBillsView extends GetView<CashierBillsController> {
  const CashierBillsView({super.key});

  @override
  Widget build(BuildContext context) {
    EBSizeConfig.init(context);
    return GetBuilder<CashierBillsController>(
      builder: (controller) {
        return EBCustomScaffold(
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
                      onPressed: () {
                        controller.addBillItemByQrOrBarcode();
                        // controller.showScanner = !controller.showScanner;
                        // controller.isExpanded = !controller.isExpanded;
                        // controller.update();
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
                        '${controller.totalPrice}  Bill',
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
            tablet: mobileBillItemsWidget(),
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

  Widget tabBottomSheet(
      CashierBillsController controller, BuildContext context) {
    return Container(
      constraints: const BoxConstraints(
        maxWidth: double.infinity,
      ),
      child: Column(
        mainAxisAlignment: MainAxisAlignment.end,
        children: [
          GestureDetector(
            onTap: controller.toggleSheet,
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

  Widget saleTab(context) {
    return GetBuilder<CashierBillsController>(
      builder: (_) {
        if (controller.inventoryController.filterableCategoryList == null) return const LoadingWidget();
        return Padding(
          padding: EBSizeConfig.edgeInsetsActivities,
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              const BillItemListWidget(),
              Flexible(
                child: Column(
                  children: [
                    Container(
                      width: 60,
                      height: 60,
                      decoration: const BoxDecoration(
                        shape: BoxShape.circle,
                        color: EBTheme.listColor,
                      ),
                      child: IconButton(
                        icon: const Icon(
                          Icons.search,
                          size: 32,
                          color: EBTheme.kPrimaryColor,
                        ),
                        onPressed: () {
                          controller.updateseachableProductList(0);
                          productSearchSheet(context);
                        },
                      ),
                    ),
                    Expanded(
                      child: ListView.builder(
                          itemCount: _.inventoryController
                              .filterableCategoryList!.length,
                          itemBuilder: (context, index) {
                            return GestureDetector(
                              onTap: () => _.categoryListPressed(index),
                              child: Container(
                                width: 60,
                                height: 60,
                                margin: const EdgeInsets.only(top: 12),
                                decoration: index == _.selectedIndex
                                    ? const BoxDecoration(
                                        shape: BoxShape.circle,
                                        color: EBTheme.kPrintBtnColor,
                                      )
                                    : const BoxDecoration(
                                        shape: BoxShape.circle,
                                        color: EBTheme.listColor,
                                      ),
                                child: Center(
                                  child: Text(
                                      _
                                          .inventoryController
                                          .filterableCategoryList![index]
                                          .categoryname!
                                          .substring(0, 3)
                                          .toUpperCase(),
                                      style: index == _.selectedIndex
                                          ? EBAppTextStyle.printBtn
                                          : EBAppTextStyle.bodyText),
                                ),
                              ),
                            );
                          }),
                    ),
                  ],
                ),
              ),
            ],
          ),
        );
      },
    );
  }

  Future deleteAlertDialog() {
    return const CustomAlertDialog().alertDialog(
      dialogTitle: 'Delete Bill',
      isformChildrenNeeded: true,
      dialogContent: 'Are you sure you want delete this Bill items',
      formKey: key,
      confirmButtonText: EBAppString.delete,
      confirmOnPressed: () {
        controller.cancelOrderPressed();
        Get.back();
      },
      cancelButtonText: EBAppString.cancel,
      cancelOnPressed: () {
        Get.back();
      },
    );
  }

  Widget billTab() {
    return GetBuilder<CashierBillsController>(builder: (_) {
      return BillCalculatorWidget(
        crossAxisCount: 4,
        mainAxisSpacing: 6,
        itemCount: _.calulaterButtons.length,
        itemBuilder: (BuildContext context, int index) {
          if (_.calulaterButtons[index] is String) {
            return CalculatorButton(
              btnText: _.calulaterButtons[index],
              onButtonPressed: () {
                _.shopproductid = _.shopproductid + _.calulaterButtons[index];
                _.update();
              },
            );
          } else if (_.calulaterButtons[index] == true) {
            return CalculatorButton(
              isAddItemBtn: _.calulaterButtons[index],
              onButtonPressed: _.seperatingQty,
            );
          } else {
            // Backspace for quickslae tab
            if (index == 3) {
              return CalculatorButton(
                btnIcon: _.calulaterButtons[index],
                onButtonPressed: () {
                  if (_.shopproductid.isNotEmpty) {
                    if (_.shopproductid[_.shopproductid.length - 1] == 'x') {
                      _.isXpressed = !_.isXpressed;
                      _.isDesimal = true;
                      _.update();
                    }
                    if (_.shopproductid[_.shopproductid.length - 1] == '.') {
                      _.isDecimalPressed = !_.isDecimalPressed;
                    }
                    _.shopproductid = _.shopproductid
                        .substring(0, _.shopproductid.length - 1);
                    _.update();
                  }
                },
              );
            }
            // if x pressed
            if (index == 7) {
              return CalculatorButton(
                btnIcon: _.calulaterButtons[index],
                onButtonPressed: () {
                  if (_.shopproductid.isNotEmpty && !_.isXpressed) {
                    _.shopproductid += 'x';
                    _.isXpressed = !_.isXpressed;
                    _.isShopProductIdPresent();
                    _.update();
                  }
                },
              );
            }
            return CalculatorButton(
                btnIcon:
                    _.isDesimal ? _.calulaterButtons[index] : const Icon(null),
                onButtonPressed: () {
                  if (_.shopproductid.isNotEmpty && !_.isDecimalPressed) {
                    _.shopproductid += '.';
                    _.isDecimalPressed = !_.isDecimalPressed;
                    _.update();
                  }
                });
          }
        },
      );
    });
  }

  Widget tokenTab() {
    return const Padding(
      padding: EdgeInsets.all(8.0),
      child: BillCalculatorTokenWidget(),
    );
  }
}

class PersistentBottomSheet extends StatelessWidget {
  final Widget child;

  const PersistentBottomSheet({super.key, required this.child});

  @override
  Widget build(BuildContext context) {
    return Positioned(
      // Position widget strategically
      bottom: 0.0,
      left: 0.0,
      right: 0.0, // Set full width
      child: Container(
        color: Colors.white, // Adjust background color as needed
        child: SafeArea(
          child: child, // Your bottom sheet content goes here
        ),
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
              ? EBSizeConfig.screenHeight * 0.13
              : EBSizeConfig.screenHeight * 0.60,
          child: ListView.builder(
            padding: EBSizeConfig.textContentPadding,
            itemCount: controller.billItems.length,
            itemBuilder: (context, index) => Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Text(
                    '${EBAppString.productlanguage == 'English' ? controller.billItems[index].productNameEnglish : controller.billItems[index].productnameTamil} ( ${controller.billItems[index].isDecimal == true ? controller.billItems[index].quantity : controller.billItems[index].quantity!.round()} )',
                    style: EBAppTextStyle.heading2),
                Row(
                  children: [
                    Text(' + ${controller.billItems[index].totalprice}',
                        style: EBAppTextStyle.avtiveTxt),
                    IconButton(
                      icon: const Icon(
                        Icons.edit_outlined,
                        size: 16,
                      ), // 'x' icon
                      onPressed: () {
                        // edit bottom sheet
                        controller.billItemIndex = index;
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

class BillCalculatorTokenWidget extends GetView<CashierBillsController> {
  const BillCalculatorTokenWidget({super.key});
  @override
  Widget build(BuildContext context) {
    return GetBuilder<CashierBillsController>(builder: (_) {
      if (controller.inventoryController.seachableProductList == null) {
        return const LoadingWidget();
      } else {
        return GridView.builder(
            gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
              crossAxisCount: 2, // Number of columns
              crossAxisSpacing: 10.0, // Spacing between columns
              mainAxisSpacing: 10.0, // Spacing between rows
              childAspectRatio: 2,
            ),
            itemCount: _.inventoryController.seachableProductList!
                .length, // Total number of items
            itemBuilder: (BuildContext context, int index) {
              // Return a widget for each item
              return GestureDetector(
                  onTap: () {
                    controller.productQuantity = '';
                    // controller.isDecimal = true;
                    Product product =
                        _.inventoryController.seachableProductList![index];

                    // quantityBillCalculatorBottomSheet(
                    //   context,
                    //   product,
                    // );
                    //quantityBillCalculatorWidget(product);
                    Get.toNamed(Routes.QUNATITY_BILL_CALCULATOR, arguments: {
                      "selectedProduct": product,
                    });
                  },
                  child: CustomContainer(
                      color: EBTheme.listColor,
                      child: Column(
                        children: [
                          Row(
                            children: [
                              Text(
                                EBAppString.productlanguage == 'English'
                                    ? _
                                        .inventoryController
                                        .seachableProductList![index]
                                        .productnameEnglish!
                                    : _
                                        .inventoryController
                                        .seachableProductList![index]
                                        .productnameTamil!,
                                style: EBAppTextStyle.bodyText,
                              )
                            ],
                          ),
                          const Spacer(),
                          Row(
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            children: [
                              Text(
                                _.inventoryController
                                    .seachableProductList![index].price
                                    .toString(),
                                style: EBAppTextStyle.catStyle,
                              ),
                              Text(
                                _.inventoryController
                                    .seachableProductList![index].unitid
                                    .toString(),
                                style: EBAppTextStyle.avtiveTxt,
                              )
                            ],
                          )
                        ],
                      ))
                  // Container(
                  //   color: Colors.blue,
                  //   child: Center(
                  //     child: Text(
                  //       'Item $index',
                  //       style: const TextStyle(color: Colors.white),
                  //     ),
                  //   ),
                  // ),
                  );
            });
      }
    });
  }
}

class BillItemListWidget extends GetView<CashierBillsController> {
  const BillItemListWidget({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return GetBuilder<CashierBillsController>(
      builder: (_) {
        if (controller.inventoryController.seachableProductList == null) return const LoadingWidget();
        return Expanded(
          flex: 4,
          child: GridView.builder(
            controller: ScrollController(),
            gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
              crossAxisCount: Responsive.isTablet(context) == true ? 4 : 2,
              crossAxisSpacing: 10.0, // Spacing between columns
              mainAxisSpacing: 10.0, // Spacing between rows
              childAspectRatio: 2,
            ),
            itemCount: _.inventoryController.seachableProductList!
                .length, // Total number of items
            itemBuilder: (BuildContext context, int index) {
              // Return a widget for each item

              return GestureDetector(
                onTap: () {
                  controller.productQuantity = '';
                  Product product =
                      _.inventoryController.seachableProductList![index];

                  print(
                      "${product.productnameEnglish} has popup ===========>> : ${product.showQuantityPopup}");
                  print(
                      "${product.productnameEnglish} has decimal ===========>> : ${product.isDecimalAllowed}");
                  print(
                      "${product.productnameEnglish} shopProduct Id ===========>> : ${product.shopproductid}");
                  product.showQuantityPopup == true
                      ? Get.toNamed(Routes.QUNATITY_BILL_CALCULATOR,
                          arguments: {
                              "selectedProduct": product,
                            })
                      : _.nextPressed(product);
                },
                child: CustomContainer(
                  color: EBTheme.listColor,
                  child: Column(
                    children: [
                      Row(
                        children: [
                          Expanded(
                            child: Text(
                              EBAppString.productlanguage == 'English'
                                  ? _
                                      .inventoryController
                                      .seachableProductList![index]
                                      .productnameEnglish!
                                  : _
                                      .inventoryController
                                      .seachableProductList![index]
                                      .productnameTamil!,
                              style: EBAppTextStyle.bodyText,
                              overflow: TextOverflow.ellipsis,
                            ),
                          )
                        ],
                      ),
                      const Spacer(),
                      Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          Text(
                            _.inventoryController.seachableProductList![index]
                                .price
                                .toString(),
                            style: EBAppTextStyle.catStyle,
                          ),
                          Text(
                            _.inventoryController.seachableProductList![index]
                                .shopproductid
                                .toString(),
                            style: EBAppTextStyle.avtiveTxt,
                          )
                        ],
                      )
                    ],
                  ),
                ),
                // Container(
                //   color: Colors.blue,
                //   child: Center(
                //     child: Text(
                //       'Item $index',
                //       style: const TextStyle(color: Colors.white),
                //     ),
                //   ),
                // ),
              );
            },
          ),
        );
      },
    );
  }

  // Future<void> quantityBillCalculatorBottomSheet(context) {
  //   return showModalBottomSheet<void>(
  //     context: context,
  //     isScrollControlled: true,
  //     builder: (BuildContext context) {
  //       return Padding(
  //         padding: EBSizeConfig.edgeInsetsAll15,
  //         child: Column(
  //           mainAxisAlignment: MainAxisAlignment.end,
  //           children: [
  //             EBSizeConfig.sizedBoxH20,
  //             Row(
  //               children: [
  //                 IconButton(
  //                   icon: const Icon(
  //                     Icons.close,
  //                     size: 30,
  //                   ), // 'x' icon
  //                   onPressed: () {
  //                     Get.back();
  //                   },
  //                 ),
  //                 // You can adjust the alignment or add more widgets here
  //               ],
  //             ),
  //             Expanded(
  //               child: CustomContainer(
  //                 color: EBTheme.kPrimaryWhiteColor,
  //                 child: Column(
  //                   crossAxisAlignment: CrossAxisAlignment.start,
  //                   children: [
  //                     Text(
  //                       'Pongal',
  //                       style: EBAppTextStyle.heading2,
  //                     ),
  //                     Text(
  //                       'Enter quantity',
  //                       style: EBAppTextStyle.bodyText,
  //                     ),
  //                   ],
  //                 ),
  //               ),
  //             ),
  //             Expanded(
  //               child: CustomContainer(
  //                 padding: EBSizeConfig.edgeInsetsAll10,
  //                 // alignment: Alignment.bottomRight,
  //                 color: EBTheme.kPrimaryWhiteColor,
  //                 child: Row(
  //                   //crossAxisAlignment: CrossAxisAlignment.end,
  //                   mainAxisAlignment: MainAxisAlignment.spaceBetween,
  //                   children: [
  //                     Text(
  //                       '1',
  //                       style: EBAppTextStyle.heading1,
  //                     ),
  //                     IconButton(
  //                       icon: const Icon(Icons.backspace),
  //                       onPressed: () {
  //                         // final text = controller.text;
  //                         // if (text.isNotEmpty) {
  //                         //   final newText = text.substring(0, text.length - 1);
  //                         //   controller.value =
  //                         //    TextEditingValue(
  //                         //     text: newText,
  //                         //     selection: TextSelection.collapsed(offset: newText.length),
  //                         //   );
  //                         // }
  //                       },
  //                     ),
  //                   ],
  //                 ),
  //               ),
  //             ),
  //             GridView.count(
  //               shrinkWrap: true,
  //               crossAxisCount: 3,
  //               mainAxisSpacing: 4,
  //               crossAxisSpacing: 6,
  //               children: const [
  //                 CalculatorButton(btnText: '1'),
  //                 CalculatorButton(btnText: '2'),
  //                 CalculatorButton(btnText: '3'),
  //                 CalculatorButton(btnText: '4'),
  //                 CalculatorButton(btnText: '5'),
  //                 CalculatorButton(btnText: '6'),
  //                 CalculatorButton(btnText: '7'),
  //                 CalculatorButton(btnText: '8'),
  //                 CalculatorButton(btnText: '9'),
  //                 CalculatorButton(
  //                     btnIcon: Icon(
  //                   Icons.circle,
  //                   size: 10,
  //                 )),
  //                 CalculatorButton(btnText: '00'),
  //                 CalculatorButton(btnText: '0'),
  //               ],
  //             ),
  //             EBSizeConfig.sizedBoxH20,
  //             const CustomElevatedButton(
  //                 onPressed: null, child: Text(EBAppString.next))
  //           ],
  //         ),
  //       );
  //     },
  //   );
  // }
}
