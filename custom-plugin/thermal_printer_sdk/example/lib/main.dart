import 'package:flutter/material.dart';
import 'dart:async';

import 'package:flutter/services.dart';
import 'package:thermal_printer_sdk/models/printer_settings.dart';
import 'package:thermal_printer_sdk/models/template_settings.dart';
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
  late final ThermalPrinterSdk _thermalPrinterSdkPlugin;
  bool _isBluetoothEnabled = false;

  @override
  void initState() {
    super.initState();
    _thermalPrinterSdkPlugin = ThermalPrinterSdk(PrinterSettings(
      printerDpi: 200,
      printerWidth: 48,
      nbrCharPerLine: 32,
      deviceAddress: "DC:0D:30:7D:B0:96",
    ));
  }

  // Platform messages are asynchronous, so we initialize in an async method.
  Future<void> initPlatformState() async {
    String platformVersion;
    // Platform messages may fail, so we use a try/catch PlatformException.
    // We also handle the message potentially returning null.
    try {
      String storeName = await _thermalPrinterSdkPlugin.textToImg(
              TextToImageArgs(
                  text: "ஸ்ட்ரீட் வாக் கபே",
                  textSize: 36,
                  interfaceType: "BOLD",
                  alignment: "CENTER")) ??
          "";
      String Addr1 = await _thermalPrinterSdkPlugin.textToImg(TextToImageArgs(
              text: "APK மெயின் ரோடு",
              textSize: 36,
              interfaceType: "BOLD",
              alignment: "CENTER")) ??
          "";
      String Addr2 = await _thermalPrinterSdkPlugin.textToImg(TextToImageArgs(
              text: "அவனியாபுரம்",
              textSize: 36,
              interfaceType: "BOLD",
              alignment: "CENTER")) ??
          "";
      String Addr3 = await _thermalPrinterSdkPlugin.textToImg(TextToImageArgs(
              text: "மதுரை",
              textSize: 36,
              interfaceType: "BOLD",
              alignment: "CENTER")) ??
          "";
      String pongal = await _thermalPrinterSdkPlugin.textToImg(TextToImageArgs(
              text: "பொங்கல்",
              textSize: 28,
              interfaceType: "NORMAL",
              alignment: "NORMAL")) ??
          "";
      String dosa = await _thermalPrinterSdkPlugin.textToImg(TextToImageArgs(
              text: "தோசை",
              textSize: 28,
              interfaceType: "NORMAL",
              alignment: "NORMAL")) ??
          "";
      String idly = await _thermalPrinterSdkPlugin.textToImg(TextToImageArgs(
              text: "இட்லி",
              textSize: 28,
              interfaceType: "NORMAL",
              alignment: "NORMAL")) ??
          "";
      String template1 =
          "[C]<img>$storeName</img>\n[C]<img>$Addr1</img>\n[C]<img>$Addr2</img>\n[C]<img>$Addr3</img>\n\n[C]<b>Ph: 9944040006</b>\n\n[L]<b><font size='big'>Bill No: 30</font></b>\n\n[L]<b>Date: 29-Jun-24</b>[R]<b>Time: 06:44 PM</b>\n[C]--------------------------------\n[L]<b>Sr</b>[L]<b>Name</b>[R]<b>Rate</b>[R]<b>Qty</b>[R]<b>Amount</b>\n[C]--------------------------------\n[L]<img>$pongal</img>\n[L][L][R]<b>40.00</b>[R]<b>2.00</b>[R]<b>80.00</b>\n[L]<img>$idly</img>\n[L][L][R]<b>10.00</b>[R]<b>10.00</b>[R]<b>100.00</b>\n[L]<img>$dosa</img>\n[L][L][R]<b>50.00</b>[R]<b>1.00</b>[R]<b>50.00</b>\n[C]--------------------------------\n[L]<b>Items: 3</b>[C]<b>Qty:13.00</b>[R]<b>230.00</b>\n[C]--------------------------------\n[C]<b><font size='big'>Rs 230.00</font></b>\n[C]<b><font size='big'>!THANK YOU VISIT AGAIN!</font></b>\n[L]\n[L]\n";
      await _thermalPrinterSdkPlugin
          .print(TemplateSettings(template: template1));

      platformVersion = await _thermalPrinterSdkPlugin.getPlatformVersion() ??
          'Unknown platform version';
    } catch (e) {
      if (e is PlatformException) print(e);
    }
    // If the widget was removed from the tree while the asynchronous platform
    // message was in flight, we want to discard the reply rather than calling
    // setState to update our non-existent appearance.
    if (!mounted) return;

    setState(() {
      // _platformVersion = platformVersion;
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
          child: Column(
            children: [
              IconButton(
                  onPressed: () {
                    initPlatformState();
                  },
                  icon: const Icon(Icons.print)),
              Text(
                  'Running on: $_platformVersion\n Bluetooth enabled: $_isBluetoothEnabled'),
            ],
          ),
        ),
      ),
    );
  }
}
