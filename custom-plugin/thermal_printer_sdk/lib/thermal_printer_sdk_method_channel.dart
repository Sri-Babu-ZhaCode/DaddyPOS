import 'package:flutter/foundation.dart';
import 'package:flutter/services.dart';
import 'package:thermal_printer_sdk/models/printer_template_settings.dart';
import 'package:thermal_printer_sdk/models/text_to_image_args.dart';

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

  @override
  Future<bool?> printUsb(PrinterTemplateSettings settings) async {
    final status = await methodChannel.invokeMethod<bool>('printUsb', {
      "template": settings.template,
      "printerDpi": settings.printerDpi,
      "printerWidth": settings.printerWidth,
      "nbrCharPerLine": settings.nbrCharPerLine,
    });
    return status;
  }

  @override
  Future<String?> textToImg(TextToImageArgs args) async {
    final text = await methodChannel.invokeMethod<String>('textToImg', {
      "text": args.text,
      "textSize": args.textSize,
      "interfaceType": args.interfaceType,
      "alignment": args.alignment
    });
    return text;
  }
}
