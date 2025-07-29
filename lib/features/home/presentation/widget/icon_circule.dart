import 'package:flutter/material.dart';

class IconCircle extends StatelessWidget {
  final IconData icon;
  final VoidCallback? onTap;
  final Color? backgroundColor;
  final Color? iconColor;
  final Color? borderColor;

  const IconCircle({
    super.key, 
    required this.icon , 
    required this.onTap,
    this.backgroundColor, 
    this.iconColor,   
    this.borderColor,
    } );

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: onTap,
      child: Container(
        width: 40,
        height: 40,
        padding: const EdgeInsets.all(12),
        decoration: BoxDecoration(
          shape: BoxShape.circle,
          color: backgroundColor,
          border: borderColor != null
              ? Border.all(color: borderColor!)
              : null,
        ),
        child: Icon(
          icon,
          size: 16,
          color: iconColor,
        ),
      ),
    );

    
  }
}