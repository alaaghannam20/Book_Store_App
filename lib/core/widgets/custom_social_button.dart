import 'package:bookstore_app/core/theme/app_style.dart';
import 'package:bookstore_app/core/theme/colors.dart';
import 'package:flutter/material.dart';

class CustomSocialButton extends StatelessWidget {
  final String text;
  final String iconPath;
  final VoidCallback? onPressed;

  const CustomSocialButton({
    super.key,
    required this.text,
    required this.iconPath,
    this.onPressed,
  });

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      height: 54,
      child: ElevatedButton(
        onPressed: onPressed ?? () {},
        style: ElevatedButton.styleFrom(
          backgroundColor: Colors.transparent,
          elevation: 0,
          padding: const EdgeInsets.symmetric(horizontal: 16),
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(8),
            side: BorderSide(
              color: AppColors.borderColor.withOpacity(0.5),
              width: 1,
            ),
          ),
        ),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Image.asset(
              iconPath,
              width: 22,
              height: 22,
            ),
            const SizedBox(width: 8),
            Text(text,
                style: AppStyle.splashStyle.copyWith(
                    fontWeight: FontWeight.w400, color: AppColors.borderColor)),
          ],
        ),
      ),
    );
  }
}
