// ignore_for_file: must_be_immutable, avoid_init_to_null, unnecessary_null_in_if_null_operators, prefer_const_constructors

import 'package:easy_localization/easy_localization.dart';
 import 'package:flutter/material.dart';
import 'package:flutter/services.dart';



import 'package:fils/utils/theme/color_manager.dart';
import 'package:fils/utils/theme/font_manager.dart';
import 'package:flutter_svg/svg.dart';

import '../storage.dart';
import 'flip_view.dart';


class TextFormFieldWidget extends StatefulWidget {
  final TextInputType? textInputType;
  final String? hintText;
  final TextEditingController? controller;
  final Function()? onTap;
  final Function(String)? onTapDoneKey;
  final Function(dynamic)? onChange;

  final bool? isIcon;
  final String? pathIcon;
  final String? pathIconPrefix;

  final bool? isRequired;
  final TextInputAction? textInputAction;
  bool? isShow;
  final Function? ontapIcon;
  final Function? ontapIconPrefix;

  final bool? isPassword;
  final bool? isEmail;
  final EdgeInsets? edgeInsets;
  final dynamic maxLine;
  final Color? colorIconsPaht;
  String? initValue;
  final bool? isPreffix;
  final Widget? customIcon;
  bool isDouble;
  TextFormFieldWidget({
    super.key,
    this.textInputType,
     this.isDouble  = false,
    this.customIcon,
    this.ontapIconPrefix,
    this.pathIconPrefix,
    this.hintText,
    this.colorIconsPaht,
    this.ontapIcon,
    this.controller,
    this.onChange,
    this.initValue = null,
    this.isEmail = false,
    this.maxLine = 1,
    this.isPassword = false,
    this.isShow = false,
    this.onTap,
    this.textInputAction = TextInputAction.next,
    this.isRequired = false,
    this.isIcon = false,
    this.onTapDoneKey,
    this.pathIcon,
    this.isPreffix = false,
    this.edgeInsets = const EdgeInsets.all(20),
  });

  @override
  State<TextFormFieldWidget> createState() => _TextFormFieldWidgetState();
}

class _TextFormFieldWidgetState extends State<TextFormFieldWidget> {
  var emailRegExp =
      r'^(([^<>()[\]\\.,;:\s@\"]+(\.[^<>()[\]\\.,;:\s@\"]+)*)|(\".+\"))@((\[[0-9]{1,3}\.[0-9]{1,3}\.[0-9]{1,3}\.[0-9]{1,3}\])|(([a-zA-Z\-0-9]+\.)+[a-zA-Z]{2,}))$';




  @override
  Widget build(BuildContext context) {
    return TextFormField(
      obscureText: widget.isShow!,
      controller: widget.controller,
      maxLines: widget.maxLine,
      textInputAction: widget.textInputAction,
      keyboardType: widget.textInputType ?? TextInputType.none,
      onTap: widget.onTap,
      onFieldSubmitted: widget.onTapDoneKey,
      cursorColor: primaryColor,
      inputFormatters: widget.isDouble?  [
        FilteringTextInputFormatter.allow(RegExp(r'^\d*\.?\d{0,}$')),
       ] : null,
      initialValue: widget.initValue,
      scrollPadding: widget.edgeInsets!,
      validator: (value) {
        if (widget.isRequired!) {
          if (widget.isPassword!) {
            if (value!.length < 6) {
              return "Password less 6 characters".tr();
            } else {
              return null;
            }
          } else if (widget.isEmail!) {
            RegExp regExp = RegExp(emailRegExp);
            if (!regExp.hasMatch(value!)) {
              return "You Must Enter A Valid Email".tr();
            } else {
              return null;
            }
          }
          if (value!.isEmpty) {
            return "Please fill in this field".tr();
          } else {
            return null;
          }
        } else {
          return null;
        }
      },
      onChanged: widget.onChange ?? null,
      decoration: InputDecoration(
        filled: false,
        fillColor: const Color.fromARGB(255, 248, 247, 247),
        hintText: widget.hintText,
        hintStyle: TextStyle(
          overflow: TextOverflow.ellipsis,
          fontWeight: FontWeight.w400,
          color: Color(0xff898384),
          fontFamily:
              getLang() == 'en'
                  ? FontConstants.fontFamily
                  : FontConstants.fontFamilyAr,
          fontSize: 12,
        ),
        contentPadding: EdgeInsets.symmetric(vertical: 15, horizontal: 10),
        border: OutlineInputBorder(
          borderRadius: BorderRadius.circular(12),
          borderSide: BorderSide(color: border),
        ),
        enabledBorder: OutlineInputBorder(
          borderRadius: BorderRadius.circular(12),
          borderSide: BorderSide(color: border),
        ),
        focusedErrorBorder: OutlineInputBorder(
          borderRadius: BorderRadius.circular(12),
          borderSide: BorderSide(color: border),
        ),
        focusedBorder: OutlineInputBorder(
          borderRadius: BorderRadius.circular(12),
          borderSide: BorderSide(color: border),
        ),
        suffixIcon:
            widget.isIcon!
                ? GestureDetector(
                  onTap: () {
                    widget.ontapIcon!();
                  },
                  child: Container(
                    width: MediaQuery.of(context).size.width * 0.03,
                    color: Colors.transparent,
                    child: Center(
                      child:
                          widget.pathIcon.toString().contains(
                                ".svg",
                                widget.pathIcon.toString().length - 6,
                              )
                              ? FlipView(
                                child: SvgPicture.asset(widget.pathIcon!),
                              )
                              : Image.asset(
                                widget.pathIcon!,
                                height: 25,
                                width: 25,
                              ),
                    ),
                  ),
                )
                : widget.customIcon,
        prefixIcon:
            widget.isPreffix!
                ? Container(
                  width: MediaQuery.of(context).size.width * 0.02,
                  color: Colors.transparent,
                  child: GestureDetector(
                    onTap: () {
                      widget.ontapIconPrefix!();
                    },
                    child: Center(
                      child:
                          widget.pathIconPrefix.toString().contains(
                                ".svg",
                                widget.pathIconPrefix.toString().length - 6,
                              )
                              ? SvgPicture.asset(widget.pathIconPrefix!)
                              : Image.asset(
                                widget.pathIconPrefix!,
                                height: 25,
                                width: 25,
                              ),
                    ),
                  ),
                )
                : null,
      ),
    );
  }
}
