import 'package:bookstore_app/core/app_routes/routes.dart';
import 'package:bookstore_app/core/theme/app_style.dart';
import 'package:bookstore_app/core/theme/colors.dart';
import 'package:bookstore_app/core/widgets/custom_button.dart';
import 'package:flutter/material.dart';

class ConfirmOrder extends StatefulWidget {
  const ConfirmOrder({super.key});

  @override
  State<ConfirmOrder> createState() => _ConfirmOrderState();
}

class _ConfirmOrderState extends State<ConfirmOrder> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        leading: Padding(
          padding: const EdgeInsets.only(left: 16),
          child: SizedBox(
            height: 22,
            width: 22,
            child: IconButton(
              icon: const Icon(Icons.arrow_back_ios_new_rounded, size: 16),
              onPressed: () {
                Navigator.pop(context);
              },
            ),
          ),
        ),
        leadingWidth: 30,
        title: Text(" "),
      ),

      body: Padding(padding: EdgeInsets.fromLTRB(16, 24, 16, 24),
      child: SingleChildScrollView(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.start,
          children: [
            Center(
              child: Column(
                children: [
                  SizedBox(height: 24),
                   Image.asset(
                      'assets/images/check-circle (1) 1 (1).png',
                      width: 80,
                      height: 80,
                    ),
                    SizedBox(height: 24,),
                    Text("Successful!",
                    textAlign: TextAlign.center,
                    style: AppStyle.passwordChangedStyle,),
                    SizedBox(
                    height: 8,
                    ),
                    Center(
                      child: Column(
                        children: [
                            Text(
                            'Your order has been',
                            textAlign: TextAlign.center,
                            style: AppStyle.forgetScreenStyle.copyWith(color: AppColors.borderColor.withOpacity(0.5)),
                          ),
                          
                          Text(
                            'confirmed successfully!',
                            textAlign: TextAlign.center,
                            style: AppStyle.forgetScreenStyle.copyWith(color: AppColors.borderColor.withOpacity(0.5)),
                          ),
                        ],
                      ),
                    ),

                    SizedBox(height: 24,),
                      SizedBox(
                      width: double.infinity,
                      child: CustomButton(
                        text: "keep shopping",
                        backgroundColor: AppColors.pinkprimary,
                        textColor: AppColors.whiteColor,
                        onPressed: () {
                          Navigator.pushNamed(
                            context,
                            Routes.bookScreen,
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
