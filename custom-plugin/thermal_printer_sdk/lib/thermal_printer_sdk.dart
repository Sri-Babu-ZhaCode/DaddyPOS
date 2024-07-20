import 'package:thermal_printer_sdk/models/printer_template_settings.dart';

import 'thermal_printer_sdk_platform_interface.dart';

class ThermalPrinterSdk {
  Future<String?> getPlatformVersion() {
    return ThermalPrinterSdkPlatform.instance.getPlatformVersion();
  }

  Future<bool?> print(PrinterTemplateSettings settings) {
    return ThermalPrinterSdkPlatform.instance.print(settings);
  }
}
