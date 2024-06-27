import 'package:flutter/material.dart';

import 'package:get/get.dart';

import '../controllers/cashier_controller.dart';

class CashierView extends GetView<CashierController> {
  const CashierView({super.key});
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('CashierView'),
        centerTitle: true,
      ),
      body: const Center(
        child: Text(
          'CashierView is working',
          style: TextStyle(fontSize: 20),
        ),
      ),
    );
  }
}
