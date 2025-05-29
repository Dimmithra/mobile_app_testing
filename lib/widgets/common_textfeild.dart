import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:mobile_app_test/utils/colors.dart';
import 'package:provider/provider.dart';

class CommonTextFeild extends StatefulWidget {
  const CommonTextFeild({
    super.key,
    required this.label,
    required this.hint,
    this.maxLength,
    this.maxLine = 1,
    this.isPassword = false,
    this.controller,
    this.isValidate = false,
    this.color = kDefTextColor,
    this.bordercolor,
    this.backgroundcolor,
    this.fullborder = false,
    this.filled,
    this.suffix,
    this.keyboardType = TextInputType.text,
    this.onChanged,
    this.capitalize = false,
    this.copyText = true,
    this.cutTextText = true,
    this.pasteText = true,
    this.selectAllText = true,
    this.height,
    this.fontSize,
    this.focusNode,
    this.textInputAction,
    this.fullbordercolor,
    this.prefixIcon,
    this.onTap,
  });

  final String label;
  final String hint;
  final int? maxLength;
  final int? maxLine;
  final bool isPassword;
  final TextEditingController? controller;
  final bool isValidate;
  final Color? color;
  final Color? bordercolor;
  final Color? fullbordercolor;
  final Color? backgroundcolor;
  final bool fullborder;
  final bool? filled;
  final Widget? suffix;
  final Widget? prefixIcon;
  final TextInputType keyboardType;
  final Function(String)? onChanged;
  final bool capitalize;
  final bool copyText;
  final bool cutTextText;
  final bool pasteText;
  final bool selectAllText;
  final double? height;
  final double? fontSize;
  final FocusNode? focusNode;
  final TextInputAction? textInputAction;
  final Function()? onTap;

  @override
  State<CommonTextFeild> createState() => _CommonTextFeildState();
}

class _CommonTextFeildState extends State<CommonTextFeild> {
  @override
  Widget build(BuildContext context) {
    return TextFormField(
      onTap: widget.onTap,
      textInputAction: widget.textInputAction,
      toolbarOptions: ToolbarOptions(
        copy: widget.copyText,
        cut: widget.cutTextText,
        paste: widget.pasteText,
        selectAll: widget.selectAllText,
      ),
      focusNode: widget.focusNode, // Correctly assigning the FocusNode here
      inputFormatters: const <TextInputFormatter>[],
      textCapitalization: widget.capitalize
          ? TextCapitalization.characters
          : TextCapitalization.none,
      controller: widget.controller,
      validator: (text) {
        if (widget.isValidate) {
          if (text == null || text.isEmpty) {
            return '${widget.hint} is Required';
          }
          return null;
        }
        return null;
      },
      onChanged: widget.onChanged,
      maxLength: widget.maxLength,
      keyboardType: widget.keyboardType,
      obscureText: widget.isPassword,

      style: TextStyle(
        fontSize: widget.fontSize ?? 14,
        height: widget.height ?? 1,
        color: kDefTextColor,
      ),
      maxLines: !widget.isPassword ? widget.maxLine : 1,
      decoration: InputDecoration(
        labelText: widget.label,
        hintText: widget.hint,
        hintStyle: TextStyle(color: kDefTextColor),
        labelStyle: TextStyle(
          color: kDefTextColor,
        ),
        filled: widget.filled,
        suffixIcon: widget.suffix,
        prefixIcon: widget.prefixIcon,
        fillColor: Colors.black,
        enabledBorder: widget.fullborder
            ? OutlineInputBorder(
                borderRadius: BorderRadius.circular(10),
                borderSide: BorderSide(
                  color: widget.fullbordercolor ?? Colors.blue,
                ),
              )
            : null,
        errorBorder: widget.fullborder
            ? OutlineInputBorder(
                borderRadius: BorderRadius.circular(10.0),
                borderSide: BorderSide(color: kErrorMessageColor),
              )
            : null,
        focusedBorder: !widget.fullborder
            ? UnderlineInputBorder(
                borderSide: BorderSide(
                    color: widget.bordercolor ?? widget.color ?? Colors.black),
              )
            : OutlineInputBorder(
                borderRadius: BorderRadius.circular(10.0),
                borderSide: BorderSide(
                  color: Colors.black,
                ),
              ),
      ),
    );
  }
}
