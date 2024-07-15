import 'package:flutter/material.dart';

import '../../constants/size_config.dart';
import '../../constants/themes.dart';

class CustomContainer extends StatelessWidget {
  CustomContainer({
    super.key,
    this.alignment,
    this.padding,
    this.color,
    this.decoration,
    this.foregroundDecoration,
    BoxConstraints? constraints,
    this.margin,
    this.transform,
    this.transformAlignment,
    this.child,
    this.clipBehavior = Clip.none,
    this.height,
    this.noHeight,
    this.borderColor,
    this.onPressed,
    this.borderWidth,
    this.width,
  })  : assert(margin == null || margin.isNonNegative),
        assert(padding == null || padding.isNonNegative),
        assert(decoration == null || decoration.debugAssertIsValid()),
        assert(constraints == null || constraints.debugAssertIsValid()),
        assert(decoration != null || clipBehavior == Clip.none),
        assert(
          color == null || decoration == null,
          'Cannot provide both a color and a decoration\n'
          'To provide both, use "decoration: BoxDecoration(color: color)".',
        );

  final AlignmentGeometry? alignment;
  final EdgeInsetsGeometry? padding;
  final Color? color;
  final Color? borderColor;
  final bool? noHeight;
  final Decoration? decoration;
  final Decoration? foregroundDecoration;
  final EdgeInsetsGeometry? margin;
  final Matrix4? transform;
  final AlignmentGeometry? transformAlignment;
  final Clip clipBehavior;
  final Widget? child;
  final double? height;
  final double? width;
  final VoidCallback? onPressed;
  final double? borderWidth;

  @override
  Widget build(BuildContext context) {
    return noHeight == true
        ? Container(
            padding: padding ?? EBSizeConfig.textContentPadding,
            margin: margin ?? EBSizeConfig.edgeInsetsAll02,
            alignment: Alignment.centerLeft,
            width: width ?? double.infinity,
            decoration: BoxDecoration(
                color: color ?? EBTheme.listColor,
                borderRadius: EBSizeConfig.borderRadiusCircular04,
                border: borderColor != null
                    ? Border.all(color: borderColor!, width: borderWidth ?? 4.0)
                    : null),
            child: child,
          )
        : Container(
            padding: padding ?? EBSizeConfig.textContentPadding,
            margin: margin ?? EBSizeConfig.edgeInsetsAll02,
            alignment: Alignment.centerLeft,
            width: width ?? double.infinity,
            height: height ?? 100,
            decoration: BoxDecoration(
                color: color ?? EBTheme.listColor,
                borderRadius: EBSizeConfig.borderRadiusCircular04,
                border: borderColor != null
                    ? Border.all(color: borderColor!, width: borderWidth ?? 4.0)
                    : null),
            child: child,
          );
  }
}
