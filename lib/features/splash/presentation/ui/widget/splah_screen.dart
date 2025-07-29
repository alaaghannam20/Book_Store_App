import 'package:bookstore_app/core/app_routes/routes.dart';
import 'package:bookstore_app/core/theme/app_style.dart';
import 'package:bookstore_app/core/theme/colors.dart';
import 'package:bookstore_app/core/widgets/custom_button.dart';
import 'package:flutter/material.dart';
import 'dart:async';

class SplashScreen extends StatefulWidget {
  const SplashScreen({super.key});

  @override
  State<SplashScreen> createState() => _SplashScreenState();
}

class _SplashScreenState extends State<SplashScreen> {
  bool showScreen = false;

  @override
  void initState() {
    super.initState();

    Timer(const Duration(seconds: 2), () {
      setState(() {
        showScreen = true;
      });
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Stack(
        children: [
          Positioned.fill(
            child: Image.asset(
              showScreen
                  ? 'assets/images/Splash 0.png'
                  : 'assets/images/Splash 1.png',
              fit: BoxFit.cover,
            ),
          ),
          SafeArea(
            child: Column(
              children: [
                SizedBox(height: 195),
                Center(
                  child: Container(
                    width: 343,
                    height: 252,
                    padding: const EdgeInsets.all(0),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.center,
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        Row(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: [
                            Image.asset(
                              'assets/images/book-bookmark 1.png',
                              height: 60,
                              width: 60,
                            ),
                            const SizedBox(
                              width: 8,
                            ),
                            Text(
                              "Bookshop",
                              style: TextStyle(
                                fontFamily: "Open Sans",
                                fontWeight: FontWeight.w400,
                                fontSize: 30,
                                color: AppColors.whiteColor,
                              ),
                            )
                          ],
                        ),
                        const SizedBox(height: 80),
                        CustomButton(
                          text: 'Log in',
                          backgroundColor: AppColors.pinkprimary,
                          textColor: AppColors.whiteColor,
                          textStyle: AppStyle.splashStyle,
                          onPressed: () {
                            Navigator.pushNamed(context, Routes.loginScreen);
                          },
                        ),
                        const SizedBox(height: 16),
                        CustomButton(
                          text: 'Create account',
                          backgroundColor: AppColors.pinkprimary,
                          textColor: AppColors.whiteColor,
                          borderColor: AppColors.pinkprimary,
                          textStyle: AppStyle.splashStyle,
                          onPressed: () {
                            Navigator.pushNamed(
                                context, Routes.createAccountScreen);
                          },
                        ),
                      ],
                    ),
                  ),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}
