// ignore_for_file: no_wildcard_variable_uses

import 'package:easybill_app/app/constants/app_string.dart';
import 'package:easybill_app/app/constants/app_text_style.dart';
import 'package:easybill_app/app/constants/size_config.dart';
import 'package:easybill_app/app/constants/themes.dart';
import 'package:easybill_app/app/widgets/custom_widgets/custom_container.dart';
import 'package:easybill_app/app/widgets/custom_widgets/custom_scaffold.dart';
import 'package:easybill_app/app/widgets/loading_widget.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import '../../../../constants/bools.dart';
import '../../../../widgets/custom_widgets/custom_elevated_button.dart';
import '../controllers/subscription_controller.dart';

class SubscriptionView extends GetView<SubscriptionController> {
  const SubscriptionView({super.key});
  @override
  Widget build(BuildContext context) {
    return EBCustomScaffold(
      noDrawer: true,
      resizeToAvoidBottomInset: false,
      bottomSheet: Container(
        height: 85,
        width: double.infinity,
        decoration: const BoxDecoration(
          color: Colors.white,
          boxShadow: [
            BoxShadow(
              color: Color.fromRGBO(58, 57, 57, 1),
              offset: Offset(0.0, 1.0), //(x,y)
              blurRadius: 6.0,
            ),
          ],
        ),
        child: Padding(
          padding: EBSizeConfig.edgeInsetsAll20,
          child: GetBuilder<SubscriptionController>(
              init: controller, // use it only first time on each controller
              builder: (_) {
                return CustomElevatedButton(
                  onPressed: () {
                    _.onNextBtnPressed();
                  },
                  // : null,
                  child: EBBools.isLoading
                      ? const LoadingWidget(color: EBTheme.kPrimaryWhiteColor)
                      : Text(
                          EBAppString.next,
                          style: EBAppTextStyle.button,
                        ),
                );
              }),
        ),
      ),
      body: Padding(
        padding: EBSizeConfig.edgeInsetsActivities,
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            EBSizeConfig.sizedBoxH10,
            Text(
              'Choose Subscription',
              style: EBAppTextStyle.heading2,
            ),
            const SubscriptionListWidget(),
          ]
              .expand(
                (element) => [
                  element,
                  EBSizeConfig.sizedBoxH15,
                ],
              )
              .toList(),
        ),
      ),
    );
  }

  // Future setPasswordAlertDialof(SubscriptionController controller) {
  //   return const CustomAlertDialog().alertDialog(
  //     key: key,
  //     makeUpPopbale: true,
  //     dialogTitle: 'Create Password',
  //     dialogContent: 'Please update password',
  //     formChildren: [
  //       Form(
  //         key: controller.formKey,
  //         child: Column(
  //           children: [
  //             CustomTextFormField(
  //               controller: controller.mobileController,
  //               readOnly: true,
  //               labelText: EBAppString.mobile,
  //               maxLength: 10,
  //               keyboardType: TextInputType.phone,
  //               inputFormatters: <TextInputFormatter>[
  //                 FilteringTextInputFormatter.digitsOnly
  //               ],
  //             ),
  //             EBSizeConfig.sizedBoxH15,
  //             CustomTextFormField(
  //                 controller: controller.passwordController,
  //                 labelText: EBAppString.pass,
  //                 validator: (value) => EBValidation.validateIsEmpty(value!)),
  //           ],
  //         ),
  //       ),
  //     ],
  //     confirmButtonText: EBAppString.update,
  //     confirmOnPressed: () {
  //       controller.onUpdatePressed();
  //     },
  //     cancelButtonText: EBAppString.cancel,
  //     cancelOnPressed: () {
  //       Get.back();
  //     },
  //   );
  // }
}

class SubscriptionListWidget extends StatelessWidget {
  const SubscriptionListWidget({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    EBSizeConfig.init(context);
    return GetBuilder<SubscriptionController>(builder: (_) {
      if (EBBools.isLoading) return const LoadingWidget();
      return Padding(
        padding: EBSizeConfig.edgeInsetsActivities,
        child: ListView.builder(
            addRepaintBoundaries: true,
            shrinkWrap: true,
            itemCount: _.subscriptionList!.length,
            itemBuilder: (context, index) {
              debugPrint(
                  "screen width of this container ------------->> ${EBSizeConfig.screenWidth}");
              return GestureDetector(
                onTap: () {
                  _.selectedIndex = index;
                  // updating selected subscrpition
                  _.selectedSubscription = _.subscriptionList![index];
                  _.update();
                },
                child: CustomContainer(
                  borderColor:
                      _.selectedIndex == index ? EBTheme.kPrimaryColor : null,
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text(
                              _.subscriptionList![index].planname!
                                  .toUpperCase(),
                              style: EBAppTextStyle.billQty),
                          Text('Price ${_.subscriptionList![index].price!}',
                              style: EBAppTextStyle.subStyle),
                        ],
                      ),
                      SizedBox(
                        width: EBSizeConfig.screenWidth * 0.2,
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Text('Screens', style: EBAppTextStyle.bodyText),
                            ListView.builder(
                              shrinkWrap: true,
                              itemCount: _
                                  .subscriptionList![index].screenAcess!.length,
                              itemBuilder: (context, screenIndex) => Text(
                                  _.subscriptionList![index]
                                      .screenAcess![screenIndex],
                                  style: EBAppTextStyle.catStyle),
                            ),
                          ],
                        ),
                      )
                    ],
                  ),
                ),
              );
            }),
        //   List.generate(
        //     _.membershipLevels.length,
        //     (index) => GestureDetector(
        //       onTap: () {
        //         _.selectedIndex.value = index;
        //         _.update();
        //       },
        //       child: CustomContainer(
        //         borderColor:
        //             _.selectedIndex.value == index ? EBTheme.kPrimaryColor : null,
        //         child: Center(
        //           child: Text(_.membershipLevels[index],
        //               style: EBAppTextStyle.heading2),
        //         ),
        //       ),
        //     ),
        //   ),
      );
    });
  }
}
