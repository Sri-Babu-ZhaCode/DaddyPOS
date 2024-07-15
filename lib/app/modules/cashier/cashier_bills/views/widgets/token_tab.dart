import 'package:flutter/widgets.dart';
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

Widget tokenTab() {
  return const Padding(
    padding: EdgeInsets.all(8.0),
    child: BillCalculatorTokenWidget(),
  );
}

class BillCalculatorTokenWidget extends GetView<CashierBillsController> {
  const BillCalculatorTokenWidget({super.key});
  @override
  Widget build(BuildContext context) {
    return GetBuilder<CashierBillsController>(builder: (_) {
      if (_.inventoryController.seachableProductList == null) {
        return const LoadingWidget();
      } else {
        return GridView.builder(
            gridDelegate:  SliverGridDelegateWithFixedCrossAxisCount(
              crossAxisCount:  Responsive.isTablet(context) == true ? 3 :  2, // Number of columns
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
                    _.productQuantity = '';
                    // _.isDecimal = true;
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
                                ),
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
                                    .seachableProductList![index].shopproductid
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
