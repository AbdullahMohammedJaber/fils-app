// ignore_for_file: constant_identifier_names

import 'package:flutter/material.dart';

enum FontType { bold, regular, medium, light, veryLight, SemiBold, lineThrough }

class DefaultText extends StatelessWidget {
  final String? text;
  final Color? color;

  final double? height;
  final TextAlign? textAlign;
  final TextOverflow? overflow;
  final TextStyle? textStyle;
  final dynamic maxLines;
  final FontWeight? fontWeight;
  final FontType? type;
  final double? fontSize;
  final TextDirection? textDirection;
  final TextDecoration? textDecoration;
  final bool? isHexColor;
  const DefaultText(
    this.text, {
    super.key,
    this.type = FontType.regular,
    this.color,
    this.textAlign = TextAlign.start,
    this.fontSize,
    this.overflow = TextOverflow.ellipsis,
    this.maxLines,
    this.textStyle,
    this.height,
    this.isHexColor = false,
    this.textDecoration = TextDecoration.none,
    this.fontWeight,
    this.textDirection,
  });

  @override
  Widget build(BuildContext context) {
    return Text(
      text ?? '-',
      textAlign: textAlign,
      overflow: overflow,
      maxLines: overflow == TextOverflow.clip ? maxLines : null,
      style:
          textStyle ??
          style(context).copyWith(
            color: color ?? style(context).color,
            height: height ?? 1.3,
            fontSize: fontSize,
            fontWeight: fontWeight,
            decoration: textDecoration,
          ),
      textDirection: textDirection,
    );
  }

  TextStyle style(context) {
    switch (type!) {
      case FontType.bold:
        return Theme.of(context).textTheme.displayLarge!;
      case FontType.medium:
        return Theme.of(context).textTheme.displayMedium!;
      case FontType.regular:
        return Theme.of(context).textTheme.headlineMedium!;
      case FontType.light:
        return Theme.of(context).textTheme.bodySmall!;
      case FontType.SemiBold:
        return Theme.of(context).textTheme.headlineLarge!;

      case FontType.lineThrough:
        return Theme.of(context).textTheme.displaySmall!;

      case FontType.veryLight:
        return Theme.of(context).textTheme.titleSmall!;
    }
  }
}
