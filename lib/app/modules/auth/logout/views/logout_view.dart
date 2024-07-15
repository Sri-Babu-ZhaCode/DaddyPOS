import 'package:easybill_app/app/constants/themes.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import '../../../../constants/app_string.dart';
import '../../../../constants/app_text_style.dart';
import '../../../../constants/size_config.dart';
import '../../../../widgets/custom_widgets/custom_elevated_button.dart';
import '../controllers/logout_controller.dart';

class LogoutView extends GetView<LogoutController> {
  const LogoutView({super.key});
  @override
  Widget build(BuildContext context) {
    EBSizeConfig.init(context);
    return GetBuilder<LogoutController>(builder: (_) {
      return Scaffold(
        body: SafeArea(
          child: Padding(
            padding: EBSizeConfig.edgeInsetsActivitiesDouble,
            child: Column(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Card(
                  elevation: 4,
                  color: EBTheme.kPrimaryWhiteColor,
                  margin: EBSizeConfig.edgeInsetsAll15,
                  child: Padding(
                    padding: EBSizeConfig.edgeInsetsAll15,
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        // Image.network(
                        //   'https://example.com/clock.png', // Replace with your image URL
                        //   height: 50.0,
                        // ),

                        Text(
                          'Warning !',
                          style: EBAppTextStyle.heading1,
                          textAlign: TextAlign.left,
                        ),

                        Text(
                            'Only one device login allowed at a time. Please logout from other devices if you intend to login here.',
                            style: EBAppTextStyle.bodyText),
                      ],
                    ),
                  ),
                ),
                logoOutButtons(_),
              ],
            ),
          ),
        ),
      );
    });
  }
}

Widget logoOutButtons(LogoutController _) {
  return Column(
    children: [
      CustomElevatedButton(
        onPressed: () {
          _.onLogoutPressed();
        },
        child: Text(
          EBAppString.logoutFromOtherDevices,
          style: EBAppTextStyle.button,
        ),
      ),
      EBSizeConfig.sizedBoxH15,
      CustomElevatedButton(
        btnColor: EBTheme.kPrimaryWhiteColor,
        onPressed: () {
          Get.back();
        },
        child: Text(
          EBAppString.cancel,
          style: EBAppTextStyle.customeTextStyle(
            color: EBTheme.blackColor,
            fontSize: 18,
            fontWeigh: FontWeight.w500,
          ),
        ),
      ),
      EBSizeConfig.sizedBoxH15,
    ],
  );
}
