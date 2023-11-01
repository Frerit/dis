import 'package:flutter_modular/flutter_modular.dart';
import 'package:progressprodis/app/home/presenter/page/home_page.dart';

import 'bloc/home_bloc.dart';

class HomeModule extends Module {
  static const String getHome = "/home";

  @override
  void binds(Injector i) {
    i.addSingleton(HomeBloc.new);
  }

  @override
  void routes(RouteManager r) {
    r.child("/", child: (context) => const HomePage());
  }
}
