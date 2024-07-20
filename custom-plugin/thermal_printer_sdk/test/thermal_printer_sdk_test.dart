import 'package:flutter_test/flutter_test.dart';
import 'package:thermal_printer_sdk/thermal_printer_sdk.dart';
import 'package:thermal_printer_sdk/thermal_printer_sdk_platform_interface.dart';
import 'package:thermal_printer_sdk/thermal_printer_sdk_method_channel.dart';
import 'package:plugin_platform_interface/plugin_platform_interface.dart';

class MockThermalPrinterSdkPlatform
    with MockPlatformInterfaceMixin
    implements ThermalPrinterSdkPlatform {

  @override
  Future<String?> getPlatformVersion() => Future.value('42');
}

void main() {
  final ThermalPrinterSdkPlatform initialPlatform = ThermalPrinterSdkPlatform.instance;

  test('$MethodChannelThermalPrinterSdk is the default instance', () {
    expect(initialPlatform, isInstanceOf<MethodChannelThermalPrinterSdk>());
  });

  test('getPlatformVersion', () async {
    ThermalPrinterSdk thermalPrinterSdkPlugin = ThermalPrinterSdk();
    MockThermalPrinterSdkPlatform fakePlatform = MockThermalPrinterSdkPlatform();
    ThermalPrinterSdkPlatform.instance = fakePlatform;

    expect(await thermalPrinterSdkPlugin.getPlatformVersion(), '42');
  });
}
