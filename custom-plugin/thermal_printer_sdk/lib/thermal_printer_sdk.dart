import 'package:thermal_printer_sdk/models/printer_template_settings.dart';
import 'package:thermal_printer_sdk/models/text_to_image_args.dart';

import 'thermal_printer_sdk_platform_interface.dart';

class ThermalPrinterSdk {
  Future<String?> getPlatformVersion() {
    return ThermalPrinterSdkPlatform.instance.getPlatformVersion();
  }

  Future<bool?> print(PrinterTemplateSettings settings) {
    return ThermalPrinterSdkPlatform.instance.print(settings);
  }

  Future<bool?> printUsb(PrinterTemplateSettings settings) {
    return ThermalPrinterSdkPlatform.instance.printUsb(settings);
  }

  Future<String?> textToImg(TextToImageArgs args) {
    return ThermalPrinterSdkPlatform.instance.textToImg(args);
  }
}
