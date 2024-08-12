import 'package:easybill_app/app/constants/app_text_style.dart';
import 'package:easybill_app/app/modules/admin/inventory/views/category_tab.dart';
import 'package:easybill_app/app/widgets/custom_widgets/custom_scaffold.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import '../../../../constants/size_config.dart';
import '../../../../constants/themes.dart';
import '../controllers/inventory_controller.dart';
import 'product_tab.dart';

class InventoryView extends GetView<InventoryController> {
  const InventoryView({super.key});
  @override
  Widget build(BuildContext context) {
    return GetBuilder<InventoryController>(builder: (_) {
      return DefaultTabController(
        length: 2,
        child: EBCustomScaffold(
            // actionWidgetList: [
            //   IconButton(onPressed: (){
            //       _.downloadProduct();
            //   }, icon: const Icon(Icons.download_rounded)),
            //   IconButton(onPressed: (){
            //     _.chooeseFile();
            //   }, icon: const Icon(Icons.upload_file_outlined)),
            // ],
            body: Padding(
          padding: EBSizeConfig.edgeInsetsActivities,
          child: Column(
            children: [
              TabBar(
                overlayColor:
                    MaterialStatePropertyAll(EBTheme.kPrimaryLightColor),
                labelColor: EBTheme.kPrimaryColor,
                indicatorSize: TabBarIndicatorSize.tab,
                indicatorColor: EBTheme.kPrimaryColor,
                tabs: ["Category", "Products"]
                    .map((e) => Tab(
                          child: Text(
                            e,
                            overflow: TextOverflow.ellipsis,
                            style: EBAppTextStyle.heading2,
                          ),
                        ))
                    .toList(),
              ),
              const Expanded(
                child: Padding(
                  padding: EBSizeConfig.edgeInsetsOnlyH10,
                  child: TabBarView(
                    children: [
                      CategoryTab(),
                      ProductTab(),
                    ],
                  ),
                ),
              ),
            ],
          ),
        )),
      );
    });
  }
}
