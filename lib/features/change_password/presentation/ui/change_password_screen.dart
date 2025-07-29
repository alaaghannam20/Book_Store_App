import 'package:bookstore_app/core/app_routes/routes.dart';
import 'package:bookstore_app/core/theme/app_style.dart';
import 'package:bookstore_app/core/theme/colors.dart';
import 'package:bookstore_app/core/widgets/custom_button.dart';
import 'package:flutter/material.dart';

class CheckPasswordScreen extends StatefulWidget {
  const CheckPasswordScreen({super.key});

  @override
  State<CheckPasswordScreen> createState() => _CheckPasswordScreenState();
}

class _CheckPasswordScreenState extends State<CheckPasswordScreen> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColors.screenColor,
      body: Padding(
        padding: const EdgeInsets.only(top: 60, left: 16, right: 16),
        child: SingleChildScrollView(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              GestureDetector(
                onTap: () {
                  Navigator.pop(context);
                },
                child: const Icon(
                  Icons.arrow_back_ios_new,
                  size: 22,
                  color: AppColors.blackColor,
                ),
              ),
              SizedBox(
                height: 122,
              ),
              Center(
                child: Column(
                  children: [
                    Image.asset(
                      'assets/images/check-circle (1) 1 (1).png',
                      width: 103,
                      height: 103,
                    ),
                    SizedBox(height: 24,),
                    Text("Password Changed!",
                    textAlign: TextAlign.center,
                    style: AppStyle.passwordChangedStyle,),
                    SizedBox(
                    height: 8,
                    ),
                    Center(
                      child: Column(
                        children: [
                            Text(
                            'Your password has been',
                            textAlign: TextAlign.center,
                            style: AppStyle.forgetScreenStyle.copyWith(color: AppColors.borderColor.withOpacity(0.5)),
                          ),
                          
                          Text(
                            '  changed successfully',
                            textAlign: TextAlign.center,
                            style: AppStyle.forgetScreenStyle.copyWith(color: AppColors.borderColor.withOpacity(0.5)),
                          ),
                        ],
                      ),
                    ),
                    SizedBox(height: 40,),
                      SizedBox(
                      width: double.infinity,
                      child: CustomButton(
                        text: "Finish!",
                        backgroundColor: AppColors.pinkprimary,
                        textColor: AppColors.whiteColor,
                        onPressed: () {
                          Navigator.pushNamed(
                            context,
                            Routes.homeScreen,
                            arguments: {'withFade': true},
                          );
                        },
                        textStyle: AppStyle.splashStyle
                            .copyWith(color: AppColors.whiteColor),
                      ),
                    ),
                  ],
                ),
              )
            ],
          ),
        ),
      ),
    );
  }
}
