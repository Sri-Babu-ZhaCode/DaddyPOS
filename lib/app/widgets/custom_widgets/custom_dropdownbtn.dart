import 'package:flutter/material.dart';

import '../../constants/size_config.dart';
import '../../constants/themes.dart';

class CustomDropDownFormField<T> extends StatelessWidget {
  final Widget? icon;
  final bool isExpanded = true;
  final T? value;
  final Widget? suffixIcon;
  final void Function(T?)? onChanged;
  final List<DropdownMenuItem<T>>? items;

  const CustomDropDownFormField({
    super.key,
    this.icon,
    this.suffixIcon,
    required this.items,
    required this.onChanged,
    this.value,
  });

  @override
  Widget build(BuildContext context) {
    return DropdownButtonFormField<T>(
      value: value,
      items: items,
      onChanged: onChanged,
      icon: const Icon(Icons.keyboard_arrow_down_rounded),
      iconSize: 20,
      decoration: InputDecoration(
        fillColor: EBTheme.kPrimaryWhiteColor,
        filled: true,
        border: OutlineInputBorder(
          borderRadius: EBSizeConfig.borderRadiusCircular04,
        ),
        focusedBorder: OutlineInputBorder(
          borderRadius: EBSizeConfig.borderRadiusCircular04,
          borderSide: const BorderSide(
            color: EBTheme.kPrimaryColor,
          ),
        ),
        disabledBorder: const OutlineInputBorder(
          borderSide: BorderSide(
            color: EBTheme.kPrimaryColor,
          ),
        ),
        suffixIcon: suffixIcon,
      ),
    );
  }
}
