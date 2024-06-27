import 'package:easybill_app/app/constants/app_text_style.dart';
import 'package:easybill_app/app/constants/size_config.dart';
import 'package:easybill_app/app/constants/themes.dart';
import 'package:easybill_app/app/widgets/custom_widgets/custom_dropdownbtn.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import '../../../../constants/app_string.dart';
import '../../../../widgets/custom_widgets/custom_elevated_button.dart';
import '../../../../widgets/custom_widgets/custom_list_tile.dart';
import '../../../../widgets/custom_widgets/custom_toogle_btn.dart';
import '../controllers/admin_settings_controller.dart';

class PrinterSettingView extends GetView<AdminSettingsController> {
  const PrinterSettingView({super.key});
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(
          'PrinterSettingView',
          style: EBAppTextStyle.printBtn,
        ),
        backgroundColor: EBTheme.kPrimaryColor,
        centerTitle: true,
      ),
      bottomNavigationBar: Container(
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
            onPressed: null,
            child: Text(
              EBAppString.update,
              style: EBAppTextStyle.button,
            ),
          ),
        ),
      ),
      body: Padding(
        padding: EBSizeConfig.edgeInsetsActivities,
        child: Column(
          children: [
            EBCustomListTile(
              titleName: 'Printer Size : ',
              trailingWidget: FractionallySizedBox(
                widthFactor: 0.50,
                child: CustomDropDownFormField<String>(
                  value: controller.printerSizeList[0],
                  items: controller.printerSizeList
                      .map<DropdownMenuItem<String>>(
                        (element) => DropdownMenuItem<String>(
                          value: element,
                          child: Text(element.toString().toUpperCase()),
                        ),
                      )
                      .toList(),
                  onChanged: (value) {
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
              titleName: 'Enable Auto Print',
              trailingWidget:
                  EBCustomToogleBtn(value: true, onChanged: (value) => {}),
            ),
            EBCustomListTile(
              titleName: 'Open Cash Drawer : ',
              trailingWidget:
                  EBCustomToogleBtn(value: true, onChanged: (value) => {}),
            ),
            EBCustomListTile(
              titleName: 'Disconnect after every print : ',
              trailingWidget:
                  EBCustomToogleBtn(value: true, onChanged: (value) => {}),
            ),
            EBCustomListTile(
              titleName: 'Auto-Cut after printing : ',
              trailingWidget:
                  EBCustomToogleBtn(value: true, onChanged: (value) => {}),
            ),
          ],
        ),
      ),
    );
  }
}
