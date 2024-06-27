import 'package:easybill_app/app/widgets/custom_widgets/custom_scaffold.dart';
import 'package:flutter/material.dart';

import 'package:get/get.dart';

import '../controllers/admin_help_controller.dart';

class AdminHelpView extends GetView<AdminHelpController> {
  const AdminHelpView({super.key});
  @override
  Widget build(BuildContext context) {
    return const EBCustomScaffold(
      body: Center(
        child: Text(
          'AdminHelpView is working',
          style: TextStyle(fontSize: 20),
        ),
      ),
    );
  }
}
