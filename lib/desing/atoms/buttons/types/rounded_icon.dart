import 'package:flutter/material.dart';

class RoundedIcon extends StatelessWidget {
  const RoundedIcon({
    Key? key,
    required this.onTap,
    required this.padding,
    this.btnColor,
    this.svg,
  }) : super(key: key);

  final Color? btnColor;
  final VoidCallback? onTap;
  final EdgeInsets padding;

  final Widget? svg;
  @override
  Widget build(BuildContext context) {
    const double width = 50;
    return Container(
      width: width,
      margin: const EdgeInsets.only(left: 10),
      child: ElevatedButton(
          style: ButtonStyle(
            backgroundColor: MaterialStateProperty.resolveWith<Color?>(
                (Set<MaterialState> states) {
              if (states.contains(MaterialState.disabled)) {
                return Colors.white;
              }
              return btnColor;
            }),
            shape: MaterialStateProperty.all<RoundedRectangleBorder>(
              RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(width / 2),
                side: BorderSide.none,
              ),
            ),
            elevation: MaterialStateProperty.all(1),
            padding: MaterialStateProperty.all(padding),
          ),
          onPressed: onTap,
          child: Center(
            child: svg ?? const Icon(Icons.clear_sharp),
          )),
    );
  }
}
