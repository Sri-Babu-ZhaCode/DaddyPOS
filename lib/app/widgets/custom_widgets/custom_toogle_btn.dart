import 'package:flutter/material.dart';
import '../../constants/themes.dart';

class EBCustomToogleBtn extends StatelessWidget {
  const EBCustomToogleBtn({super.key, required this.value, this.onChanged});
  final bool value;
  final ValueChanged<bool>? onChanged;

  @override
  Widget build(BuildContext context) {
    return Switch(
      value: value,
      onChanged: onChanged,
      activeTrackColor: EBTheme.kPrintBtnColor,
      inactiveTrackColor: EBTheme.kPrimaryWhiteColor,
      inactiveThumbColor: EBTheme.textFillColor,
    );
  }
}
