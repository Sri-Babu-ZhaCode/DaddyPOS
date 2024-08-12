import 'package:easybill_app/app/constants/size_config.dart';
import 'package:easybill_app/app/modules/cashier/cashier_bills/views/widgets/product_list.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

import '../../../../../constants/app_text_style.dart';
import '../../../../../constants/themes.dart';
import '../../../../../widgets/loading_widget.dart';
import '../../controllers/cashier_bills_controller.dart';
import '../product_search_sheet.dart';

Widget saleTab(context) {
  return GetBuilder<CashierBillsController>(
    builder: (_) {
      if (_.inventoryController.filterableCategoryList == null ) return const LoadingWidget();
      return Padding(
        padding: EBSizeConfig.edgeInsetsActivities,
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            const ProductListWidget(),
            Expanded(
              child: Column(
                children: [
                  Container(
                    height: 60,
                    width: 60,
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
                      onPressed: () async {
                        _.updateseachableProductList(0);
                        await productSearchSheet(context);
                        _.updateseachableProductList(0);
                        _.update();
                      },
                    ),
                  ),
                  Expanded(
                    child: ListView.builder(
                        itemCount: _
                            .inventoryController.filterableCategoryList!.length,
                        itemBuilder: (context, index) {
                          return GestureDetector(
                            onTap: () => _.categoryListPressed(index),
                            child: Container(
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
