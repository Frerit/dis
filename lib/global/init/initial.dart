import 'package:flutter/material.dart';
import 'package:get_storage/get_storage.dart';
import 'package:progressprodis/global/init/appconfig.dart';
import 'package:flutter_modular/flutter_modular.dart';

class AppInitialization {
  const AppInitialization._();

  static Future<void> run() async {
    try {
      final appConfig = Modular.get<AppConfig>();
      final newAppConfig = await AppConfigInit(appConfig: appConfig).init();
      // ignore: avoid_print
      print(newAppConfig);
    } catch (e) {
      // ignore: avoid_print
      print(e);
    }
  }

  static Future<void> init() async {
    WidgetsFlutterBinding.ensureInitialized();
    await GetStorage.init();
  }
}
