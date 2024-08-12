import 'package:audioplayers/audioplayers.dart';
import 'package:easybill_app/app/constants/app_string.dart';
import 'package:easybill_app/app/constants/bools.dart';
import 'package:easybill_app/app/data/models/bill_items.dart';
import 'package:easybill_app/app/data/models/product.dart';
import 'package:easybill_app/app/data/models/setting.dart';
import 'package:easybill_app/app/internet/controller/network_controller.dart';
import 'package:easybill_app/app/routes/app_pages.dart';
import 'package:easybill_app/app/widgets/custom_widgets/custom_toast.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:intl/intl.dart';
import 'package:mobile_scanner/mobile_scanner.dart';
import '../../../../constants/size_config.dart';
import '../../../../data/repositories/setting_repo.dart';
import '../../../admin/inventory/controllers/inventory_controller.dart';
import '../views/widgets/token_delete_dialog.dart';

class CashierBillsController extends GetxController
    with GetSingleTickerProviderStateMixin {
  InventoryController inventoryController = Get.find<InventoryController>();
  final AudioPlayer _audioPlayer = AudioPlayer();
  final _settingsRepo = SettingsRepo();

  final quantityCalulatorConroller = TextEditingController();
  final itemNameController = TextEditingController();
  final itemPriceController = TextEditingController();
  final itemQuantityController = TextEditingController();
  late TabController tabController;

  NumberFormat decimalFormatter = NumberFormat('#.###');

  double? initialSheetHeight = EBSizeConfig.screenHeight * 0.60;
  double? initialSheetHMW;
  double? sheetHeight;
  double? screenWidth;
  double? sheetAfterTappedHeight = 30;
  bool isExpanded = true;

  String productQuantity = '';
  String shopproductid = '';
  double defaultQuantity = 1;
  double billItemsTotalPrice = 0;
  double billItemsTotalQty = 0;
  int? billItemIndex;
  int qrQuantity = 1;
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

  double? deviceScreenHeight;

  Setting? billConfig;

  MobileScannerController? mobileScannerCtrl;

  void nextPressed(Product p) async {
    bool isAdded = false;
    debugPrint('next pressed outside if ------------------->>');
    if (EBBools.isTokenPresent &&
        tabIndex == EBAppString.screenAccessList.length - 1) {
      debugPrint('next pressed inside if ------------------->>');
      if (billItems.isNotEmpty) {
        await deteteBillItemsIfTokenAdded(p);
      } else {
        addBillItem(p);
        Get.toNamed(Routes.BILL_DETAILS, arguments: {'billItems': billItems});
      }
    } else {
      for (var item in billItems) {
        if (item.productId == p.productid) {
          item.quantity = item.quantity! +
              double.parse(productQuantity.isEmpty
                  ? defaultQuantity.toString()
                  : formateQty(productQuantity));
          item.totalprice = formateDecimal(
              updatedPrice: double.parse(p.price!) * item.quantity!);
          isAdded = true;
          getTotalPriceAndQtyOfBill();
          update();
          break;
        }
      }
      if (!isAdded) {
        addBillItem(p);
        update();
      }
    }
    // if (EBAppString.screenAccessList.length == 2 && tabIndex != 1) {
    //   Get.back();
    // }
  }

  void addBillItem(Product p) {
    billItems = [
      BillItems(
          p.productnameEnglish!,
          p.productid,
          double.parse(productQuantity.isEmpty
              ? defaultQuantity.toString()
              : formateQty(productQuantity)),
          double.parse(p.price!),
          formateDecimal(p: p),
          p.shopproductid,
          p.isDecimalAllowed,
          p.productnameTamil),
      ...billItems
    ];
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
    debugPrint(
        'demal for this ${p.productnameEnglish} is : ${p.isDecimalAllowed}');
    getTotalPriceAndQtyOfBill();
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
    sheetHeight = initialSheetHeight;
    // SchedulerBinding.instance.addPostFrameCallback((_) {

    // });
    // tabController = TabController(length: 3, vsync: this);
    //    debugPrint('outside future delayed-------------------->>');
    //  Future.delayed(Duration.zero, () {
    //   debugPrint('inside future delayed-------------------->>');
    //   tabController = TabController(length: 3, vsync: this);
    //     selectedIndex = tabController.index;
    //      updateseachableProductList(tabController.index);
    //    update();

    // });
    getSetting();
    getScreenAccess();
    tabController = TabController(
      length: EBAppString.screenAccessList.length,
      vsync: this,
    );
    // tabController.addListener(() {
    //   selectedIndex = tabController.index;
    //   // update();
    //   debugPrint("Selected Index ------------->>: ${tabController.index}");
    //   updateseachableProductList(tabController.index);
    // });

    //// pageController = PageController();
    // updateseachableProductList(selectedIndex);

    // // Add listener to the PageController to listen for page changes
    // pageController.addListener(() {
    //   int newIndex = pageController.page!.round();
    //   if (selectedIndex != newIndex) {
    //     selectedIndex = newIndex;
    //     debugPrint('-------------------->> current index  ${selectedIndex}');
    //     updateseachableProductList(selectedIndex);
    //     update();
    //   }
    // });
  }

  Future<void> getSetting() async {
    try {
      EBBools.isLoading = true;
      final result = await _settingsRepo.getSettings();

      if (result != null) {
        billConfig = result[0];
      }

      for (var element in result!) {
        debugPrint('----------------------------------->> getSettings ');

        debugPrint(element.businessaddress);
        debugPrint(element.mobileenable.toString());
        debugPrint(element.emailenable.toString());
        debugPrint(element.businessname);
        debugPrint(element.settimeinterval);

        EBAppString.settimeinterval =
            element.settimeinterval == null || element.settimeinterval!.isEmpty
                ? '1'
                : element.settimeinterval;
      }
    } catch (e) {
      debugPrint(e.toString());
    } finally {
      EBBools.isLoading = false;
      update();
    }
  }

  void updateseachableProductList(int index) {
    debugPrint('Called times  ${index + 1}');
    if (index == 0) {
      inventoryController.seachableProductList =
          inventoryController.productList;
      inventoryController.filterableCategoryList =
          inventoryController.filterableCategoryList;
      // updating category list
      selectedIndex = 0;
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
    sheetHeight = isExpanded
        ? EBSizeConfig.screenHeight * 0.00
        : EBSizeConfig.screenHeight * 0.59;
    isExpanded = !isExpanded;
    update();
  }

  void toggleSheetForTab() {
    sheetHeight = sheetAfterTappedHeight;
    isExpanded = !isExpanded;
    update();
  }

  @override
  void onReady() {
    super.onReady();
    debugPrint('on ready called;');
    Future.delayed(const Duration(seconds: 2), _updateSalesTab);
  }

  @override
  void onClose() {
    super.onClose();
    tabController.dispose();
  }

  void updateBillItem(BillItems billItem) {
    if (itemQuantityController.text.isEmpty) {
      ebCustomTtoastMsg(message: 'Can\'t update with empty quantity');
    } else {
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
      getTotalPriceAndQtyOfBill();

      Get.back();
      update();
    }
  }

  void getTotalPriceAndQtyOfBill() {
    billItemsTotalPrice = billItems.fold(
        0.0, (previousValue, item) => previousValue + item.totalprice!);
    billItemsTotalQty = billItems.fold(
        0.0, (previousValue, item) => previousValue + item.quantity!);
    update();
  }

  void cancelOrderPressed() {
    billItems.clear();
    shopproductid = '';
    getTotalPriceAndQtyOfBill();
    update();
  }

  void deleteBillItem(value) {
    billItems.remove(value);
    getTotalPriceAndQtyOfBill();
    Get.back();
  }

  void isShopProductIdPresent() {
    debugPrint('shoprproduct id  ----------->>  $shopproductid');
    String shopproductidWithOutX =
        shopproductid.substring(0, shopproductid.length - 1);
    debugPrint('shoprproduct id  ----------->>  $shopproductidWithOutX');

    product = inventoryController.productList?.firstWhereOrNull(
        (product) => product.shopproductid.toString() == shopproductidWithOutX);
    if (product == null) {
      ebCustomTtoastMsg(message: 'No Product Key available');
      // update();
    } else {
      // checking is decimal is allowed or not and validating visibility of the decimal accordingly
      product?.isDecimalAllowed == true ? isDesimal = true : isDesimal = false;
      debugPrint(
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
      debugPrint('matched variable --------->>  $productQty');

      if (productQty != null && double.parse(productQty) > 0.1) {
        productQuantity = formateQty(productQty);
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
      //   debugPrint("product qunatity ---------------->>>  $productQty");
      //   productQuantity = productQty;
      //   shopproductid = '';
      //   isXpressed = false;
      //   isDecimalPressed = false;
      //   update();
      //   nextPressed(product!);
      // }
    }
  }

  Future<void> addBillItemByQrOrBarcode(String result) async {
    debugPrint('result of qr -------------->>  $result');
    Product? product = inventoryController.productList?.firstWhereOrNull(
      (product) => result.toString() == product.qrbarcode,
    );
    if (product != null) {
      debugPrint(
          'result of Product QR  -------------->>  ${product.qrbarcode}');
      nextPressed(product);
      // playing beep sound
      ebCustomTtoastMsg(
          message: '${product.productnameEnglish} added in Bill Items');
      qrQuantity++;

      playBeepSound();
      update();
    } else {
      ebCustomTtoastMsg(message: 'Not a registed scannable code');
    }
  }

  Future<void> playBeepSound() async {
    await _audioPlayer.play(AssetSource('sounds/beep.mp3'));
  }

  void getScreenAccess() {
    EBBools.isSalePresent = EBAppString.screenAccessList.contains("sale");
    EBBools.isQuickPresent = EBAppString.screenAccessList.contains("quick");
    EBBools.isTokenPresent = EBAppString.screenAccessList.contains("token");

    debugPrint("sales ----------------->> ${EBBools.isSalePresent}");
    debugPrint("quick -------------------->> ${EBBools.isQuickPresent}");
    debugPrint("token ------------------->> ${EBBools.isTokenPresent}");
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

  String formateQty(String value) {
    double number = double.tryParse(value) ?? 0.0;
    NumberFormat formatter = NumberFormat('0.000');
    return formatter.format(number);
  }

  void _updateSalesTab() {
    debugPrint('_updateSalesTab called ----------------------->>   ');
    if (inventoryController.filterableCategoryList != null &&
        inventoryController.seachableProductList != null) {
      debugPrint(
          'filterableCategoryList and seachableProductList data are presednt ----------------------->>  ');
      update();
    } else {
      Future.delayed(const Duration(seconds: 2), update);
      NetworkController.logoutFromApp();
    }
  }

  String converDecimalConditionally(double num) {
    // Check if the number is an integer by comparing the fractional part to 0
    if (num == num.toInt()) {
      return num.toInt().toString();
    } else {
      return num.toString();
    }
  }
}
