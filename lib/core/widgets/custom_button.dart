import 'package:bookstore_app/core/theme/colors.dart';
import 'package:flutter/material.dart';

class CustomButton extends StatelessWidget {
  final String text;
  final Color backgroundColor;
  final VoidCallback onPressed;
  final Color textColor;
  final Color? borderColor;
    final double? width;
  final double? height;
  final EdgeInsetsGeometry? padding;
  final TextStyle ? textStyle;

  const CustomButton({
    super.key,
    required this.text,
    required this.backgroundColor,
    required this.onPressed,
    required this.textColor,
    this.borderColor,
    this.width,
    this.height,
    this.padding,
    this.textStyle
  });

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      width: width?? 343,
      height: height?? 48,
      child: ElevatedButton(
          onPressed: onPressed,
          style: ElevatedButton.styleFrom(
              backgroundColor: backgroundColor,
              foregroundColor: textColor,
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(8),
                side: borderColor != null
                    ? BorderSide(color:borderColor ?? AppColors.borderColor.withOpacity(0.5))
                    : BorderSide.none,
              ),
              padding: EdgeInsets.fromLTRB(16, 13, 16, 13)),
          child: Text(
            text,
             style: textStyle ?? TextStyle (color: textColor)
            
          )),
    );
  }
}
