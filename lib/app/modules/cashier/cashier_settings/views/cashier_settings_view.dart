import 'package:flutter/material.dart';

import 'package:get/get.dart';

import '../controllers/cashier_settings_controller.dart';

class CashierSettingsView extends GetView<CashierSettingsController> {
  const CashierSettingsView({Key? key}) : super(key: key);
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('CashierSettingsView'),
        centerTitle: true,
      ),
      body: const Center(
        child: Text(
          'CashierSettingsView is working',
          style: TextStyle(fontSize: 20),
        ),
      ),
    );
  }
}
