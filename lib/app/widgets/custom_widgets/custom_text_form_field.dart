import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import '../../constants/app_text_style.dart';
import '../../constants/size_config.dart';
import '../../constants/themes.dart';

class CustomTextFormField extends StatelessWidget {
  final String labelText;
  final Color? fillColor;
  final String? hintText;
  final int? maxLines;
  final int? maxLength;
  final TextStyle? style;
  final Widget? suffixIcon;
  final Widget? prefixIcon;
  final void Function(String)? onChanged;
  final Function()? onTap;
  final bool? enabled;
  final TextEditingController? controller;
  final bool? autofocus = false;
  final bool readOnly;
  final AutovalidateMode? autovalidateMode;
  final TextInputType? keyboardType;
  final InputDecoration? decoration;
  final bool obscureText;
  final String? errorText;
  final String? initialValue;
  final String? Function(String?)? validator;
  final List<TextInputFormatter>? inputFormatters;
  final bool? expand;

  final EdgeInsetsGeometry? contentPadding;

  const CustomTextFormField(
      {super.key,
      required this.labelText,
      this.hintText,
      this.fillColor,
      this.style,
      this.maxLength,
      this.onChanged,
      this.controller,
      this.keyboardType,
      this.decoration,
      this.errorText,
      this.readOnly = false,
      this.onTap,
      this.enabled,
      this.initialValue,
      this.prefixIcon,
      this.maxLines = 1,
      this.suffixIcon,
      this.validator,
      this.inputFormatters,
      this.obscureText = false,
      this.expand = false,
      this.contentPadding,
      this.autovalidateMode});

  @override
  Widget build(BuildContext context) {
    return TextFormField(
      expands: expand!,
      validator: validator,
      maxLines: maxLines,
      enabled: enabled,
      onChanged: onChanged,
      onTap: onTap,
      controller: controller,
      keyboardType: keyboardType,
      initialValue: initialValue,
      autovalidateMode: autovalidateMode ?? AutovalidateMode.onUserInteraction,
      readOnly: readOnly,
      enableInteractiveSelection: readOnly ? false : true,
      obscureText: obscureText,
      maxLength: maxLength,
      inputFormatters: inputFormatters,
      decoration: InputDecoration(
        suffixIcon: suffixIcon,
        suffixIconColor: EBTheme.kPrimaryColor,
        prefixIcon: prefixIcon,
        prefixIconColor: EBTheme.kPrimaryColor,
        filled: true,
        counterText: '',
        errorText: errorText,
        fillColor: fillColor,
        contentPadding: contentPadding ?? EBSizeConfig.textContentPadding,
        hintText: hintText,
        labelText: labelText,
        labelStyle: EBAppTextStyle.txtStyle,
        border: OutlineInputBorder(
          borderRadius: EBSizeConfig.borderRadiusCircular04,
          borderSide: const BorderSide(
            color: EBTheme.kPrimaryColor,
          ),
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
      ),
    );
  }
}
