// ignore_for_file: no_wildcard_variable_uses

import 'package:easybill_app/app/constants/bools.dart';
import 'package:easybill_app/app/data/models/category.dart';
import 'package:easybill_app/app/data/models/utilities.dart';
import 'package:easybill_app/app/routes/app_pages.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:get/get.dart';
import 'package:shimmer/shimmer.dart';
import '../../../../constants/app_string.dart';
import '../../../../constants/app_text_style.dart';
import '../../../../constants/size_config.dart';
import '../../../../constants/themes.dart';
import '../../../../constants/validation.dart';
import '../../../../widgets/custom_widgets/custom_dropdownbtn.dart';
import '../../../../widgets/custom_widgets/custom_elevated_button.dart';
import '../../../../widgets/custom_widgets/custom_text_form_field.dart';
import '../controllers/product_management_controller.dart';

class ProductManagementView extends GetView<ProductManagementController> {
  const ProductManagementView({super.key});
  @override
  Widget build(BuildContext context) {
    EBSizeConfig.init(context);
    return GetBuilder<ProductManagementController>(builder: (_) {
      return Scaffold(
        body: SafeArea(
          child: EBBools.isLoading
              ? const ShimmerLoading()
              : SingleChildScrollView(
                  child: Form(
                    key: controller.formKey,
                    child: Padding(
                      padding: EBSizeConfig.edgeInsetsActivities,
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text(
                            EBAppString.itemName,
                            style: EBAppTextStyle.bodyText,
                          ),
                          CustomTextFormField(
                            readOnly: !controller.isEditMode,
                            controller: controller.productNameTamilController,
                            labelText: EBAppString.native,
                            validator: (value) => EBValidation.validateIsEmpty(value!),
                          ),
                          CustomTextFormField(
                            readOnly: !controller.isEditMode,
                            controller: controller.productNameEnglishController,
                            labelText: EBAppString.english,
                            validator: (value) =>
                                controller.validateProductName(value!),
                          ),
                          Text(
                            EBAppString.category,
                            style: EBAppTextStyle.bodyText,
                          ),
                          buildCategory(),
                          Row(
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            children: [
                              Text(
                                EBAppString.qrBarcode,
                                style: EBAppTextStyle.bodyText,
                              ),
                              Container(),
                              Text(
                                'Generate',
                                style: EBAppTextStyle.bodyText,
                              ),
                              Padding(
                                padding: const EdgeInsets.only(right: 10),
                                child: Text(
                                  'Scan',
                                  style: EBAppTextStyle.bodyText,
                                ),
                              ),
                            ],
                          ),
                          getScannerId(context),

                          Visibility(
                            visible: controller.tokenFlag,
                            child: Row(
                              children: [
                                Text(
                                  EBAppString.token,
                                  style: EBAppTextStyle.bodyText,
                                ),
                                Expanded(
                                  child: RadioListTile<bool>(
                                    title: Text(
                                      EBAppString.yes,
                                      style: EBAppTextStyle.bodyText,
                                    ),
                                    value: true,
                                    groupValue: controller.tokenVal,
                                    activeColor: EBTheme.kPrimaryColor,
                                    onChanged: !controller.isEditMode
                                        ? null
                                        : (value) {
                                            controller.tokenVal = value!;
                                            controller.selectedUnits =
                                                controller.unitList[0];
                                            controller.update();
                                          },
                                  ),
                                ),
                                Expanded(
                                  child: RadioListTile<bool>(
                                      title: Text(
                                        EBAppString.no,
                                        style: EBAppTextStyle.bodyText,
                                      ),
                                      value: false,
                                      groupValue: controller.tokenVal,
                                      activeColor: EBTheme.kPrimaryColor,
                                      onChanged: !controller.isEditMode
                                          ? null
                                          : (value) {
                                              controller.tokenVal = value!;
                                              controller.update();
                                            }),
                                ),
                              ],
                            ),
                          ),
                          Visibility(
                            visible: controller.tokenFlag,
                            child: Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                Text(
                                  EBAppString.units,
                                  style: EBAppTextStyle.bodyText,
                                ),
                                EBSizeConfig.sizedBoxH15,
                                CustomDropDownFormField<Units>(
                                  value: controller.selectedUnits,
                                  items: controller.unitList
                                      .map<DropdownMenuItem<Units>>(
                                        (element) => DropdownMenuItem<Units>(
                                          value: element,
                                          child: Text(element.unitname
                                              .toString()
                                              .toUpperCase()),
                                        ),
                                      )
                                      .toList(),
                                  onChanged: !controller.isEditMode ||
                                          controller.tokenVal
                                      ? null
                                      : (value) {
                                          controller.selectedUnits = value;
                                          controller.update();
                                        },
                                ),
                              ],
                            ),
                          ),

                          Text(
                            EBAppString.price,
                            style: EBAppTextStyle.bodyText,
                          ),
                          CustomTextFormField(
                            readOnly: !controller.isEditMode,
                            controller: controller.priceController,
                            labelText: EBAppString.price,
                            maxLength: 8,
                            keyboardType: TextInputType.phone,
                            inputFormatters: <TextInputFormatter>[
                              FilteringTextInputFormatter.digitsOnly
                            ],
                            validator: (value) =>
                                EBValidation.validateIsEmpty(value!),
                          ),

                          // checking gst is true if true this files are visible else not
                          Visibility(
                              visible: EBBools.isTaxNeeded,
                              child: Column(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  Text(
                                    EBAppString.taxType,
                                    style: EBAppTextStyle.bodyText,
                                  ),
                                  CustomDropDownFormField<TaxType>(
                                    value: controller.selectedTaxType,
                                    items: controller.taxType
                                        .map<DropdownMenuItem<TaxType>>(
                                          (element) =>
                                              DropdownMenuItem<TaxType>(
                                                  value: element,
                                                  child: Text(
                                                    element.taxtypename
                                                        .toString()
                                                        .toUpperCase(),
                                                    overflow:
                                                        TextOverflow.ellipsis,
                                                    maxLines: 1,
                                                    style:
                                                        EBAppTextStyle.bodyText,
                                                  )),
                                        )
                                        .toList(),
                                    onChanged: !controller.isEditMode
                                        ? null
                                        : (value) {
                                            controller.selectedTaxType = value;
                                            controller.hideTaxFiled();
                                            controller.update();
                                          },
                                  ),
                                  Visibility(
                                    visible: !controller.isTaxFieldNeeded,
                                    child: Text(
                                      EBAppString.taxPer,
                                      style: EBAppTextStyle.bodyText,
                                    ),
                                  ),
                                  Visibility(
                                    visible: !controller.isTaxFieldNeeded,
                                    child: CustomTextFormField(
                                      readOnly: !controller.isEditMode,
                                      controller:
                                          controller.taxPercentageController,
                                      labelText: EBAppString.taxPer,
                                      maxLength: 2,
                                      keyboardType: TextInputType.phone,
                                      inputFormatters: <TextInputFormatter>[
                                        FilteringTextInputFormatter.digitsOnly
                                      ],
                                      validator: (value) =>
                                          EBValidation.validateIsEmpty(value!),
                                    ),
                                  ),
                                ]
                                    .expand(
                                      (element) => [
                                        element,
                                        EBSizeConfig.sizedBoxH15,
                                      ],
                                    )
                                    .toList(),
                              )),

                          Row(
                            mainAxisAlignment: MainAxisAlignment
                                .spaceBetween, // Adjust alignment as needed
                            children: [
                              Expanded(
                                child: controller.isEditMode
                                    ? CustomElevatedButton(
                                        isDefaultWidth: true,
                                        onPressed:
                                            controller.selectedProduct != null
                                                ? controller.savePressedOnEdit
                                                : controller.savePressedOnAdd,
                                        child: Text(
                                          EBAppString.save,
                                          style: EBAppTextStyle.button,
                                        ),
                                      )
                                    : CustomElevatedButton(
                                        isDefaultWidth: true,
                                        onPressed: EBBools.isLoading
                                            ? null
                                            : () {
                                                controller.isEditMode = true;
                                                controller.update();
                                              },
                                        child: Text(
                                          EBAppString.edit,
                                          style: EBAppTextStyle.button,
                                        ),
                                      ),
                              ),
                              EBSizeConfig.sizedBoxW10,
                              Expanded(
                                child: CustomElevatedButton(
                                  isDefaultWidth: true,
                                  btnColor: EBTheme.kCancelBtnColor,
                                  onPressed: () {
                                    Get.back();
                                  },
                                  child: Text(
                                    EBAppString.cancel,
                                    style: EBAppTextStyle.button,
                                  ),
                                ),
                              ),
                            ],
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
                ),
        ),
      );
    });
  }

  Widget getScannerId(BuildContext context) {
    return GetBuilder<ProductManagementController>(builder: (_) {
      EBSizeConfig.init(context);
      return Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          SizedBox(
            width: EBSizeConfig.screenWidth * 0.5,
            child: CustomTextFormField(
              maxLength: 50,
              controller: _.scannerController,
              // validator: (value) => _.validateScanner(value!),
              readOnly: true,
              labelText: 'Scanner Id',
            ),
          ),
          SizedBox(
            width: EBSizeConfig.screenWidth * 0.2,
            height: EBSizeConfig.screenHeight * 0.1 / 1.7,
            child: CustomElevatedButton(
              elevation: 3,
              btnColor: EBTheme.kPrimaryWhiteColor,
              onPressed: () {
                if (controller.scannerController.text.isEmpty ||
                    controller.isQrOrBarcodeFound == true) {
                  controller.scannerController.text =
                      controller.generateBarcodeID(12);
                  controller.update();
                }
              },
              child: const Center(
                child: Icon(
                  color: EBTheme.kPrintBtnColor,
                  Icons.qr_code_scanner_outlined,
                  size: 25,
                ),
              ),
            ),
          ),
          SizedBox(
            width: EBSizeConfig.screenWidth * 0.2,
            height: EBSizeConfig.screenHeight * 0.1 / 1.7,
            child: CustomElevatedButton(
              elevation: 3,
              btnColor: EBTheme.kPrimaryWhiteColor,
              onPressed: () async {
                debugPrint(' QR_SCANNER ------------------------------->>');
                final result = await Get.toNamed(Routes.QR_SCANNER);
                if (result != null) {
                  debugPrint('result of qr -------------->>  $result');
                  _.scannerController.text = result.toString();
                }
                _.update();
              },
              child: const Center(
                child: Icon(
                  color: EBTheme.kPrintBtnColor,
                  Icons.qr_code_scanner_outlined,
                  size: 25,
                ),
              ),
            ),
          ),
        ],
      );
    });
  }

  Widget buildCategory() {
    return Column(
      children: [
        CustomDropDownFormField<Category>(
          value: controller.selectedCategory,
          items: controller.categoryList
              .map<DropdownMenuItem<Category>>(
                  (element) => DropdownMenuItem<Category>(
                        value: element,
                        child: Text(
                          overflow: TextOverflow.ellipsis,
                          maxLines: 1,
                          element.categoryname!.toUpperCase(),
                          style: EBAppTextStyle.bodyText,
                        ),
                      ))
              .toList(),
          onChanged: !controller.isEditMode || controller.triggeredFromCategory
              ? null
              : (value) {
                  controller.selectedCategory = value;
                },
        )
      ],
    );
  }
}

class ShimmerLoading extends StatelessWidget {
  const ShimmerLoading({super.key});

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(16.0),
      child: Shimmer.fromColors(
        baseColor: Colors.grey[300]!,
        highlightColor: Colors.grey[100]!,
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            _buildShimmerBox(),
            _buildShimmerBox(),
            _buildShimmerBox(),
            _buildShimmerBox(),
            _buildShimmerBox(),
            _buildShimmerBox(),
            _buildShimmerBox(),
            _buildShimmerBox(),
            _buildShimmerBox(),
          ]
              .expand(
                (element) => [
                  element,
                  EBSizeConfig.sizedBoxH20,
                ],
              )
              .toList(),
        ),
      ),
    );
  }

  Widget _buildShimmerBox() {
    return Container(
      height: 60,
      width: double.infinity,
      color: Colors.white,
    );
  }
}
