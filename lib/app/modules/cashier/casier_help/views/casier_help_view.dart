import 'package:flutter/material.dart';

import 'package:get/get.dart';

import '../../../../widgets/custom_widgets/custom_scaffold.dart';
import '../controllers/casier_help_controller.dart';

class CasierHelpView extends GetView<CasierHelpController> {
  const CasierHelpView({super.key});
  @override
  Widget build(BuildContext context) {
    return const EBCustomScaffold(
      body: Center(
        child: Text(
          'CasierHelpView is working',
          style: TextStyle(fontSize: 20),
        ),
      ),
    );
  }
}
