import 'package:flutter/material.dart';
import 'package:flutter_modular/flutter_modular.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:get_storage/get_storage.dart';
import 'package:supabase_flutter/supabase_flutter.dart';

import 'app_config.dart';

class AppInitialization {
  const AppInitialization._();

  static Future<void> run() async {
    try {
      final appConfig = Modular.get<AppConfig>();
      final newAppConfig = await AppConfigInit(appConfig: appConfig).init();
      // ignore: avoid_print
      print(newAppConfig);
    } catch (e) {
      Fluttertoast.showToast(
        msg: "Ha ocurrido un error: $e",
        toastLength: Toast.LENGTH_SHORT,
        gravity: ToastGravity.BOTTOM,
        timeInSecForIosWeb: 1,
        fontSize: 11.0,
      );
      print(e);
    }
  }

  static Future<void> init() async {
    WidgetsFlutterBinding.ensureInitialized();
    await Supabase.initialize(
      url: 'https://hisgouqcvwdolwkcvgrc.supabase.co',
      anonKey:
          'eyJhbGciOiJIUzI1NiIsInR5cCI6IkpXVCJ9.eyJpc3MiOiJzdXBhYmFzZSIsInJlZiI6Imhpc2dvdXFjdndkb2x3a2N2Z3JjIiwicm9sZSI6ImFub24iLCJpYXQiOjE2ODAyOTAxMTQsImV4cCI6MTk5NTg2NjExNH0.xOVFTobcGhCsRaTKwsLjgZBzB82nzsMiImzAvz_DwEE',
    );
    await GetStorage.init();
  }
}
