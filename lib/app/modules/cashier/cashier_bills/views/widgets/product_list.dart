import 'package:flutter/material.dart';
import 'package:get/get.dart';

import '../../../../../constants/app_string.dart';
import '../../../../../constants/app_text_style.dart';
import '../../../../../constants/themes.dart';
import '../../../../../data/models/product.dart';
import '../../../../../routes/app_pages.dart';
import '../../../../../widgets/custom_widgets/custom_container.dart';
import '../../../../../widgets/loading_widget.dart';
import '../../../../../widgets/responsive.dart';
import '../../controllers/cashier_bills_controller.dart';

class ProductListWidget extends GetView<CashierBillsController> {
  const ProductListWidget({
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
              crossAxisCount: Responsive.isTablet(context) == true ? 3 : 2,
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
                          Flexible(
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