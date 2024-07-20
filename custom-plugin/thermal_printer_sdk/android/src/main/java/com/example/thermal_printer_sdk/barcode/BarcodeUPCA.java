package com.example.thermal_printer_sdk.barcode;


import com.example.thermal_printer_sdk.EscPosPrinterCommands;
import com.example.thermal_printer_sdk.EscPosPrinterSize;
import com.example.thermal_printer_sdk.exceptions.EscPosBarcodeException;

public class BarcodeUPCA extends BarcodeNumber {

    public BarcodeUPCA(EscPosPrinterSize printerSize, String code, float widthMM, float heightMM, int textPosition) throws EscPosBarcodeException {
        super(printerSize, EscPosPrinterCommands.BARCODE_TYPE_UPCA, code, widthMM, heightMM, textPosition);
    }

    @Override
    public int getCodeLength() {
        return 12;
    }
}
