import 'package:flutter/material.dart';
import 'package:progressprodis/desing/tokens/_tokens.dart';

class GenericButton extends StatelessWidget {
  const GenericButton({
    Key? key,
    required this.label,
    required this.onTap,
    this.width,
    this.btnColor,
    this.labelColor = AppColors.white,
    this.labelFontWeight,
    this.showShadow = false,
    this.isLoading = false,
    this.borderRadius,
  }) : super(key: key);

  final double? width;
  final String label;
  final VoidCallback? onTap;
  final Color? labelColor;
  final Color? btnColor;
  final FontWeight? labelFontWeight;
  final bool showShadow;
  final bool isLoading;
  final BorderRadiusGeometry? borderRadius;

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      width: width,
      child: ElevatedButton(
        style: ButtonStyle(
          backgroundColor: MaterialStateProperty.resolveWith<Color?>(
              (Set<MaterialState> states) {
            if (states.contains(MaterialState.disabled)) {
              return AppColors.disabeleColor;
            }
            return btnColor ?? AppColors.primaryColor;
          }),
          shape: MaterialStateProperty.all<RoundedRectangleBorder>(
            RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(12),
              side: BorderSide.none,
            ),
          ),
          elevation: MaterialStateProperty.all(0),
          padding: MaterialStateProperty.all(
            const EdgeInsets.symmetric(
              vertical: 20,
              horizontal: 35,
            ),
          ),
        ),
        onPressed: onTap,
        child: isLoading
            ? const SizedBox(
                width: 18,
                height: 18,
                child: CircularProgressIndicator(
                  color: AppColors.white,
                  strokeWidth: 1.9,
                ),
              )
            : Text(
                label,
                textAlign: TextAlign.center,
                style: TextStyle(
                  color: labelColor,
                  fontWeight: FontWeight.bold,
                ),
              ),
      ),
    );
  }
}
