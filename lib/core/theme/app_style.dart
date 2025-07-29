import 'package:bookstore_app/core/theme/colors.dart';
import 'package:flutter/material.dart';

class AppStyle {
  static TextStyle splashStyle = TextStyle(
    fontFamily: 'OpenSans',
    fontWeight: FontWeight.w600,
    fontSize: 16,
    height: 1.0,
    letterSpacing: 0.0,
    color: AppColors.whiteColor,
  );

  static TextStyle loginStyle = TextStyle(
    fontFamily: 'Open Sans',
    fontWeight: FontWeight.w400,
    fontSize: 16,
    height: 21 / 16,
    letterSpacing: 0,
    color: AppColors.blackColor,
  );

  static TextStyle emailStyle = TextStyle(
    fontWeight: FontWeight.w400,
    fontSize: 12,
    height: 1.0,
    letterSpacing: 0,
    color: AppColors.hintTextColor,
  );

  static TextStyle rememberMeStyle = TextStyle(
    fontFamily: 'Open Sans',
    fontSize: 12,
    fontWeight: FontWeight.w400,
    height: 21 / 12,
    letterSpacing: -0.32,
    color: AppColors.borderColor,
  );

  static TextStyle forgetPasswordStyle = TextStyle(
    fontSize: 14,
    fontWeight: FontWeight.w400,
    height: 21 / 14,
    letterSpacing: 0,
    color: AppColors.pinkprimary,
  );

  static TextStyle forgetScreenStyle = TextStyle(
    fontFamily: 'Open Sans',
    fontSize: 14,
    fontWeight: FontWeight.w400,
    height: 1.55,
    letterSpacing: 0,
    color: AppColors.borderColor,
  );

  static TextStyle passwordChangedStyle = TextStyle(
    fontFamily: 'OpenSans',
    fontSize: 22,
    fontWeight: FontWeight.w600,
    height: 1.0,
    letterSpacing: 0,
    color: AppColors.borderColor,
  );
}
