package com.example.thermal_printer_sdk.barcode;


import com.example.thermal_printer_sdk.EscPosPrinterCommands;
import com.example.thermal_printer_sdk.EscPosPrinterSize;
import com.example.thermal_printer_sdk.exceptions.EscPosBarcodeException;

public class Barcode39 extends Barcode {
    public Barcode39(EscPosPrinterSize printerSize, String code, float widthMM, float heightMM, int textPosition) throws EscPosBarcodeException {
        super(printerSize, EscPosPrinterCommands.BARCODE_TYPE_39, code, widthMM, heightMM, textPosition);
    }

    @Override
    public int getCodeLength() {
        return this.code.length();
    }

    @Override
    public int getColsCount() {
        return (this.getCodeLength() + 4) * 16;
    }
}
