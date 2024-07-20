package com.example.thermal_printer_sdk.textparser;


import com.example.thermal_printer_sdk.EscPosPrinterCommands;
import com.example.thermal_printer_sdk.exceptions.EscPosConnectionException;
import com.example.thermal_printer_sdk.exceptions.EscPosEncodingException;

public interface IPrinterTextParserElement {
    int length() throws EscPosEncodingException;
    IPrinterTextParserElement print(EscPosPrinterCommands printerSocket) throws EscPosEncodingException, EscPosConnectionException;
}
