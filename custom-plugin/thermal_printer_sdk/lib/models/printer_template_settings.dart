class PrinterTemplateSettings {
  String? deviceAddress;
  String template;
  num printerDpi;
  num printerWidth;
  num nbrCharPerLine;
  PrinterTemplateSettings({
    this.deviceAddress,
    required this.template,
    required this.printerDpi,
    required this.printerWidth,
    required this.nbrCharPerLine,
  }) : super();
}
