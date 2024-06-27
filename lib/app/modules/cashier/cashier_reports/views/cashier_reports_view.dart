import 'package:flutter/material.dart';

import 'package:get/get.dart';

import '../../../../widgets/custom_widgets/custom_scaffold.dart';
import '../controllers/cashier_reports_controller.dart';

class CashierReportsView extends GetView<CashierReportsController> {
  const CashierReportsView({super.key});
  @override
  Widget build(BuildContext context) {
    return const EBCustomScaffold(
      body: Center(
        child: Text(
          'CashierReportsView is working',
          style: TextStyle(fontSize: 20),
        ),
      ),
    );
  }
}
