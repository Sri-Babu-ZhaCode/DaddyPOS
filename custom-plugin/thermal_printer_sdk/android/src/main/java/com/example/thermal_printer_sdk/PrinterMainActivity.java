package com.example.thermal_printer_sdk;

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
import com.example.thermal_printer_sdk.usb.UsbConnection;
import com.example.thermal_printer_sdk.usb.UsbPrintersConnections;

class TemplateSettings {
    String deviceAddress;
    String template;
    int printerDpi;
    float printerWidth;
    int nbrCharPerLine;

    TemplateSettings(String deviceAddress,
                     String template,
                     int printerDpi,
                     float printerWidth,
                     int nbrCharPerLine) {
        this.deviceAddress = deviceAddress;
        this.template = template;
        this.printerDpi = printerDpi;
        this.printerWidth = printerWidth;
        this.nbrCharPerLine = nbrCharPerLine;
    }

}

public class PrinterMainActivity {
    private static final String ACTION_USB_PERMISSION = "com.android.example.USB_PERMISSION";
    private Context _context;

    private final BroadcastReceiver usbReceiver = new BroadcastReceiver() {
        @RequiresApi(api = Build.VERSION_CODES.N)
        public void onReceive(Context context, Intent intent) {
            String action = intent.getAction();
            if (ACTION_USB_PERMISSION.equals(action)) {
                synchronized (this) {
                    UsbManager usbManager = (UsbManager) _context.getSystemService(Context.USB_SERVICE);
                    UsbDevice usbDevice = (UsbDevice) intent.getParcelableExtra(UsbManager.EXTRA_DEVICE);
                    if (intent.getBooleanExtra(UsbManager.EXTRA_PERMISSION_GRANTED, false)) {
                        if (usbManager != null && usbDevice != null) {

                            try {
                                EscPosPrinter printer;
                                printer =  new EscPosPrinter(new UsbConnection(usbManager, usbDevice), 200, 48f, 32);
                                printer.printFormattedTextAndCut("templateSettings.template");
                            } catch (Exception e) {
                                Toast.makeText(context, e.toString(), Toast.LENGTH_SHORT).show();
                                throw new RuntimeException(e);
                            }
                        }
                    }
                }
            }
        }
    };
    private BluetoothConnection getDeviceFromAddress(String deviceAddress) {
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
            DeviceConnection deviceConnection = getDeviceFromAddress(templateSettings.deviceAddress);
            if (deviceConnection == null) {

            }
            printer = new EscPosPrinter(deviceConnection, templateSettings.printerDpi, templateSettings.printerWidth, templateSettings.nbrCharPerLine);
            printer.printFormattedTextAndCut(templateSettings.template);
        } catch (Exception e) {

            throw new RuntimeException(e);
        }
    }
    public void printUsb(Context context) {
        _context = context;
        UsbConnection usbConnection = UsbPrintersConnections.selectFirstConnected(context);
        UsbManager usbManager = (UsbManager) context.getSystemService(Context.USB_SERVICE);

        if (usbConnection == null || usbManager == null) {
            Log.d("PrintUSB","Failed");
            return;
        }

        PendingIntent permissionIntent = PendingIntent.getBroadcast(
                context,
                0,
                new Intent(ACTION_USB_PERMISSION),
                android.os.Build.VERSION.SDK_INT >= android.os.Build.VERSION_CODES.S ? PendingIntent.FLAG_MUTABLE : 0
        );
        IntentFilter filter = new IntentFilter(ACTION_USB_PERMISSION);
        context.registerReceiver(this.usbReceiver, filter);
        usbManager.requestPermission(usbConnection.getDevice(), permissionIntent);
    }

    /**
     * @param text
     * @param textSize      32
     * @param interfaceType NORMAL,BOLD
     * @param alignment     CENTER,NORMAL
     * @return
     */
    public String changeTextToImageString(String text, int textSize, String interfaceType, String alignment){

        return bitmapToHexadecimalString(bitmapToBytes(72,getMultiLangTextAsImage(text, textSize, interfaceType.contains("BOLD")?
                Typeface.defaultFromStyle(Typeface.BOLD):Typeface.defaultFromStyle(Typeface.NORMAL), alignment.contains("CENTER")?
                Layout.Alignment.ALIGN_CENTER:Layout.Alignment.ALIGN_NORMAL)));

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
    Bitmap getMultiLangTextAsImage(String text, float textSize, Typeface typeface, Layout.Alignment alignment)  {
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
