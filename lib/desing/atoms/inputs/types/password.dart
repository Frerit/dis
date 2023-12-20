import 'package:flutter/material.dart';
import 'package:progressprodis/desing/tokens/_tokens.dart';

class PassWordInput extends StatefulWidget {
  const PassWordInput({
    Key? key,
    required this.controller,
    required this.width,
    this.label = "",
    this.labelStyle,
    this.onChange,
    this.showError = false,
  }) : super(key: key);

  final TextEditingController controller;
  final double width;
  final TextStyle? labelStyle;
  final String label;
  final Function(String)? onChange;
  final bool showError;

  @override
  State<PassWordInput> createState() => _PassWordInputState();
}

class _PassWordInputState extends State<PassWordInput> {
  var obscureText = true;

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        widget.label.isNotEmpty
            ? Container(
                margin: const EdgeInsets.only(bottom: 10),
                width: widget.width,
                child: Text(
                  widget.label,
                  style: widget.labelStyle,
                ),
              )
            : const SizedBox.shrink(),
        Container(
          width: widget.width,
          margin: const EdgeInsets.only(bottom: 20),
          decoration: BoxDecoration(
            boxShadow: [
              BoxShadow(
                color: widget.showError
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
            obscureText: obscureText,
            controller: widget.controller,
            onChanged: widget.onChange,
            decoration: InputDecoration(
              filled: true,
              fillColor: Colors.white,
              border: OutlineInputBorder(
                borderSide: BorderSide.none,
                borderRadius: BorderRadius.circular(12),
              ),
              suffixIcon: InkWell(
                onTap: () => setState(
                  () => obscureText = !obscureText,
                ),
                focusNode: FocusNode(skipTraversal: true),
                child: Icon(
                  obscureText
                      ? Icons.visibility_outlined
                      : Icons.visibility_off_outlined,
                  color: const Color(0xFF95A1AC),
                  size: 22,
                ),
              ),
            ),
          ),
        ),
        widget.showError
            ? SizedBox(
                width: widget.width,
                child: const Row(
                  mainAxisAlignment: MainAxisAlignment.end,
                  children: [
                    Text(
                      "Datos incorrectos",
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
