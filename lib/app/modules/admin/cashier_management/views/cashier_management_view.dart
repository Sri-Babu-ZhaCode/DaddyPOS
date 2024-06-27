import 'package:flutter/material.dart';

import 'package:get/get.dart';

import '../controllers/cashier_management_controller.dart';

class CashierManagementView extends GetView<CashierManagementController> {
  const CashierManagementView({Key? key}) : super(key: key);
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('CashierManagementView'),
        centerTitle: true,
      ),
      body: const Center(
        child: Text(
          'CashierManagementView is working',
          style: TextStyle(fontSize: 20),
        ),
      ),
    );
  }
}
