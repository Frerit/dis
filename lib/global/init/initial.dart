import 'package:progressprodis/global/init/appconfig.dart';
import 'package:flutter_modular/flutter_modular.dart';

class AppInitialization {
  const AppInitialization._();

  static Future<void> run() async {
    try {
      final appConfig = Modular.get<AppConfig>();
      final newAppConfig = await AppConfigInit(appConfig: appConfig).init();
    } catch (e) {
      print(e);
    }
  }
}
