import 'package:flutter_modular/flutter_modular.dart';
import 'package:progressprodis/app/activity/_children/add_group/presenter/page/add_new_group.dart';

class ActivityModule extends Module {
  static const String newGroupRoute = "/new_group";

  @override
  void routes(RouteManager r) {
    r.child(
      "/",
      child: (context) => AddNewGroupView(),
    );
  }
}
