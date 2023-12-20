import 'package:flutter/material.dart';
import 'package:progressprodis/desing/tokens/_tokens.dart';

class SmallButton extends StatelessWidget {
  const SmallButton({
    super.key,
    required this.title,
    this.color = AppColors.white,
    this.textColor = AppColors.raisenBlak,
    this.fontSize = 15.0,
    this.active = false,
    required this.onTap,
  });

  final String title;
  final double fontSize;
  final Color color;
  final Color textColor;
  final bool active;
  final VoidCallback onTap;

  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: onTap,
      child: Container(
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(8),
          color: active ? AppColors.primaryColor : AppColors.white,
          boxShadow: [
            BoxShadow(
              color: AppColors.quickSilver.withAlpha(30),
              blurRadius: 6.0,
              spreadRadius: 2,
              offset: const Offset(0.0, 5.0),
            )
          ],
        ),
        padding: const EdgeInsets.symmetric(
          horizontal: 10,
          vertical: 6,
        ),
        child: Text(
          title,
          style: TextStyle(
            fontWeight: FontWeight.bold,
            fontSize: fontSize,
            color: active ? AppColors.white : AppColors.raisenBlak,
          ),
        ),
      ),
    );
  }
}
