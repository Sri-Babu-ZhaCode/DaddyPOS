import 'package:get/get.dart';

import '../controllers/product_management_controller.dart';

class ProductManagementBinding extends Bindings {
  @override
  void dependencies() {
    Get.lazyPut<ProductManagementController>(
      () => ProductManagementController(
        categoryList: Get.arguments['categoryList'],
        isEditMode: Get.arguments['isEditMode'],
        triggeredFromCategory: Get.arguments["triggeredFromCategory"] ?? false,
        selectedProduct: Get.arguments["selectedProduct"],
        selectedCategory: Get.arguments["selectedCategory"],
        unitList: Get.arguments['unitList'],
        taxType: Get.arguments['taxType'],
      ),
    );
  }
}
