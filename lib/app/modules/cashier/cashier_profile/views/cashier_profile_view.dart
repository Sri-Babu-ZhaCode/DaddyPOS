import 'package:flutter/material.dart';
import 'package:get/get.dart';

import '../../../../constants/app_string.dart';
import '../../../../constants/size_config.dart';
import '../../../../constants/themes.dart';
import '../../../../widgets/custom_widgets/custom_container.dart';
import '../../../../widgets/custom_widgets/custom_list_tile.dart';
import '../../../../widgets/custom_widgets/custom_scaffold.dart';
import '../../../admin/admin_profile/views/update_pass_dialog.dart';
import '../controllers/cashier_profile_controller.dart';

class CashierProfileView extends GetView<CashierProfileController> {
  const CashierProfileView({super.key});
  @override
  Widget build(BuildContext context) {
    return EBCustomScaffold(
      body: Padding(
        padding: EBSizeConfig.edgeInsetsOnlyH250,
        child: ListView( 
          children: [
            GetBuilder<CashierProfileController>(builder: (_) {
              return Form(
                //   key: _.formKey,
                child: Padding(
                  padding: EBSizeConfig.edgeInsetsActivities,
                  child: CustomContainer(
                    noHeight: true,
                    borderWidth: 2,
                    padding: EBSizeConfig.edgeInsetsAll20,
                    color: EBTheme.kPrimaryWhiteColor,
                    borderColor: EBTheme.silverColor,
                    child: Column(
                      children: [
                        EBCustomListTile(
                          trailingIconSize: 20,
                          titleName: EBAppString.updatePassword,
                          trailingIcon: Icons.edit,
                          onTap: () async {
                           await updatePassDialog(_);
                          },
                        ),
                      ]
                          .expand(
                            (element) => [
                              element,
                             // EBSizeConfig.sizedBoxH15,
                            ],
                          )
                          .toList(),
                    ),
                  ),
                ),
              );
            }),
          ],
        ),
      ),
    );
  }
}
