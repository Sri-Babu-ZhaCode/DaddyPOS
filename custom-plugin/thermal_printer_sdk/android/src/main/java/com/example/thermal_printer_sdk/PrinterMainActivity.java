package com.example.thermal_printer_sdk;

import android.annotation.SuppressLint;
import android.app.PendingIntent;
import android.content.BroadcastReceiver;
import android.content.Context;
import android.content.Intent;
import android.content.IntentFilter;
import android.graphics.Bitmap;
import android.graphics.Canvas;
import android.graphics.Color;
import android.graphics.Typeface;
import android.hardware.usb.UsbDevice;
import android.hardware.usb.UsbManager;
import android.os.Build;
import android.text.Layout;
import android.text.StaticLayout;
import android.text.TextPaint;
import android.util.Log;
import android.widget.Toast;

import androidx.annotation.RequiresApi;

import com.example.thermal_printer_sdk.bluetooth.BluetoothConnection;
import com.example.thermal_printer_sdk.bluetooth.BluetoothPrintersConnections;
import com.example.thermal_printer_sdk.exceptions.EscPosConnectionException;
import com.example.thermal_printer_sdk.textparser.PrinterTextParserImg;
import com.example.thermal_printer_sdk.usb.UsbConnection;
import com.example.thermal_printer_sdk.usb.UsbPrintersConnections;

import java.util.InvalidPropertiesFormatException;

class TemplateSettings {
    String template;

    TemplateSettings(
                     String template) {
        this.template = template;
    }

}
class PrinterSettings {
    String deviceAddress;
    int printerDpi;
    float printerWidth;
    int nbrCharPerLine;

    PrinterSettings(
            String deviceAddress,
            int printerDpi,
            float printerWidth,
            int nbrCharPerLine) {
        this.deviceAddress = deviceAddress;
        this.printerDpi = printerDpi;
        this.printerWidth = printerWidth;
        this.nbrCharPerLine = nbrCharPerLine;
    }

}

abstract class UsbReceiverCallback{
    void onComplete(UsbManager usbManager, UsbDevice usbDevice){}
    void onComplete(){}
    void onComplete(String content){}
    void onFailed(Exception e){}
}

interface TextToImageCallBackListerner{
    void onSuccess(String content);
    void onFailure(Exception e);
}

class DeviceNotFoundException extends Exception{
    DeviceNotFoundException(String message){
        super(message);
    }
}

public class PrinterMainActivity {
    private static final String ACTION_USB_PERMISSION = "com.android.example.USB_PERMISSION";
    private TemplateSettings templateSettings;
    private PrinterSettings printerSettings;
    private UsbManager usbManagerGlobal;
    private UsbDevice usbDeviceGlobal;
    private static PrinterMainActivity instance;
    private DeviceConnection selectedDevice;

    public static PrinterMainActivity getInstance(){
        if(instance ==null){
            synchronized (PrinterMainActivity.class){
                if (instance == null){
                    instance = new PrinterMainActivity();
                }
            }
        }
        return instance;
    }

    public void init(Context context,PrinterSettings settings) {
        printerSettings = settings;
        getSelectedDevice(context);

    }

    private static BluetoothConnection getDeviceFromAddress(String deviceAddress) {
        BluetoothConnection[] list = new BluetoothPrintersConnections().getList();

        if (list != null) {
            for (BluetoothConnection bluetoothConnection : list) {
                if (bluetoothConnection.getDevice().getAddress().contains(deviceAddress)) {
                    return new BluetoothConnection(bluetoothConnection.getDevice());
                }
            }
        }
        return null;
    }

    void print(TemplateSettings templateSettings) {
        try {
            EscPosPrinter printer;
//            DeviceConnection deviceConnection = getDeviceFromAddress(printerSettings.deviceAddress);
            if (selectedDevice == null) {
                throw new DeviceNotFoundException("DEVICE_NOT_FOUND");
            }
            printer = new EscPosPrinter(selectedDevice, printerSettings.printerDpi, printerSettings.printerWidth, printerSettings.nbrCharPerLine);
            printer.printFormattedTextAndCut(templateSettings.template);
        } catch (Exception e) {

            throw new RuntimeException(e);
        }
    }
    @SuppressLint("UnspecifiedRegisterReceiverFlag")
    private void checkUsbConnection(Context context,UsbReceiverCallback usbReceiverCallback) throws DeviceNotFoundException {
        UsbConnection usbConnection = UsbPrintersConnections.selectFirstConnected(context);
        UsbManager usbManager = (UsbManager) context.getSystemService(Context.USB_SERVICE);

        if (usbConnection == null || usbManager == null) {
            throw new DeviceNotFoundException("USB Device not found");
        }

        PendingIntent permissionIntent = PendingIntent.getBroadcast(
                context,
                0,
                new Intent(ACTION_USB_PERMISSION),
                android.os.Build.VERSION.SDK_INT >= android.os.Build.VERSION_CODES.S ? PendingIntent.FLAG_MUTABLE : 0
        );
        IntentFilter filter = new IntentFilter(ACTION_USB_PERMISSION);
        context.registerReceiver(new BroadcastReceiver() {

            @RequiresApi(api = Build.VERSION_CODES.N)
            public void onReceive(Context _context, Intent intent) {
                String action = intent.getAction();
                if (ACTION_USB_PERMISSION.equals(action)) {
                    synchronized (this) {
                        UsbManager usbManager = (UsbManager) context.getSystemService(Context.USB_SERVICE);
                        UsbDevice usbDevice = (UsbDevice) intent.getParcelableExtra(UsbManager.EXTRA_DEVICE);
                        if (intent.getBooleanExtra(UsbManager.EXTRA_PERMISSION_GRANTED, false)) {
                            if (usbManager != null && usbDevice != null) {
                               usbReceiverCallback.onComplete(usbManager,usbDevice);
                               return;
                            }
                        }
                    }
                }
                usbReceiverCallback.onFailed(new DeviceNotFoundException("USB_DEVICE_NOT_FOUND"));
            }

        }, filter);
        usbManager.requestPermission(usbConnection.getDevice(), permissionIntent);
    }
    @SuppressLint("UnspecifiedRegisterReceiverFlag")
    public void printUsb(Context  context, TemplateSettings settings, UsbReceiverCallback usbReceiverCallback) throws DeviceNotFoundException {

        templateSettings = settings;
        checkUsbConnection(context, new UsbReceiverCallback() {


            @Override
            public void onComplete(UsbManager usbManager, UsbDevice usbDevice)  {
                try {
                    EscPosPrinter printer;
                    if(templateSettings==null) usbReceiverCallback.onFailed(new InvalidPropertiesFormatException("Invalid Template settings"));
                    printer =  new EscPosPrinter(new UsbConnection(usbManager, usbDevice), printerSettings.printerDpi, printerSettings.printerWidth, printerSettings.nbrCharPerLine);
                    printer.printFormattedTextAndCut("templateSettings.template");
                    usbReceiverCallback.onComplete();
                } catch (Exception e) {
                    try {
                        usbReceiverCallback.onFailed(e);
                    } catch (Exception ex) {
                        throw new RuntimeException(ex);
                    }
                }
            }

            @Override
            void onFailed(Exception e)  {
                try {
                    usbReceiverCallback.onFailed(e);
                } catch (Exception ex) {
                    throw new RuntimeException(ex);
                }
            }
        });

    }

    private void getSelectedDevice(Context context){
        if(printerSettings.deviceAddress !=null){
            DeviceConnection deviceConnection = getDeviceFromAddress(printerSettings.deviceAddress);
            if (deviceConnection != null) {
               selectedDevice = deviceConnection;
            }

        }else{
            try {
                checkUsbConnection(context, new UsbReceiverCallback() {
                    @Override
                    void onComplete(UsbManager usbManager, UsbDevice usbDevice)  {
                        selectedDevice = new UsbConnection(usbManager,usbDevice);
                    }
                });
            } catch (DeviceNotFoundException e) {
                throw new RuntimeException(e);
            }
        }
    }

    /**
     * @param text
     * @param textSize      32
     * @param interfaceType NORMAL,BOLD
     * @param alignment     CENTER,NORMAL
     * @return
     */
    public String changeTextToImageString(String text, int textSize, String interfaceType, String alignment) throws EscPosConnectionException {
        EscPosPrinter printer;
        printer= new EscPosPrinter(selectedDevice, printerSettings.printerDpi, printerSettings.printerWidth, printerSettings.nbrCharPerLine);
        String content = PrinterTextParserImg.bitmapToHexadecimalString(printer,getMultiLangTextAsImage(text, textSize, interfaceType.contains("BOLD")?
                Typeface.defaultFromStyle(Typeface.BOLD):Typeface.defaultFromStyle(Typeface.NORMAL), alignment.contains("CENTER")?
                Layout.Alignment.ALIGN_CENTER:Layout.Alignment.ALIGN_NORMAL));
        return content;

    }

    private String bitmapToHexadecimalString(byte[] bytes) {
        StringBuilder imageHexString = new StringBuilder();
        for (byte aByte : bytes) {
            String hexString = Integer.toHexString(aByte & 0xFF);
            if (hexString.length() == 1) {
                imageHexString.append("0");
            }
            imageHexString.append(hexString);
        }
        return imageHexString.toString();
    }
    private byte[] bitmapToBytes(int maxWidth ,Bitmap bitmap) {
        boolean isSizeEdit = false;
        int bitmapWidth = bitmap.getWidth(),
                bitmapHeight = bitmap.getHeight(),
                maxHeight = 800;

        if (bitmapWidth > maxWidth) {
            bitmapHeight = Math.round(((float) bitmapHeight) * ((float) maxWidth) / ((float) bitmapWidth));
            bitmapWidth = maxWidth;
            isSizeEdit = true;
        }
        if (bitmapHeight > maxHeight) {
            bitmapWidth = Math.round(((float) bitmapWidth) * ((float) maxHeight) / ((float) bitmapHeight));
            bitmapHeight = maxHeight;
            isSizeEdit = true;
        }

        if (isSizeEdit) {
            bitmap = Bitmap.createScaledBitmap(bitmap, bitmapWidth, bitmapHeight, true);
        }

        return EscPosPrinterCommands.bitmapToBytes(bitmap, false);
    }
    Bitmap getMultiLangTextAsImage(String text, int textSize, Typeface typeface, Layout.Alignment alignment)  {
        TextPaint mPaint = new TextPaint();
        mPaint.setColor(Color.BLACK);
        if (typeface != null) mPaint.setTypeface(typeface);
        mPaint.setTextSize(textSize);


        StaticLayout mStaticLayout = new StaticLayout(text  , mPaint, 400, alignment, 1.0f, 0, true);

        int width = mStaticLayout.getWidth();
        int height = mStaticLayout.getHeight();

        Bitmap bitmap = Bitmap.createBitmap(width, height, Bitmap.Config.ARGB_8888);

        Canvas canvas = new Canvas(bitmap);

        canvas.drawColor(Color.WHITE);

        mStaticLayout.draw(canvas);

        return bitmap;
    }
}
