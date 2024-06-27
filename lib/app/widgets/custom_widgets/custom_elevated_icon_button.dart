import 'package:flutter/material.dart';
import '../../constants/size_config.dart';
import '../../constants/themes.dart';

class CustomElevatedIconButton extends StatelessWidget {
  const CustomElevatedIconButton({
    super.key,
    this.label,
    required this.onPressed,
    this.iconData,
    this.bgColor,
  });
  final VoidCallback? onPressed;
  final Widget? label;
  final IconData? iconData;
  final Color? bgColor;

  @override
  Widget build(BuildContext context) {
    return ElevatedButton.icon(
        onPressed: onPressed,
        style: ElevatedButton.styleFrom(
          elevation: 8,
          foregroundColor: Colors.white,
          backgroundColor: bgColor ?? EBTheme.kPrintBtnColor,
          shape: RoundedRectangleBorder(
            borderRadius: EBSizeConfig.borderRadiusCircular40,
          ),
          // maximumSize: const Size(double.infinity, 56),
          //  minimumSize: const Size(double.infinity, 56),
        ),
        icon: Container(
          decoration: const BoxDecoration(
            shape: BoxShape.circle,
            color: EBTheme.kPrimaryWhiteColor,
          ),
          child: Icon(
            iconData ?? Icons.add,
            color: EBTheme.kPrintBtnColor,
          ),
        ),
        label: label ?? const Spacer());
  }
}
