import 'package:flutter/foundation.dart';
import 'package:flutter/services.dart';
import 'package:thermal_printer_sdk/models/printer_template_settings.dart';

import 'thermal_printer_sdk_platform_interface.dart';

/// An implementation of [ThermalPrinterSdkPlatform] that uses method channels.
class MethodChannelThermalPrinterSdk extends ThermalPrinterSdkPlatform {
  /// The method channel used to interact with the native platform.
  @visibleForTesting
  final methodChannel = const MethodChannel('thermal_printer_sdk');

  @override
  Future<String?> getPlatformVersion() async {
    final version =
        await methodChannel.invokeMethod<String>('getPlatformVersion');
    return version;
  }

  @override
  Future<bool?> print(PrinterTemplateSettings settings) async {
    final status = await methodChannel.invokeMethod<bool>('print', {
      "deviceAddress": settings.deviceAddress,
      "template": settings.template,
      "printerDpi": settings.printerDpi,
      "printerWidth": settings.printerWidth,
      "nbrCharPerLine": settings.nbrCharPerLine,
    });
    return status;
  }
}
