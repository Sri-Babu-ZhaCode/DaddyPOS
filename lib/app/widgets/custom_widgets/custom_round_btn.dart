import 'package:easybill_app/app/constants/size_config.dart';
import 'package:flutter/material.dart';

class RoundedButton extends StatelessWidget {
  final IconData icon;
  final Function()? onPressed;
  final Color? bgColor;

  final Color? iconColor;

  const RoundedButton(
      {super.key,
      required this.icon,
      required this.onPressed,
      this.bgColor,
      this.iconColor});

  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: onPressed,
      borderRadius: EBSizeConfig.borderRadiusCircular15,
      child: Container(
        margin: EBSizeConfig.edgeInsetsAll08,
        padding: EBSizeConfig.edgeInsetsAll08,
        decoration: BoxDecoration(
          borderRadius: EBSizeConfig
              .borderRadiusCircular15, // Adjust border radius as needed
          border: Border.all(color: bgColor ?? Colors.blue), // Border color
        ),
        child: Icon(icon, color: iconColor ?? Colors.blue),
      ),
    );
  }
}
