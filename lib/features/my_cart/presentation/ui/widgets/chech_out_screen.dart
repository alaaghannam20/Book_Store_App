import 'package:bookstore_app/core/app_routes/routes.dart';
import 'package:bookstore_app/core/theme/app_style.dart';
import 'package:bookstore_app/core/theme/colors.dart';
import 'package:bookstore_app/core/widgets/custom_button.dart';
import 'package:bookstore_app/core/widgets/custom_textfiled.dart';
import 'package:flutter/material.dart';

class ChechOutScreen extends StatefulWidget {
  const ChechOutScreen({super.key});

  @override
  State<ChechOutScreen> createState() => _ChechOutScreenState();
}

class _ChechOutScreenState extends State<ChechOutScreen> {
  String? _chosenPaymentMethod;
  final TextEditingController _addNoteController = TextEditingController();

  TextStyle _titleStyle() {
    return TextStyle(
      fontFamily: 'OpenSans',
      fontWeight: FontWeight.w400,
      fontSize: 14,
      height: 21.75 / 14,
      letterSpacing: 0.0,
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SingleChildScrollView(
        child: Padding(
          padding: const EdgeInsets.all(16.0),
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
                  Text('Check Out', style: AppStyle.loginStyle),
                ],
              ),
              SizedBox(height: 16),
              Card(
                elevation: 3,
                color: AppColors.whiteColor,
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(12),
                ),
                child: Padding(
                  padding: const EdgeInsets.all(16.0),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        'Payment Method',
                        style: TextStyle(
                          fontFamily: 'OpenSans',
                          fontWeight: FontWeight.w600,
                          fontSize: 14,
                          height: 27.3 / 14,
                          letterSpacing: 0.0,
                        ),
                      ),
                      SizedBox(height: 12),
                      RadioListTile(
                        title: Text(
                          'Online payment',
                          style: _titleStyle().copyWith(
                            color: _chosenPaymentMethod == 'Online'
                                ? Color(0x80D9176C)
                                : Colors.black,
                          ),
                        ),
                        value: 'Online',
                        groupValue: _chosenPaymentMethod,
                        onChanged: (value) => setState(() {
                          _chosenPaymentMethod = value as String?;
                        }),
                        tileColor: Colors.white,
                        selectedTileColor: const Color(0x1AD9176C),
                        activeColor: const Color(0x1AD9176C),
                      ),
                      RadioListTile(
                        title: Text(
                          'Cash on delivery',
                          style: _titleStyle().copyWith(
                            color: _chosenPaymentMethod == 'Cash'
                                ? Color(0x80D9176C)
                                : Colors.black,
                          ),
                        ),
                        value: 'Cash',
                        groupValue: _chosenPaymentMethod,
                        onChanged: (value) => setState(() {
                          _chosenPaymentMethod = value as String?;
                        }),
                        tileColor: Colors.white,
                        selectedTileColor: const Color(0x1AD9176C),
                        activeColor: const Color(0x1AD9176C),
                      ),
                      RadioListTile(
                        title: Text(
                          'POS on delivery',
                          style: _titleStyle().copyWith(
                            color: _chosenPaymentMethod == 'POS'
                                ? Color(0x80D9176C)
                                : Colors.black,
                          ),
                        ),
                        value: 'POS',
                        groupValue: _chosenPaymentMethod,
                        onChanged: (value) => setState(() {
                          _chosenPaymentMethod = value as String?;
                        }),
                        tileColor: Colors.white,
                        selectedTileColor: const Color(0x1AD9176C),
                        activeColor: const Color(0x1AD9176C),
                      ),
                    ],
                  ),
                ),
              ),
              SizedBox(
                height: 12,
              ),
              Card(
                elevation: 3,
                color: AppColors.whiteColor,
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(12),
                ),
                child: Padding(
                  padding: EdgeInsets.all(16.0),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        'Add Note',
                        style: TextStyle(
                          fontFamily: 'OpenSans',
                          fontWeight: FontWeight.w600,
                          fontSize: 14,
                          height: 27.3 / 14,
                          letterSpacing: 0.0,
                        ),
                      ),
                      SizedBox(
                        height: 10,
                      ),
                      SizedBox(
                        width: 311,
                        height: 120,
                        child: CustomTextField(
                          controller: _addNoteController,
                          hintText: "Add note",
                          maxLines: null,
                          prefixIcon: Icon(Icons.note_add),
                          width: 311,
                          height: 120,
                        ),
                      ),
                    ],
                  ),
                ),
              ),
              SizedBox(
                height: 16,
              ),
              SizedBox(
                width: double.infinity,
                child: CustomButton(
                  text: "Confirm order",
                  backgroundColor: AppColors.pinkprimary,
                  textColor: AppColors.whiteColor,
                  onPressed: () {
                    Navigator.pushNamed(
                      context,
                      Routes.confirmOrderScreen,
                      arguments: {'withFade': true},
                    );
                  },
                  textStyle: AppStyle.splashStyle
                      .copyWith(color: AppColors.whiteColor),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
