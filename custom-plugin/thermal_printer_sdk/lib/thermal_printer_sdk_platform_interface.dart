import 'package:plugin_platform_interface/plugin_platform_interface.dart';
import 'package:thermal_printer_sdk/models/printer_settings.dart';
import 'package:thermal_printer_sdk/models/template_settings.dart';
import 'package:thermal_printer_sdk/models/text_to_image_args.dart';

import 'thermal_printer_sdk_method_channel.dart';

abstract class ThermalPrinterSdkPlatform extends PlatformInterface {
  /// Constructs a ThermalPrinterSdkPlatform.
  ThermalPrinterSdkPlatform() : super(token: _token);

  static final Object _token = Object();

  static ThermalPrinterSdkPlatform _instance = MethodChannelThermalPrinterSdk();

  /// The default instance of [ThermalPrinterSdkPlatform] to use.
  ///
  /// Defaults to [MethodChannelThermalPrinterSdk].
  static ThermalPrinterSdkPlatform get instance => _instance;

  /// Platform-specific implementations should set this with their own
  /// platform-specific class that extends [ThermalPrinterSdkPlatform] when
  /// they register themselves.
  static set instance(ThermalPrinterSdkPlatform instance) {
    PlatformInterface.verifyToken(instance, _token);
    _instance = instance;
  }

  Future<String?> getPlatformVersion() {
    throw UnimplementedError('platformVersion() has not been implemented.');
  }

  Future<bool?> print(TemplateSettings  settings) {
    throw UnimplementedError('platformVersion() has not been implemented.');
  }

  Future<bool?> printUsb(TemplateSettings settings) {
    throw UnimplementedError('platformVersion() has not been implemented.');
  }

  Future<String?> textToImg(TextToImageArgs args) {
    throw UnimplementedError('platformVersion() has not been implemented.');
  }

  Future<bool?> init(PrinterSettings settings) {
    throw UnimplementedError('platformVersion() has not been implemented.');
  }
}
