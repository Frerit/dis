import 'package:flutter/material.dart';
import 'package:progressprodis/app/home/presenter/page/home_page.dart';

class CalendarPage extends StatelessWidget {
  const CalendarPage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return const Scaffold(
      bottomNavigationBar: NavigationAppBar(),
    );
  }
}
