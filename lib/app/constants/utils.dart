import 'dart:io';

import 'package:device_info_plus/device_info_plus.dart';

String? deviceID;
String? deviceName;
Future getDeviceInfo() async {
  DeviceInfoPlugin deviceInfo = DeviceInfoPlugin();
  if (Platform.isAndroid) {
    AndroidDeviceInfo androidInfo = await deviceInfo.androidInfo;
    deviceID = androidInfo.id;
    deviceName = androidInfo.model;
  }
  // else if (Platform.isIOS) {
  //   IosDeviceInfo iosInfo = await deviceInfo.iosInfo;
  // }

  print('------------------------>> Devide Unique Id : $deviceID');
  print('------------------------>> Devide Unique Name : $deviceName');
}
