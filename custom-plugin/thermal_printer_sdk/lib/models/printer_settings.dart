class PrinterSettings {
  String? deviceAddress;
  num printerDpi;
  num printerWidth;
  num nbrCharPerLine;
  PrinterSettings({
    this.deviceAddress,
    required this.printerDpi,
    required this.printerWidth,
    required this.nbrCharPerLine,
  }) : super();
}
