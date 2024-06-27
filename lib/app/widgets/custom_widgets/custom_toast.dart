import 'package:easybill_app/app/constants/themes.dart';
import 'package:fluttertoast/fluttertoast.dart';

Future<bool?> ebCustomTtoastMsg({required String message}) {
  Fluttertoast.cancel();
  return Fluttertoast.showToast(
      msg: message,
      toastLength: Toast.LENGTH_LONG,
      gravity: ToastGravity.BOTTOM,
      fontSize: 18,
      backgroundColor: EBTheme.toastBgColor,
      timeInSecForIosWeb: 1,
      textColor: EBTheme.kPrimaryWhiteColor);
}
