import 'package:flutter/material.dart';
import 'dart:async';

import 'package:flutter/services.dart';
import 'package:thermal_printer_sdk/models/printer_template_settings.dart';
import 'package:thermal_printer_sdk/models/text_to_image_args.dart';
import 'package:thermal_printer_sdk/thermal_printer_sdk.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatefulWidget {
  const MyApp({super.key});

  @override
  State<MyApp> createState() => _MyAppState();
}

class _MyAppState extends State<MyApp> {
  String _platformVersion = 'Unknown';
  final _thermalPrinterSdkPlugin = ThermalPrinterSdk();
  bool _isBluetoothEnabled = false;

  @override
  void initState() {
    super.initState();
    initPlatformState();
  }

  // Platform messages are asynchronous, so we initialize in an async method.
  Future<void> initPlatformState() async {
    String platformVersion;
    // Platform messages may fail, so we use a try/catch PlatformException.
    // We also handle the message potentially returning null.
    try {
      // _isBluetoothEnabled = await _thermalPrinterSdkPlugin.print(
      //         PrinterTemplateSettings(
      //             deviceAddress: "DC:0D:30:23:0E:00",
      //             template: "template",
      //             printerDpi: 200,
      //             printerWidth: 72,
      //             nbrCharPerLine: 48)) ??
      final imageString = await _thermalPrinterSdkPlugin.textToImg(
          TextToImageArgs(
              text: "text",
              textSize: 36,
              interfaceType: "BOLD",
              alignment: "CENTER"));
      print(imageString);
      _thermalPrinterSdkPlugin.printUsb(PrinterTemplateSettings(
          template: "template",
          printerDpi: 200,
          printerWidth: 72,
          nbrCharPerLine: 48));
      false;
      platformVersion = await _thermalPrinterSdkPlugin.getPlatformVersion() ??
          'Unknown platform version';
    } on PlatformException {
      platformVersion = 'Failed to get platform version.';
    }

    // If the widget was removed from the tree while the asynchronous platform
    // message was in flight, we want to discard the reply rather than calling
    // setState to update our non-existent appearance.
    if (!mounted) return;

    setState(() {
      _platformVersion = platformVersion;
    });
  }

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      home: Scaffold(
        appBar: AppBar(
          title: const Text('Plugin example app'),
        ),
        body: Center(
          child: Text(
              'Running on: $_platformVersion\n Bluetooth enabled: $_isBluetoothEnabled'),
        ),
      ),
    );
  }
}
