import 'dart:async';
import 'package:bookstore_app/core/theme/colors.dart';
import 'package:flutter/material.dart';

class CustomTextField extends StatefulWidget {
  final Color? color;
  final String hintText;
  final String? labelText;
  final TextStyle? hintStyle;
  final TextStyle? labelStyle;
  final Widget? prefixIcon;
  final Widget? suffixIcon;
  final bool obscureText;
  final int? maxLines;
  final TextEditingController? controller;
  final FormFieldValidator<String>? validator;
  final TextInputType? keyboardType;
  final bool isPassword;
  final double? width;
  final double? height;
  final Function(String)? onDebouncedChanged;

  const CustomTextField({
    super.key,
    required this.hintText,
    this.color,
    this.labelText,
    this.hintStyle,
    this.labelStyle,
    this.prefixIcon,
    this.suffixIcon,
    this.obscureText = false,
    this.maxLines = 1,
    this.controller,
    this.validator,
    this.keyboardType,
    this.isPassword = false,
    this.width,
    this.height,
    this.onDebouncedChanged,
  });

  @override
  State<CustomTextField> createState() => _CustomTextFieldState();
}

class _CustomTextFieldState extends State<CustomTextField> {
  late bool obscure;
  Timer? debounce;

  @override
  void initState() {
    super.initState();
    obscure = widget.isPassword ? true : widget.obscureText;
  }

  void onTextChanged(String text) {
    if (debounce?.isActive ?? false) debounce?.cancel();

    debounce = Timer(const Duration(milliseconds: 500), () {
      if (widget.onDebouncedChanged != null) {
        widget.onDebouncedChanged!(text);
      }
    });
  }

  @override
  void dispose() {
    debounce?.cancel();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final Color backgroundColor = widget.color ?? Colors.white;
    final Color borderColor = AppColors.borderColor;

    return SizedBox(
      width: widget.width ?? 343,
      height: widget.height ?? 44,
      child: TextFormField(
        controller: widget.controller,
        obscureText: obscure,
        maxLines: widget.maxLines ?? 1,
        validator: widget.validator,
        keyboardType: widget.keyboardType,
        onChanged: onTextChanged,
        decoration: InputDecoration(
          filled: true,
          fillColor: backgroundColor,
          hintText: widget.hintText,
          labelText: widget.labelText,
          prefixIcon: widget.prefixIcon,
          suffixIcon: widget.isPassword
              ? GestureDetector(
                  onTap: () {
                    setState(() {
                      obscure = !obscure;
                    });
                  },
                  child: Icon(
                    obscure ? Icons.visibility_off : Icons.visibility,
                    size: 20,
                    color: AppColors.hintTextColor,
                  ),
                )
              : widget.suffixIcon,
          hintStyle: widget.hintStyle ??
              const TextStyle(fontSize: 12, color: AppColors.greyColor),
          labelStyle: widget.labelStyle ??
              const TextStyle(fontSize: 16, color: AppColors.blackColor),
          enabledBorder: OutlineInputBorder(
            borderRadius: BorderRadius.circular(8),
            borderSide:
                BorderSide(width: 1, color: borderColor.withOpacity(0.5)),
          ),
          focusedBorder: OutlineInputBorder(
            borderRadius: BorderRadius.circular(8),
            borderSide:
                BorderSide(width: 1, color: borderColor.withOpacity(0.5)),
          ),
          errorBorder: OutlineInputBorder(
            borderRadius: BorderRadius.circular(8),
            borderSide: BorderSide(width: 2, color: AppColors.redColor),
          ),
          focusedErrorBorder: OutlineInputBorder(
            borderRadius: BorderRadius.circular(8),
            borderSide: BorderSide(width: 2, color: AppColors.redColor),
          ),
        ),
      ),
    );
  }
}
