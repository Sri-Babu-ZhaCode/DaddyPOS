package com.example.thermal_printer_sdk;

import android.app.Activity;

import androidx.annotation.NonNull;

import com.example.thermal_printer_sdk.exceptions.EscPosConnectionException;

import io.flutter.embedding.engine.plugins.FlutterPlugin;
import io.flutter.embedding.engine.plugins.activity.ActivityAware;
import io.flutter.embedding.engine.plugins.activity.ActivityPluginBinding;
import io.flutter.plugin.common.MethodCall;
import io.flutter.plugin.common.MethodChannel;
import io.flutter.plugin.common.MethodChannel.MethodCallHandler;
import io.flutter.plugin.common.MethodChannel.Result;

/** ThermalPrinterSdkPlugin */
public class ThermalPrinterSdkPlugin implements FlutterPlugin, MethodCallHandler, ActivityAware {
  /// The MethodChannel that will the communication between Flutter and native Android
  ///
  /// This local reference serves to register the plugin with the Flutter Engine and unregister it
  /// when the Flutter Engine is detached from the Activity
  private MethodChannel channel;
  private Activity activityContext;


  @Override
  public void onAttachedToEngine(@NonNull FlutterPluginBinding flutterPluginBinding) {
    channel = new MethodChannel(flutterPluginBinding.getBinaryMessenger(), "thermal_printer_sdk");
    channel.setMethodCallHandler(this);
  }

  @Override
  public void onMethodCall(@NonNull MethodCall call, @NonNull Result result) {
    PrinterMainActivity printerMainActivity = PrinterMainActivity.getInstance();
      switch (call.method) {
          case "getPlatformVersion":
              result.success("Android " + android.os.Build.VERSION.RELEASE);
              break;
          case "print":
              try {
                  String template = call.argument("template");
                  TemplateSettings settings = new TemplateSettings(
                          template
                  );
                  printerMainActivity.print(settings);
                  result.success(true);
              } catch (Exception e) {
                  result.error("ERROR", "Failed to print to the bluetooth printer. Please try again.", e);
              }

              break;
          case "printUsb":
              try {
                  String template = call.argument("template");

                  TemplateSettings settings = new TemplateSettings(
                          template
                  );
                  printerMainActivity.printUsb(activityContext.getApplicationContext(), settings, new UsbReceiverCallback() {
                    @Override
                    void onComplete() {
                      result.success(true);
                    }

                    @Override
                      public void onFailed(Exception e) {
                          if (e instanceof DeviceNotFoundException) {
                              result.error("ERROR", "Failed to detect the device, Please check the printer connection.", e);
                          } else {
                              result.error("ERROR", "Failed to print to the usb printer. Please try again.", e);
                          }
                      }
                  });

              } catch (Exception e) {
                  if (e instanceof DeviceNotFoundException) {
                      result.error("ERROR", "Failed to detect the device, Please check the printer connection.", e);
                  } else {
                      result.error("ERROR", "PrintUSB", e);
                  }

              }

              break;
          case "textToImg":
              try {
                  String content = call.argument("text");
                  int textSize = call.argument("textSize");
                  String interfaceType = call.argument("interfaceType");
                  String alignment = call.argument("alignment");
                  String text = printerMainActivity.changeTextToImageString( content, textSize, interfaceType, alignment);
                  result.success(text);
              } catch (Exception e) {
                  if (e instanceof EscPosConnectionException) {
                      result.error("ERROR", "Failed to detect the device, Please check the printer connection.", e);
                  } else {
                      result.error("ERROR", "Failed to convert the text to image", e);
                  }


              }
              break;
          case "init":
              try {
                  String deviceAddress = call.argument("deviceAddress");
                  int printerDpi = call.argument("printerDpi");
                  int printerWidth = call.argument("printerWidth");
                  int nbr = call.argument("nbrCharPerLine");
                  printerMainActivity.init(activityContext.getApplicationContext(),new PrinterSettings(deviceAddress, printerDpi, printerWidth, nbr));
                  result.success(true);
              } catch (Exception e) {
                  result.error("ERROR", "Failed to initialise the plugin", e);
              }

              break;
          default:
              result.notImplemented();
              break;
      }
  }



  @Override
  public void onDetachedFromEngine(@NonNull FlutterPluginBinding binding) {
    channel.setMethodCallHandler(null);
  }

  @Override
  public void onAttachedToActivity(@NonNull ActivityPluginBinding activityPluginBinding) {
    activityContext =  activityPluginBinding.getActivity();
//    activityContext.onRequestPermissionsResult();
  }

  @Override
  public void onDetachedFromActivityForConfigChanges() {

  }

  @Override
  public void onReattachedToActivityForConfigChanges(@NonNull ActivityPluginBinding activityPluginBinding) {

  }

  @Override
  public void onDetachedFromActivity() {

  }
}
