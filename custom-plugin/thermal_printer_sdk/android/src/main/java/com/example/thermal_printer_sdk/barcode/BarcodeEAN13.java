package com.example.thermal_printer_sdk.barcode;

import com.example.thermal_printer_sdk.EscPosPrinterCommands;
import com.example.thermal_printer_sdk.EscPosPrinterSize;
import com.example.thermal_printer_sdk.exceptions.EscPosBarcodeException;

public class BarcodeEAN13 extends BarcodeNumber {

    public BarcodeEAN13(EscPosPrinterSize printerSize, String code, float widthMM, float heightMM, int textPosition) throws EscPosBarcodeException {
        super(printerSize, EscPosPrinterCommands.BARCODE_TYPE_EAN13, code, widthMM, heightMM, textPosition);
    }

    @Override
    public int getCodeLength() {
        return 13;
    }
}
