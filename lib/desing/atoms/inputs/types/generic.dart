import 'package:flutter/material.dart';
import 'package:progressprodis/desing/tokens/_tokens.dart';

class GenericInput extends StatelessWidget {
  GenericInput({
    Key? key,
    required this.controller,
    required this.width,
    this.label = "",
    this.labelStyle,
    this.keyboardType,
    this.showError = false,
    this.onChange,
    this.validator = "Error",
  }) : super(key: key);

  final TextEditingController controller;
  final double width;
  final String label;
  final TextStyle? labelStyle;
  final TextInputType? keyboardType;
  final bool showError;
  final Function(String)? onChange;
  final String? validator;

  final _emailRegex = RegExp(r'^[\w-\.]+@([\w-]+\.)+[\w-]{2,4}$');

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        label.isNotEmpty
            ? Container(
                margin: const EdgeInsets.only(bottom: 10),
                width: width,
                child: Text(
                  label,
                  style: labelStyle,
                ),
              )
            : const SizedBox.shrink(),
        Container(
          width: width,
          margin: const EdgeInsets.only(bottom: 8),
          decoration: BoxDecoration(
            boxShadow: [
              BoxShadow(
                color: showError
                    ? AppColors.error.withAlpha(40)
                    : AppColors.quickSilver.withAlpha(30),
                blurRadius: 6.0, // has the effect of softening the shadow
                spreadRadius: 2, // has the effect of extending the shadow
                offset: const Offset(
                  0.0,
                  5.0,
                ),
              )
            ],
          ),
          child: TextFormField(
            keyboardType: keyboardType,
            controller: controller,
            onChanged: onChange!,
            style: const TextStyle(fontSize: 18),
            textInputAction: TextInputAction.next,
            decoration: InputDecoration(
              filled: true,
              fillColor: Colors.white,
              border: OutlineInputBorder(
                borderSide: BorderSide.none,
                borderRadius: BorderRadius.circular(12),
              ),
            ),
            validator: (value) {
              if (keyboardType == TextInputType.visiblePassword) {
                if (value != null && value.length < 8) {
                  return 'Password should be at least $validator characters long';
                }
              } else if (keyboardType == TextInputType.emailAddress) {
                if (value != null && !_emailRegex.hasMatch(value)) {
                  return 'Please enter a valid email address';
                }
              }
              return null;
            },
          ),
        ),
        showError
            ? SizedBox(
                width: width,
                child: const Row(
                  mainAxisAlignment: MainAxisAlignment.end,
                  children: [
                    Text(
                      "Formato incorrecto",
                      style: TextStyle(color: AppColors.error),
                    ),
                  ],
                ),
              )
            : const SizedBox(height: 10),
      ],
    );
  }
}
