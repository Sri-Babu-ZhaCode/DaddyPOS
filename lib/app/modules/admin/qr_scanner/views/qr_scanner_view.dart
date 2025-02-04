import 'dart:async';

import 'package:easybill_app/app/constants/app_string.dart';
import 'package:easybill_app/app/constants/bools.dart';
import 'package:easybill_app/app/modules/admin/qr_scanner/controllers/qr_scanner_controller.dart';
import 'package:easybill_app/app/modules/cashier/cashier_bills/controllers/cashier_bills_controller.dart';
import 'package:easybill_app/app/widgets/custom_widgets/custom_scaffold.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:mobile_scanner/mobile_scanner.dart';

import '../../../../constants/app_text_style.dart';
import '../../../../constants/size_config.dart';
import '../../../cashier/cashier_bills/views/bill_items_edit.dart';

class QrScannerView extends StatefulWidget {
  const QrScannerView({super.key});

  @override
  // ignore: library_private_types_in_public_api
  _QrScannerViewState createState() => _QrScannerViewState();
}

class _QrScannerViewState extends State<QrScannerView> {
  @override
  void initState() {
    super.initState();
    debugPrint('${EBAppString.settimeinterval}');
  }

  final MobileScannerController controller = MobileScannerController(
    // formats: const [BarcodeFormat.qrCode],
    formats: const [BarcodeFormat.all],
    detectionTimeoutMs: int.parse(EBAppString.settimeinterval ?? '1') * 1000,
  );

  @override
  Widget build(BuildContext context) {
    EBSizeConfig.init(context);
    final scanWindow = Rect.fromCenter(
      center: MediaQuery.sizeOf(context).center(Offset.zero),
      width: 200,
      height: 200,
    );

    return GetBuilder<QrScannerController>(builder: (_) {
      return EBCustomScaffold(
        noDrawer: true,
        body: Column(
          children: [
            if (EBBools.triggeredFromBillTab)
              GetBuilder<CashierBillsController>(builder: (controller) {
                return SizedBox(
                  height: EBSizeConfig.screenHeight * 0.18,
                  child: ListView.builder(
                    padding: EBSizeConfig.textContentPadding,
                    itemCount: controller.billItems.length,
                    itemBuilder: (context, index) => Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Flexible(
                          child: Text(
                              '${EBAppString.productlanguage == 'English' ? controller.billItems[index].productNameEnglish : controller.billItems[index].productnameTamil} (${controller.converDecimalConditionally(controller.billItems[index].quantity!)})',
                              style: EBAppTextStyle.billItemStyle),
                        ),
                        Row(
                          children: [
                            Text(
                                ' + ${controller.billItems[index].totalprice!.toStringAsFixed(2)}',
                                style: EBAppTextStyle.avtiveTxt),
                            IconButton(
                              icon: const Icon(
                                Icons.edit_outlined,
                                size: 16,
                              ), // 'x' icon
                              onPressed: () {
                                // edit bottom sheet
                                controller.billItemIndex = index;

                                controller.itemQuantityController.text =
                                    controller.billItems[index].quantity
                                        .toString();
                                billItemEditorBottomSheet(
                                    context, controller.billItems[index]);
                              },
                            ),
                          ],
                        )
                      ],
                    ),
                  ),
                );
              }),
            Expanded(
              child: Stack(
                fit: StackFit.expand,
                children: [
                  Center(
                    child: MobileScanner(
                      fit: BoxFit.fill,
                      controller: controller,
                      scanWindow: scanWindow,
                      errorBuilder: (context, error, child) {
                        return ScannerErrorWidget(error: error);
                      },
                      overlayBuilder: (context, constraints) {
                        return Padding(
                          padding: const EdgeInsets.all(16.0),
                          child: Align(
                            alignment: Alignment.topCenter,
                            child: ScannedBarcodeLabel(
                                barcodes: controller.barcodes),
                          ),
                        );
                      },
                      onDetect: (capture) async {
                        controller.detectionTimeoutMs;
                        final List<Barcode> barcodes = capture.barcodes;
                        //   LogUtility.custom('Capture Object ${capture.raw}');
                        //   LogUtility.custom('RAW ${capture.raw}');
                        var value = barcodes.isNotEmpty
                            ? barcodes.first.rawValue
                            : null;
                        if (value != null) {
                          debugPrint(
                              ' ----------------------------------->>  : barcode value $value');
                          if (EBBools.triggeredFromBillTab) {
                            //   Timer(const Duration(seconds: 2), () {
                            Get.find<CashierBillsController>()
                                .addBillItemByQrOrBarcode(value);
                            //  });
                          } else {
                            debugPrint(
                                ' oppes else part executed ------------------------->>>');
                            Get.back(result: value);
                            controller.stop();
                          }
                          //  context.pop(value);
                        }
                      },
                    ),
                  ),
                  ValueListenableBuilder(
                    valueListenable: controller,
                    builder: (context, value, child) {
                      if (!value.isInitialized ||
                          !value.isRunning ||
                          value.error != null) {
                        return const SizedBox();
                      }

                      return CustomPaint(
                        painter: ScannerOverlay(scanWindow: scanWindow),
                      );
                    },
                  ),
                  Align(
                    alignment: Alignment.bottomCenter,
                    child: Padding(
                      padding: const EdgeInsets.all(16.0),
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                        children: [
                          ToggleFlashlightButton(controller: controller),
                          SwitchCameraButton(controller: controller),
                        ],
                      ),
                    ),
                  ),
                ],
              ),
            ),
          ],
        ),
      );
    });
  }

  @override
  Future<void> dispose() async {
    super.dispose();
    await controller.dispose();
    await controller.stop();
  }
}

class ScannerOverlay extends CustomPainter {
  const ScannerOverlay({
    required this.scanWindow,
    this.borderRadius = 12.0,
  });

  final Rect scanWindow;
  final double borderRadius;

  @override
  void paint(Canvas canvas, Size size) {
    // we need to pass the size to the custom paint widget
    final backgroundPath = Path()..addRect(Rect.largest);

    final cutoutPath = Path()
      ..addRRect(
        RRect.fromRectAndCorners(
          scanWindow,
          topLeft: Radius.circular(borderRadius),
          topRight: Radius.circular(borderRadius),
          bottomLeft: Radius.circular(borderRadius),
          bottomRight: Radius.circular(borderRadius),
        ),
      );

    final backgroundPaint = Paint()
      ..color = Colors.black.withOpacity(0.5)
      ..style = PaintingStyle.fill
      ..blendMode = BlendMode.dstOut;

    final backgroundWithCutout = Path.combine(
      PathOperation.difference,
      backgroundPath,
      cutoutPath,
    );

    final borderPaint = Paint()
      ..color = Colors.white
      ..style = PaintingStyle.stroke
      ..strokeWidth = 4.0;

    final borderRect = RRect.fromRectAndCorners(
      scanWindow,
      topLeft: Radius.circular(borderRadius),
      topRight: Radius.circular(borderRadius),
      bottomLeft: Radius.circular(borderRadius),
      bottomRight: Radius.circular(borderRadius),
    );

    // First, draw the background,
    // with a cutout area that is a bit larger than the scan window.
    // Finally, draw the scan window itself.
    canvas.drawPath(backgroundWithCutout, backgroundPaint);
    canvas.drawRRect(borderRect, borderPaint);
  }

  @override
  bool shouldRepaint(ScannerOverlay oldDelegate) {
    return scanWindow != oldDelegate.scanWindow ||
        borderRadius != oldDelegate.borderRadius;
  }
}

class StartStopMobileScannerButton extends StatelessWidget {
  const StartStopMobileScannerButton({required this.controller, super.key});

  final MobileScannerController controller;

  @override
  Widget build(BuildContext context) {
    return ValueListenableBuilder(
      valueListenable: controller,
      builder: (context, state, child) {
        if (!state.isInitialized || !state.isRunning) {
          return IconButton(
            color: Colors.white,
            icon: const Icon(Icons.play_arrow),
            iconSize: 32.0,
            onPressed: () async {
              await controller.stop();
              await controller.start();
            },
          );
        }

        return IconButton(
          color: Colors.white,
          icon: const Icon(Icons.stop),
          iconSize: 32.0,
          onPressed: () async {
            await controller.stop();
          },
        );
      },
    );
  }
}

class SwitchCameraButton extends StatelessWidget {
  const SwitchCameraButton({required this.controller, super.key});

  final MobileScannerController controller;

  @override
  Widget build(BuildContext context) {
    return ValueListenableBuilder(
      valueListenable: controller,
      builder: (context, state, child) {
        if (!state.isInitialized || !state.isRunning) {
          return const SizedBox.shrink();
        }

        final int? availableCameras = state.availableCameras;

        if (availableCameras != null && availableCameras < 2) {
          return const SizedBox.shrink();
        }

        final Widget icon;

        switch (state.cameraDirection) {
          case CameraFacing.front:
            icon = const Icon(Icons.camera_front);
          case CameraFacing.back:
            icon = const Icon(Icons.camera_rear);
        }

        return IconButton(
          iconSize: 32.0,
          icon: icon,
          onPressed: () async {
            await controller.switchCamera();
          },
        );
      },
    );
  }
}

class ToggleFlashlightButton extends StatelessWidget {
  const ToggleFlashlightButton({required this.controller, super.key});

  final MobileScannerController controller;

  @override
  Widget build(BuildContext context) {
    return ValueListenableBuilder(
      valueListenable: controller,
      builder: (context, state, child) {
        if (!state.isInitialized || !state.isRunning) {
          return const SizedBox.shrink();
        }

        switch (state.torchState) {
          case TorchState.auto:
            return IconButton(
              color: Colors.white,
              iconSize: 32.0,
              icon: const Icon(Icons.flash_auto),
              onPressed: () async {
                await controller.toggleTorch();
              },
            );
          case TorchState.off:
            return IconButton(
              color: Colors.white,
              iconSize: 32.0,
              icon: const Icon(Icons.flash_off),
              onPressed: () async {
                await controller.toggleTorch();
              },
            );
          case TorchState.on:
            return IconButton(
              color: Colors.white,
              iconSize: 32.0,
              icon: const Icon(Icons.flash_on),
              onPressed: () async {
                await controller.toggleTorch();
              },
            );
          case TorchState.unavailable:
            return const Icon(
              Icons.no_flash,
              color: Colors.grey,
            );
        }
      },
    );
  }
}

class ScannerErrorWidget extends StatelessWidget {
  const ScannerErrorWidget({super.key, required this.error});

  final MobileScannerException error;

  @override
  Widget build(BuildContext context) {
    String errorMessage;

    switch (error.errorCode) {
      case MobileScannerErrorCode.controllerUninitialized:
        errorMessage = 'Controller not ready.';
      case MobileScannerErrorCode.permissionDenied:
        errorMessage = 'Permission denied';
      case MobileScannerErrorCode.unsupported:
        errorMessage = 'Scanning is unsupported on this device';
      default:
        errorMessage = 'Generic Error';
        break;
    }

    return ColoredBox(
      color: Colors.black,
      child: Center(
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            const Padding(
              padding: EdgeInsets.only(bottom: 16),
              child: Icon(Icons.error, color: Colors.white),
            ),
            Text(
              errorMessage,
              style: const TextStyle(color: Colors.white),
            ),
            Text(
              error.errorDetails?.message ?? '',
              style: const TextStyle(color: Colors.white),
            ),
          ],
        ),
      ),
    );
  }
}

class ScannedBarcodeLabel extends StatelessWidget {
  const ScannedBarcodeLabel({
    super.key,
    required this.barcodes,
  });

  final Stream<BarcodeCapture> barcodes;

  @override
  Widget build(BuildContext context) {
    return StreamBuilder(
      stream: barcodes,
      builder: (context, snapshot) {
        final scannedBarcodes = snapshot.data?.barcodes ?? [];

        if (scannedBarcodes.isEmpty) {
          return const Text(
            'Scan something!',
            overflow: TextOverflow.fade,
            style: TextStyle(color: Colors.white),
          );
        }

        return Text(
          scannedBarcodes.first.displayValue ?? 'No display value.',
          overflow: TextOverflow.fade,
          style: const TextStyle(color: Colors.white),
        );
      },
    );
  }
}
