import 'package:bookstore_app/core/app_routes/routes.dart';
import 'package:bookstore_app/core/theme/app_style.dart';
import 'package:bookstore_app/core/theme/colors.dart';
import 'package:bookstore_app/core/widgets/custom_button.dart';
import 'package:bookstore_app/core/widgets/custom_social_button.dart';
import 'package:bookstore_app/core/widgets/custom_textfiled.dart';
import 'package:bookstore_app/features/createaccount/presentation/maneger/create_account_cubit.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';


class CreateAccountScreen extends StatefulWidget {
  const CreateAccountScreen({super.key});

  @override
  State<CreateAccountScreen> createState() => _CreateAccountScreenState();
}

class _CreateAccountScreenState extends State<CreateAccountScreen> {
  final formKey = GlobalKey<FormState>();
  final nameController = TextEditingController();
  final emailController = TextEditingController();
  final passwordController = TextEditingController();
  final confirmpasswordController = TextEditingController();
  bool isCheckedAgree = false;

  @override
  void dispose() {
    nameController.dispose();
    emailController.dispose();
    passwordController.dispose();
    confirmpasswordController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return BlocListener<CreateAccountCubit, CreateAccountState>(
      listener: (context, state) {
        if (state is CreateAccountLoading) {
          showDialog(
            context: context,
            barrierDismissible: false,
            builder: (context) => const Center(
              child: CircularProgressIndicator(),
            ),
          );
        } else if (state is CreateAccountError) {
          Navigator.pop(context); 
          showDialog(
            context: context,
            builder: (context) => AlertDialog(
              content: Text(state.errorMessage),
            ),
          );
        } else if (state is CreateAccountSuccess) {
          Navigator.pop(context); 
          Navigator.pushReplacementNamed(context, Routes.homeScreen);
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
                      Text('Create Account', style: AppStyle.loginStyle),
                    ],
                  ),
                  const SizedBox(height: 62),
                  Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text("Name", style: AppStyle.loginStyle),
                      const SizedBox(height: 8),
                      SizedBox(
                        width: double.infinity,
                        child: CustomTextField(
                          controller: nameController,
                          hintText: "Your name",
                          hintStyle: AppStyle.emailStyle,
                          validator: (name) {
                            if (name == null || name.isEmpty) {
                              return "Please enter your Name";
                            }
                            return null;
                          },
                          maxLines: 1,
                          keyboardType: TextInputType.name,
                        ),
                      ),
                      const SizedBox(height: 16),
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
                      const SizedBox(height: 16),
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
                              return "Please confirm your Password";
                            }
                            if (confirmpassword != passwordController.text) {
                              return "Passwords do not match";
                            }
                            return null;
                          },
                          maxLines: 1,
                          keyboardType: TextInputType.text,
                        ),
                      ),
                      const SizedBox(height: 16),
                      Row(
                        children: [
                          Transform.scale(
                            scale: 0.8,
                            child: Checkbox(
                              value: isCheckedAgree,
                              onChanged: (value) {
                                setState(() {
                                  isCheckedAgree = value!;
                                });
                              },
                              materialTapTargetSize:
                                  MaterialTapTargetSize.shrinkWrap,
                              side: const BorderSide(
                                width: 1,
                                color: AppColors.borderColor,
                              ),
                              activeColor: AppColors.greenColor,
                            ),
                          ),
                          Text("Agree with",
                              style: AppStyle.rememberMeStyle),
                          const SizedBox(width: 1),
                          Text(
                            "Terms & Conditions",
                            style: AppStyle.rememberMeStyle.copyWith(
                                color: AppColors.pinkprimary),
                          ),
                        ],
                      ),
                      const SizedBox(height: 32),
                      SizedBox(
                        width: double.infinity,
                        child: CustomButton(
                          text: "Create Account",
                          backgroundColor: AppColors.pinkprimary,
                          textColor: AppColors.whiteColor,
                          textStyle: AppStyle.splashStyle.copyWith(
                            color: AppColors.whiteColor,
                          ),
                          onPressed: () {
                            if (formKey.currentState!.validate()) {
                              if (!isCheckedAgree) {
                                ScaffoldMessenger.of(context).showSnackBar(
                                  const SnackBar(
                                      content: Text(
                                          "You must agree to Terms & Conditions")),
                                );
                                return;
                              }
                              context
                                  .read<CreateAccountCubit>()
                                  .createAccount(
                                    name: nameController.text,
                                    email: emailController.text,
                                    password: passwordController.text,
                                    passwordConfirmation:
                                        confirmpasswordController.text,
                                  );
                            }
                          },
                        ),
                      ),
                      const SizedBox(height: 40),
                      Column(
                        children: [
                          Row(
                            children: [
                              const Expanded(
                                child:
                                    Divider(color: AppColors.blackColor),
                              ),
                              const SizedBox(width: 4),
                              Text(
                                "Or Sign in with",
                                style: AppStyle.emailStyle.copyWith(
                                  fontFamily: 'Open Sans',
                                  color: AppColors.blackColor,
                                ),
                              ),
                              const SizedBox(width: 4),
                              const Expanded(
                                child:
                                    Divider(color: AppColors.blackColor),
                              ),
                            ],
                          ),
                          const SizedBox(height: 20),
                          BlocConsumer<CreateAccountCubit,
                              CreateAccountState>(
                            listener: (context, state) {
                              if (state is CreateAccountSuccess) {
                                Navigator.pushReplacementNamed(
                                    context, Routes.homeScreen);
                              } else if (state is CreateAccountError) {
                                ScaffoldMessenger.of(context).showSnackBar(
                                  SnackBar(
                                      content:
                                          Text(state.errorMessage)),
                                );
                              }
                            },
                            builder: (context, state) {
                              if (state is CreateAccountLoading) {
                                return const Center(
                                    child: CircularProgressIndicator());
                              }

                              return Row(
                                children: [
                                  Expanded(
                                    child: CustomSocialButton(
                                      text: "Facebook",
                                      iconPath:
                                          "assets/images/facebook.png",
                                      onPressed: () {
                                        context
                                            .read<CreateAccountCubit>()
                                            .signInWithFacebook();
                                      },
                                    ),
                                  ),
                                  const SizedBox(width: 16),
                                  Expanded(
                                    child: CustomSocialButton(
                                      text: "Google",
                                      iconPath:
                                          "assets/images/google.png",
                                      onPressed: () {
                                        context
                                            .read<CreateAccountCubit>()
                                            .signInWithGoogle();
                                      },
                                    ),
                                  ),
                                ],
                              );
                            },
                          ),
                        ],
                      ),
                    ],
                  ),
                  const SizedBox(height: 24),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Text(
                        "Already have an account?",
                        style: AppStyle.splashStyle.copyWith(
                          fontSize: 14,
                          color: AppColors.borderColor,
                        ),
                      ),
                      const SizedBox(width: 4),
                      GestureDetector(
                        onTap: () {
                          Navigator.pushNamed(
                            context,
                            Routes.loginScreen,
                            arguments: {'withFade': true},
                          );
                        },
                        child: Text(
                          "Login",
                          style: AppStyle.loginStyle.copyWith(
                            fontSize: 14,
                            color: AppColors.pinkprimary,
                            fontWeight: FontWeight.w600,
                          ),
                        ),
                      ),
                    ],
                  ),
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }

  
}
