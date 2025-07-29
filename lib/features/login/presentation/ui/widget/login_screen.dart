import 'package:bookstore_app/core/app_routes/routes.dart';
import 'package:bookstore_app/core/theme/app_style.dart';
import 'package:bookstore_app/core/theme/colors.dart';
import 'package:bookstore_app/core/widgets/custom_button.dart';
import 'package:bookstore_app/core/widgets/custom_social_button.dart';
import 'package:bookstore_app/core/widgets/custom_textfiled.dart';
import 'package:bookstore_app/core/services/local/shared_prefs_helper.dart';
import 'package:bookstore_app/features/login/presentation/maneger/login_auth_cubit.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class LoginScreen extends StatefulWidget {
  const LoginScreen({super.key});

  @override
  State<LoginScreen> createState() => _LoginScreenState();
}

class _LoginScreenState extends State<LoginScreen> {
  final formKey = GlobalKey<FormState>();
  final emailController = TextEditingController();
  final passwordController = TextEditingController();
  bool isChecked = false;

  @override
  void initState() {
    super.initState();
    _loadSavedLoginData();
  }

  Future<void> _loadSavedLoginData() async {
    final savedEmail = SharedPrefsHelper.getData(key: 'saved Email');
    final savedPassword = SharedPrefsHelper.getData(key: 'saved Password');
    final savedRememberMe = SharedPrefsHelper.getData(key: 'remember_me');

    if (savedEmail != null &&
        savedPassword != null &&
        savedRememberMe == true) {
      setState(() {
        emailController.text = savedEmail;
        passwordController.text = savedPassword;
        isChecked = true;
      });
    }
  }

  @override
  void dispose() {
    emailController.dispose();
    passwordController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
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
                    Text('Log in', style: AppStyle.loginStyle),
                  ],
                ),
                const SizedBox(height: 62),
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
                    const SizedBox(height: 16),
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
                    const SizedBox(height: 8),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Row(
                          mainAxisSize: MainAxisSize.min,
                          children: [
                            Transform.scale(
                              scale: 0.8,
                              child: Checkbox(
                                value: isChecked,
                                onChanged: (value) {
                                  setState(() {
                                    isChecked = value!;
                                  });
                                },
                                materialTapTargetSize:
                                    MaterialTapTargetSize.shrinkWrap,
                                side: const BorderSide(
                                  width: 1,
                                  color: AppColors.borderColor,
                                ),
                                activeColor: AppColors.pinkprimary,
                              ),
                            ),
                            Text("Remember me",
                                style: AppStyle.rememberMeStyle),
                          ],
                        ),
                        GestureDetector(
                          onTap: () {
                            Navigator.pushNamed(
                              context,
                              Routes.forgetpasswordScreen,
                              arguments: {'withFade': true},
                            );
                          },
                          child: Text(
                            "Forget your password?",
                            style: AppStyle.forgetPasswordStyle,
                          ),
                        ),
                      ],
                    ),
                    SizedBox(height: 32),
                    BlocConsumer<LoginCubit, LoginAuthState>(
                      listener: (context, state) async {
                        if (state is LoginLoading) {
                          showDialog(
                            context: context,
                            barrierDismissible: false,
                            builder: (context) => const Center(
                              child: CircularProgressIndicator(),
                            ),
                          );
                        } else if (state is LoginSuccess) {
                          Navigator.pop(context); // Close dialog
                          if (isChecked) {
                            await SharedPrefsHelper.saveData(
                                key: 'saved Email',
                                value: emailController.text);
                            await SharedPrefsHelper.saveData(
                                key: 'saved Password',
                                value: passwordController.text);
                            await SharedPrefsHelper.saveData(
                                key: 'remember_me', value: true);
                          } else {
                            await SharedPrefsHelper.deleteData(
                                key: 'saved email');
                            await SharedPrefsHelper.deleteData(
                                key: 'saved password');
                            await SharedPrefsHelper.saveData(
                                key: 'remember_me', value: false);
                          }
                          Navigator.pushReplacementNamed(
                              context, Routes.homeScreen);
                        } else if (state is LoginError) {
                          Navigator.pop(context); // Close dialog
                          ScaffoldMessenger.of(context).showSnackBar(
                            SnackBar(content: Text(state.errorMessage)),
                          );
                        }
                      },
                      builder: (context, state) {
                        return SizedBox(
                          width: double.infinity,
                          child: CustomButton(
                            text: "Log in",
                            backgroundColor: AppColors.pinkprimary,
                            textColor: AppColors.whiteColor,
                            onPressed: () {
                              if (formKey.currentState!.validate()) {
                                context.read<LoginCubit>().login(
                                      email: emailController.text,
                                      password: passwordController.text,
                                    );
                              }
                            },
                            textStyle: AppStyle.splashStyle
                                .copyWith(color: AppColors.whiteColor),
                          ),
                        );
                      },
                    ),
                  ],
                ),
                SizedBox(height: 40),
                Column(
                  children: [
                    Row(
                      children: [
                        Expanded(child: Divider(color: AppColors.blackColor)),
                        SizedBox(width: 4),
                        Text(
                          "Or login with",
                          style: AppStyle.emailStyle.copyWith(
                              fontFamily: 'Open Sans',
                              color: AppColors.blackColor),
                        ),
                        SizedBox(width: 4),
                        Expanded(child: Divider(color: AppColors.blackColor)),
                      ],
                    ),
                    SizedBox(height: 20),
                    Row(
                      children: [
                        Expanded(
                          child: CustomSocialButton(
                            text: "Facebook",
                            iconPath: "assets/images/facebook.png",
                            onPressed: () {
                              context.read<LoginCubit>().signInWithFacebook();
                            },
                          ),
                        ),
                        const SizedBox(width: 16),
                        Expanded(
                          child: CustomSocialButton(
                            text: "Google",
                            iconPath: "assets/images/google.png",
                            onPressed: () {
                              context.read<LoginCubit>().signInWithGoogle();
                            },
                          ),
                        ),
                      ],
                    ),
                  ],
                ),
                SizedBox(height: 24),
                Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Text(
                      "Don’t have an account?",
                      style: AppStyle.splashStyle
                          .copyWith(fontSize: 14, color: AppColors.borderColor),
                    ),
                    SizedBox(width: 4),
                    GestureDetector(
                      onTap: () {
                        Navigator.pushNamed(
                          context,
                          Routes.createAccountScreen,
                          arguments: {'withFade': true},
                        );
                      },
                      child: Text(
                        "Sign up",
                        style: AppStyle.loginStyle.copyWith(
                          fontSize: 14,
                          color: AppColors.pinkprimary,
                          fontWeight: FontWeight.w600,
                        ),
                      ),
                    ),
                  ],
                )
              ],
            ),
          ),
        ),
      ),
    );
  }
}
