import 'package:easybill_app/app/constants/themes.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:get/get.dart';
import 'package:mobile_scanner/mobile_scanner.dart';
import 'app/constants/size_config.dart';
import 'app/internet/dependency.dart';
import 'app/routes/app_pages.dart';
import 'app/widgets/custom_widgets/custom_elevated_icon_button.dart';

Future<void> main() async {
  WidgetsFlutterBinding.ensureInitialized();
  if (isPhone) {
    await SystemChrome.setPreferredOrientations([
      DeviceOrientation.portraitUp,
    ]);
  }

  EBSizeConfig.mediaQueryData =
      MediaQueryData.fromView(WidgetsBinding.instance.window);
  SystemChrome.setSystemUIOverlayStyle(const SystemUiOverlayStyle(
    statusBarColor: EBTheme.kPrimaryColor,
  ));
  runApp(const MyApp());
  DependencyInjection.init();
}

bool get isPhone {
  final data = MediaQueryData.fromWindow(WidgetsBinding.instance.window);
  return data.size.shortestSide < 576; // Adjust threshold as needed
}

class MyApp extends StatelessWidget {
  const MyApp({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return GetMaterialApp(
      debugShowCheckedModeBanner: false,
      title: "Easy Bill",
      theme: ThemeData(
        primaryColor: EBTheme.kPrimaryColor,
        scaffoldBackgroundColor: Colors.white,
        bottomSheetTheme: const BottomSheetThemeData(
            backgroundColor: EBTheme.kPrimaryWhiteColor),
        popupMenuTheme:
            const PopupMenuThemeData(position: PopupMenuPosition.over),
        inputDecorationTheme: InputDecorationTheme(
          filled: true,
          fillColor: Colors.white,
          iconColor: EBTheme.kPrimaryColor,
          prefixIconColor: EBTheme.kPrimaryColor,
          contentPadding: const EdgeInsets.symmetric(
              horizontal: EBSizeConfig.defaultPadding,
              vertical: EBSizeConfig.defaultPadding),
          border: OutlineInputBorder(
            borderRadius: EBSizeConfig.borderRadiusCircular10,
            borderSide: BorderSide.none,
          ),
        ),
      ),
      initialRoute: AppPages.INITIAL,
      getPages: AppPages.routes,
      // home: Scaffold(
      //   body: Center(
      //     child: CustomElevatedButton(
      //         onPressed: () {
      //           Get.to(() => ScannerCode(title: "hellow",));
      //         },
      //         child: const Text('MobileScanner with zoom slider')),
      //   ),
      // ),
    );
  }
}

class ScannerCode extends StatefulWidget {
  final String title;
  const ScannerCode({super.key, required this.title});

  static MaterialPageRoute materialPageRoute(
      BuildContext context, String title) {
    return MaterialPageRoute(builder: (_) => ScannerCode(title: title));
  }

  @override
  State<ScannerCode> createState() => _ScannerCodeState();
}

class _ScannerCodeState extends State<ScannerCode> with WidgetsBindingObserver {
  late final MobileScannerController controller;
  bool loading = true;

  @override
  void initState() {
    super.initState();
    Future.delayed(Duration.zero, () {
      controller = MobileScannerController();
      // var d = MobileScannerPlatform.instance.;
      // AppUtil.unfocus(context);
      loading = false;
      setState(() {});
      WidgetsBinding.instance.addObserver(this);

      // Start listening to the barcode events.
      // _subscription = controller.barcodes.listen(_handleBarcode);

      // Finally, start the scanner itself.
      // unawaited(controller.start());
    });
  }

  @override
  void didChangeAppLifecycleState(AppLifecycleState state) {
    // If the controller is not ready, do not try to start or stop it.
    // Permission dialogs can trigger lifecycle changes before the controller is ready.
    if (!controller.value.isInitialized) {
      return;
    }

    switch (state) {
      case AppLifecycleState.detached:
      case AppLifecycleState.hidden:
      case AppLifecycleState.paused:
        return;
      case AppLifecycleState.resumed:
      // Restart the scanner when the app is resumed.
      // Don't forget to resume listening to the barcode events.
      //  _subscription = controller.barcodes.listen(_handleBarcode);
      case AppLifecycleState.inactive:
      // Stop the scanner when the app is paused.
      // Also stop the barcode events subscription.
      // unawaited(_subscription?.cancel());
      // _subscription = null;
      // unawaited(controller.stop());
    }
  }

  @override
  void dispose() {
    super.dispose();
    controller.dispose();
    // Stop listening to lifecycle changes.
    WidgetsBinding.instance.removeObserver(this);
    // Stop listening to the barcode events.
    // unawaited(_subscription?.cancel());
    // _subscription = null;
    // Dispose the widget itself.
    // super.dispose();
    // Finally, dispose of the controller.
    // await controller.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        centerTitle: true,
        toolbarHeight: 70,
        leadingWidth: 60,
        leading: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            CustomElevatedIconButton(
              iconData: Icons.arrow_back,
              onPressed: () async {
                await controller.stop().then((value) {
                  Navigator.of(context).pop();
                });
              },
            ),
          ],
        ),
        title: Text(
          widget.title,
          style: const TextStyle(color: EBTheme.kPrimaryColor, fontSize: 18),
        ),
        actions: [
          if (!loading)
            Column(
              mainAxisAlignment: MainAxisAlignment.center,
              crossAxisAlignment: CrossAxisAlignment.end,
              children: [
                SizedBox(
                  height: 40,
                  width: 90,
                  child: Padding(
                    padding: EBSizeConfig.edgeInsetsOnlyW20,
                    child: CustomElevatedIconButton(
                      iconData: controller.torchEnabled
                          ? Icons.flash_on
                          : Icons.flash_off,
                      onPressed: () {
                        controller.toggleTorch();
                        setState(() {});
                      },
                    ),
                  ),
                ),
              ],
            ),
        ],
        backgroundColor: EBTheme.blue,
        elevation: 0.0,
      ),
      body: loading
          ? const Center(child: CircularProgressIndicator())
          : Column(
              children: [
                EBSizeConfig.sizedBoxH20,
                EBSizeConfig.sizedBoxH20,
                const Text(
                  'Place Your Camera Into the barcode',
                  style: TextStyle(
                    color: EBTheme.blue,
                    fontSize: 16,
                  ),
                ),
                EBSizeConfig.sizedBoxH08,
                const Text(
                  'Scanning............',
                  style: TextStyle(
                    color: EBTheme.kPrimaryColor,
                    fontSize: 16,
                  ),
                ),
                EBSizeConfig.sizedBoxH100,
                Center(
                  child: SizedBox(
                    height: context.height * 0.4,
                    width: context.width * 0.9,
                    child: DecoratedBox(
                      decoration:
                          const BoxDecoration(color: EBTheme.kCancelBtnColor),
                      child: MobileScanner(
                        controller: controller,
                        // startDelay: true,
                        onDetect: (capture) {
                          final List<Barcode> barcodes = capture.barcodes;
                          //   LogUtility.custom('Capture Object ${capture.raw}');
                          //   LogUtility.custom('RAW ${capture.raw}');
                          var value = barcodes.isNotEmpty
                              ? barcodes.first.rawValue
                              : null;
                          if (value != null) {
                            controller.stop();
                            //  context.pop(value);
                          }
                        },
                      ),
                    ),
                  ),
                ),
              ],
            ),
    );
  }
}
