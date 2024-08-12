// ignore_for_file: unnecessary_overrides

import 'dart:math';
import 'package:easybill_app/app/data/models/category.dart';
import 'package:easybill_app/app/data/models/product.dart';
import 'package:easybill_app/app/data/models/utilities.dart';
import 'package:easybill_app/app/data/repositories/product_repo.dart';
import 'package:easybill_app/app/modules/admin/inventory/controllers/inventory_controller.dart';
import 'package:flutter/widgets.dart';
import 'package:get/get.dart';
import '../../../../constants/app_string.dart';
import '../../../../constants/bools.dart';

class ProductManagementController extends GetxController {
  bool isTaxFieldNeeded = false;

  bool tokenFlag = true;

  ProductManagementController({
    required this.isEditMode,
    required this.categoryList,
    required this.unitList,
    required this.taxType,
    required this.triggeredFromCategory,
    this.selectedProduct,
    this.selectedCategory,
  });

  ProductRepo productRepo = ProductRepo();
  bool isEditMode, triggeredFromCategory;
  bool? isQrOrBarcodeFound;
  Product? selectedProduct;

  TextEditingController productNameEnglishController = TextEditingController();
  TextEditingController productNameTamilController = TextEditingController();
  TextEditingController taxPercentageController = TextEditingController();
  TextEditingController priceController = TextEditingController();
  TextEditingController scannerController = TextEditingController();

  bool tokenVal = false;
  Units? selectedUnits;
  TaxType? selectedTaxType;
  Category? selectedCategory;
  List<Category> categoryList;
  List<Units> unitList;
  List<TaxType> taxType;

  final formKey = GlobalKey<FormState>();

  @override
  void onInit() {
    super.onInit();
    getScreenAccess();
    if (selectedProduct != null) {
      initProduct();
    } else {
      setDefaultValues();
    }
  }

  void initProduct() {
    productNameEnglishController.text =
        selectedProduct!.productnameEnglish ?? '';
    productNameTamilController.text = selectedProduct!.productnameTamil ?? '';
    priceController.text = selectedProduct!.price ?? '';
    taxPercentageController.text = selectedProduct!.taxpercentage ?? '';
    scannerController.text = selectedProduct!.qrbarcode ?? '';
    selectedUnits = unitList
        .firstWhere((element) => selectedProduct!.unitid == element.unitid);
    selectedTaxType = taxType.firstWhere(
        (element) => selectedProduct!.taxtypeid == element.taxtypeid);
    selectedCategory = categoryList.firstWhere(
        (element) => selectedProduct!.categoryid == element.categoryid);
    tokenVal = selectedProduct!.istoken!;
  }

  @override
  void onReady() {
    super.onReady();
  }

  @override
  void onClose() {
    super.onClose();
  }

  String generateBarcodeID(int length) {
    final Random random = Random();
    const String characters = '3102967854';
    return String.fromCharCodes(Iterable.generate(length,
        (_) => characters.codeUnitAt(random.nextInt(characters.length))));
  }

  String? validateProductName(String val) {
    if (val.trim().isEmpty) return 'This field is required';
    if (val.trim().length >= 50) {
      return 'Maximum upto 50 charectes';
    }
    if (!RegExp(r'^[a-zA-Z0-9\s]+$').hasMatch(val)) {
      return 'Please enter text in English only';
    }
    if (isEditMode) return null;
    bool isProductFound = Get.find<InventoryController>().productList!.any(
        (product) =>
            val.trim().toLowerCase() ==
            product.productnameEnglish?.trim().toLowerCase());

    if (isProductFound) return 'Product already added';

    return null;
  }

  String? validateScanner(String val) {
    if (val.trim().isEmpty) return 'This field is required';
    if (val.trim().length > 50) return 'Maximum 50 charecters';

    isQrOrBarcodeFound = Get.find<InventoryController>()
        .productList!
        .any((product) => val == product.qrbarcode);

    if (isQrOrBarcodeFound == true) return 'Qr Or Barcode is already added';

    return null;
  }

  Future<void> addProduct() async {
    try {
      EBBools.isLoading = true;
      update();
      Product product = Product(
          productnameEnglish: productNameEnglishController.text,
          productnameTamil: productNameTamilController.text,
          categoryid: selectedCategory?.categoryid,
          istoken: tokenFlag == false ? true : tokenVal,
          qrbarcode: scannerController.text,
          price: priceController.text,
          unitid: selectedUnits?.unitid,
          taxpercentage: taxPercentageController.text.isEmpty
              ? '0'
              : taxPercentageController.text,
          taxtypeid: selectedTaxType?.taxtypeid);
      final productList = await productRepo.addProduct(product);
      Get.find<InventoryController>().updateProducts(productList!);
      update();
      Get.back();
    } catch (e) {
      debugPrint(e.toString());
      rethrow;
    } finally {
      EBBools.isLoading = false;
      update();
    }
  }

  void savePressedOnAdd() {
    if (formKey.currentState?.validate() == true) {
      addProduct();
      update();
    }
  }

  void savePressedOnEdit() {
    if (formKey.currentState?.validate() == true) {
      updateProduct();
      update();
    }
  }

  Future<void> updateProduct() async {
    try {
      EBBools.isLoading = true;
      update();
      Product p = Product(
          shopproductid: selectedProduct!.shopproductid,
          productnameEnglish: productNameEnglishController.text,
          productnameTamil: productNameTamilController.text,
          categoryid: selectedCategory?.categoryid,
          qrbarcode: scannerController.text,
          istoken: tokenVal,
          price: priceController.text,
          unitid: selectedUnits?.unitid,
          taxpercentage: taxPercentageController.text,
          taxtypeid: selectedTaxType?.taxtypeid);
      final productList = await productRepo.updateProduct(p);
      Get.find<InventoryController>().updateProducts(productList!);
      update();
      Get.back();
    } catch (e) {
      debugPrint(e.toString());
    } finally {
      EBBools.isLoading = false;
      update();
    }
  }

  void setDefaultValues() {
    selectedCategory ??=
        categoryList.firstWhere((element) => element.isdefault == true);
    selectedUnits = unitList.firstWhere((element) => element.isdefault == true);
    selectedTaxType =
        taxType.firstWhere((element) => element.isdefault == true);
  }

  void getScreenAccess() {
    EBBools.isSalePresent = EBAppString.screenAccessList.contains("sale");
    EBBools.isQuickPresent = EBAppString.screenAccessList.contains("quick");
    EBBools.isTokenPresent = EBAppString.screenAccessList.contains("token");

    if (EBBools.isTokenPresent &&
        !EBBools.isQuickPresent &&
        !EBBools.isSalePresent) {
      tokenFlag = false;
      selectedUnits = unitList[0];
      update();
    }

    debugPrint("sales ----------------->> ${EBBools.isSalePresent}");
    debugPrint("quick -------------------->> ${EBBools.isQuickPresent}");
    debugPrint("token ------------------->> ${EBBools.isTokenPresent}");
  }

  bool hideTaxFiled() {
    return isTaxFieldNeeded =
        selectedTaxType!.taxtypeid == 3 || selectedTaxType!.taxtypeid == 4;
  }
}
