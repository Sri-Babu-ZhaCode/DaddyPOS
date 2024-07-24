package com.example.thermal_printer_sdk;

import android.app.Activity;

import androidx.annotation.NonNull;

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
    PrinterMainActivity printerMainActivity = new PrinterMainActivity();
    if (call.method.equals("getPlatformVersion")) {
      result.success("Android " + android.os.Build.VERSION.RELEASE);
    }
    else if (call.method.equals("print")){
      try {
        String deviceAddress = call.argument("deviceAddress");
        String template = call.argument("template");
        int printerDpi = call.argument("printerDpi");
        int printerWidth = call.argument("printerWidth");
        int nbr = call.argument("nbrCharPerLine");
        TemplateSettings settings = new TemplateSettings(
                deviceAddress,template,printerDpi,printerWidth,nbr
        );
        printerMainActivity.print(settings);
        result.success(true);
      }catch (Exception e){
        result.error("Exception","Print Bluetooth",e);
      }

    }else if(call.method.equals("printUsb")){
      try {
        String template = call.argument("template");
        int printerDpi = call.argument("printerDpi");
        int printerWidth = call.argument("printerWidth");
        int nbr = call.argument("nbrCharPerLine");
        TemplateSettings settings = new TemplateSettings(
                null,template,printerDpi,printerWidth,nbr
        );
        printerMainActivity.printUsb(activityContext.getApplicationContext(),settings);
        result.success(true);
      }catch (Exception e){
        result.error("Exception","PrintUSB",e);
      }

    }else if(call.method.equals("textToImg")){
      try {
        String content = call.argument("text");
        int textSize = call.argument("textSize");
        String interfaceType = call.argument("interfaceType");
        String alignment = call.argument("alignment");
        String text = printerMainActivity.changeTextToImageString(content,textSize,interfaceType,alignment);
        result.success(text);
      }catch (Exception e){
        result.error("Exception","PrintUSB",e);

      }
    }
    else {
      result.notImplemented();
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
