import 'package:flutter/material.dart';
import 'package:progressprodis/desing/tokens/_tokens.dart';

class BaseAppBar extends StatelessWidget implements PreferredSizeWidget {
  final Color backgroundColor = Colors.white;
  final Text title;
  final AppBar appBar;
  final List<Widget> widgets;

  const BaseAppBar({
    super.key,
    required this.title,
    required this.appBar,
    required this.widgets,
  });

  /// you can add more fields that meet your needs

  @override
  Widget build(BuildContext context) {
    return AppBar(
      title: title,
      backgroundColor: backgroundColor,
      iconTheme: const IconThemeData(
        color: AppColors.primaryColor,
      ),
      elevation: 0,
      actions: widgets,
    );
  }

  @override
  Size get preferredSize => Size.fromHeight(appBar.preferredSize.height);
}
