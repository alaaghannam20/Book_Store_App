import 'package:bookstore_app/core/app_routes/routes.dart';
import 'package:bookstore_app/core/theme/app_style.dart';
import 'package:bookstore_app/core/theme/colors.dart';
import 'package:bookstore_app/core/widgets/custom_button.dart';
import 'package:bookstore_app/core/widgets/custom_textfiled.dart';
import 'package:bookstore_app/features/forget_password/presentation/manager/forget_password_cubit.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class ForgetPasswordScreen extends StatefulWidget {
  const ForgetPasswordScreen({super.key});

  @override
  State<ForgetPasswordScreen> createState() => _ForgetPasswordScreenState();
}

class _ForgetPasswordScreenState extends State<ForgetPasswordScreen> {
  final formKey = GlobalKey<FormState>();
  final emailController = TextEditingController();

  @override
  void dispose() {
    emailController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        backgroundColor: AppColors.screenColor,
        body: Padding(
          padding: const EdgeInsets.only(top: 60, left: 16, right: 16),
          child: BlocListener<ForgetPasswordCubit, ForgetPasswordState>(
            listener: (context, state) {
              if (state is ForgetPasswordLoading) {
                showDialog(
                  context: context,
                  barrierDismissible: false,
                  builder: (context) => AlertDialog(
                    backgroundColor: AppColors.transparenteColor,
                    content: const Center(
                      child: CircularProgressIndicator(),
                    ),
                  ),
                );
              } else if (state is ForgetPasswordError) {
                Navigator.pop(context);
                showDialog(
                  context: context,
                  builder: (context) => AlertDialog(
                    content: Text(state.errorMessage),
                  ),
                );
              } else if (state is ForgetPasswordSuccess) {
                Navigator.pop(context);
                Navigator.pushNamed(
                  context,
                  Routes.verifyCodeScreen,
                  arguments: {'email': emailController.text},
                );
              }
            },
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
                        Text('Forget Password', style: AppStyle.loginStyle),
                      ],
                    ),
                    SizedBox(
                      height: 94,
                    ),
                    Center(
                      child: Column(
                        children: [
                          Text(
                            'Enter your email',
                            textAlign: TextAlign.center,
                            style: AppStyle.forgetScreenStyle,
                          ),
                          SizedBox(height: 4),
                          Text(
                            'to reset your password',
                            textAlign: TextAlign.center,
                            style: AppStyle.forgetScreenStyle,
                          ),
                        ],
                      ),
                    ),
                    SizedBox(
                      height: 32,
                    ),
                    Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text("Email", style: AppStyle.loginStyle),
                          const SizedBox(height: 8),
                          SizedBox(
                            width: double.infinity,
                            child: CustomTextField(
                              controller: emailController,
                              hintText: "Example@gmail.com",
                              hintStyle: AppStyle.emailStyle,
                              validator: (email) {
                                if (email == null || email.isEmpty) {
                                  return "Please enter your Email";
                                }
                                return null;
                              },
                              maxLines: 1,
                              keyboardType: TextInputType.emailAddress,
                            ),
                          ),
                        ]),
                    SizedBox(
                      height: 32,
                    ),
                    SizedBox(
                      width: double.infinity,
                      child: CustomButton(
                        text: "Send Code",
                        backgroundColor: AppColors.pinkprimary,
                        textColor: AppColors.whiteColor,
                        onPressed: () {
                          if (formKey.currentState!.validate()) {
                            context.read<ForgetPasswordCubit>().forgetPassword(
                                  email: emailController.text,
                                );
                          }
                        },
                        textStyle: AppStyle.splashStyle
                            .copyWith(color: AppColors.whiteColor),
                      ),
                    ),
                  ],
                ),
              ),
            ),
          ),
        ));
  }
}
