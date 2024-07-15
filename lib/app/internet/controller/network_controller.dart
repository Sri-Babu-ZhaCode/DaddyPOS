import 'package:connectivity_plus/connectivity_plus.dart';
import 'package:easybill_app/app/constants/bools.dart';
import 'package:easybill_app/app/constants/themes.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

import '../../routes/app_pages.dart';
import '../../widgets/custom_widgets/custom_snackbar.dart';

class NetworkController extends GetxController {
  final Connectivity _connectivity = Connectivity();

  @override
  void onInit() {
    super.onInit();
    _connectivity.onConnectivityChanged
        .listen((List<ConnectivityResult> result) {
      _updateConnectionStatus(result);
    });
  }

  static void logoutFromApp() {
    if (Get.isSnackbarOpen) {
      Get.offAllNamed(Routes.LOGIN);
    }
  }

  _updateConnectionStatus(List<ConnectivityResult> connectivityResults) {
    for (var connectivityResult in connectivityResults) {
      if (connectivityResult != ConnectivityResult.wifi &&
          connectivityResult != ConnectivityResult.mobile) {
        debugPrint('internet not connected ---------------------------->>');
        EBCustomSnackbar.showWithDays(
          'No Internet Connection or slow connection',
          days: 1,
          backgroundColor: EBTheme.redColor,
          icon: const Icon(
            Icons.wifi_off,
            color: Colors.white,
            size: 35,
          ),
        );
        EBBools.isInternerAvailabile = false;
        update();
        // Get.rawSnackbar(
        //     messageText: const Text('Please connect to the Internet',
        //         style: TextStyle(color: Colors.white, fontSize: 14)),
        //     isDismissible: false,
        //     duration: const Duration(days: 1),
        //     backgroundColor: EBTheme.redColor,
        //     icon: const Icon(
        //       Icons.wifi_off,
        //       color: Colors.white,
        //       size: 35,
        //     ),
        //     margin: EdgeInsets.zero,
        //     snackStyle: SnackStyle.GROUNDED);
      } else {
         EBBools.isInternerAvailabile = true;
        debugPrint('internet connected ---------------------------->>');
        if (Get.isSnackbarOpen) {
          Get.closeCurrentSnackbar();
        }
        update();
      }
    }
  }
}
