import 'package:bookstore_app/core/app_routes/routes.dart';
import 'package:bookstore_app/core/theme/app_style.dart';
import 'package:bookstore_app/core/theme/colors.dart';
import 'package:bookstore_app/core/widgets/custom_button.dart';
import 'package:bookstore_app/features/validate_code/presentation/manager/validate_code_cubit.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class VerifyCodeScreen extends StatefulWidget {
  final String email;
  const VerifyCodeScreen({super.key, required this.email});

  @override
  State<VerifyCodeScreen> createState() => _EnterCodeScreenState();
}

class _EnterCodeScreenState extends State<VerifyCodeScreen> {
  final List<TextEditingController> controllers = List.generate(
    4,
    (index) => TextEditingController(),
  );

  @override
  void dispose() {
    for (var controller in controllers) {
      controller.dispose();
    }
    super.dispose();
  }

  String getVerifyCode() {
    return controllers.map((e) => e.text).join();
  }

  @override
  Widget build(BuildContext context) {
    return BlocListener<VerifyCodeCubit, VerifyCodeState>(
      listener: (context, state) {
        if (state is VerifyCodeLoading) {
          showDialog(
            context: context,
            barrierDismissible: false,
            builder: (context) => AlertDialog(
              backgroundColor: AppColors.transparenteColor,
              content: Center(
                child: CircularProgressIndicator(),
              ),
            ),
          );
        } else if (state is VerifyCodeError) {
          Navigator.pop(context);
          showDialog(
            context: context,
            builder: (context) => AlertDialog(
              content: Text(state.errorMessage),
            ),
          );
        } else if (state is VerifyCodeSuccess) {
          Navigator.pop(context);
          Navigator.pushNamed(
            context,
            Routes.resetpasswordScreen,
            arguments: getVerifyCode(),
          );
        }
      },
      child: Scaffold(
        backgroundColor: AppColors.screenColor,
        body: Padding(
          padding: const EdgeInsets.only(top: 60, left: 16, right: 16),
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
                  Text('Enter Code', style: AppStyle.loginStyle),
                ],
              ),
              SizedBox(
                height: 94,
              ),
              Center(
                child: Column(
                  children: [
                    Text(
                      'Enter the 4 dights code that',
                      textAlign: TextAlign.center,
                      style: AppStyle.forgetScreenStyle,
                    ),
                    SizedBox(height: 4),
                    Text(
                      'you received on your email',
                      textAlign: TextAlign.center,
                      style: AppStyle.forgetScreenStyle,
                    ),
                  ],
                ),
              ),
              SizedBox(
                height: 32,
              ),
              Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: List.generate(
                  4,
                  (index) => Padding(
                    padding: const EdgeInsets.symmetric(horizontal: 12.0),
                    child: SizedBox(
                      width: 48,
                      height: 48,
                      child: TextFormField(
                        controller: controllers[index],
                        keyboardType: TextInputType.number,
                        textAlign: TextAlign.center,
                        maxLength: 1,
                        decoration: InputDecoration(
                          counterText: "",
                          border: OutlineInputBorder(
                            borderRadius: BorderRadius.circular(8),
                            borderSide: BorderSide(
                              color: AppColors.borderColor.withOpacity(0.3),
                              width: 1,
                            ),
                          ),
                        ),
                        style: const TextStyle(
                          fontSize: 22,
                          fontWeight: FontWeight.w600,
                        ),
                        onChanged: (value) {
                          if (value.length == 1 && index < 3) {
                            FocusScope.of(context).nextFocus();
                          } else if (value.isEmpty && index > 0) {
                            FocusScope.of(context).previousFocus();
                          }
                        },
                      ),
                    ),
                  ),
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
                    final code = getVerifyCode();
                    if (code.length < 4 || code.contains('')) {
                      ScaffoldMessenger.of(context).showSnackBar(
                        SnackBar(
                            content: Text('Please enter the 4-digit code')),
                      );
                      return;
                    }
                    context.read<VerifyCodeCubit>().verifyCode(
                          email: widget.email,
                          code: code,
                        );
                  },
                  textStyle: AppStyle.splashStyle
                      .copyWith(color: AppColors.whiteColor),
                ),
              ),
              SizedBox(
                height: 80,
              ),
              Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Text(
                    "Didn’t receive a code?",
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
                      "Send again",
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
          )),
        ),
      ),
    );
  }
}
