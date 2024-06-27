import 'dart:convert';

import 'package:easybill_app/app/constants/app_string.dart';
import 'package:easybill_app/app/constants/app_text_style.dart';
import 'package:easybill_app/app/constants/bools.dart';
import 'package:easybill_app/app/constants/themes.dart';
import 'package:easybill_app/app/constants/validation.dart';
import 'package:easybill_app/app/routes/app_pages.dart';
import 'package:easybill_app/app/widgets/custom_widgets/custom_container.dart';
import 'package:easybill_app/app/widgets/custom_widgets/custom_scaffold.dart';
import 'package:easybill_app/app/widgets/loading_widget.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import '../../../../constants/size_config.dart';
import '../../../../widgets/custom_widgets/custom_dropdownbtn.dart';
import '../../../../widgets/custom_widgets/custom_elevated_button.dart';
import '../../../../widgets/custom_widgets/custom_list_tile.dart';
import '../../../../widgets/custom_widgets/custom_text_form_field.dart';
import '../../../../widgets/custom_widgets/custom_toogle_btn.dart';
import '../controllers/admin_settings_controller.dart';

class AdminSettingsView extends GetView<AdminSettingsController> {
  const AdminSettingsView({super.key});
  @override
  Widget build(BuildContext context) {
    EBSizeConfig.init(context);
    return EBCustomScaffold(
      actionWidget: IconButton(
          icon: const Icon(
            Icons.edit,
            size: 20,
            color: EBTheme.listColor,
          ),
          onPressed: () {
            controller.readOnly = false;
            controller.update();
          }),
      bottomNavBar: GetBuilder<AdminSettingsController>(builder: (_) {
        return Container(
          height: 100,
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
            child: CustomElevatedButton(
              onPressed:
                  controller.readOnly ? null : controller.onUpdatePressed,
              child: Text(
                EBAppString.update,
                style: EBAppTextStyle.button,
              ),
            ),
          ),
        );
      }),
      body: DefaultTabController(
        length: 3,
        child: Column(
          children: [
            TabBar(
              overlayColor:
                  MaterialStatePropertyAll(EBTheme.kPrimaryLightColor),
              labelColor: EBTheme.kPrimaryColor,
              indicatorSize: TabBarIndicatorSize.tab,
              indicatorColor: EBTheme.kPrimaryColor,
              tabs:
                  [EBAppString.invoice, EBAppString.printer, EBAppString.theme]
                      .map((e) => Tab(
                            child: Text(
                              e,
                              overflow: TextOverflow.ellipsis,
                              style: EBAppTextStyle.heading2,
                            ),
                          ))
                      .toList(),
            ),
            Expanded(
              child: Padding(
                padding: EBSizeConfig.edgeInsetsOnlyH30,
                child: TabBarView(
                  children: [
                    invoiceTab(),
                    themePrinter(),
                    pdfTab(),
                  ],
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }

  Widget invoiceTab() {
    return GetBuilder<AdminSettingsController>(builder: (_) {
      if (EBBools.isLoading) return const LoadingWidget();
      return SingleChildScrollView(
        child: Form(
          child: Padding(
            padding: EBSizeConfig.edgeInsetsActivitiesDouble,
            child: Column(
              children: [
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(
                          '${EBAppString.businessLogo} : ',
                          style: EBAppTextStyle.heading2,
                        ),
                        Text(
                          'Recomended size 512px x 512px\nmax 100kb',
                          style: EBAppTextStyle.customeTextStyle(
                              fontSize: 12, color: Colors.grey.shade500),
                        ),
                      ],
                    ),
                    // const CircleAvatar(
                    //   backgroundColor: EBTheme.listColor,
                    //   maxRadius: 40,
                    //   backgroundImage: AssetImage(
                    //     EBAppString.businessLogoImg,
                    //   ),
                    // ),
                    GetBuilder<AdminSettingsController>(builder: (_) {
                      return SizedBox(
                        width: EBSizeConfig.screenWidth * 0.3,
                        height: EBSizeConfig.screenHeight * 0.2 / 1.5,
                        child: GestureDetector(
                          onTap: () {
                            controller.readOnly
                                ? null
                                : controller.imgPickerFromGallery();
                          },
                          child: CustomContainer(
                            padding: EBSizeConfig.edgeInsetsZero,
                            color: EBTheme.listColor,
                            height: 90,
                            borderColor: Colors.grey,
                            borderWidth: 1,
                            child: Center(
                              child: EBBools.isImageSelected
                                  ? const LoadingWidget()
                                  : controller.imageInBytes == null
                                      ? Image.asset(
                                          fit: BoxFit.fill,
                                          EBAppString.businessLogoImg,
                                        )
                                      : Image.memory(
                                          base64Decode(
                                              controller.imageInBytes!),
                                          fit: BoxFit.fill,
                                        ),
                            ),
                          ),
                        ),
                      );
                    }),
                  ],
                ),
                CustomTextFormField(
                  readOnly: controller.readOnly,
                  controller: controller.businessNameController,
                  labelText: EBAppString.business,
                  validator: (value) => EBValidation.validateIsEmpty(value!),
                ),
                CustomTextFormField(
                  readOnly: controller.readOnly,
                  controller: controller.businessAddressController,
                  labelText: EBAppString.address,
                  validator: (value) => EBValidation.validateIsEmpty(value!),
                ),
                GestureDetector(
                  onDoubleTap: () => _.onTapOfUnEditable(),
                  child: CustomTextFormField(
                    readOnly: true,
                    controller: controller.mobilController,
                    labelText: EBAppString.mobile,
                  ),
                ),
                CustomTextFormField(
                  readOnly: controller.readOnly,
                  controller: controller.emailController,
                  labelText: EBAppString.email,
                  validator: (value) => EBValidation.validateEmail(value!),
                ),
                Visibility(
                  visible: _.gstFlag,
                  child: GestureDetector(
                    onDoubleTap: () => _.onTapOfUnEditable(),
                    child: CustomTextFormField(
                      readOnly: true,
                      controller: controller.gstController,
                      labelText: EBAppString.gst,
                    ),
                  ),
                ),
                CustomTextFormField(
                  readOnly: controller.readOnly,
                  controller: controller.footerController,
                  maxLines: 7,
                  labelText: EBAppString.footer,
                  validator: (value) => EBValidation.validateIsEmpty(value!),
                ),
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
    });
  }
}

Widget pdfTab() {
  return const Center(
    child: Text('Pdf Need to be implemented'),
  );
}

Widget themePrinter() {
  return GetBuilder<AdminSettingsController>(builder: (controller) {
    if (EBBools.isLoading) return const LoadingWidget();
    return SingleChildScrollView(
      child: Padding(
        padding: EBSizeConfig.edgeInsetsActivities,
        child: Column(
          children: [
            Padding(
              padding: EBSizeConfig.edgeInsetsActivitiesDouble,
              child: GestureDetector(
                onTap: () {
                  // var statusBle = Permission.bluetooth;

                  // if (await statusBle.isGranted != true) {
                  //   _permissionStatus = 'Granted';
                  //   await Permission.location.request();
                  // }

                  // print('permiision statusBle =======>>  $_permissionStatus');

                  // if (await status.isDenied || await status.isPermanentlyDenied) {
                  //   // Request the permission
                  //   PermissionStatus newStatus =
                  //       await Permission.bluetooth.request();
                  //   _permissionStatus = newStatus.toString();

                  //   if (newStatus.isPermanentlyDenied) {
                  //     // Open app settings if permission is permanently denied
                  //     openAppSettings();
                  //   }
                  // }
                  // Map<Permission, PermissionStatus> statuses = await [
                  //   Permission.location,
                  //   Permission.bluetoothScan,
                  //   Permission.bluetoothConnect
                  // ].request();

                  // bool allGranted = true;
                  // statuses.forEach((permission, status) {
                  //   if (status.isDenied || status.isPermanentlyDenied) {
                  //     allGranted = false;
                  //   }
                  // });

                  // if (allGranted) {
                  //   //    _permissionStatus = 'All permissions granted';
                  // } else {
                  //   // _permissionStatus = 'Some permissions denied or permanently denied';
                  // }

                  // statuses.forEach((permission, status) {
                  //   if (status.isDenied) {
                  //     EBCustomSnackbar.show(
                  //         'The ${permission.toString().split('.').last} permission was denied. Please allow it to use this feature.');
                  //   } else if (status.isPermanentlyDenied) {
                  //     openAppSettings();
                  //   }
                  // });
                  controller.readOnly
                      ? null
                      : Get.toNamed(Routes.CHOOSE_PRINTER);
                },
                child: CustomContainer(
                  color: EBTheme.kPrimaryWhiteColor,
                  noHeight: true,
                  borderColor: EBTheme.kPrimaryColor,
                  borderWidth: 0.5,
                  child: const EBCustomListTile(
                    leading: Icon(
                      Icons.print_rounded,
                      size: 25,
                    ),
                    titleName: 'Choose ${EBAppString.printer}',
                    trailingIcon: Icons.add,
                    trailingIconSize: 25,
                  ),
                ),
              ),
            ),
            EBCustomListTile(
              titleName: 'Printer Size',
              trailingWidget: FractionallySizedBox(
                widthFactor: 0.60,
                heightFactor: 0.90,
                child: CustomDropDownFormField<String>(
                  value: controller.selectedPrinterSize,
                  items: controller.printerSizeList
                      .map<DropdownMenuItem<String>>(
                        (element) => DropdownMenuItem<String>(
                          value: element,
                          child: Text(element.toString().toUpperCase(),
                              overflow: TextOverflow.ellipsis,
                              style: EBAppTextStyle.bodyText),
                        ),
                      )
                      .toList(),
                  onChanged: controller.readOnly
                      ? null
                      : (value) {
                          if (value == null) {
                            return;
                          }
                          controller.selectedPrinterSize = value;
                          controller.update();
                        },
                ),
              ),
            ),
            EBCustomListTile(
              titleName: 'Language',
              trailingWidget: FractionallySizedBox(
                widthFactor: 0.60,
                heightFactor: 0.90,
                child: CustomDropDownFormField<String>(
                  value: controller.selectedLanguage,
                  items: controller.languageList
                      .map<DropdownMenuItem<String>>(
                        (element) => DropdownMenuItem<String>(
                          value: element,
                          child: Text(element.toString().toUpperCase(),
                              overflow: TextOverflow.ellipsis,
                              style: EBAppTextStyle.bodyText),
                        ),
                      )
                      .toList(),
                  onChanged: controller.readOnly
                      ? null
                      : (value) {
                          if (value == null) {
                            return;
                          }
                          controller.selectedLanguage = value;
                          controller.update();
                        },
                ),
              ),
            ),
            EBCustomListTile(
              titleName: EBAppString.email,
              trailingWidget: EBCustomToogleBtn(
                  value: controller.isEmail!,
                  onChanged: controller.readOnly
                      ? null
                      : (value) => {
                            controller.isEmail = value,
                            controller.update(),
                          }),
            ),
            EBCustomListTile(
              titleName: EBAppString.mobile,
              trailingWidget: EBCustomToogleBtn(
                  value: controller.isMobile!,
                  onChanged: controller.readOnly
                      ? null
                      : (value) => {
                            controller.isMobile = value,
                            controller.update(),
                          }),
            ),
            Visibility(
              visible: controller.gstFlag,
              child: EBCustomListTile(
                titleName: EBAppString.gst,
                trailingWidget: EBCustomToogleBtn(
                    value: controller.isGst!,
                    onChanged: controller.readOnly
                        ? null
                        : (value) => {
                              controller.isGst = value,
                              controller.update(),
                            }),
              ),
            ),
            EBCustomListTile(
              titleName: EBAppString.footer,
              trailingWidget: EBCustomToogleBtn(
                  value: controller.isFooter!,
                  onChanged: controller.readOnly
                      ? null
                      : (value) => {
                            controller.isFooter = value,
                            controller.update(),
                          }),
            ),
            EBCustomListTile(
              titleName: EBAppString.whatsApp,
              trailingWidget: EBCustomToogleBtn(
                  value: controller.isWhatsapp!,
                  onChanged: controller.readOnly
                      ? null
                      : (value) => {
                            controller.isWhatsapp = value,
                            controller.update(),
                          }),
            ),
          ]
              .expand(
                (element) => [
                  element,
                  EBSizeConfig.sizedBoxH08,
                ],
              )
              .toList(),
        ),
      ),
    );
  });
}
