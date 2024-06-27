import 'package:easybill_app/app/modules/cashier/cashier_bills/controllers/cashier_bills_controller.dart';
import 'package:flutter/material.dart';
import 'package:flutter_staggered_grid_view/flutter_staggered_grid_view.dart';
import 'package:get/get.dart';

class BillCalculatorWidget extends GetView<CashierBillsController> {
  final int crossAxisCount;
  final IndexedWidgetBuilder itemBuilder;
  final int itemCount;
  final double? mainAxisSpacing;
  const BillCalculatorWidget(
      {super.key,
      required this.crossAxisCount,
      required this.itemBuilder,
      required this.itemCount,
      this.mainAxisSpacing});

  @override
  Widget build(BuildContext context) {
    return MasonryGridView.builder(
      shrinkWrap: true,
      physics: const NeverScrollableScrollPhysics(),
      gridDelegate: SliverSimpleGridDelegateWithFixedCrossAxisCount(
        crossAxisCount: crossAxisCount,
      
      ),
      crossAxisSpacing: 6,
      mainAxisSpacing: mainAxisSpacing ?? 10,
      itemBuilder: itemBuilder,
      itemCount: itemCount,
    );
  }
}
