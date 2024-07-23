import 'package:thermal_printer_sdk/models/printer_settings.dart';
import 'package:thermal_printer_sdk/models/template_settings.dart';
import 'package:thermal_printer_sdk/models/text_to_image_args.dart';

import 'thermal_printer_sdk_platform_interface.dart';

class ThermalPrinterSdk {
  ThermalPrinterSdk(PrinterSettings settings) {
    _init(settings);
  }
  Future<String?> getPlatformVersion() {
    return ThermalPrinterSdkPlatform.instance.getPlatformVersion();
  }

  Future<bool?> print(TemplateSettings settings) {
    return ThermalPrinterSdkPlatform.instance.print(settings);
  }

  Future<bool?> printUsb(TemplateSettings settings) {
    return ThermalPrinterSdkPlatform.instance.printUsb(settings);
  }

  Future<String?> textToImg(TextToImageArgs args) {
    return ThermalPrinterSdkPlatform.instance.textToImg(args);
  }

  _init(PrinterSettings settings) {
    return ThermalPrinterSdkPlatform.instance.init(settings);
  }
}
