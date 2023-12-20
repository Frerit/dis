import 'package:flutter/material.dart';
import 'package:progressprodis/desing/atoms/buttons/buttons.dart';
import 'package:progressprodis/desing/tokens/_tokens.dart';

class GenericAlert {
  static final GenericAlert _instance = GenericAlert.internal();

  GenericAlert.internal();

  factory GenericAlert() => _instance;

  static void show(BuildContext context,
      {required String title,
      String okBtnText = "Aceptar",
      required Widget content,
      required Widget image,
      required Function() onPresed}) {
    showGeneralDialog(
      context: context,
      barrierDismissible: true,
      barrierLabel: MaterialLocalizations.of(context).modalBarrierDismissLabel,
      barrierColor: Colors.black45,
      transitionDuration: const Duration(milliseconds: 200),
      pageBuilder: (BuildContext buildContext, Animation animation,
          Animation secondaryAnimation) {
        return Center(
          child: Container(
            decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(12),
              color: Colors.white,
            ),
            padding: const EdgeInsets.all(20),
            margin: const EdgeInsets.symmetric(horizontal: 20),
            child: Column(
              mainAxisSize: MainAxisSize.min,
              mainAxisAlignment: MainAxisAlignment.spaceAround,
              children: [
                image,
                DefaultTextStyle(
                  style: const TextStyle(
                    fontSize: 19.0,
                    fontWeight: FontWeight.bold,
                    color: AppColors.black,
                    decoration: null,
                  ),
                  child: Text(
                    title,
                  ),
                ),
                DefaultTextStyle(
                  style: const TextStyle(),
                  child: Padding(
                    padding: const EdgeInsets.all(20.0),
                    child: content,
                  ),
                ),
                SizedBox(
                  child: GenericButton(
                    width: double.infinity,
                    label: okBtnText,
                    onTap: onPresed,
                  ),
                )
              ],
            ),
          ),
        );
      },
    );
  }
}
