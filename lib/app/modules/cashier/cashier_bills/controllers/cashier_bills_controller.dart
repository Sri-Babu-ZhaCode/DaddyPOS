import 'package:easybill_app/app/constants/app_string.dart';
import 'package:easybill_app/app/constants/bools.dart';
import 'package:easybill_app/app/data/models/bill_items.dart';
import 'package:easybill_app/app/data/models/product.dart';
import 'package:easybill_app/app/routes/app_pages.dart';
import 'package:easybill_app/app/widgets/custom_widgets/custom_toast.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:intl/intl.dart';

import '../../../../constants/size_config.dart';
import '../../../admin/inventory/controllers/inventory_controller.dart';

class CashierBillsController extends GetxController
    with GetSingleTickerProviderStateMixin {
  InventoryController inventoryController = Get.find<InventoryController>();

  final quantityCalulatorConroller = TextEditingController();
  final itemNameController = TextEditingController();
  TextEditingController itemPriceController = TextEditingController();
  final itemQuantityController = TextEditingController();
  late TabController tabController;

  NumberFormat decimalFormatter = NumberFormat('#.###');

  double sheetHeight = EBSizeConfig.screenHeight * 0.59;
  bool isExpanded = true;

  String productQuantity = '';
  String shopproductid = '';
  double defaultQuantity = 1;
  double totalPrice = 0.0;
  int? billItemIndex;
  Product? product;

  List quantityButtons = [
    '1',
    '2',
    '3',
    '4',
    '5',
    '6',
    '7',
    '8',
    '9',
    '.',
    '00',
    '0',
  ];

  List calulaterButtons = [
    '7',
    '8',
    '9',
    const Icon(
      Icons.backspace_outlined,
      size: 30,
    ),
    '4',
    '5',
    '6',
    const Icon(
      Icons.close,
      size: 30,
      weight: 100,
    ),
    '1',
    '2',
    '3',
    true,
    '0',
    '00',
    const Icon(
      Icons.circle,
      size: 14,
    ),
  ];

  List<BillItems> billItems = [];

  int selectedIndex = 0;

  bool showScanner = false;

  bool isXpressed = false;
  bool isDecimalPressed = false;

  int tabIndex = 0;

  bool isDesimal = true;

  void isPopUp() {}

  void nextPressed(Product p) {
    bool isAdded = false;

    // print('token -------------->>  ${p.istoken}');
    if (EBBools.isTokenPresent  &&  tabIndex == EBAppString.screenAccessList.length - 1) {
      billItems.clear();
      addBillItem(p);
      Get.offNamed(Routes.BILL_DETAILS, arguments: {'billItems': billItems});
    } else {
      for (var item in billItems) {
        if (item.productId == p.productid) {
          item.quantity = item.quantity! +
              double.parse(productQuantity.isEmpty
                  ? defaultQuantity.toString()
                  : productQuantity);
          item.totalprice = formateDecimal(
              updatedPrice: double.parse(p.price!) * item.quantity!);
          isAdded = true;
          getTotalPriceOfBill();
          update();
          break;
        }
      }
      if (!isAdded) {
        addBillItem(p);
        update();
      }
      // quick sale tab resticting form going back
      tabIndex != 1 ? Get.back() : null;
    }
  }

  void addBillItem(Product p) {
    billItems = [BillItems(
        p.productnameEnglish!,
        p.productid,
        double.parse(productQuantity.isEmpty
            ? defaultQuantity.toString()
            : productQuantity),
        double.parse(p.price!),
        formateDecimal(p: p),
        p.shopproductid,
        p.isDecimalAllowed,
        p.productnameTamil), ...billItems];
    // billItems.add(BillItems(
    //     p.productnameEnglish!,
    //     p.productid,
    //     double.parse(productQuantity.isEmpty
    //         ? defaultQuantity.toString()
    //         : productQuantity),
    //     double.parse(p.price!),
    //     formateDecimal(p: p),
    //     p.shopproductid,
    //     p.isDecimalAllowed,
    //     p.productnameTamil));
    print('demal for this ${p.productnameEnglish} is : ${p.isDecimalAllowed}');
    getTotalPriceOfBill();
  }

  void categoryListPressed(index) {
    inventoryController.filterProdutListByCatId(
        inventoryController.filterableCategoryList![index].categoryid!);
    selectedIndex = index;
    update();
  }

  // void totalPriceCalulator(Product p) {
  //   totalPrice =;
  // }

  @override
  void onInit() {
    super.onInit();
    // SchedulerBinding.instance.addPostFrameCallback((_) {

    // });
    // tabController = TabController(length: 3, vsync: this);
    //    print('outside future delayed-------------------->>');
    //  Future.delayed(Duration.zero, () {
    //   print('inside future delayed-------------------->>');
    //   tabController = TabController(length: 3, vsync: this);
    //     selectedIndex = tabController.index;
    //      updateseachableProductList(tabController.index);
    //    update();

    // });
    getScreenAccess();
    tabController = TabController(
        length: EBAppString.screenAccessList.length,
        vsync: this,
        initialIndex: 1);
    // tabController.addListener(() {
    //   selectedIndex = tabController.index;
    //   // update();
    //   print("Selected Index ------------->>: ${tabController.index}");
    //   updateseachableProductList(tabController.index);
    // });

    //// pageController = PageController();
    // updateseachableProductList(selectedIndex);

    // // Add listener to the PageController to listen for page changes
    // pageController.addListener(() {
    //   int newIndex = pageController.page!.round();
    //   if (selectedIndex != newIndex) {
    //     selectedIndex = newIndex;
    //     print('-------------------->> current index  ${selectedIndex}');
    //     updateseachableProductList(selectedIndex);
    //     update();
    //   }
    // });
    WidgetsFlutterBinding.ensureInitialized();
    print('widgets initialized --------->>');
    update();
  }

  void updateseachableProductList(int index) {
    print('Called times  ${index + 1}');
    if (index == 0) {
      inventoryController.seachableProductList =
          inventoryController.productList;
      inventoryController.filterableCategoryList =
          inventoryController.filterableCategoryList;
      update();
    } else if (index == 2) {
      if (inventoryController.productList == null) return;
      inventoryController.seachableProductList = inventoryController
          .productList!
          .where((element) => element.istoken == true)
          .toList();
      update();
    }
  }

  void toggleSheet() {
    print(sheetHeight);
    print(isExpanded);
    sheetHeight = isExpanded
        ? EBSizeConfig.screenHeight * 0.00
        : EBSizeConfig.screenHeight * 0.59;
    isExpanded = !isExpanded;
    update();
  }

  @override
  void onReady() {
    super.onReady();
    print('on ready called;');
    update();
  }

  @override
  void onClose() {
    super.onClose();
    tabController.dispose();
  }

  void updateBillItem(BillItems billItem) {
    double tolalprice = double.parse(itemPriceController.text) *
        double.parse(itemQuantityController.text);
    billItems[billItemIndex!] = BillItems(
        billItem.productNameEnglish,
        billItem.productId,
        double.parse(itemQuantityController.text),
        double.parse(itemPriceController.text),
        tolalprice,
        billItem.shopproductid,
        billItem.isDecimal,
        billItem.productnameTamil);
    getTotalPriceOfBill();

    Get.back();
    update();
  }

  void getTotalPriceOfBill() {
    totalPrice = billItems.fold(
        0.0, (previousValue, item) => previousValue + item.totalprice!);
    update();
  }

  void cancelOrderPressed() {
    billItems.clear();
    shopproductid = '';
    getTotalPriceOfBill();
    update();
  }

  void deleteBillItem(value) {
    billItems.remove(value);
    Get.back();
    update();
  }

  void isShopProductIdPresent() {
    print('shoprproduct id  ----------->>  $shopproductid');
    String shopproductidWithOutX =
        shopproductid.substring(0, shopproductid.length - 1);
    print('shoprproduct id  ----------->>  $shopproductidWithOutX');

    product = inventoryController.productList?.firstWhereOrNull(
        (product) => product.shopproductid.toString() == shopproductidWithOutX);
    if (product == null) {
      ebCustomTtoastMsg(message: 'No Product Key available');
      // update();
    } else {
      // checking is decimal is allowed or not and validating visibility of the decimal accordingly
      product?.isDecimalAllowed == true ? isDesimal = true : isDesimal = false;
      print(
          'produdct name ${product?.shopproductid} ------------->> decimal allowed ${product?.isDecimalAllowed}');
      update();
    }
  }

  void seperatingQty() {
    if (shopproductid.isEmpty) return;

    if (product == null) {
      ebCustomTtoastMsg(message: 'No Product Key available');
    } else {
      RegExp regExp = RegExp(r'x([0-9]*\.?[0-9]+)$');

      RegExpMatch? match = regExp.firstMatch(shopproductid);
      String? productQty = match?.group(1);
      print('matched variable --------->>  $productQty');
      if (productQty != null && double.parse(productQty) > 0.1) {
        productQuantity = productQty;
        shopproductid = '';
        isXpressed = false;
        isDecimalPressed = false;
        isDesimal = true;
        nextPressed(product!);
        update();
      } else {
        ebCustomTtoastMsg(message: 'Enter a valid quantity');
      }

      // int indexOfX = shopproductid.indexOf('x');
      // if (indexOfX != -1 && indexOfX < shopproductid.length - 1) {
      //   String productQty =
      //       shopproductid.substring(indexOfX + 1, shopproductid.length);
      //   print("product qunatity ---------------->>>  $productQty");
      //   productQuantity = productQty;
      //   shopproductid = '';
      //   isXpressed = false;
      //   isDecimalPressed = false;
      //   update();
      //   nextPressed(product!);
      // }
    }
  }

  Future<void> addBillItemByQrOrBarcode() async {
    final result = await Get.toNamed(Routes.QR_SCANNER);
    if (result != null) {
      print('result of qr -------------->>  $result');
      Product? product = inventoryController.productList?.firstWhereOrNull(
        (product) => result.toString() == product.qrbarcode,
      );
      if (product != null) {
        print('result of Product QR  -------------->>  ${product.qrbarcode}');
        nextPressed(product);
        update();
      } else {
        ebCustomTtoastMsg(message: 'Not a registed scannable code');
      }
    }
  }

  void getScreenAccess() {
    EBBools.isSalePresent = EBAppString.screenAccessList.contains("sale");
    EBBools.isQuickPresent = EBAppString.screenAccessList.contains("quick");
    EBBools.isTokenPresent = EBAppString.screenAccessList.contains("token");

    print("sales ----------------->> ${EBBools.isSalePresent}");
    print("quick -------------------->> ${EBBools.isQuickPresent}");
    print("token ------------------->> ${EBBools.isTokenPresent}");
  }

  double formateDecimal({Product? p, double? updatedPrice}) {
    String formattedNumber;
    double totalPrice;
    if (updatedPrice != null) {
      totalPrice = updatedPrice;
    } else {
      totalPrice = double.parse(productQuantity.isEmpty
              ? defaultQuantity.toString()
              : productQuantity) *
          int.parse(p!.price!);
    }
    formattedNumber = decimalFormatter.format(
      totalPrice,
    );

    return double.parse(formattedNumber);
  }
}
