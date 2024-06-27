import 'package:flutter/material.dart';
import '../../constants/size_config.dart';
import '../../constants/themes.dart';

class CustomElevatedButton extends StatelessWidget {
  final VoidCallback? onPressed;
  final Widget? child;
  final double minWidth;
  final bool isDefaultWidth;
  final Color? btnColor;
  final double? elevation;

  const CustomElevatedButton({
    super.key,
    required this.onPressed,
    required this.child,
    this.minWidth = double.infinity,
    this.isDefaultWidth = false,
    this.btnColor,
    this.elevation,
  });

  @override
  Widget build(BuildContext context) {
    return ElevatedButton(
      onPressed: onPressed,
      style: isDefaultWidth
          ? ElevatedButton.styleFrom(
              alignment: Alignment.center,
              elevation: elevation ?? 8,
              foregroundColor: Colors.white,
              backgroundColor: btnColor ?? EBTheme.kPrintBtnColor,
              shape: RoundedRectangleBorder(
                borderRadius: EBSizeConfig.borderRadiusCircular08,
              ),
            )
          : ElevatedButton.styleFrom(
              alignment: Alignment.center,
              elevation: elevation ?? 8,
              foregroundColor: Colors.white,
              backgroundColor: btnColor ?? EBTheme.kPrintBtnColor,
              shape: RoundedRectangleBorder(
                borderRadius: EBSizeConfig.borderRadiusCircular08,
              ),
              minimumSize: Size(minWidth, 56),
              maximumSize: const Size(double.infinity, 56),
            ),
      child: child,
    );
  }
}
