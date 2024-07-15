import 'package:easybill_app/app/widgets/custom_widgets/custom_scaffold.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

import '../../../../constants/app_string.dart';
import '../../../../constants/app_text_style.dart';
import '../../../../constants/size_config.dart';
import '../../../../routes/app_pages.dart';
import '../../../../widgets/custom_widgets/custom_container.dart';
import '../../../../widgets/custom_widgets/custom_elevated_icon_button.dart';
import '../../../../widgets/loading_widget.dart';
import '../controllers/cashiers_controller.dart';

class CashiersView extends GetView<CashiersController> {
  const CashiersView({super.key});
  @override
  Widget build(BuildContext context) {
    EBSizeConfig.init(context);
    return EBCustomScaffold(
      body: SafeArea(
        child: Padding(
          padding: EBSizeConfig.edgeInsetsActivities,
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Row(
                mainAxisAlignment: MainAxisAlignment.end,
                children: [
                  CustomElevatedIconButton(
                    onPressed: () {
                      Get.toNamed(Routes.CASHIER_REGISTER, arguments: {
                        'isEditMode': false,
                        //'cashierList': controller.cashierList,
                      });
                    },
                    label: Text(
                      EBAppString.addStaff,
                      style: EBAppTextStyle.button,
                    ),
                  ),
                ],
              ),

              // staff details widget

              Expanded(
                  child:
                      //controller.cashierList == null
                      //? msgForNoStaff()
                      cashierDetailsList()),
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
      ),
    );
  }

  Widget msgForNoStaff() {
    return Center(
      child: Text(
        'Add first staff',
        style: EBAppTextStyle.bodyText,
      ),
    );
  }

  Widget cashierDetailsList() {
    return GetBuilder<CashiersController>(builder: (_) {
      if (controller.cashierList == null) return const LoadingWidget();
      return GridView.builder(
        gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
          crossAxisCount: 2, // Number of columns
          crossAxisSpacing: 10.0, // Spacing between columns
          mainAxisSpacing: 10.0, // Spacing between rows
          childAspectRatio: 2,
        ),
        shrinkWrap: true,
        itemCount: controller.cashierList!.length,
        itemBuilder: (context, index) {
          return GestureDetector(
            onTap: () {
              Get.toNamed(Routes.CASHIER_REGISTER, arguments: {
                'isEditMode': true,
                'selectedCashier': controller.cashierList![index],
              });
            },
            child: CustomContainer(
              padding: EBSizeConfig.edgeInsetsAll04,
              noHeight: true,
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Expanded(
                    child: Row(
                      children: [
                        Text('Login Username', style: EBAppTextStyle.catStyle),
                        //      IconButton(
                        //   onPressed: () {
                        //     // _deleteAlertDialof(
                        //     //     controller.cashierList![index]);
                        //   },
                        //   icon: const Icon(

                        //      textDirection: TextDirection.ltr,
                        //     Icons.delete_forever, size: 18, color: Colors.red),
                        // ),
                      ],
                    ),
                  ),
                  Expanded(
                    child: Text(
                      '${controller.cashierList![index].loginusername}',
                      style: EBAppTextStyle.catStyle,
                      overflow: TextOverflow.ellipsis,
                    ),
                  ),

                  Expanded(
                      child: Row(
                    children: [
                      Text(
                        'Username :',
                        style: EBAppTextStyle.bodyText,
                      ),
                      Flexible(
                        child: Text(
                          ' ${controller.cashierList![index].staffname}',
                          style: EBAppTextStyle.bodyText,
                        ),
                      ),
                    ],
                  )),

                  Expanded(
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Expanded(
                          child: Text(
                            'Role : ${controller.cashierList![index].userrole}',
                            style: EBAppTextStyle.bodyText,
                          ),
                        ),
                        Text(
                          controller.cashierList![index].isactive!
                              ? 'Active'
                              : 'Idle',
                          style: EBAppTextStyle.avtiveTxt,
                        ),
                      ],
                    ),
                  ),
                  // Row(
                  //   mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  //   children: [
                  //     Text(
                  //         'Username : ${controller.cashierList![index].username}',
                  //         style: EBAppTextStyle.bodyText),
                  //     Text(
                  //       'Role : ${controller.cashierList![index].userrole}',
                  //       style: EBAppTextStyle.bodyText,
                  //     ),
                  //   ],
                  // ),
                ],
              ),
            ),
          );
        },
      );

      // ListView.builder(
      //   shrinkWrap: true,
      //   itemCount: controller.cashierList!.length,
      //   itemBuilder: (context, index) => GestureDetector(
      //     onTap: () {
      //       Get.toNamed(Routes.CASHIER_REGISTER, arguments: {
      //         'isEditMode': true,
      //         'selectedCashier': controller.cashierList![index],
      //       });
      //     },
      //     child: CustomContainer(
      //       noHeight: true,
      //       child: Column(
      //         children: [
      //           Row(
      //             mainAxisAlignment: MainAxisAlignment.spaceBetween,
      //             children: [
      //               Text(
      //                   'Login Username : ${controller.cashierList![index].loginusername}',
      //                   style: EBAppTextStyle.catStyle),
      //               Text(
      //                 controller.cashierList![index].isactive!
      //                     ? 'Actice'
      //                     : 'Idle',
      //                 style: EBAppTextStyle.avtiveTxt,
      //               ),
      //             ],
      //           ),
      //           Row(
      //             mainAxisAlignment: MainAxisAlignment.spaceBetween,
      //             children: [
      //               Text(
      //                   'Username : ${controller.cashierList![index].username}',
      //                   style: EBAppTextStyle.bodyText),
      //               Text(
      //                 'Role : ${controller.cashierList![index].userrole}',
      //                 style: EBAppTextStyle.bodyText,
      //               ),
      //             ],
      //           ),
      //         ],
      //       ),
      //     ),
      //   ),
      // );
    });
  }
}
