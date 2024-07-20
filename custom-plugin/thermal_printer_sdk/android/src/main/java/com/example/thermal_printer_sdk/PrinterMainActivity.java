package com.example.thermal_printer_sdk;

import com.example.thermal_printer_sdk.bluetooth.BluetoothConnection;
import com.example.thermal_printer_sdk.bluetooth.BluetoothPrintersConnections;

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
}
