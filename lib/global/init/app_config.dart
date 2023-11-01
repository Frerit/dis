import 'package:package_info_plus/package_info_plus.dart';

class AppConfig {
  AppConfig({
    required this.name,
    this.buildNumber = '',
    this.version = '',
  });

  final String name;
  String buildNumber;
  String version;
}

class AppConfigInit {
  AppConfigInit({required this.appConfig});

  final AppConfig appConfig;

  Future<AppConfig> init() async {
    await PackageInfo.fromPlatform().then((info) {
      appConfig.version = info.version;
      appConfig.buildNumber = info.buildNumber;
    });

    return appConfig;
  }
}
