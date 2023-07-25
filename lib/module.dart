import 'package:flutter_modular/flutter_modular.dart';
import 'package:modular_bloc_bind/modular_bloc_bind.dart';
import 'package:progressprodis/app/init/bloc/auth_bloc.dart';
import 'package:progressprodis/app/init/page/page.dart';
import 'package:progressprodis/global/build/appconfig.dart';

class AppModule extends Module {
  @override
  List<Bind<Object>> get binds => [
        BlocBind.singleton(
          (i) => AuthBloc(),
        ),
        Bind<AppConfig>(
          (i) => AppConfig(name: "ProgressPro"),
        )
      ];

  @override
  List<ModularRoute> get routes => [
        ChildRoute(
          '/',
          child: (_, __) => const InitPage(),
        ),
      ];
}
