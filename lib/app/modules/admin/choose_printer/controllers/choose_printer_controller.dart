import 'dart:async';
import 'package:blue_thermal_printer/blue_thermal_printer.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class ChoosePrinterController extends GetxController {
  BlueThermalPrinter bluetooth = BlueThermalPrinter.instance;

  List<BluetoothDevice>? devices = [];
  bool connected = false;
  bool? isBluetoothAvailable;
  // BluetoothAdapterState adapterState = BluetoothAdapterState.unknown;
  // late StreamSubscription<BluetoothAdapterState> adapterStateStateSubscription;
  @override
  void onInit() {
    super.onInit();
    checkBlutoothAvailability();
    fetchingBtDevices();
  }

  Future<void> fetchingBtDevices() async {
    try {
      getBtDevices();
    } catch (e) {
      debugPrint('error ---------------->>  $e');
    }
  }

  Future<void> getBtDevices() async {
    devices = await bluetooth.getBondedDevices();
    devices ??= [];
    update();
    for (var element in devices!) {
      debugPrint(element.name);
    }
  }

  @override
  void onReady() {
    super.onReady();
  }

  @override
  void onClose() {
    // adapterStateStateSubscription.cancel();
    super.onClose();
  }

  void checkBlutoothAvailability() async {
    isBluetoothAvailable = await bluetooth.isOn;
    update();

    print(isBluetoothAvailable);
  }

  // Future<void> initBluetoothState() async {
  //   try {
  //     if (Platform.isAndroid) {
  //       await FlutterBluePlus.turnOn();
  //     }
  //   } catch (e) {
  //     EBCustomSnackbar.show('Turn on bluetooth to Choose printer');
  //   }
  // }

/* 

 Future<void> initPlatformState() async {
    print('Choose printer is called ===============>>  ');
    String _permissionStatus = 'Unknown';

    var statusLocation = Permission.location;
    // openAppSettings();

    if (!await statusLocation.isGranted) {
      _permissionStatus = 'Granted';
      await Permission.location.request();
    }
    if (await statusLocation.isDenied) {
      _permissionStatus = 'denied';
      await Permission.location.request();
      EBCustomSnackbar.show(
          'Location Permission is needed to select the printer');
    }
    if (await statusLocation.isPermanentlyDenied) {
      _permissionStatus = 'permanently denied';
      openAppSettings();
    }
    print('permiision statusLocation =======>>  $_permissionStatus');

    // Map<Permission, PermissionStatus> statuses =
    //     await [Permission.location, Permission.bluetoothScan, Permission.bluetoothConnect].request();

    // bool allGranted = true;
    // statuses.forEach((permission, status) {
    //   if (status.isDenied || status.isPermanentlyDenied) {
    //     allGranted = false;
    //   }
    // });

    // if (allGranted) {
    //   fetchingBtDevices();
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

    //  var statusLocation = Permission.location;
    // if (await statusLocation.isGranted != true) {
    //   await Permission.location.request();
    // }
    // if (await statusLocation.isGranted) {

    // } else {

    // }
    // bool? isConnected = await bluetooth.isConnected;
    // try {
    //   devices = await bluetooth.getBondedDevices();
    // } on PlatformException {}

    // bluetooth.onStateChanged().listen((state) {
    //   switch (state) {
    //     case BlueThermalPrinter.CONNECTED:
    //         _connected = true;
    //         debugPrint("bluetooth device state: connected");

    //       break;
    //     case BlueThermalPrinter.DISCONNECTED:
    //         _connected = false;
    //         debugPrint("bluetooth device state: disconnected");
    //       break;
    //     case BlueThermalPrinter.DISCONNECT_REQUESTED:
    //         _connected = false;
    //         debugPrint("bluetooth device state: disconnect requested");
    //       break;
    //     case BlueThermalPrinter.STATE_TURNING_OFF:
    //         _connected = false;
    //         debugPrint("bluetooth device state: bluetooth turning off");
    //       break;
    //     case BlueThermalPrinter.STATE_OFF:
    //         _connected = false;
    //         debugPrint("bluetooth device state: bluetooth off");
    //       break;
    //     case BlueThermalPrinter.STATE_ON:
    //         _connected = false;
    //         debugPrint("bluetooth device state: bluetooth on");
    //       break;
    //     case BlueThermalPrinter.STATE_TURNING_ON:
    //         _connected = false;
    //         debugPrint("bluetooth device state: bluetooth turning on");
    //       break;
    //     case BlueThermalPrinter.ERROR:
    //         _connected = false;
    //         debugPrint("bluetooth device state: error");
    //       break;
    //     default:
    //       debugPrint(state.toString());
    //       break;
    //   }
    // });

    // if (isConnected == true) {
    //     _connected = true;
    // }
    // if (_connected) {
    //   fetchingBtDevices() ;
    // }
  }









*/
}
