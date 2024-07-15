import 'dart:io';

import 'package:easybill_app/app/constants/app_string.dart';
import 'package:easybill_app/app/constants/bools.dart';
import 'package:easybill_app/app/data/repositories/category_repo.dart';
import 'package:easybill_app/app/data/repositories/product_repo.dart';
import 'package:easybill_app/app/widgets/custom_widgets/custom_toast.dart';
import 'package:file_picker/file_picker.dart';
import 'package:flutter/widgets.dart';
import 'package:get/get.dart';
import '../../../../data/models/category.dart';
import '../../../../data/models/product.dart';
import '../../../../data/models/utilities.dart';

class InventoryController extends GetxController {
  ProductRepo productRepo = ProductRepo();
  CategoryRepo categoryRepo = CategoryRepo();
  List<Category>? categoryList;
  List<Category>? filterableCategoryList;
  List<Product>? productList;
  List<Product>? seachableProductList;
  List<Units>? unitList;
  List<TaxType>? taxType;
  InventoryController();

  List<Product>? categoryProductsList(int catId) =>
      productList?.where((element) => element.categoryid == catId).toList();

  TextEditingController categoryController = TextEditingController();

  final formKey = GlobalKey<FormState>();

  @override
  void onInit() {
    debugPrint(' inventory oninint called');
    debugPrint(
        '------------------->> triggered from staff  :  ${EBBools.triggeredFromStaff}');
    super.onInit();

    getProducts();
    getUtilitiesUnit();
    getUtilitiesTaxtype();
  }

  Future<void> getProducts() async {
    try {
      final x = await productRepo.getProducts();
      productList = x;
      seachableProductList = x;
      getCategories();
      for (var element in productList!) {
        debugPrint('product names ----------->>  ${element.productnameEnglish}');
      }
      update();
    } catch (e) {
      if (e is SocketException) {
        debugPrint(
            '<<---------------------------------------------- Error in Internet --------------------------------------------------------------->>');
      }

      debugPrint(
          '<<---------------------------------------------- Error occured --------------------------------------------------------------->>');
    }
  }

  Future<void> getCategories() async {
    try {
      final x = await categoryRepo.getCategories();
      categoryList = x;
      List<Category> resultList = [];
      for (var element in categoryList!) {
        if (isProductPresent(element.categoryid)) {
          resultList.add(element);
          debugPrint(element.categoryname);
        }
      }

      filterableCategoryList = [
        Category(categoryid: 0, categoryname: 'ALL'),
        ...resultList
      ];

      update();
    } catch (e) {
      debugPrint(e.toString());
    }
  }

  Future<void> getUtilitiesUnit() async {
    try {
      final x = await productRepo.getUtilitiesUnit();
      unitList = x;
      update();
    } catch (e) {
      debugPrint(e.toString());
    }
  }

  Future<void> getUtilitiesTaxtype() async {
    try {
      final x = await productRepo.getUtilitiesTaxtype();
      taxType = x;
      update();
    } catch (e) {
      debugPrint(e.toString());
    }
  }

  Future<void> deleteProducts(Product p) async {
    try {
      final x = await productRepo.deleteProducts(p);
      productList = x;
      seachableProductList = x;
      update();
      Get.back();
    } catch (e) {
      debugPrint(e.toString());
    }
  }

  Future<void> downloadProduct() async {
    try {
      await productRepo.downloadProduct();
      ebCustomTtoastMsg(message: 'Product CSV downloaded');
      update();
    } catch (e) {
      debugPrint(e.toString());
    }
  }

  Future<void> uploadProduct() async {
    try {
      Product p = Product();
      await productRepo.updateProduct(p);
      ebCustomTtoastMsg(message: EBAppString.responseMsg ?? "-");
      update();
    } catch (e) {
      debugPrint(e.toString());
    }
  }

  @override
  void onReady() {
    super.onReady();
    debugPrint('on ready called -------------->>');
  }

  @override
  void onClose() {
    super.onClose();
    debugPrint('on closed called -------------->>');
  }

  bool isProductPresent(int? categoryid) {
    if (productList == null) {
      return false;
    }
    return productList!
        .where((element) => element.categoryid == categoryid)
        .isNotEmpty;
  }

  String? validateCategory(String val) {
    if (val.trim().isEmpty) return 'This field is required';

    bool isCatNamePresent = categoryList!.any((category) =>
        category.categoryname!.trim().toLowerCase() ==
        val.trim().toLowerCase());

    if (isCatNamePresent == true) return 'Category already added';

    return null;
  }

  updateProducts(List<Product> prdts) {
    productList = prdts;
    seachableProductList = productList;
    updateCategory(categoryList!);
    update();
  }

  updateCategory(List<Category> cats) {
    categoryList = cats;
    List<Category> resultList = [];
    for (var element in cats) {
      if (isProductPresent(element.categoryid)) {
        resultList.add(element);
      }
    }

    filterableCategoryList = [
      Category(categoryid: 0, categoryname: 'ALL'),
      ...resultList
    ];
    update();
  }

  void addPressed() {
    debugPrint('add category validation called ----------------->>      ');
    if (formKey.currentState?.validate() == true) {
      debugPrint('inside add category validation called ----------------->>      ');
      addCategory();
      update();
    }
  }

  void editPressed(category) {
    debugPrint('edit category calleedd ----------------->>      ');
    if (formKey.currentState?.validate() == true) {
      editCategory(category);
      update();
    }
  }

  Future<void> addCategory() async {
    try {
      Category category = Category(categoryname: categoryController.text);
      final x = await categoryRepo.addCategory(category);
      categoryList = x;
      categoryController.text = "";
      update();
      Get.back();
    } catch (e) {
      debugPrint(e.toString());
    }
  }

  Future<void> editCategory(Category c) async {
    debugPrint('edit apdi called -------------------->> ');
    try {
      Category category = Category(
          categoryid: c.categoryid, categoryname: categoryController.text);
      final categoryList = await categoryRepo.editCategory(category);
      updateCategory(categoryList!);
      Get.back();
    } catch (e) {
      debugPrint(e.toString());
    }
  }

  Future<void> deleteCategory(Category c) async {
    try {
      Category category = Category(categoryid: c.categoryid);
      final x = await categoryRepo.deleteCategory(category);
      categoryList = x;
      Get.back();
      update();
    } catch (e) {
      debugPrint(e.toString());
    }
  }

  void searchList(String value) {
    List<Product>? resultList;
    if (value.isEmpty) {
      resultList = productList;
    } else {
      resultList = productList!
          .where((product) => EBAppString.productlanguage == 'English'
              ? product.productnameEnglish!
                  .toLowerCase()
                  .contains(value.toLowerCase())
              : product.productnameTamil!
                  .toLowerCase()
                  .contains(value.toLowerCase()))
          .toList();
    }
    seachableProductList = resultList;
    update();
  }

  void filterProdutListByCatId(int categoryid) {
    List<Product>? resultList;
    if (categoryid == 0) {
      seachableProductList = productList;
      update();
    } else {
      resultList = productList!
          .where((product) => product.categoryid == categoryid)
          .toList();
      seachableProductList = resultList;
      update();
    }
  }

  void chooeseFile() async {
    FilePickerResult? result = await FilePicker.platform.pickFiles();
    if (result != null) {
      final file = File(result.files.single.path!);

    } else {
      ebCustomTtoastMsg(message: 'No File Selected');
    }
  }
}
