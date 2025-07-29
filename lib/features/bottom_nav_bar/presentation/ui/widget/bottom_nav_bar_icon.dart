import 'package:bookstore_app/core/theme/colors.dart';
import 'package:flutter/material.dart';

class BottomNavBarIcon extends StatelessWidget {
  final bool isActive;
  final Function()? onTap;
  final IconData icon;
  final String labelText;
  const BottomNavBarIcon(
      {super.key,
      this.isActive = false,
      this.onTap,
      required this.icon,
      required this.labelText});

  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: onTap,
      child: Column(children: [
        Icon(
          icon,
          color: isActive ? AppColors.pinkprimary : AppColors.blackColor,
          size: 20,
        ),
        Text(labelText ,
        style: TextStyle(
          color: isActive ? AppColors.pinkprimary : AppColors.blackColor,
          fontSize: 10,
          fontWeight: FontWeight.w400,
        ),)
      ]
      ),
    );
  }
}
