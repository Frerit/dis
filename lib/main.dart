import 'package:flutter/material.dart';
import 'package:flutter_modular/flutter_modular.dart';
import 'package:progressprodis/app/auth/presenter/page/manager.dart';
import 'package:progressprodis/global/init/app_initial.dart';
import 'package:progressprodis/module.dart';

import 'desing/tokens/_tokens.dart';

void main() async {
  await AppInitialization.init();

  runApp(ModularApp(
    module: AppModule(),
    child: const App(),
  ));
}

class App extends StatefulWidget {
  const App({super.key});

  @override
  State<App> createState() => _AppState();
}

class _AppState extends State<App> {
  @override
  Widget build(BuildContext context) {
    AppInitialization.run();
    return const AuthManager(
      child: AppBody(),
    );
  }
}

class AppBody extends StatelessWidget {
  const AppBody({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp.router(
      title: "ProgressPro Trainer",
      theme: ThemeData(
        brightness: Brightness.light,
      ),
      darkTheme: ThemeData(
        brightness: Brightness.dark,
        scaffoldBackgroundColor: AppColors.primaryDarkColor,
      ),
      themeMode: ThemeMode.dark,
      debugShowCheckedModeBanner: false,
      routerConfig: Modular.routerConfig,
    );
  }
}
