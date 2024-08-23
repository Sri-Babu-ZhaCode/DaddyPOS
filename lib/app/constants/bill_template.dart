class BillTemplate {
  String template = '';
  String billData = '';
  String date = '';
  String time = '';
  String rate = '';
  String qty = '';
  String sno = '';
  String totlaQty = '';
  String amt = '';
  String totlaAmt = '';

  String get imageTagW1linebreak => "[C]<img>$billData</img>\n";
  String get imageTagW2linebreak => "[C]<img>$billData</img>\n\n";
  String get billPhone => "[C]<b>Mob: $billData</b>\n\n";
  String get billNo => "[L]<font size='big'>Bill No: $billData</font>\n\n";
  String get tokenNo => "[L]<b><font size='NORMAL'>Token No: $billData</font></b>\n\n";
  String get inch2divider => "[C]<b>--------------------------------</b>\n";
  String get inch3divider => "[C]<b>------------------------------------------------</b>\n";
  String get inch3QR => "\n[C]<qrcode size='30'>$billData</qrcode>\n\n";
  String get billDateTime => "[L]<b><font size='normal'>Date: $date</font></b>[R]<b>Time: $time</font></b>\n";
  String get tokenBillDateTime => "[L]<b><font size='normal'>Date:   $billData</font></b>\n";
  String get inch2billTopColumn => "[L]<b><font size='normal'>Sr</font></b>[L]<b><font size='normal'>Name</font></b>[R]<b><font size='normal'>Rate</font></b>[C]<b><font size='normal'>Qty</font></b>[C]<b><font size='normal'>Amount</font></b>\n";
  String get inch3billTopColumn => "[L]<b><font size='normal'>Sr Name</font></b>[L][R]<b><font size='normal'>Rate</font></b>[R]<b><font size='normal'>Qty</font></b>[R]<b><font size='normal'>Amount</font></b>\n";
  String get billProduct => '[L]<img>$billData</img>\n';
  String get billTokenProduct => '[L]<img>$billData</img>\n';
  String get inch2billPriceQtyAmt => "[L][L][R]<b><font size='normal'>$rate</font></b>[C]<b><font size='normal'>$qty</font></b>[C]<b><font size='normal'>$amt</font></b>\n";
  String get inch3billPriceQtyAmt => "[L][L][R]<b><font size='normal'>$rate</font></b>[R]<b><font size='normal'>$qty</font></b>[R]<b><font size='normal'>$amt</font></b>\n";
  String get billBottomColumn => "[L]<b><font size='normal'>Items: $billData</font></b>[C]<b><font size='normal'>Qty:$totlaQty</font></b>[R]<b><font size='normal'>$totlaAmt</font></b>\n";
  String get billDataTotalAmt => "[C]<font size='big'>Rs $totlaAmt</font>\n\n";
  String get billFooter => "[C]<img>$billData</img>\n\n\n\n";
}