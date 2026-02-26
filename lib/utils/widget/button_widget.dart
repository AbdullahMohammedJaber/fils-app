import 'package:flutter/material.dart';
import 'package:fils/utils/theme/color_manager.dart';

import 'defulat_text.dart';

class ButtonWidget extends StatefulWidget {
  final dynamic title;
  final Color? colorTitle;
  final double? sizeTitle;
  final FontType fontType;
  final Color? colorButton;
  final double? heightButton;
  final Function()? onTap;
  final double? radius;

  const ButtonWidget({
    super.key,
    this.title,
    this.colorTitle = Colors.white,
    this.sizeTitle = 16,
    this.radius = 14,
    this.heightButton = 55,
    this.onTap,
    this.fontType = FontType.SemiBold,
    this.colorButton,
  });

  @override
  State<ButtonWidget> createState() => _ButtonWidgetState();
}

class _ButtonWidgetState extends State<ButtonWidget> {
  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: widget.onTap!,
      child: Container(
        height: widget.heightButton,
        decoration: BoxDecoration(
          color: widget.colorButton ?? primaryColor,
          borderRadius: BorderRadius.circular(widget.radius!),
        ),
        child: Center(
          child:
              widget.title is bool && widget.title == true
                  ? CircularProgressIndicator(
                    color: white,
                    strokeCap: StrokeCap.square,
                  )
                  : DefaultText(
                    widget.title!,
                    fontSize: 14,
                    type: widget.fontType,
                     
                    color: widget.colorTitle!,
                  ),
        ),
      ),
    );
  }
}

class ButtonWidgetBorder extends StatefulWidget {
  final dynamic title;
  final Color? colorTitle;
  final double? sizeTitle;
  final dynamic fontType;
  final Color? colorBorder;
  final double? heightButton;
  final Function()? onTap;

  const ButtonWidgetBorder({
    super.key,
    this.title,
    this.colorTitle = Colors.white,
    this.sizeTitle = 16,
    this.heightButton = 55,
    this.fontType = FontType.regular,
    this.colorBorder,
    this.onTap,
  });

  @override
  State<ButtonWidgetBorder> createState() => _ButtonWidgetBorderState();
}

class _ButtonWidgetBorderState extends State<ButtonWidgetBorder> {
  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: widget.onTap!,
      child: Container(
        height: widget.heightButton,
        decoration: BoxDecoration(
          color: white,
          borderRadius: BorderRadius.circular(14),
          border: Border.all(color: widget.colorBorder ?? primaryColor),
        ),
        child: Center(
          child:
              widget.title is bool && widget.title == true
                  ? CircularProgressIndicator(
                    color: white,
                    strokeCap: StrokeCap.square,
                  )
                  : DefaultText(
                    widget.title!,
                    fontSize: widget.sizeTitle!,
                    type: widget.fontType,
                    color: widget.colorTitle!,
                  ),
        ),
      ),
    );
  }
}
