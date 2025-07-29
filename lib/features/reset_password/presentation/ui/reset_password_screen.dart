import 'package:bookstore_app/core/app_routes/routes.dart';
import 'package:bookstore_app/core/theme/app_style.dart';
import 'package:bookstore_app/core/theme/colors.dart';
import 'package:bookstore_app/core/widgets/custom_button.dart';
import 'package:bookstore_app/core/widgets/custom_textfiled.dart';
import 'package:bookstore_app/features/reset_password/presentation/manager/reset_password_cubit.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class ResetPasswordScreen extends StatefulWidget {
  final String code;
  const ResetPasswordScreen({super.key , required this.code});

  @override
  State<ResetPasswordScreen> createState() => _ResetPasswordScreenState();
}

class _ResetPasswordScreenState extends State<ResetPasswordScreen> {
  final formKey = GlobalKey<FormState>();
  final passwordController = TextEditingController();
  final confirmpasswordController = TextEditingController();


  @override
  void dispose() {
    passwordController.dispose();
    confirmpasswordController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return BlocListener<ResetPasswordCubit, ResetPasswordState>(
      listener: (context, state) {
       if (state is ResetPasswordLoading) {
          showDialog(
            context: context,
            barrierDismissible: false,
            builder: (_) => const AlertDialog(
              backgroundColor: Colors.transparent,
              content: Center(child: CircularProgressIndicator()),
            ),
          );
        } else if (state is ResetPasswordError) {
          Navigator.of(context).pop(); 
          showDialog(
            context: context,
            builder: (_) => AlertDialog(
              content: Text(state.errorMessage),
            ),
          );
        } else if (state is ResetPasswordSuccess) {
          Navigator.of(context).pop(); 
          Navigator.pushNamed(
            context,
            Routes.splashScreen,
          );
        }
      },
      
      child: Scaffold(
          backgroundColor: AppColors.screenColor,
          body: Padding(
            padding: const EdgeInsets.only(top: 60, left: 16, right: 16),
            child: Form(
              key: formKey,
              child: SingleChildScrollView(
                child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Row(
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
                          const SizedBox(width: 8),
                          Text('Reset Password', style: AppStyle.loginStyle),
                        ],
                      ),
                      SizedBox(
                        height: 94,
                      ),
                      Center(
                        child: Column(
                          children: [
                            Text(
                              'Your new password must be',
                              textAlign: TextAlign.center,
                              style: AppStyle.forgetScreenStyle,
                            ),
                            SizedBox(height: 4),
                            Text(
                              ' different from previous one',
                              textAlign: TextAlign.center,
                              style: AppStyle.forgetScreenStyle,
                            ),
                          ],
                        ),
                      ),
                      SizedBox(
                        height: 40,
                      ),
                      Text("Password", style: AppStyle.loginStyle),
                      const SizedBox(height: 8),
                      SizedBox(
                        width: double.infinity,
                        child: CustomTextField(
                          controller: passwordController,
                          isPassword: true,
                          hintText: "************",
                          hintStyle: AppStyle.emailStyle,
                          validator: (password) {
                            if (password == null || password.isEmpty) {
                              return "Please enter your Password";
                            }
                            return null;
                          },
                          maxLines: 1,
                          keyboardType: TextInputType.text,
                        ),
                      ),
                      SizedBox(
                        height: 32,
                      ),
                      Text("Confirm Password", style: AppStyle.loginStyle),
                      const SizedBox(height: 8),
                      SizedBox(
                        width: double.infinity,
                        child: CustomTextField(
                          controller: confirmpasswordController,
                          isPassword: true,
                          hintText: "************",
                          hintStyle: AppStyle.emailStyle,
                          validator: (confirmpassword) {
                            if (confirmpassword == null ||
                                confirmpassword.isEmpty) {
                              return "Please enter your Password";
                            }
                            return null;
                          },
                          maxLines: 1,
                          keyboardType: TextInputType.text,
                        ),
                      ),
                      const SizedBox(height: 32),
                      SizedBox(
                        width: double.infinity,
                        child: CustomButton(
                          text: "Reset Password",
                          backgroundColor: AppColors.pinkprimary,
                          textColor: AppColors.whiteColor,
                            onPressed: () {
                        if (formKey.currentState!.validate()) {
                          if (passwordController.text !=
                              confirmpasswordController.text) {
                            showDialog(
                              context: context,
                              builder: (_) => const AlertDialog(
                                content: Text("Passwords do not match"),
                              ),
                            );
                          } else {
                            context
                                .read<ResetPasswordCubit>()
                                .resetPassword(
                                  code: widget.code,
                                  password: passwordController.text,
                                 confPassword: confirmpasswordController.text,
                                );
                          }
                        }
                      },
                          textStyle: AppStyle.splashStyle
                              .copyWith(color: AppColors.whiteColor),
                        ),
                      ),
                    ]),
              ),
            ),
          )),
    );
  }
}
